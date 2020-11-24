import React from 'react';
import Drawer from "../drawer";
import {Container, createStyles, MenuItem, TextField, Theme, Typography} from "@material-ui/core";
import style from "../editDevice/editDevice.module.scss";
import {makeStyles} from "@material-ui/styles";

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
        value: 'dark',
        label: 'Dark Theme',
    },
    {
        value: 'light',
        label: 'Light Mode',
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


const useStyles = makeStyles((theme: Theme) =>
    createStyles({
        root: {
            '& .MuiTextField-root': {
                margin: theme.spacing(1),
                width: '25ch',
            },
        },
    }),
);

export default function ApplicationSettings(){
    const classes = useStyles();
    const [language, setLanguage] = React.useState('DE');
    const [theme, setTheme] = React.useState(typeof window !== "undefined"
        ? window.localStorage.getItem("darkMode")
        : "light");
    const [mode, setMode] = React.useState('expert');

    const handleChangeLanguages = (event) => {
        setLanguage(event.target.value);
    };

    const handleThemeChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        if (window.localStorage.getItem("darkMode") === "dark"){
            setTheme("light");
            window.localStorage.setItem("darkMode", "light");
        } else {
            setTheme("dark");
            window.localStorage.setItem("darkMode", "dark");
        }
        location.reload();
    };

    const handleChangeModes = (event) => {
        setMode(event.target.value);
    };

    return(
        <div>
            <div>
                <Drawer/>
            </div>
            <div>
                <Container maxWidth="lg">
                    <Typography component="div" className={style.typographyStyle}>
                        <h2 className={style.heading}>Einstellungen</h2>
                        <div>
                            <form className={classes.root} noValidate autoComplete="off">
                                <div>
                                    <TextField
                                        id="select language"
                                        select
                                        label="LANGUAGE"
                                        value={theme}
                                        onChange={handleChangeLanguages}
                                        helperText="Please select your preferred language"
                                    >
                                        {languages.map((option) => (
                                            <MenuItem key={option.value} value={option.value}>
                                                {option.label}
                                            </MenuItem>
                                        ))}
                                    </TextField>
                                </div>
                                <br/>
                                <div>
                                    <TextField
                                        id="select theme"
                                        select
                                        label="THEME"
                                        value={theme}
                                        onChange={handleThemeChange}
                                        helperText="Please select your preferred theme"
                                    >
                                        {themes.map((option) => (
                                            <MenuItem key={option.value} value={option.value}>
                                                {option.label}
                                            </MenuItem>
                                        ))}
                                    </TextField>
                                </div>
                                <br/>
                                <div>
                                    <TextField
                                        id="select mode"
                                        select
                                        label="MODE"
                                        value={theme}
                                        onChange={handleChangeModes}
                                        helperText="Please select your preferred mode"
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
                    </Typography>
                </Container>
            </div>
        </div>
    )
}