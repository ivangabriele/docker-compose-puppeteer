const { setWorldConstructor } = require('cucumber')
const { expect } = require('chai')
const puppeteer = require('puppeteer')

if (process.env.WEB_URI === undefined) {
  require('dotenv').config({ path: `${__dirname}/../../../.env` })
}

const WEB_URI = process.env.WEB_URI !== undefined
  ? process.env.WEB_URI
  : `http://localhost:${process.env.WEB_PORT}`

console.log(WEB_URI)

class World {
  async start() {
    this.browser = await puppeteer.launch({
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    })
    this.page = await this.browser.newPage()
    this.extendPage()
  }

  extendPage() {
    this.page.waitForSelectors = function(selectors) {
      return Promise.all(
        selectors.map(selector => this.waitForSelector(selector))
      )
    }.bind(this.page)
  }

  async goToHome() {
    await this.page.goto(WEB_URI)
  }

  async checkTitle(text) {
    const titleSelector = 'h1'
    await this.page.waitForSelector(titleSelector)

    const titleText = await this.page.evaluate(
      titleSelector => document.querySelector(titleSelector).innerText,
      titleSelector
    )

    expect(titleText).to.eql(text)
  }

  async stop() {
    await this.browser.close()
  }
}

setWorldConstructor(World)
