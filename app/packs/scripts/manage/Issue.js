import React, { useState, Component, useEffect } from "react";
import { AnimatedMultiIssue } from "./basic";
export const MakeIssue = ({ item }) => {
    return (
        <div className="col-md-8">
            <label className="form-label" htmlFor="inputIssue">Issue to Consider</label>
            <AnimatedMultiIssue id={item.id} data={item.issue} key={Math.random()} />
            <input id={`hiddenInputIssue-${item.id}`} name="prompt[issue]" type="hidden" />
        </div>
    )
}