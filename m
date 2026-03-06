From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 18:08:30 +0000
References: <gerrit.1772820505000.I89f0aa9a23915c7783ae03793080ee989a437208@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5abeb608941f51179c5d1315da0e5a302ff79979-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XXWTex97SG4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: doc: fix client-nat
 syntax and examples
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XXWTex97SG4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1560?usp=3Demail

to review the following change.


Change subject: doc: fix client-nat syntax and examples
......................................................................

doc: fix client-nat syntax and examples

The client-nat documentation uses an incorrect command form and
incomplete examples.

Document the actual syntax accepted by openvpn:
  client-nat snat|dnat network netmask alias

Update examples to include all required arguments and rewrite the
explanatory text to describe 'network', 'netmask', and 'alias'
separately.

Documentation-only change; no behavior change.

Change-Id: I89f0aa9a23915c7783ae03793080ee989a437208
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M doc/man-sections/client-options.rst
1 file changed, 11 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1560/1

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index b9ae7ce..85d25e5 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -132,16 +132,21 @@
   ifconfig settings pushed to the client would create an IP numbering
   conflict.

+  Valid syntax:
+  ::
+
+      client-nat snat|dnat network netmask alias
+
   Examples:
   ::

-      client-nat snat 192.168.0.0/255.255.0.0
-      client-nat dnat 10.64.0.0/255.255.0.0
+      client-nat snat 192.168.0.0 255.255.0.0 10.64.0.0
+      client-nat dnat 10.64.0.0 255.255.0.0 192.168.0.0

-  ``network/netmask`` (for example :code:`192.168.0.0/255.255.0.0`) defines
-  the local view of a resource from the client perspective, while
-  ``alias/netmask`` (for example :code:`10.64.0.0/255.255.0.0`) defines the
-  remote view from the server perspective.
+  ``network`` and ``netmask`` (for example :code:`192.168.0.0
+  255.255.0.0`) define the local view of a resource from the client
+  perspective, while ``alias`` (for example :code:`10.64.0.0`) defines the
+  remote view from the server perspective using the same netmask.

   Use :code:`snat` (source NAT) for resources owned by the client and
   :code:`dnat` (destination NAT) for remote resources.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1560?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89f0aa9a23915c7783ae03793080ee989a437208
Gerrit-Change-Number: 1560
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--XXWTex97SG4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>ralf_lici would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1560?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">doc: fix client-nat syntax and examples<br>=
<br>The client-nat documentation uses an incorrect command form and<br>inco=
mplete examples.<br><br>Document the actual syntax accepted by openvpn:<br>=
  client-nat snat|dnat network netmask alias<br><br>Update examples to incl=
ude all required arguments and rewrite the<br>explanatory text to describe =
&#39;network&#39;, &#39;netmask&#39;, and &#39;alias&#39;<br>separately.<br=
><br>Documentation-only change; no behavior change.<br><br>Change-Id: I89f0=
aa9a23915c7783ae03793080ee989a437208<br>Signed-off-by: Ralf Lici &lt;ralf@...220...=
..2726...&gt;<br>---<br>M doc/man-sections/client-options.rst<br>1 file cha=
nged, 11 insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1560/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/doc/man-sections/client-options.rst b/doc/man-sections/client-optio=
ns.rst</span><br><span>index b9ae7ce..85d25e5 100644</span><br><span>--- a/=
doc/man-sections/client-options.rst</span><br><span>+++ b/doc/man-sections/=
client-options.rst</span><br><span>@@ -132,16 +132,21 @@</span><br><span>  =
 ifconfig settings pushed to the client would create an IP numbering</span>=
<br><span>   conflict.</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  Valid syntax:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  ::</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      client-nat =
snat|dnat network netmask alias</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>   Examples:</span><br><span>   ::</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      client-na=
t snat 192.168.0.0/255.255.0.0</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      client-nat dnat 10.64.0.0/255.255.0.0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      client-nat snat 192.168.0.0 255.255=
.0.0 10.64.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 client-nat dnat 10.64.0.0 255.255.0.0 192.168.0.0</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  ``network/netmask`` (for e=
xample :code:`192.168.0.0/255.255.0.0`) defines</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  the local view of a resource from the client pe=
rspective, while</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``a=
lias/netmask`` (for example :code:`10.64.0.0/255.255.0.0`) defines the</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  remote view from the ser=
ver perspective.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `=
`network`` and ``netmask`` (for example :code:`192.168.0.0</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  255.255.0.0`) define the local vie=
w of a resource from the client</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  perspective, while ``alias`` (for example :code:`10.64.0.0`) =
defines the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  remote=
 view from the server perspective using the same netmask.</span><br><span> =
</span><br><span>   Use :code:`snat` (source NAT) for resources owned by th=
e client and</span><br><span>   :code:`dnat` (destination NAT) for remote r=
esources.</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1560?usp=3Demail">change 1560</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1560?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89f0aa9a23915c7783ae0379308=
0ee989a437208 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1560 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--XXWTex97SG4=--

