import { Manage_page, Pending_Manage_page } from "../scripts/manage/manage";
import React, { useState, Component, useEffect } from "react";
import ReactDOM from "react-dom";


try {
    const pending = document.querySelector("#eeevee");
    const manage = document.querySelector("#pikachu");
    if (pending) {
        ReactDOM.render(<Pending_Manage_page />, pending)

    }
    if (manage) {
        ReactDOM.render(<Manage_page />, manage)
    }
} catch (error) {
    console.error("error:", error);
}
