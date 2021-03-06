#!/usr/bin/env node

// THIS FILE IS CODE-GENERATED
// Encapsule holistic v0.0.38 "calvert-rc4" xVMelTFpRSmMS7faXh6MWQ 9aeb4b84798f9e67c9e6513e6890fa354a4fb6db
//

const arccore = require("@encapsule/arccore");

const childProcess = require("child_process");
const fs = require("fs");
const path = require("path");

// Get long-form git commit hash of the most recent commit on the current branch.
//
// WARNING:
// It is perfectly valid to rebuild the application with uncommited/untracked changes.
// So we neither check nor enforce policy regarding uncommitted/untracked repo changes here.
//
// HOWEVER, as a matter of deployment policy it is strongly suggested that developers
// ensure that production builds are allowed only on git branches with no uncommitted or
// untracked changes. If this precondition is met, then the commit hash captured below
// can be used to unambiguously track a deployed application runtime back to the precise
// versions of application, platform, and tooling infrastructure used to produce the
// deployed runtime. This allows you to, for example, rebuild the version exactly in
// order to debug problems. Or, test out changes.
//
// TODO: Persist the list of uncommitted/untracked changes at the time that the buildtag
// manifest is created. Mostly we don't care. However, one might check this information
// in a deployment script and refuse to deploy untrackable test builds to the cloud.
//

const commitHash = childProcess.execSync('git rev-parse HEAD').toString('utf8').trim();

// We're executing at the behest of some recipe defined in the code-generated Makefile
// used to build the application runtime. Load up all the various pieces of metadata
// that we have defined in this holistic application git repository, grab some timestamps,
// generate a unique ID for the build, and create a unique build-manifest.

const holisticApplicationManifest = require("../../holistic-app");
const applicationPackageManifest = require("../../package");
const holisticPlatformManifest = require("../../HOLISTIC/PACKAGES/holistic");

const buildTime = arccore.util.getEpochTime(); // this is in unit seconds
const buildDate = new Date(buildTime * 1000);
const buildDateISO = buildDate.toISOString();
const buildYear = buildDate.getFullYear();

console.log(JSON.stringify({
    app: {
        name: applicationPackageManifest.name,
        description: applicationPackageManifest.description,
        version: applicationPackageManifest.version,
        codename: applicationPackageManifest.codename,
        author: applicationPackageManifest.author,
        contributors: applicationPackageManifest.contributors,
        license: applicationPackageManifest.license,
        buildID: arccore.identifier.irut.fromEther(),
        buildSource: commitHash,
        buildTime: buildTime,
        buildDateISO: buildDateISO,
        buildYear: buildYear
    },
    platform: holisticPlatformManifest


}, undefined, 2));
