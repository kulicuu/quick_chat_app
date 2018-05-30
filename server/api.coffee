

c = console.log.bind console
color = require 'bash-color'
_ = require 'lodash'
fp = require 'lodash/fp'



users = {}


chatlog = {}





user_gen = ({ username_candidate }) ->
    username: username_candidate
    placeholder: 64




aa = {}



aa.initiate_login = ({ payload, spark }) ->
    { username_candidate } = payload
    if (_.includes (_.keys users), username_candidate)
        spark.write
            type: 'res_initiate_login'
            payload:
                status: false
                msg: 'Username candidate already exists.'
                username: username_candidate
    else
        the_user = user_gen { username_candidate }
        users[the_user.username] = the_user
        primus.write
            type: 'a_user_logged_in'
            payload:
                username: the_user.username
        spark.write
            type: 'res_initiate_login'
            payload:
                status: true
                msg: 'User successfully logged in.'
                username: the_user.username



aa.check_is_username_avail = ({ payload, spark }) ->
    { username_candidate } = payload
    if (_.includes (_.keys users), username_candidate)
        status = false
    else
        status = true
    spark.write
        type: 'res_check_is_username_avail'
        payload: { status }


aa.checkin = ({ payload, spark }) ->
    spark.write
        type: "OK"
        payload: null # might prefetch some data here


keys_aa = _.keys aa
api = ({ type, payload, spark }) ->
    if _.includes(keys_aa, type)
        aa[type] { payload, spark }
    else
        c "no-op", type


exports.default = api
