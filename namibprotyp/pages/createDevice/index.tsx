import Drawer from '../drawer';
import React from 'react';
import Typography from '@material-ui/core/Typography';
import Container from '@material-ui/core/Container';
import {makeStyles} from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import {Button, FormControl, FormGroup} from "@material-ui/core";
import FormLabel from '@material-ui/core/FormLabel';
import style from './createDevice.module.scss';
import CustomDialog from './MUDDialog'

const useStyles = makeStyles((theme) => ({
    root: {
        '& > *': {
            margin: theme.spacing(1),
            width: '25ch',
        },
    },
}));

export default function Test() {
    const classes = useStyles();

    return (
        <div>
            <div>
                <Drawer/>
            </div>
            <div className={style.test}>
                <Container maxWidth="lg">
                    <Typography component="div" style={{height: '90vh'}}
                                className={style.typographyStyle}>
                        <h2 className={style.heading}>Gerät hinzufügen</h2>
                        <div className={style.container}>
                            <FormControl style={{display: "block"}}>
                                <div className={style.inputGroups}>
                                    <FormLabel>Gerät:</FormLabel>
                                    <FormGroup>
                                        <TextField className={style.textInput} id="standard-basic" />
                                    </FormGroup>
                                </div>
                                <br/>
                                <div className={style.inputGroups}>
                                    <FormLabel>Gerätename:</FormLabel>
                                    <FormGroup>
                                        <TextField className={style.textInput} id="standard-basic" />
                                    </FormGroup>
                                </div>
                            </FormControl>
                        </div>
                        <div className={style.dialogContainer}>
                            <br/>
                            <p className={style.dialogLabel}>MUD-Profil</p>
                            <CustomDialog />
                        </div>
                        <br/>
                        <div style={{position: 'relative'}}>
                            <form className={style.buttonGroup}>
                                <FormGroup>
                                    <Button onClick={(e) => {
                                        e.preventDefault();
                                        window.location.href = '/deviceOverview';
                                    }} className={style.buttons} variant="contained" color="primary">
                                        Speichern
                                    </Button>
                                    <br/>
                                    <Button onClick={(e) => {
                                        e.preventDefault();
                                        window.location.href = '/deviceOverview';
                                    }} className={style.buttons} variant="contained" >Abbrechen</Button>
                                </FormGroup>
                            </form>
                        </div>
                    </Typography>
                </Container>
            </div>
        </div>
    )
}