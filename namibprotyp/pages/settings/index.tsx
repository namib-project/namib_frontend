import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import MenuItem from '@material-ui/core/MenuItem';
import Drawer from "../drawer";
import style from "../networkbehaviour/networkbehaviour.module.css";

const supportedLanguages = [
    {
        value: 'DE',
        label: 'German',
    },
    {
        value: 'EN',
        label: 'English',
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


    const handleChange = (event) => {
        setCurrency(event.target.value);
    };

    return (

            <div className={classes.container}>
                <Drawer />
                <form noValidate autoComplete="off">
                    <div>

                <h1 className={style.h1class}>Übersicht über Netzwerkverhalten</h1>


            </div>
            <div>

                <TextField
                    id="filled-select-supportedLanguages-native"
                    select
                    label="Language"
                    value={currency}
                    onChange={handleChange}
                    SelectProps={{
                        native: true,
                    }}
                    helperText="Please select your language"
                    variant="filled"
                >
                    {supportedLanguages.map((option) => (
                        <option key={option.value} value={option.value}>
                            {option.label}
                        </option>
                    ))}
                </TextField>
            </div>

            </form>
            </div>

    );
}
