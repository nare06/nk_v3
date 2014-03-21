# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $("input[id*='event_category_ids']").click ->
    if $(@).prop('checked')
      $(@).parent().removeClass('btn-default')
      $(@).parent().addClass('btn-info')
    else
      $(@).parent().removeClass('btn-info')
      $(@).parent().addClass('btn-default')
jQuery ->
  $("input[id*='event_domain_ids']").click ->
    if $(@).prop('checked')
      $(@).parent().removeClass('btn-default')
      $(@).parent().addClass('btn-info')
    else
      $(@).parent().removeClass('btn-info')
      $(@).parent().addClass('btn-default')      
jQuery ->
  $("input[id*='event_eligible_ids']").click ->
    if $(@).prop('checked')
      $(@).parent().removeClass('btn-default')
      $(@).parent().addClass('btn-info')
    else
      $(@).parent().removeClass('btn-info')
      $(@).parent().addClass('btn-default')      
jQuery ->
  $("input[id*='user_eligible_ids']").click ->
    if $(@).prop('checked')
      $(@).parent().removeClass('btn-default')
      $(@).parent().addClass('btn-info')
    else
      $(@).parent().removeClass('btn-info')
      $(@).parent().addClass('btn-default') 
jQuery ->
  $("input[id*='user_domain_ids']").click ->
    if $(@).prop('checked')
      $(@).parent().removeClass('btn-default')
      $(@).parent().addClass('btn-info')
    else
      $(@).parent().removeClass('btn-info')
      $(@).parent().addClass('btn-default') 
jQuery ->
  $("input[id*='user_category_ids']").click ->
    if $(@).prop('checked')
      $(@).parent().removeClass('btn-default')
      $(@).parent().addClass('btn-info')
    else
      $(@).parent().removeClass('btn-info')
      $(@).parent().addClass('btn-default')                   
