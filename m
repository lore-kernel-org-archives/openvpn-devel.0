From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 18:08:25 +0000
In-Reply-To: <gerrit.1764157430000.I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8@...2715...>
References: <gerrit.1764157430000.I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fb3eae8e7f40561fb6233842ce14c873a03c9930-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qWZSN9srlmw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Changes.rst: Fix
 various syntax errors and typos
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qWZSN9srlmw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
05?usp=3Demail )

Change subject: Changes.rst: Fix various syntax errors and typos
......................................................................

Changes.rst: Fix various syntax errors and typos

Mostly people trying to write MarkDown, but this is
reStructuredText.

Change-Id: I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1405
Message-Id: <20251126120009.12191-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
707.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
1 file changed, 8 insertions(+), 7 deletions(-)




diff --git a/Changes.rst b/Changes.rst
index 40984f5..20d8957 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -112,7 +112,8 @@
     can be pinged, can serve a website and more without requiring any
     elevated permission. This can make testing OpenVPN much easier.

-    For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/l=
wipovpn).
+    For more details see
+    `lwipovpn on Github <https://github.com/OpenVPN/lwipovpn>`_.

 Allow overriding username with ``--override-username``
     This is intended to allow using auth-gen-token in scenarios where the
@@ -314,17 +315,17 @@
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
@@ -809,7 +810,7 @@
     wait for the second factor authentication to complete.

     This feature currently requires usage of the managent interface
-    on both client and server side. See the `management-notes.txt`
+    on both client and server side. See the ``management-notes.txt``
     ``client-pending-auth`` and ``cr-response`` commands for more
     details.

@@ -828,7 +829,7 @@
 Allow unicode search string in ``--cryptoapicert`` option (Windows)

 Support IPv4 configs with /31 netmasks now
-    (By no longer trying to configure ``broadcast x.x.x.x'' in
+    (By no longer trying to configure ``broadcast x.x.x.x`` in
     ifconfig calls, /31 support "just works")

 New option ``--block-ipv6`` to reject all IPv6 packets (ICMPv6)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1405?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8
Gerrit-Change-Number: 1405
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qWZSN9srlmw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1405?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Changes.rst: Fix various syntax errors and typos=
<br><br>Mostly people trying to write MarkDown, but this is<br>reStructured=
Text.<br><br>Change-Id: I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/open=
vpn/+/1405<br>Message-Id: &lt;20251126120009.12191-1-gert@...1296...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3=
4707.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M Changes.rst<br>1 file changed, 8 insertions(+), 7 deletions(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 40984f5..20=
d8957 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -112,7 +112,8 @@</span><br><span>     can be pinge=
d, can serve a website and more without requiring any</span><br><span>     =
elevated permission. This can make testing OpenVPN much easier.</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    For more de=
tails see [lwipovpn on Gihtub](https://github.com/OpenVPN/lwipovpn).</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    For more details see</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    `lwipovpn on Gith=
ub &lt;https://github.com/OpenVPN/lwipovpn&gt;`_.</span><br><span> </span><=
br><span> Allow overriding username with ``--override-username``</span><br>=
<span>     This is intended to allow using auth-gen-token in scenarios wher=
e the</span><br><span>@@ -314,17 +315,17 @@</span><br><span>   use from &qu=
ot;ifconfig&quot;, this change repairs functionality (this has</span><br><s=
pan>   been backported to 2.6.15, but is not in earlier 2.6 versions).</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-- `max-r=
outes-per-client 0` used to be silently upgraded to `1`.  This</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+- ``max-routes-per-client 0`` us=
ed to be silently upgraded to ``1``.  This</span><br><span>   now produces =
an error.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-- `ifconfig` and `ifconfig-ipv6` values are now stored in pre-connect=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- ``ifconfig`` and =
``ifconfig-ipv6`` values are now stored in pre-connect</span><br><span>   o=
ptions cache, and will be restored to pre-connect values on reconnects</spa=
n><br><span>   if the server stops pushing the respective option.</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-- `tapctl.exe=
` helper binary on Windows has been reworked to improve</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+- ``tapctl.exe`` helper binary on Windo=
ws has been reworked to improve</span><br><span>   help texts (making clear=
 that it can not only do TAP-Adapters but</span><br><span>   Win-DCO as wel=
l), add printing of the hwid to all adapter outputs, and</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  change the default adapter type create=
d to `ovpn-dco`.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  c=
hange the default adapter type created to ``ovpn-dco``.</span><br><span> </=
span><br><span> - the default for ``multihome`` egress interface handling h=
as changed.</span><br><span>   2.7.0 will default to ipi_ifindex=3D0, that =
is, leave the decision to the</span><br><span>@@ -809,7 +810,7 @@</span><br=
><span>     wait for the second factor authentication to complete.</span><b=
r><span> </span><br><span>     This feature currently requires usage of the=
 managent interface</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  on both client and server side. See the `management-notes.txt`</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    on both client and server =
side. See the ``management-notes.txt``</span><br><span>     ``client-pendin=
g-auth`` and ``cr-response`` commands for more</span><br><span>     details=
.</span><br><span> </span><br><span>@@ -828,7 +829,7 @@</span><br><span> Al=
low unicode search string in ``--cryptoapicert`` option (Windows)</span><br=
><span> </span><br><span> Support IPv4 configs with /31 netmasks now</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    (By no longer trying to =
configure ``broadcast x.x.x.x&#39;&#39; in</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    (By no longer trying to configure ``broadcast x.=
x.x.x`` in</span><br><span>     ifconfig calls, /31 support &quot;just work=
s&quot;)</span><br><span> </span><br><span> New option ``--block-ipv6`` to =
reject all IPv6 packets (ICMPv6)</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1405?usp=3Demail"=
>change 1405</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1405?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e390a276418dda9e7caa6edcd3=
a9d59d50ce4f8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1405 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--qWZSN9srlmw=--

