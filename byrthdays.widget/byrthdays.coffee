refreshFrequency: 900000

command: "byrthdays.widget/byrthdays -d 14 -o json -t 120 -g"

render: -> """
  <table>
    <thead>
    </thead>
    <tbody>
    </tbody>
    <tfoot>
    </tfoot>
  </table>
"""

updateHeader: (table) ->
  thead = table.find("thead")
  thead.empty()

  thead.append "<tr>"
  thead.append "  <th class='title' colspan='3'>BYRTHDAYS</th>"
  thead.append "</tr>"

updateBody: (rows, table) ->
  tbody = table.find("tbody")
  tbody.empty()

  for row in rows
    name = row.firstName + ' ' + row.lastName

    if row.age > 0
        age = "will be " + row.age
    else
        age = "will be ???"

    if row.daysToBirthday == 0
        daysToBirthday = "Today"
    else if row.daysToBirthday == 1
        daysToBirthday = "Tomorrow"
    else
        daysToBirthday = row.daysToBirthday + " days"

    nextBirthdayDate = row.nextBirthdayDate

    if row.image == ''
      imgTag = "<img src='byrthdays.widget/missing.png' height='60' />"
    else
      imgTag = "<img src='data:image/png;base64," + row.image + "' height='60' />"

    tbody.append "<tr>"
    tbody.append "  <td width='90' align='right'><span class='daystobirthday'>#{daysToBirthday}</span><br><span class='nextbirthday'>#{nextBirthdayDate}</span></td>"
    tbody.append "  <td width='60' height='60'>#{imgTag}</td>"
    tbody.append "  <td width='250' align='left'><span class='name'>#{name}</span><br><span class='age'>#{age}</span></td>"
    tbody.append "</tr>"

updateFooter: (rows, table) ->
  tfoot = table.find("tfoot")
  tfoot.empty()

  if rows.length > 6
    tfoot.append "<tr>"
    tfoot.append "  <td colspan='3' align='left'><span class='footer'>and #{rows.length-6} more birthdays</span></td>"
    tfoot.append "</tr>"
  else if rows.length == 0
    tfoot.append "<tr>"
    tfoot.append " <td colspan='3' align='left'><span class='footer'>there are no birthdays</span></td>"
    tfoot.append "</tr>"

update: (output, domEl) ->
  rows = JSON.parse(output)
  table = $(domEl).find("table")

  @updateHeader table
  @updateBody rows, table
  @updateFooter rows, table

style: """
  color: #fff
  background: rgba(#000, 0.0)
  padding: 0px
  left: 1%
  top: 50%
  transform: translateY(-50%);

  table, th, td
    color: rgba(#fff, 1.0)
    border: 0px solid red
    border-collapse: collapse
    font-family: 'Helvetica Neue'
    font-weight: 100
    font-smoothing: antialiased
    white-space: nowrap

  table th
    font-size: 32px
    padding: 5px 0px
    text-align: left

  table td
    font-size: 18px
    line-height: 1.3

  .title
    padding-left: 41px

  .name
    margin-left: 12px

  .age
    margin-left: 12px
    font-size: 14px

  .nextbirthday
    margin-right: 12px
    font-size: 14px

  .daystobirthday
    margin-right: 12px

  .footer
    margin-left: 30px

"""
