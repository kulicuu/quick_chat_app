









header = ->
    div
        style:
            display: 'flex'
            flexDirection: 'row'
            backgroundColor: 'snow'
            width: '100%'
            height: '6%'
            justifyContent: 'center'
            alignItems: 'center'
        p
            style:
                fontSize: 10
                color: 'grey'
                fontFamily: 'sans'
            "<-----------chat----------->"


users_in_room = ->
    div
        style:
            width: '33%'
            height: '100%'
            backgroundColor: 'lightgreen'
        # c @props.users_in_room
        @props.users_in_room.toArray().map (user, idx) =>
            p
                key: "user_in_room:#{idx}"
                style:
                    marginLeft: 10
                    fontSize: 11
                user.toString()


thread_roll = ->
    div
        style:
            display: 'flex'
            flexDirection: 'column'
            width: '100%'
            backgroundColor: 'black'
            height: '88%'

        p
            style:
                fontSize: 11
                marginLeft: 10
                color: 'grey'
            @state.pending_msg_content




msg_entry = ->
    div
        style:
            display: 'flex'
            flexDirection: 'column'
            backgroundColor: 'red'
            justifyContent: 'center'
            alignItems: 'center'
            width: '100%'
            height: '12%'
        input
            style:
                width: '80%'
                height: '40%'
            placeholder: '...'
            value: @state.msg_candidate
            type: 'text'
            onChange: (e) =>
                msg_candidate = e.currentTarget.value
                @setState { msg_candidate }

            onKeyPress: (e) =>
                if (e.key is 'Enter')
                    @setState
                        msg_pending: true
                        pending_msg_content: @state.msg_candidate
                        msg_candidate: ""
                    @props.initiate_msg_send
                        msg_candidate: @state.msg_candidate


thread_dash = ->
    div
        style:
            width: '67%'
            height: '100%'
            backgroundColor: 'lightslategrey'
            display: 'flex'
            flexDirection: 'column'
        thread_roll.bind(@)()
        msg_entry.bind(@)()


main_dash = ->
    div
        style:
            display: 'flex'
            flexDirection: 'row'
            height: '90%'
            width: '100%'
            backgroundColor: 'lightskyblue'
        users_in_room.bind(@)()
        thread_dash.bind(@)()


footer = ->
    div
        style:
            height: '4%'
            width: '100%'
            backgroundColor: 'ivory'



lobby = ->
    if @state.login_pending is true
        div
            style:
                width: '100%'
                height: '100%'
                display: 'flex'
                flexDirection: 'column'
                backgroundColor: 'linen'
                justifyContent: 'center'
                alignItems: 'center'
            h4
                style:
                    color: 'grey'
                    fontFamily: 'sans'
                "Login pending... please be patient."

    else
        div
            style:
                width: '100%'
                height: '100%'
                display: 'flex'
                flexDirection: 'column'
                backgroundColor: 'linen'
                justifyContent: 'center'
                alignItems: 'center'
            h3
                style:
                    color: 'grey'
                    fontFamily: 'sans'
                "Welcome to the Chat-Room."
            h4
                style:
                    color: 'grey'
                    fontFamily: 'sans'
                "Please enter a username:"
            input
                type: 'text'
                placeholder: 'username'
                style:
                    fontSize: 14
                onChange: (e) =>
                    username_candidate = e.currentTarget.value
                    @setState { username_candidate }
                    @props.check_is_username_avail { username_candidate }

                onKeyPress: (e) =>
                    if (e.key is 'Enter') and (@props.username_avail is true)
                        @setState
                            login_pending: true
                        @props.initiate_login
                            username_candidate: @state.username_candidate

            c @props.username_avail
            if @props.username_avail isnt null
                if @props.username_avail is true
                    p
                        style:
                            color: 'limegreen'
                        "OK"
                else if @props.username_avail is false
                    p
                        style:
                            color: 'orange'
                        "Username taken"








chat_room = ->
    div
        style:
            width: '100%'
            height: '100%'
            display: 'flex'
            flexDirection: 'column'
            backgroundColor: 'linen'
            justifyContent: 'flex-start'
            alignItems: 'center'
        header.bind(@)()
        main_dash.bind(@)()
        footer.bind(@)()


comp = rr


    getInitialState: ->
        login_pending: false
        username_candidate: null
        msg_candidate: ""
        msg_pending: null
        pending_msg_content: null



    render: ->
        if @props.username is null
            lobby.bind(@)()
        else
            chat_room.bind(@)()






map_state_to_props = (state) ->
    username: state.getIn ['lookup','username']
    username_avail: state.getIn ['lookup', 'username_avail']
    users_in_room: state.getIn ['lookup', 'users_in_room']


map_dispatch_to_props = (dispatch) ->

    initiate_msg_send: ({ msg_candidate }) ->
        dispatch
            type: 'initiate_msg_send'
            payload: { msg_candidate }

    initiate_login: ({ username_candidate }) ->
        dispatch
            type: 'api_sc'
            payload:
                type: 'initiate_login'
                payload: { username_candidate }

    check_is_username_avail: ({ username_candidate }) ->
        dispatch
            type: 'api_sc'
            payload:
                type: 'check_is_username_avail'
                payload: { username_candidate }


exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
