---
layout: default
---

## blockchain explorer

<form>
<input name="ypath" type="txt" value="/files/tmp/blockchaindemo/toc.yml">
<input type=submit onclick="update()">
</form>

# block <span id="n">n</span>

<a href="http://gateway.local/webui#/files/tmp/blockchaindemo/toc.yml">/files/tmp/blockchaindemo/toc.yml</a>

<div content=blockchain id=head>
<iframe width="80%" src="http://gateway.local/webui#/files/tmp/blockchaindemo/toc.yml"></iframe>
<script>
function callback() {
  const div = document.getElementById('head');
  var src = div.getElementsByTagName('iframe')[0].src;
  fetch(src).then(resp => resp.text())
  .then(text => {
    div.innerHTML = '<pre>'+text+'</pre>'
    div.innerHTML = div.innerHTML.replace(new RegExp(
      ' ((/ip[fn]s/)?(Qm[A-Za-z0-9]*)[^ \n]+)','g'), function(_,a,b,c) {
      console.log('rex: ',_,a,b,c);
      return ' <a href='+lgw+a+'>'+a+'</a>' })
   })
  .catch(error)
}
</script>
</div>



