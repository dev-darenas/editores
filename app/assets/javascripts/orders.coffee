# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($) ->
  $(document).ready ->
    if $('tbody tr:first').length

      nestedForm = $('tbody tr:first').last().clone()

      $(".destroy_duplicate_nested_form:first").remove()

      $('.duplicate_nested_form').click (e) ->
        e.preventDefault()

        lastNestedForm = $('tbody tr:first').last()
        newNestedForm  = $(nestedForm).clone()
        formsOnPage    = $('tbody tr:first').length

        $(newNestedForm).find('label').each ->
          oldLabel = $(this).attr 'for'
          newLabel = oldLabel.replace(new RegExp(/_[0-9]+_/), "_#{formsOnPage}_")
          $(this).attr 'for', newLabel

        $(newNestedForm).find('select, input').each ->
          oldId = $(this).attr 'id'
          newId = oldId.replace(new RegExp(/_[0-9]+_/), "_#{formsOnPage}_")
          $(this).attr 'id', newId

          oldName = $(this).attr 'name'
          newName = oldName.replace(new RegExp(/\[[0-9]+\]/), "[#{formsOnPage}]")
          $(this).attr 'name', newName

        $( newNestedForm ).insertAfter( lastNestedForm )

      $('body').on 'click', '.destroy_duplicate_nested_form', (e) ->
        $(this).closest('tbody tr').slideUp().remove()

    # $('.order_orders_wares_quantity > input').on 'change', (e) ->
      # $(this).val();
