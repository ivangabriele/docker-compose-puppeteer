const { After, Before, Then, When } = require('cucumber')

Before(async function() {
  return await this.start()
})

After(async function() {
  return await this.stop()
})

When('I open the homepage', async function() {
  await this.goToHome()
})

Then('I should see the title {string}', async function(text) {
  await this.checkTitle(text)
})
