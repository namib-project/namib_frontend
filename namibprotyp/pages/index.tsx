import Head from "next/head";
import styles from "../styles/Home.module.css";
import Link from "next/link";

export default function Home() {
  return (
    <div>
      <h1>Startseite/Login</h1>

      <form method="POST" action="/api/login">
        <input type="text" name="username" value="admin" />
        <br />
        <input type="password" name="password" value="123" />
        <br />
        <input type="button" value="Login" />
      </form>

      <h2>
        Link zur Übersicht:{" "}
        <Link href="/overview">
          <a>Overview</a>
        </Link>
      </h2>
      <h2>
        Link zur Übersicht:{" "}
        <Link href="/networkbehaviour">
          <a>Netzwerkverhalten</a>
        </Link>
      </h2>
    </div>
  );
}
