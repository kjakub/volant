module VefHelper

  def two_columns(one, two)
    result  = '<table class="whole">'
    result << "<tr>"
    result << '<td class="half">'
    result << one
    result << "</td>"
    result << '<td class="half">'
    result << two
    result << "</td>"
    result << "</tr>"
    result << "</table>"
    result
  end

  def fieldset(title, fields)
    result  = "<fieldset>"
    result << "        <legend>"
    result << "          <strong>#{title}</strong>"
    result << "        </legend>"
    result << "        <table>"

    fields.each do |field|
      unless field == :dummy
        result << "          <tr>"
        result << "            <th>#{Volunteer.human_attribute_name(field, :locale => 'en' )}:</th>"
        result << "            <td>#{@form.volunteer.send(field)}</td>"
        result << "          </tr>"
      else
        # just a formatting fixing hack
        result << "<tr><th></th><td>&nbsp;</td></tr>"
      end
    end

    result << "        </table>"
    result << "</fieldset>"
    result
  end

  def long_text(title,content)
    %{
    <fieldset>
      <legend><strong>#{title}</strong></legend>
      <p>
      #{content}
      </p>
    </fieldset>
    }
  end
end
