app= require('../app/scripts/main.coffee')

jsdom = require("jsdom")
$ = require("jquery")(jsdom.jsdom().createWindow())

chai = require('chai')
describe "A functioning system", ->
  it "knows when to foo", () ->
    instance = new app
    chai.assert.isDefined(instance)
    return
  it "should get correct value for status" , ->
    instance= new app
    chai.assert.equal(instance.GetLyncPresenceString(0),'avaliabled')
    chai.assert.equal(instance.GetLyncPresenceString(1),'offline')
    chai.assert.equal(instance.GetLyncPresenceString(4),'away')
    chai.assert.equal(instance.GetLyncPresenceString(6),'busy')
    chai.assert.equal(instance.GetLyncPresenceString(9),'donotdisturb')
    chai.assert.equal(instance.GetLyncPresenceString(12),'busy')
  return
it "should change class based on status" , ->
  instance= new app
  tag= $('<li></li>')
  instance.SetImageClassStatus(tag,2)
  chai.assert.equal $(tag).attr('class'),'sprite-icon-status-away'
  return
