// THIS FILE IS CODE-GENERATED
// Encapsule holistic v0.1.00 "alertbay" 7iQT_OrST8uVF1QuNJWEJw 19a7500adce4b27a61e77db731bb051baf754f0e
//
// webpack.config.app.client.js
//

const path = require('path');
const entryPath = path.resolve(path.join(__dirname, '../../BUILD/transpile-phase1/CLIENT/client.js'));
const outputPath = path.resolve(path.join(__dirname, '../../BUILD/webpack-phase2/'));

console.log("webpack entry module path: " + entryPath);
console.log("webpack output path: " + outputPath);

module.exports = {
    mode: 'development',
    plugins: [
    ],
    entry: {
        main: entryPath
    },
    target: "web",
    output: {
        path: outputPath,
        filename: 'client-app-bundle.js'
    },
    module: {
        rules: [
            {
                test: /\.css$/,
                use: ["style-loader", "css-loader"],
            },
        ],
    }
};
