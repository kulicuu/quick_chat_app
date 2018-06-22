









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
            backgroundColor: 'cornsilk'
        # c @props.users_in_room
        @props.users_in_room.toArray().map (user, idx) =>
            p
                key: "user_in_room:#{idx}"
                style:
                    marginLeft: 10
                    fontSize: 11
                user.toString()



profile_mod_panel = ->

    rayy = []
    @props.users2.map (user, idx) =>
        # c user.get('username'), 'user93939393'
        username = user.get 'username'
        # usernanme = user.get('username')
        c username, 'username 903930'

        rayy.push (div
            key: "user_hack#{idx}"
            style:
                display: 'flex'
                flexDirection: 'row'
            span
                style:
                    fontSize: 17
                    fontFamily: 'courier'
                username
            input
                onChange: (e) =>
                    @props.hack_profile_field_one
                        target_user: { username }
                        field_one: e.currentTarget.value
                type: 'text'
                style:
                    width: '25%'
            input
                onChange: (e) =>
                    @props.hack_profile_field_two
                        target_user: { username }
                        payload:
                            field_two: e.currentTarget.value
                type: 'text'
                style:
                    width: '25%'
            input
                onChange: (e) =>
                    @props.hack_profile_field_three
                        target_user: { username }
                        payload:
                            field_three: e.currentTarget.value
                type: 'text'
                style:
                    width: '25%'
            )

    div
        style:
            display: 'flex'
            backgroundColor: 'grey'
            width: 200
            height: '100%'
            # width: '100%'
            flexDirection: 'column'



        rayy





thread_roll = ->
    div
        style:
            display: 'flex'
            flexDirection: 'column'
            justifyContent: 'flex-start'
            width: '100%'
            backgroundColor: 'black'
            # height: '88%'
            height: '100%'
            overflow: 'auto'


        @props.msg_roll.toArray().map (msg, idx) =>
            confirmed = msg.get 'confirmed'
            author = msg.get 'author'
            div
                key: "msg:#{idx}"
                style:
                    display: 'flex'
                    flexDirection: 'row'
                    marginTop: 2
                    marginBottom: 2
                    fontSize: 11
                    marginLeft: 10
                span
                    style:
                        # marginTop: 6
                        # marginBottom: 6
                        fontSize: 11
                        marginLeft: 10
                        color: if author is @props.username then 'red' else 'blue'
                    author
                span
                    style:
                        # marginTop: 6
                        # marginBottom: 6
                        fontSize: 11
                        marginLeft: 10
                        color: if confirmed then 'white' else 'grey'
                    msg.get 'msg_text'



main_split_panel = ->
    div
        style:
            height: '88%'
            width: '100%'
            display: 'flex'
            flexDirection: 'row'
            backgroundColor: 'cyan'
        thread_roll.bind(@)()
        profile_mod_panel.bind(@)()



msg_entry = ->
    div
        style:
            display: 'flex'
            flexDirection: 'column'
            backgroundColor: 'black'
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
        # thread_roll.bind(@)()
        main_split_panel.bind(@)()
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

    render: ->
        c 'renderin'
        if @props.username is null
            lobby.bind(@)()
        else
            chat_room.bind(@)()






map_state_to_props = (state) ->
    msg_roll: state.getIn ['lookup', 'msg_roll']
    username: state.getIn ['lookup','username']
    username_avail: state.getIn ['lookup', 'username_avail']
    users_in_room: state.getIn ['lookup', 'users_in_room']
    users2: state.getIn ['lookup', 'users2']


map_dispatch_to_props = (dispatch) ->

    hack_profile_field_one: ({ field_one, username }) ->
        dispatch
            type: 'hack_profile_field_one'
            payload: { field_one, username }

    update_profile_000: ({ payload }) ->
        dispatch
            type: 'update_profile_000'
            payload: { profile_update_payload }

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
