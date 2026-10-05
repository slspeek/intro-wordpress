import 'reveal.js/reveal.css'
import 'reveal.js/theme/black.css'
import Reveal from 'reveal.js'
import Markdown from 'reveal.js/plugin/markdown'
import CopyCode from 'reveal.js-copycode';
import 'reveal.js-copycode/plugin/copycode/copycode.css';
 import './style.css'

const deck = new Reveal({
  hash: true,
  progress: true,
  slideNumber: true,
  transition: 'slide',
  plugins: [Markdown, CopyCode],
})

deck.initialize()
