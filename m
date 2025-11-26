From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 11:46:20 +0000
In-Reply-To: <gerrit.1764156955000.I621622905abd4d5ec41468ec3bade4ad6c1d1f31@...2715...>
References: <gerrit.1764156955000.I621622905abd4d5ec41468ec3bade4ad6c1d1f31@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <027ed635d18cfddf960d255add333115dfe0a146-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B2bIlTARIXo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix incorrect RST
 syntax in Changes.rst
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

--B2bIlTARIXo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1404?usp=3Demail

to look at the new patch set (#2).


Change subject: Fix incorrect RST syntax in Changes.rst
......................................................................

Fix incorrect RST syntax in Changes.rst

Single-backquotes are not allowed.  Change every occurance to double.

v2: leave :code:`mtu` alone

Change-Id: I621622905abd4d5ec41468ec3bade4ad6c1d1f31
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
1 file changed, 5 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/1404/2

diff --git a/Changes.rst b/Changes.rst
index 40984f5..3b00264 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -314,17 +314,17 @@
   use from "ifconfig", this change repairs functionality (this has
   been backported to 2.6.15, but is not in earlier 2.6 versions).

-- `max-routes-per-client 0` used to be silently upgraded to `1`.  This
+- ``max-routes-per-client 0`` used to be silently upgraded to ``1``.  This
   now produces an error.

-- `ifconfig` and `ifconfig-ipv6` values are now stored in pre-connect
+- ``ifconfig`` and ``ifconfig-ipv6`` values are now stored in pre-connect
   options cache, and will be restored to pre-connect values on reconnects
   if the server stops pushing the respective option.

-- `tapctl.exe` helper binary on Windows has been reworked to improve
+- ``tapctl.exe`` helper binary on Windows has been reworked to improve
   help texts (making clear that it can not only do TAP-Adapters but
   Win-DCO as well), add printing of the hwid to all adapter outputs, and
-  change the default adapter type created to `ovpn-dco`.
+  change the default adapter type created to ``ovpn-dco``.

 - the default for ``multihome`` egress interface handling has changed.
   2.7.0 will default to ipi_ifindex=3D0, that is, leave the decision to the
@@ -809,7 +809,7 @@
     wait for the second factor authentication to complete.

     This feature currently requires usage of the managent interface
-    on both client and server side. See the `management-notes.txt`
+    on both client and server side. See the ``management-notes.txt``
     ``client-pending-auth`` and ``cr-response`` commands for more
     details.


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1404?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I621622905abd4d5ec41468ec3bade4ad6c1d1f31
Gerrit-Change-Number: 1404
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--B2bIlTARIXo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1404?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Fix incorrect RST syntax in Changes.rst<br><br>Single-b=
ackquotes are not allowed.  Change every occurance to double.<br><br>v2: le=
ave :code:`mtu` alone<br><br>Change-Id: I621622905abd4d5ec41468ec3bade4ad6c=
1d1f31<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M C=
hanges.rst<br>1 file changed, 5 insertions(+), 5 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
04/1404/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/Changes.rst b/Changes.rst</span><br><span>in=
dex 40984f5..3b00264 100644</span><br><span>--- a/Changes.rst</span><br><sp=
an>+++ b/Changes.rst</span><br><span>@@ -314,17 +314,17 @@</span><br><span>=
   use from &quot;ifconfig&quot;, this change repairs functionality (this h=
as</span><br><span>   been backported to 2.6.15, but is not in earlier 2.6 =
versions).</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-- `max-routes-per-client 0` used to be silently upgraded to `1`.  Th=
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- ``max-routes-pe=
r-client 0`` used to be silently upgraded to ``1``.  This</span><br><span> =
  now produces an error.</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-- `ifconfig` and `ifconfig-ipv6` values are now stored=
 in pre-connect</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- ``=
ifconfig`` and ``ifconfig-ipv6`` values are now stored in pre-connect</span=
><br><span>   options cache, and will be restored to pre-connect values on =
reconnects</span><br><span>   if the server stops pushing the respective op=
tion.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-- `tapctl.exe` helper binary on Windows has been reworked to improve</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+- ``tapctl.exe`` helper =
binary on Windows has been reworked to improve</span><br><span>   help text=
s (making clear that it can not only do TAP-Adapters but</span><br><span>  =
 Win-DCO as well), add printing of the hwid to all adapter outputs, and</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  change the default adap=
ter type created to `ovpn-dco`.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  change the default adapter type created to ``ovpn-dco``.</spa=
n><br><span> </span><br><span> - the default for ``multihome`` egress inter=
face handling has changed.</span><br><span>   2.7.0 will default to ipi_ifi=
ndex=3D0, that is, leave the decision to the</span><br><span>@@ -809,7 +809=
,7 @@</span><br><span>     wait for the second factor authentication to com=
plete.</span><br><span> </span><br><span>     This feature currently requir=
es usage of the managent interface</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    on both client and server side. See the `management-notes.=
txt`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    on both cli=
ent and server side. See the ``management-notes.txt``</span><br><span>     =
``client-pending-auth`` and ``cr-response`` commands for more</span><br><sp=
an>     details.</span><br><span> </span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1404?usp=3Demai=
l">change 1404</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1404?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I621622905abd4d5ec41468ec3ba=
de4ad6c1d1f31 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1404 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--B2bIlTARIXo=--

