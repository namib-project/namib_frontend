import Drawer from "../drawer";

import style from "./networkbehaviour.module.css";

import ButtonGroup from "@material-ui/core/ButtonGroup";
import Button from "@material-ui/core/Button";
import React, { useState } from "react";

import { makeStyles, Theme, createStyles } from "@material-ui/core/styles";
import FormLabel from "@material-ui/core/FormLabel";
import FormControl from "@material-ui/core/FormControl";
import FormGroup from "@material-ui/core/FormGroup";
import FormControlLabel from "@material-ui/core/FormControlLabel";
import FormHelperText from "@material-ui/core/FormHelperText";
import Checkbox from "@material-ui/core/Checkbox";

const useStyles2 = makeStyles({
  container: {
    display: "flex",
  },
});

export default function Networkbehaviour() {
  const classes = useStyles2();
  const [path, setPath] = useState<string>("../../networkoverview1.PNG");

  return (
    <div className={classes.container}>
      <Drawer />

      <div className={style.wholeContent}>
        <img src={path} className={style.im} />

        <div className={style.select}>
          <div className={style.bGroup}>
            <ButtonGroup
              color="primary"
              aria-label="outlined primary button group"
            >
              <Button onClick={() => setPath("../../networkoverview1.PNG")}>
                Anzahl der Verbindungen
              </Button>
              <Button onClick={() => setPath("../../networkoverview2.PNG")}>
                Traffic
              </Button>
            </ButtonGroup>
          </div>

          <div className={style.check}>
            <CheckboxesGroup />
          </div>
        </div>
      </div>
    </div>
  );
}

const useStyles = makeStyles((theme: Theme) =>
  createStyles({
    root: {
      display: "flex",
    },
    formControl: {
      margin: theme.spacing(3),
    },
  })
);

function CheckboxesGroup() {
  const classes = useStyles();
  const [state, setState] = React.useState({
    gilad: true,
    jason: true,
    antoine: false,
  });

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setState({ ...state, [event.target.name]: event.target.checked });
  };

  const { gilad, jason, antoine } = state;

  return (
    <div className={classes.root}>
      <FormControl component="fieldset" className={classes.formControl}>
        <FormLabel component="legend">Ausgewählte Geräte:</FormLabel>
        <FormGroup>
          <FormControlLabel
            control={
              <Checkbox
                checked={gilad}
                onChange={handleChange}
                name="gilad"
                style={{ color: "blue" }}
              />
            }
            label="Gerät 1"
          />
          <FormControlLabel
            control={
              <Checkbox
                checked={jason}
                onChange={handleChange}
                name="jason"
                style={{ color: "blue" }}
              />
            }
            label="Gerät 2"
          />
          <FormControlLabel
            control={
              <Checkbox
                checked={antoine}
                onChange={handleChange}
                name="antoine"
                style={{ color: "blue" }}
              />
            }
            label="Gerät 3"
          />
        </FormGroup>
      </FormControl>
    </div>
  );
}
