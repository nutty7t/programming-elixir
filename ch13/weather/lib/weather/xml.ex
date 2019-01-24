defmodule Weather.XML do

  @moduledoc """
  Handles XML parsing of XML documents. Implementation stolen from
  `https://pspdfkit.com/blog/2018/how-to-parse-xml-documents-in-elixir/`.
  """

  # Records tldr;
  #
  #  - Records are tuples where the first element is an atom.
  #  - Used to work with short, internal data and to interface with Erlang records.
  #  - They're very similar to named-tuples in Python.
  #
  # We are doing the latter since we're using `xmerl` to parse the XML
  # documents and returns Erlang records which are defined in `xmerl/include/xmerl.hrl`.

  require Record
  Record.defrecord(:xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl"))
  Record.defrecord(:xmlAttribute, Record.extract(:xmlAttribute, from_lib: "xmerl/include/xmerl.hrl"))
  Record.defrecord(:xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl"))

  @doc """
  https://gist.github.com/sasa1977/5967224
  """
  def from_string(xml_string, options \\ [quiet: true]) do
    {doc, []} =
      xml_string
      |> :binary.bin_to_list
      |> :xmerl_scan.string(options)

    doc
  end

  def get_child_elements(element) do
    # How does this work?
    #
    # `xmlElement(element, :content)` extracts the `:content` field from the record.
    # The `:content` field is a list of records that shows the structure and data of
    # the document. Some of these records are `xmlElement` records. We only care about
    # these so `Enum.filter` filters the records for only `xmlElement` records.
    Enum.filter(xmlElement(element, :content), fn child ->
      Record.is_record(child, :xmlElement)
    end)
  end

  def find_child(children, name) do
    # How does this work?
    #
    # Now that we have a list of child elements from `get_child_elements`, we want
    # to find the child whose tag name is equal to `name`.
    Enum.find(children, fn child -> xmlElement(child, :name) == name end)
  end

  def get_text(element) do
    # How does this work?
    #
    # To get the text node of an XML element, we have to find the `xmlText` record in
    # the `:content` field of the element. Once we've found it, we can unwrap the value
    # from the record with `XML.xmlText(:value)`.
    Enum.find(xmlElement(element, :content), fn child ->
      Record.is_record(child, :xmlText)
    end)
    |> xmlText(:value)
  end
end
