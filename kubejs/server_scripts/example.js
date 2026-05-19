// priority: 0

// Visit the wiki for more info - https://kubejs.com/

console.info('Hello, World! (Loaded server scripts)')

BlockEvents.placed('minecraft:crafting_table', event => {
  event.player.tell('NO CRAFTING FOR YOU')
 
  event.block.set('minecraft:oak_log')
})

ServerEvents.recipes(event => {
    event.remove({ output: 'minecraft:crafting_table' })
    event.remove({ input: 'minecraft:crafting_table' })
})

console.log('test')