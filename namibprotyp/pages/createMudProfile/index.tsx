import React from "react";
import Drawer from "../drawer";

import style from "../createMudProfile/createMudProfile.module.css";
import { makeStyles } from "@material-ui/core/styles";

const useStyles = makeStyles({
    container: {
        display: "flex",
    },
});

export default function index() {
    const classes = useStyles();
    return (
        <div className={classes.container}>
            <Drawer />
            <h1 className={style.h1class}>MUD-Profil anlegen</h1>
        </div>
    );
}