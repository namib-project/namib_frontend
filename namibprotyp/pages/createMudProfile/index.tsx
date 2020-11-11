import Drawer from '../drawer';
import React from 'react';
import Typography from '@material-ui/core/Typography';
import Container from '@material-ui/core/Container';
import {makeStyles} from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import {Button, FormControl, FormGroup} from "@material-ui/core";
import FormLabel from '@material-ui/core/FormLabel';
import style from './createMudProfile.module.scss';
import FormControlLabel from "@material-ui/core/FormControlLabel";
import Checkbox from "@material-ui/core/Checkbox";
import StickyFooter from "../StickyFooter";

const useStyles = makeStyles((theme) => ({
    root: {
        '& > *': {
            margin: theme.spacing(1),
            width: '25ch',
        },
    },
    container: {
        display: 'flex',
        flexWrap: 'wrap',
    },
    textField: {
        marginTop: theme.spacing(2),
        marginLeft: theme.spacing(1),
        marginRight: theme.spacing(1),
        marginBottom: theme.spacing(2),
        width: 200,
    },
}));

export default function Test() {
    const classes = useStyles();
    const [state, setState] = React.useState({
        checkedA: true,
        checkedB: true,
        checkedF: true,
        checkedG: true,
    });

    const handleChange = (event) => {
        setState({ ...state, [event.target.name]: event.target.checked });
    };

    return (
        <div>
            <div>
                <Drawer/>
            </div>
            <div className={style.test}>
                <Container maxWidth="lg">
                    <Typography component="div" style={{backgroundColor: "white", height: '80vh'}}
                                className={style.typographyStyle}>
                        <h2 className={style.heading}>MUD-Profil anlegen</h2>
                        <div className={style.container}>
                            <FormControl style={{display: "block"}}>
                                <div className={style.inputGroups}>
                                    <FormLabel>Profilname</FormLabel>
                                    <FormGroup>
                                        <TextField  className={style.textInput} id="standard-basic" placeholder="Standardprofil"/>
                                    </FormGroup>
                                </div>
                                <div className={style.inputGroups}>
                                    <FormLabel>IoT-Gerätversion-MAC-Adresse</FormLabel>
                                    <FormGroup>
                                        <TextField className={style.textInput} id="standard-basic" placeholder="192.15.16"/>
                                    </FormGroup>
                                </div>
                                <div className={style.inputGroups}>
                                    <FormLabel>Protokollversion</FormLabel>
                                    <FormGroup>
                                        <TextField className={style.textInput} id="standard-basic" placeholder="v.1.01"/>
                                    </FormGroup>
                                </div>
                                <div className={style.inputGroups}>
                                    <FormLabel>IoT-Gerätversion</FormLabel>
                                    <FormGroup>
                                        <TextField className={style.textInput} id="standard-basic" placeholder="v.0.9"/>
                                    </FormGroup>
                                </div>
                                <div>
                                    <FormGroup>
                                        <FormControlLabel className={style.checkBox} control={<Checkbox name="checkedC" />} label="grease_extension?" />
                                    </FormGroup>
                                </div>
                                <div className={style.inputGroups}>
                                    <FormLabel>Sicherheitsalgorithmus</FormLabel>
                                    <FormGroup>
                                        <TextField className={style.textInput} id="standard-basic" placeholder="Handshake"/>
                                    </FormGroup>
                                </div>
                                <div className={style.inputGroups}>
                                    <FormLabel>MUD-URL</FormLabel>
                                    <FormGroup>
                                        <TextField className={style.textInput} id="standard-basic" placeholder="https://example.com/"/>
                                    </FormGroup>
                                </div>
                                <div>
                                    <form className={classes.container} noValidate>
                                        <TextField
                                            id="datetime-local"
                                            label="Letztes Versions-Update"
                                            type="datetime-local"
                                            defaultValue="2019-05-24T10:30"
                                            className={classes.textField}
                                            InputLabelProps={{
                                                shrink: true,
                                            }}
                                        />
                                    </form>
                                </div>
                            </FormControl>
                        </div>
                    </Typography>
                </Container>
                <StickyFooter/>
            </div>
        </div>
    )
}