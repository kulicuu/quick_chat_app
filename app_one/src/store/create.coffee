

{
    applyMiddleware, compose, createStore
} = require 'redux'
{ combineReducers } = require 'redux-immutable'
thunk = require('redux-thunk').default


initial_state = Imm.Map
    lookup: Imm.Map
        placeholder: 43
        username: null
        username_avail: null
        login_status_msg: null
        users_in_room: Imm.List([])
        msg_roll: Imm.List([])


effects_q = [
    {
        type: 'init_primus'
    }
]


lookup = require('./reducers/lookup.coffee').default { effects_q }


reducers = { lookup }


store = createStore(combineReducers(reducers), initial_state, applyMiddleware(thunk))


effects = require('./effects/index.coffee').default { store }


effect_trigger = ->
    effects { effects_q }


store.subscribe effect_trigger
effects { effects_q }


exports.default = store
