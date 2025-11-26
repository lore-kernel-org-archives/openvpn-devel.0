From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 11:48:08 +0000
In-Reply-To: <gerrit.1764157430000.I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8@...2715...>
References: <gerrit.1764157430000.I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fdecba18a16f900232b85a9dc3e546945d9219f4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1sNHwEsWgJw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1sNHwEsWgJw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1405?usp=3Demail

to look at the new patch set (#2).


Change subject: Changes.rst: Fix various syntax errors and typos
......................................................................

Changes.rst: Fix various syntax errors and typos

Mostly people trying to write MarkDown, but this is
reStructuredText.

Change-Id: I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M Changes.rst
1 file changed, 8 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/1405/2

diff --git a/Changes.rst b/Changes.rst
index 9077064..f46f7f1 100644
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

 Deprecated features
 -------------------
@@ -803,7 +804,7 @@
     wait for the second factor authentication to complete.

     This feature currently requires usage of the managent interface
-    on both client and server side. See the `management-notes.txt`
+    on both client and server side. See the ``management-notes.txt``
     ``client-pending-auth`` and ``cr-response`` commands for more
     details.

@@ -822,7 +823,7 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8
Gerrit-Change-Number: 1405
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--1sNHwEsWgJw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1405?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Changes.rst: Fix various syntax errors and typos=
<br><br>Mostly people trying to write MarkDown, but this is<br>reStructured=
Text.<br><br>Change-Id: I8e390a276418dda9e7caa6edcd3a9d59d50ce4f8<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M Changes.rst=
<br>1 file changed, 8 insertions(+), 7 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/1405/2<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 907706=
4..f46f7f1 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/C=
hanges.rst</span><br><span>@@ -112,7 +112,8 @@</span><br><span>     can be =
pinged, can serve a website and more without requiring any</span><br><span>=
     elevated permission. This can make testing OpenVPN much easier.</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    For mo=
re details see [lwipovpn on Gihtub](https://github.com/OpenVPN/lwipovpn).</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    For more details =
see</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    `lwipovpn on=
 Github &lt;https://github.com/OpenVPN/lwipovpn&gt;`_.</span><br><span> </s=
pan><br><span> Allow overriding username with ``--override-username``</span=
><br><span>     This is intended to allow using auth-gen-token in scenarios=
 where the</span><br><span>@@ -314,17 +315,17 @@</span><br><span>   use fro=
m &quot;ifconfig&quot;, this change repairs functionality (this has</span><=
br><span>   been backported to 2.6.15, but is not in earlier 2.6 versions).=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-- `=
max-routes-per-client 0` used to be silently upgraded to `1`.  This</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+- ``max-routes-per-client 0=
`` used to be silently upgraded to ``1``.  This</span><br><span>   now prod=
uces an error.</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-- `ifconfig` and `ifconfig-ipv6` values are now stored in pre-co=
nnect</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- ``ifconfig``=
 and ``ifconfig-ipv6`` values are now stored in pre-connect</span><br><span=
>   options cache, and will be restored to pre-connect values on reconnects=
</span><br><span>   if the server stops pushing the respective option.</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-- `tapct=
l.exe` helper binary on Windows has been reworked to improve</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+- ``tapctl.exe`` helper binary on =
Windows has been reworked to improve</span><br><span>   help texts (making =
clear that it can not only do TAP-Adapters but</span><br><span>   Win-DCO a=
s well), add printing of the hwid to all adapter outputs, and</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  change the default adapter type c=
reated to `ovpn-dco`.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  change the default adapter type created to ``ovpn-dco``.</span><br><spa=
n> </span><br><span> Deprecated features</span><br><span> -----------------=
--</span><br><span>@@ -803,7 +804,7 @@</span><br><span>     wait for the se=
cond factor authentication to complete.</span><br><span> </span><br><span> =
    This feature currently requires usage of the managent interface</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    on both client and server=
 side. See the `management-notes.txt`</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    on both client and server side. See the ``management-=
notes.txt``</span><br><span>     ``client-pending-auth`` and ``cr-response`=
` commands for more</span><br><span>     details.</span><br><span> </span><=
br><span>@@ -822,7 +823,7 @@</span><br><span> Allow unicode search string i=
n ``--cryptoapicert`` option (Windows)</span><br><span> </span><br><span> S=
upport IPv4 configs with /31 netmasks now</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    (By no longer trying to configure ``broadcast x.x.x=
.x&#39;&#39; in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
(By no longer trying to configure ``broadcast x.x.x.x`` in</span><br><span>=
     ifconfig calls, /31 support &quot;just works&quot;)</span><br><span> <=
/span><br><span> New option ``--block-ipv6`` to reject all IPv6 packets (IC=
MPv6)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1405?usp=3Demail">change 1405</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1405?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e390a276418dda9e7caa6edcd3=
a9d59d50ce4f8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1405 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--1sNHwEsWgJw=--

