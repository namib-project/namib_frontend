import Drawer from '../drawer';
import React from 'react';
import Typography from '@material-ui/core/Typography';
import Container from '@material-ui/core/Container';
import {makeStyles} from '@material-ui/core/styles';
import TextField from '@material-ui/core/TextField';
import {FormControl, FormGroup, Table, TableBody, TableHead} from "@material-ui/core";
import FormLabel from '@material-ui/core/FormLabel';
import style from './deviceOverview.module.scss';
import TableCell from "@material-ui/core/TableCell";
import TableRow from "@material-ui/core/TableRow";
import TableContainer from "@material-ui/core/TableContainer";
import Paper from "@material-ui/core/Paper";
import IconButton from "@material-ui/core/IconButton";
import DeleteIcon from '@material-ui/icons/Delete';
import SettingsIcon from '@material-ui/icons/Settings';
import CheckIcon from '@material-ui/icons/Check';
import ClearIcon from '@material-ui/icons/Clear';

const useStyles = makeStyles((theme) => ({
    root: {
        '& > *': {
            margin: theme.spacing(1),
            width: '25ch',
        },
    },
}));

function createData(name, active, mudProfile, carbs, protein) {
    return { name, active, mudProfile, carbs, protein };
}

// "/editDevice"

const rows = [
    createData('Fernseher', <IconButton aria-label="active">
        <CheckIcon />
    </IconButton>, 3, <IconButton onClick={(e) => {
        e.preventDefault();
        window.location.href='/editDevice';
    }} aria-label="settings">
        <SettingsIcon />
    </IconButton>, <IconButton aria-label="delete">
        <DeleteIcon />
    </IconButton>),
    createData('Deckenlampe', <IconButton aria-label="active">
        <ClearIcon />
    </IconButton>, 2, <IconButton onClick={(e) => {
        e.preventDefault();
        window.location.href='/editDevice';
    }} aria-label="settings">
        <SettingsIcon />
    </IconButton>, <IconButton aria-label="delete">
        <DeleteIcon />
    </IconButton>),
    createData('Toaster', <IconButton aria-label="active">
        <CheckIcon />
    </IconButton>, 3, <IconButton onClick={(e) => {
        e.preventDefault();
        window.location.href='/editDevice';
    }} aria-label="settings">
        <SettingsIcon />
    </IconButton>, <IconButton aria-label="delete">
        <DeleteIcon />
    </IconButton>),
    createData('Thermostat', <IconButton aria-label="active">
        <CheckIcon />
    </IconButton>, 1, <IconButton onClick={(e) => {
        e.preventDefault();
        window.location.href='/editDevice';
    }} aria-label="settings">
        <SettingsIcon />
    </IconButton>, <IconButton aria-label="delete">
        <DeleteIcon />
    </IconButton>),
    createData('WLAN Speaker', <IconButton aria-label="active">
        <ClearIcon />
    </IconButton>, 1, <IconButton onClick={(e) => {
        e.preventDefault();
        window.location.href='/editDevice';
    }} aria-label="settings">
        <SettingsIcon />
    </IconButton>, <IconButton aria-label="delete">
        <DeleteIcon />
    </IconButton>),
];

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
                        <h2 className={style.heading}>Geräteübersicht</h2>
                        <div className={style.container}>
                            <TableContainer component={Paper}>
                                <Table className={classes.root} aria-label="simple table">
                                    <TableHead>
                                        <TableRow>
                                            <TableCell>Gerätename</TableCell>
                                            <TableCell align="right">Aktiv</TableCell>
                                            <TableCell align="right">MUD-Profil</TableCell>
                                            <TableCell align="right"/>
                                            <TableCell align="right"/>
                                        </TableRow>
                                    </TableHead>
                                    <TableBody>
                                        {rows.map((row) => (
                                            <TableRow key={row.name}>
                                                <TableCell component="th" scope="row">
                                                    {row.name}
                                                </TableCell>
                                                <TableCell align="right">{row.active}</TableCell>
                                                <TableCell align="right">{row.mudProfile}</TableCell>
                                                <TableCell align="right">{row.carbs}</TableCell>
                                                <TableCell align="left">{row.protein}</TableCell>
                                            </TableRow>
                                        ))}
                                    </TableBody>
                                </Table>
                            </TableContainer>
                        </div>
                    </Typography>
                </Container>
            </div>
        </div>
    )
}