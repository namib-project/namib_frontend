import Drawer from '../drawer';
import React from 'react';
import Typography from '@material-ui/core/Typography';
import Container from '@material-ui/core/Container';
import {makeStyles} from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import {FormControl, FormGroup} from "@material-ui/core";
import FormLabel from '@material-ui/core/FormLabel';
import style from './editDevice.module.scss';

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
                    <Typography component="div" style={{backgroundColor: "white", height: '80vh'}}
                                className={style.typographyStyle}>
                        <h2 className={style.heading}>Geräteeinstellungen bearbeiten</h2>
                        <div className={style.container}>
                            <FormControl style={{display: "block"}}>
                                <div className={style.inputGroups}>
                                    <FormLabel>Gerät:</FormLabel>
                                    <FormGroup>
                                        <TextField className={style.textInput} id="standard-basic" placeholder="Mobile"/>
                                    </FormGroup>
                                </div>
                                <div className={style.inputGroups}>
                                    <FormLabel>Gerätename:</FormLabel>
                                    <FormGroup>
                                        <TextField className={style.textInput} id="standard-basic" placeholder="Samsung Galaxy S20"/>
                                    </FormGroup>
                                </div>
                            </FormControl>
                        </div>
                    </Typography>
                </Container>
            </div>
        </div>
    )
}