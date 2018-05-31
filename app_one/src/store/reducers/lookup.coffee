

bb = {}







bb.a_user_logged_in = ({ state, payload }) ->
    { username } = payload
    state = state.set 'users_in_room', (state.get 'users_in_room').push(username)
    state


bb.res_initiate_login = ({ state, payload }) ->
    { status, msg, username } = payload
    if status is true
        state = state.set 'login_status_msg', null
        state = state.set 'username', username
    else
        state = state.set 'login_status_msg', msg
    state


bb.res_check_is_username_avail = ({ state, payload }) ->
    { status } = payload
    state = state.set 'username_avail', status
    state


keys_bb = _.keys bb



server_msg_api = ({ type, payload, state, effects_q }) ->
    if _.includes(keys_bb, type)
        bb[type] { state, payload }
    else
        c "No-op in server_msg_api-api", type
        state


aa = {}


construct_msg = ({ msg_candidate }) ->
    local_id: shortid()
    timestamp: Date.now()
    msg_text: msg_candidate
    confirmed: false



aa.initiate_msg_send = ({ state, action, effects_q }) ->

    state = state.set 'msg_roll', (state.get('msg_roll').push(Imm.Map(construct_msg({ msg_candidate}))))

    effects_q.push
        type: 'api_sc'
        payload: action


aa.api_sc = ({ state, action, effects_q }) ->
    effects_q.push
        type: 'api_sc'
        payload: action.payload
    state


aa['primus:data'] = ({ state, action, effects_q }) ->
    { type, payload } = action.payload.data
    server_msg_api { type, payload, state, effects_q }


keys_aa = _.keys aa


lookup_precursor = ({ effects_q }) ->
    (state, action) ->
        if _.includes(keys_aa, action.type)
            aa[action.type] { state, action, effects_q }
        else
            c "No-op in updates/reducers with type", action.type
            # NOTE : Better not to log this in production.
            state


exports.default = lookup_precursor
# exports.default = lookup
