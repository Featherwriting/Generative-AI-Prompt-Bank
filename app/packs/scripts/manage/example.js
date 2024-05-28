import React, { useState, Component, useEffect } from "react";
import { ExampleInput } from "./basic";
export const MakeExample = ({ item }) => {
    return (
        <div className="col-md-12">
            <label className="form-label" htmlFor="inputExample">Example Link</label>
            <ExampleInput id={item.id} data={item.example} key={Math.random()} />
        </div>
    )
}