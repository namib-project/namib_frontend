import "../styles/globals.css";
import React from 'react';
import {createMuiTheme, ThemeProvider} from "@material-ui/core/styles";

const darkTheme = createMuiTheme({
    palette: {
        type: typeof window !== "undefined"
            ? window.localStorage.getItem("darkMode") === "dark" ? 'dark' : "light"
            : "light",
    },
})

function MyApp({ Component, pageProps }) {
  return (
    <ThemeProvider theme={darkTheme}>
            <Component {...pageProps} />
    </ThemeProvider>
  );
}

export default MyApp;
