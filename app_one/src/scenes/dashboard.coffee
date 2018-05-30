





comp = rr

    getInitialState: -> {}


    render: ->
        div
            style:
                width: '100%'
                display: 'flex'
                flexDirection: 'column'
                backgroundColor: 'ivory'
                justifyContent: 'center'
                alignItems: 'center'

            p null, "hello"


map_state_to_props = (state) -> {}


map_dispatch_to_props = (dispatch) -> {}


exports.default = connect(map_state_to_props, map_dispatch_to_props)(comp)
