import React from 'react';
import Typography from '@material-ui/core/Typography';
import Container from '@material-ui/core/Container';
import TextField from '@material-ui/core/TextField';
import {Button, FormControl, FormGroup} from "@material-ui/core";
import FormLabel from '@material-ui/core/FormLabel';
import style from './editDevice.module.scss';
import CustomDialog from './MUDDialog';
import Drawer from '../drawer';



export default function EditDevice() {

    return (
        <div>
            <div>
                <Drawer/>
            </div>

            <div className={style.test}>
                <Container maxWidth="lg">
                    <Typography component="div" style={{height: '90vh'}}
                                className={style.typographyStyle}>
                        <h2 className={style.heading}>Geräteeinstellungen bearbeiten</h2>
                        <div className={style.container}>
                            <FormControl style={{display: "block"}}>
                                <div className={style.inputGroups}>
                                    <FormLabel>Geräte-Typ:</FormLabel>
                                    <FormGroup>
                                        <TextField className={style.textInput} id="device-type" placeholder="Lampe"/>
                                    </FormGroup>
                                </div>
                                <br/>
                                <div className={style.inputGroups}>
                                    <FormLabel>Gerätename:</FormLabel>
                                    <FormGroup>
                                        <TextField className={style.textInput} id="device-name" placeholder="CTED13-155"/>
                                    </FormGroup>
                                </div>
                            </FormControl>
                        </div>
                        <div className={style.dialogContainer}>
                            <br/>
                            <p className={style.dialogLabel}>Aktuelles MUD - Profil</p>
                            <CustomDialog />
                        </div>
                        <br/>
                        <div className={style.buttonContainer}>
                            <div className={style.buttons}>
                                <Button variant="contained" color="primary">
                                    Speichern
                                </Button>
                            </div>
                            <div className={style.buttons}>
                                <Button variant="contained">Abbrechen</Button>
                            </div>
                        </div>
                    </Typography>
                </Container>
            </div>
        </div>
    )
}