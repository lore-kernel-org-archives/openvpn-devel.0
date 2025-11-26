From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 11:35:59 +0000
References: <gerrit.1764156955000.I621622905abd4d5ec41468ec3bade4ad6c1d1f31@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2493af4d8e9ae41330f436074f019c31b9c412cf-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0DLTV2TYAQk="; charset=UTF-8
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

--0DLTV2TYAQk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1404?usp=3Demail

to review the following change.


Change subject: Fix incorrect RST syntax in Changes.rst
......................................................................

Fix incorrect RST syntax in Changes.rst

Single-backquotes are not allowed.  Change every occurance to double.

Change-Id: I621622905abd4d5ec41468ec3bade4ad6c1d1f31
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
1 file changed, 7 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/1404/1

diff --git a/Changes.rst b/Changes.rst
index 40984f5..d47c990 100644
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
@@ -418,7 +418,7 @@


 Improved ``--mssfix`` and ``--fragment`` calculation
-    The ``--mssfix`` and ``--fragment`` options now allow an optional :cod=
e:`mtu`
+    The ``--mssfix`` and ``--fragment`` options now allow an optional :cod=
e:``mtu``
     parameter to specify that different overhead for IPv4/IPv6 should take=
n into
     account and the resulting size is specified as the total size of the V=
PN packets
     including IP and UDP headers.
@@ -547,7 +547,7 @@
 - CHACHA20-POLY1305 is included in the default of ``--data-ciphers`` when =
available.
 - Option ``--prng`` is ignored as we rely on the SSL library random number=
 generator.
 - Option ``--nobind`` is default when ``--client`` or ``--pull`` is used i=
n the configuration
-- :code:`link_mtu` parameter is removed from environment or replaced with =
0 when scripts are
+- :code:``link_mtu`` parameter is removed from environment or replaced wit=
h 0 when scripts are
   called with parameters. This parameter is unreliable and no longer inter=
nally calculated.

 - control channel packet maximum size is no longer influenced by
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I621622905abd4d5ec41468ec3bade4ad6c1d1f31
Gerrit-Change-Number: 1404
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--0DLTV2TYAQk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1404?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Fix incorrect RST syntax in Changes.rst<br>=
<br>Single-backquotes are not allowed.  Change every occurance to double.<b=
r><br>Change-Id: I621622905abd4d5ec41468ec3bade4ad6c1d1f31<br>Signed-off-by=
: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M Changes.rst<br>1 file ch=
anged, 7 insertions(+), 7 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/1404/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/Changes.rst b/Changes.rst</span><br><span>index 40984f5..d47c990 10=
0644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</s=
pan><br><span>@@ -314,17 +314,17 @@</span><br><span>   use from &quot;ifcon=
fig&quot;, this change repairs functionality (this has</span><br><span>   b=
een backported to 2.6.15, but is not in earlier 2.6 versions).</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-- `max-routes-pe=
r-client 0` used to be silently upgraded to `1`.  This</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+- ``max-routes-per-client 0`` used to be=
 silently upgraded to ``1``.  This</span><br><span>   now produces an error=
.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-- =
`ifconfig` and `ifconfig-ipv6` values are now stored in pre-connect</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+- ``ifconfig`` and ``ifconf=
ig-ipv6`` values are now stored in pre-connect</span><br><span>   options c=
ache, and will be restored to pre-connect values on reconnects</span><br><s=
pan>   if the server stops pushing the respective option.</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-- `tapctl.exe` helper=
 binary on Windows has been reworked to improve</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+- ``tapctl.exe`` helper binary on Windows has b=
een reworked to improve</span><br><span>   help texts (making clear that it=
 can not only do TAP-Adapters but</span><br><span>   Win-DCO as well), add =
printing of the hwid to all adapter outputs, and</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  change the default adapter type created to `ov=
pn-dco`.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  change th=
e default adapter type created to ``ovpn-dco``.</span><br><span> </span><br=
><span> - the default for ``multihome`` egress interface handling has chang=
ed.</span><br><span>   2.7.0 will default to ipi_ifindex=3D0, that is, leav=
e the decision to the</span><br><span>@@ -418,7 +418,7 @@</span><br><span> =
</span><br><span> </span><br><span> Improved ``--mssfix`` and ``--fragment`=
` calculation</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    The =
``--mssfix`` and ``--fragment`` options now allow an optional :code:`mtu`</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    The ``--mssfix`` =
and ``--fragment`` options now allow an optional :code:``mtu``</span><br><s=
pan>     parameter to specify that different overhead for IPv4/IPv6 should =
taken into</span><br><span>     account and the resulting size is specified=
 as the total size of the VPN packets</span><br><span>     including IP and=
 UDP headers.</span><br><span>@@ -547,7 +547,7 @@</span><br><span> - CHACHA=
20-POLY1305 is included in the default of ``--data-ciphers`` when available=
.</span><br><span> - Option ``--prng`` is ignored as we rely on the SSL lib=
rary random number generator.</span><br><span> - Option ``--nobind`` is def=
ault when ``--client`` or ``--pull`` is used in the configuration</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-- :code:`link_mtu` parameter is=
 removed from environment or replaced with 0 when scripts are</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+- :code:``link_mtu`` parameter is=
 removed from environment or replaced with 0 when scripts are</span><br><sp=
an>   called with parameters. This parameter is unreliable and no longer in=
ternally calculated.</span><br><span> </span><br><span> - control channel p=
acket maximum size is no longer influenced by</span><br><span>@@ -809,7 +80=
9,7 @@</span><br><span>     wait for the second factor authentication to co=
mplete.</span><br><span> </span><br><span>     This feature currently requi=
res usage of the managent interface</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    on both client and server side. See the `management-notes=
.txt`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    on both cl=
ient and server side. See the ``management-notes.txt``</span><br><span>    =
 ``client-pending-auth`` and ``cr-response`` commands for more</span><br><s=
pan>     details.</span><br><span> </span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1404?usp=3Dema=
il">change 1404</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1404?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I621622905abd4d5ec41468ec3ba=
de4ad6c1d1f31 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1404 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--0DLTV2TYAQk=--

