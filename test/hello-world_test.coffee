chai  = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

strToMatch = ''
matchFunc  = (val) ->
    expect(val).to.be.a( 'regexp' )
    match = strToMatch.match( val )
    return match != null
regexpMatcher = sinon.match( matchFunc, 'Matches' + strToMatch )

describe 'hello-world', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/hello-world')(@robot)

    strToMatch = ''

  it 'does not respond to "goodbye"', ->
    strToMatch = 'goodbye'
    expect(@robot.respond).to.not.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'responds to "hello"', ->
    strToMatch = 'hello'
    expect(@robot.respond).to.have.been.calledWith( sinon.match(regexpMatcher) )

  it 'registers a hear listener', ->
    strToMatch = 'orly'
    expect(@robot.hear).to.have.been.calledWith( sinon.match(regexpMatcher) )
