import express from "express";
import path from "path";

const app = express();

app.use(express.static("public"));
app.use(express.static("views"))

app.get("/", (req, res) => {
    res.render("/views/index.html")
});

app.listen(3000, () => {
    console.log("http://localhost:3000");
});
