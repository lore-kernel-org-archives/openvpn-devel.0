From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Mar 2026 13:41:41 +0000
In-Reply-To: <gerrit.1772820505000.I89f0aa9a23915c7783ae03793080ee989a437208@...2715...>
References: <gerrit.1772820505000.I89f0aa9a23915c7783ae03793080ee989a437208@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <4096ba25ab5c90ee94cec24fcc2cd1822b2ef5d2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7LoEGaDdcHI="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7LoEGaDdcHI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 ralf_lici. ( http://gerrit.openvpn.net/c/openvpn/+/1560?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1560
Message-Id: <20260309130546.7735-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
966.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/client-options.rst
1 file changed, 11 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/1560/3

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89f0aa9a23915c7783ae03793080ee989a437208
Gerrit-Change-Number: 1560
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7LoEGaDdcHI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by ralf_lici.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1560?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">doc: fix client-nat syntax a=
nd examples<br><br>The client-nat documentation uses an incorrect command f=
orm and<br>incomplete examples.<br><br>Document the actual syntax accepted =
by openvpn:<br>  client-nat snat|dnat network netmask alias<br><br>Update e=
xamples to include all required arguments and rewrite the<br>explanatory te=
xt to describe &#39;network&#39;, &#39;netmask&#39;, and &#39;alias&#39;<br=
>separately.<br><br>Documentation-only change; no behavior change.<br><br>C=
hange-Id: I89f0aa9a23915c7783ae03793080ee989a437208<br>Signed-off-by: Ralf =
Lici &lt;ralf@...2726...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2375...=
41...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1560<br>Mes=
sage-Id: &lt;20260309130546.7735-1-gert@...1296...&gt;<br>URL: https://www.=
mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35966.html<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections=
/client-options.rst<br>1 file changed, 11 insertions(+), 6 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/60/1560/3</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-options.rs=
t b/doc/man-sections/client-options.rst</span><br><span>index b9ae7ce..85d2=
5e5 100644</span><br><span>--- a/doc/man-sections/client-options.rst</span>=
<br><span>+++ b/doc/man-sections/client-options.rst</span><br><span>@@ -132=
,16 +132,21 @@</span><br><span>   ifconfig settings pushed to the client wo=
uld create an IP numbering</span><br><span>   conflict.</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntax:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      client-nat snat|dnat network netmask alias</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   Examples:<=
/span><br><span>   ::</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-      client-nat snat 192.168.0.0/255.255.0.0</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-      client-nat dnat 10.64.0.0/2=
55.255.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      cli=
ent-nat snat 192.168.0.0 255.255.0.0 10.64.0.0</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      client-nat dnat 10.64.0.0 255.255.0.0 192.=
168.0.0</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  ``network/netmask`` (for example :code:`192.168.0.0/255.255.0.0`) def=
ines</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  the local view =
of a resource from the client perspective, while</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  ``alias/netmask`` (for example :code:`10.64.0.=
0/255.255.0.0`) defines the</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  remote view from the server perspective.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  ``network`` and ``netmask`` (for example :co=
de:`192.168.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  25=
5.255.0.0`) define the local view of a resource from the client</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  perspective, while ``alias`` =
(for example :code:`10.64.0.0`) defines the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  remote view from the server perspective using the=
 same netmask.</span><br><span> </span><br><span>   Use :code:`snat` (sourc=
e NAT) for resources owned by the client and</span><br><span>   :code:`dnat=
` (destination NAT) for remote resources.</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1560?usp=
=3Demail">change 1560</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1560?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89f0aa9a23915c7783ae0379308=
0ee989a437208 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1560 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--7LoEGaDdcHI=--

