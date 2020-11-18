import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import MenuItem from '@material-ui/core/MenuItem';
import Drawer from "../drawer";
import style from "../networkbehaviour/networkbehaviour.module.css";

const languages = [
    {
        value: 'DE',
        label: 'German',
    },
    {
        value: 'EN',
        label: 'English',
    },
];

const themes = [
    {
        value: 'light',
        label: 'Light Theme',
    },
    {
        value: 'dark',
        label: 'Dark Theme',
    },
];

const modes = [
    {
        value: 'basic',
        label: 'Basic Mode',
    },
    {
        value: 'expert',
        label: 'Expert Mode',
    },
];

const useStyles = makeStyles((theme) => ({

    container: {
        display: "flex",
        '& .MuiTextField-root': {

            margin: theme.spacing(1),
            width: '25ch',

        },
    },
}));

export default function MultilineTextFields() {
    const classes = useStyles();
    const [language, setLanguage] = React.useState('EUR');
    const [theme, setTheme] = React.useState(typeof window !== "undefined"
        ? window.localStorage.getItem("darkMode")
        : "light");
    const [mode, setMode] = React.useState('EUR');

    const handleChangeLanguages = (event) => {
        setLanguage(event.target.value);
    };

    const handleChangeThemes = (event) => {
        setTheme(event.target.value);
        window.localStorage.setItem("darkMode", event.target.value);
        location.reload();
    };


    const handleChangeModes = (event) => {
        setMode(event.target.value);
    };


    return (

            <div className={classes.container}>
                <Drawer />
                <form noValidate autoComplete="off">
                    <div>

                <h1 className={style.h1class}>Einstellungen</h1>



            </div>
            <div>
                <TextField
                    id="outlined-select-currency"
                    select
                    label="LANGUAGE"
                    value={language}
                    onChange={handleChangeLanguages}
                    helperText="Please select your language"
                    variant="outlined"
                >
                    {languages.map((option) => (
                        <MenuItem key={option.value} value={option.value}>
                            {option.label}
                        </MenuItem>
                    ))}
                </TextField>

            </div>
            <div>
                <TextField
                    id="outlined-select-currency"
                    select
                    label="THEME"
                    value={theme}
                    onChange={handleChangeThemes}
                    helperText="Please select your theme"
                    variant="outlined"
                >
                    {themes.map((option) => (
                        <MenuItem key={option.value} value={option.value}>
                            {option.label}
                        </MenuItem>
                    ))}
                </TextField>

            </div>
                    <div>
                        <TextField
                            id="outlined-select-currency"
                            select
                            label="MODE"
                            value={mode}
                            onChange={handleChangeModes}
                            helperText="Please select your mode"
                            variant="outlined"
                        >
                            {modes.map((option) => (
                                <MenuItem key={option.value} value={option.value}>
                                    {option.label}
                                </MenuItem>
                            ))}
                        </TextField>

                    </div>
            </form>
            </div>

    );
}
