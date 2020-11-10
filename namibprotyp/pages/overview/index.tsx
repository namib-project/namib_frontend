import React from "react";
import Drawer from "../drawer";

import style from "./overview.module.scss";
import { makeStyles } from "@material-ui/core/styles";

const useStyles = makeStyles({
  container: {
    display: "flex",
  },
});

export default function Overview() {
  const classes = useStyles();
  return (
    <div className={classes.container}>
      <Drawer />
      <h1 className={style.h1class}>Übersicht über die einzelnen Geräte</h1>
    </div>
  );
}
