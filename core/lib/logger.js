const info = (str) => {
    console.log("\x1b[92minfo:\x1b[0m", str)
}

const warn = (str) => {
    console.log("\x1b[93mwarn:\x1b[0m", str)
}

const error = (str) => {
    console.log("\x1b[91merror:\x1b[0m", str)
}

module.exports = { info, warn, error }