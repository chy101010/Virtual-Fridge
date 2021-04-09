import React, { useEffect, useState } from 'react'
import { fetch_stores } from '../api'
import { useSelector } from 'react-redux'
import store from '../store'

import ReactVirtualizedTable from './table'

export default function Stores() {
    const session = useSelector(state => state.session);
    const stores = useSelector(state => state.stores);
    const [locationEnabled, setLocationEnabled] = useState(false);

    // cite: https://www.w3schools.com/html/html5_geolocation.asp
    function getLocation() {
        if (navigator.geolocation) {
            setLocationEnabled(true);
            navigator.geolocation.getCurrentPosition(getStores);
        }
    }

    useEffect(() => {
        if (session) {
            getLocation();
        }
    }, [])

    function getStores(position) {
        let data = {
            latitude: position.coords.latitude,
            longitude: position.coords.longitude
        }
        fetch_stores(data);
    }

    if (session) {
        if (locationEnabled) {
            return (
                <div className="myDiv">
                    <div className="bg"></div>
                    <h1>Super-Markets Within 20 km</h1>
                    <ReactVirtualizedTable stores={stores} />
                </div>
            )
        } else {
            return (
                <div>
                    <h1>Please enable your location!</h1>
                </div>
            )
        }
    } else {
        let action = {
            type: "error/set",
            data: "Required Login! Go to Home!"
        }
        store.dispatch(action);
        return <div> </div>
    }
}
