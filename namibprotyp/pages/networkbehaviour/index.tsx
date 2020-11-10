import React from "react";
import Drawer from "../drawer";

import style from "./networkbehaviour.module.css";
import { makeStyles } from "@material-ui/core/styles";

const useStyles = makeStyles({
  container: {
    display: "flex",
  },
});

export default function Networkbehaviour() {
  const classes = useStyles();
  return (
    <div className={classes.container}>
      <Drawer />
      <h1 className={style.h1class}>Übersicht über Netzwerkverhalten</h1>
    </div>
  );
}
