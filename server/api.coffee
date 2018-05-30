

c = console.log.bind console
color = require 'bash-color'
_ = require 'lodash'
fp = require 'lodash/fp'
# fs = require 'fs'


aa = {}


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
