#!/usr/bin/env node

// THIS FILE IS CODE-GENERATED
// Encapsule holistic v0.0.38 "calvert-rc4" xVMelTFpRSmMS7faXh6MWQ 9aeb4b84798f9e67c9e6513e6890fa354a4fb6db
//

const arctoolslib = require('@encapsule/arctools');

const program = arctoolslib.commander;

program
    .name("generate-runtime-package-manifest")
    .description("Generate runtime package manifest (package.json) from application build manifest (app-build.json).")
    .version("0.0.38")
    .option('--appBuildManifest <manifestPath>', 'Use <manifestPath> to select the location of the input app-build.json.')
    .parse(process.argv);

if (!program.appBuildManifest) {
    console.error("Missing --appBuildManifest option value.");
    process.exit(1);
}

var filterResponse = arctoolslib.jsrcFileLoaderSync.request(program.appBuildManifest);
if (filterResponse.error) {
    throw new Error("Invalid --appBuildManifest value. " + filterResponse.error);
}

const applicationBuildManifest = filterResponse.result.resource;


// ================================================================
// package.json generation

var packageRuntimeManifest = applicationBuildManifest.app;
packageRuntimeManifest.name = packageRuntimeManifest.name + "-app-runtime";
packageRuntimeManifest.scripts  = {
    start: "node ./SERVER/server.js"
};

// Serialize the manifest as JSON and write to stdout.
console.log(JSON.stringify(packageRuntimeManifest, undefined, 2));
