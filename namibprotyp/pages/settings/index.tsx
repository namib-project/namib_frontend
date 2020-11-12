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
        value: 'DT',
        label: 'Light Theme',
    },
    {
        value: 'EN',
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
    const [currency, setCurrency] = React.useState('EUR');


    const handleChangeLanguages = (event) => {
        setCurrency(event.target.value);
    };

    const handleChangeThemes = (event) => {
        setCurrency(event.target.value);
    };


    const handleChangeModes = (event) => {
        setCurrency(event.target.value);
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
                    value={currency}
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
                    value={currency}
                    onChange={handleChangeThemes}
                    helperText="Please select your theme"
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
                            value={themes}
                            onChange={handleChangeModes}
                            helperText="Please select your mode"
                            variant="outlined"
                        >
                            {themes.map((option) => (
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
