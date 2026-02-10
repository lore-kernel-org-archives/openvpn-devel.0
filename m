From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 10 Feb 2026 17:41:40 +0000
In-Reply-To: <gerrit.1770740212000.Idd079f42fac1189c08c6cf42ea84fa8c0383e1a8@...2715...>
References: <gerrit.1770740212000.Idd079f42fac1189c08c6cf42ea84fa8c0383e1a8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d7a76975ecfcd485d891ef073362b7df292b12ea-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PSvsa2jhRYE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Review Changes.rst
 for 2.7.0 release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PSvsa2jhRYE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1515?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Review Changes.rst for 2.7.0 release
......................................................................

Review Changes.rst for 2.7.0 release

Fixes various issues, either errors or things
that got outdated during development.

Change-Id: Idd079f42fac1189c08c6cf42ea84fa8c0383e1a8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1515
Message-Id: <20260210162038.7915-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
574.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M doc/man-sections/server-options.rst
M tests/t_server_null_default.rc
3 files changed, 20 insertions(+), 24 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1515/2

diff --git a/Changes.rst b/Changes.rst
index d2c6716..7de5f10 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -116,9 +116,9 @@
     `lwipovpn on Github <https://github.com/OpenVPN/lwipovpn>`_.

 Allow overriding username with ``--override-username``
-    This is intended to allow using auth-gen-token in scenarios where the
+    This is intended to allow using ``--auth-gen-token`` in scenarios wher=
e the
     clients use certificates and multi-factor authentication.  This will
-    also generate a 'push "auth-token-user newusername"' directives in
+    also generate a ``push "auth-token-user newusername"`` directive in
     push replies.

 ``--port-share`` now properly supports IPv6
@@ -127,20 +127,18 @@

 Support for Haiku OS

-TLS1.3 support with mbedTLS (very recent mbedTLS development versions only)
+TLS1.3 support with mbedTLS (requires mbedTLS >=3D 3.6.4)

 PUSH_UPDATE client support
     It is now possible to update parts of the client-side configuration
     (IP address, routes, MTU, DNS) by sending a new server-to-client
-    control message, PUSH_UPDATE,<options>.  Server-side support is
-    currently only supported by OpenVPN Inc commercial offerings, the
-    implementation for OpenVPN 2.x is still under development.
+    control message, ``PUSH_UPDATE,<options>``.
     See also: https://openvpn.github.io/openvpn-rfc/openvpn-wire-protocol.=
html
     NOTE: PUSH_UPDATE client support is currently disabled if DCO
     is active (on all platforms).

 PUSH_UPDATE server support (minimal)
-    new management interface commands ``push-update-broad`` and
+    New management interface commands ``push-update-broad`` and
     ``push-update-cid`` to send PUSH_UPDATE option updates to all
     clients ("there is a new DNS server") or only a specific client ID
     ("privileges have changed, here's a new IP address").  See
@@ -149,7 +147,7 @@
     is active (on all platforms).

 Support for user-defined routing tables on Linux
-    see the ``--route-table`` option in the manpage
+    See the ``--route-table`` option in the manpage

 PQE support for WolfSSL

@@ -166,7 +164,7 @@
    use policies that direct "everything that is not OpenVPN" into the
    tunnel, and have IP packets to the VPN server address arrive as
    expected (no such policies are currently installed by OpenVPN)
-   (github #669).
+   (GH: OpenVPN/openvpn#669).

 COPYING: license details only relevant to our Windows installers have
    been updated and moved to the openvpn-build repo
@@ -181,9 +179,10 @@
    (When a client is older than n days or has no timestamp, the server
     will reject it)

-mbedTLS 4 support has been added.  Algorithms need to be translated to
-   mbedTLS 4 internal IDs, and these tables are only very basic right now
-   (but AES-GCM and ChaCha-Poly are in).
+mbedTLS 4 support has been added.
+   Note that with mbedTLS 4 algorithms need to be translated to
+   mbedTLS 4 internal IDs by OpenVPN, and some names might be
+   missing.


 Deprecated features
@@ -234,7 +233,7 @@
     ``--allow-compression asym``.

 ``--memstats`` feature removed
-    The ``--mememstat`` was largely undocumented and there is no known
+    The ``--memstats`` option was largely undocumented and there is no kno=
wn
     user of this feature.  This feature provided very limited statistics
     (number of users, link bytes read/written) and we do not except any
     usage because of this.
@@ -263,7 +262,7 @@
   By default ``--topology`` is pushed from server to client.

 - ``--x509-username-field`` will no longer automatically convert fieldname=
s to
-  uppercase. This is deprecated since OpenVPN 2.4, and has now been remove=
d.
+  uppercase. This was deprecated since OpenVPN 2.4, and has now been remov=
ed.

 - ``--dh none`` is now the default if ``--dh`` is not specified. Modern TLS
   implementations will prefer ECDH and other more modern algorithms anyway.
@@ -286,7 +285,7 @@
 - ``--cryptoapicert`` now supports issuer name as well as Windows CA templ=
ate
   name or OID as selector string.

-- TLS handshake debugging information contains much more details  now when
+- TLS handshake debugging information contains much more details now when
   using recent versions of OpenSSL.

 - The ``IV_PLAT_VER`` variable sent by Windows clients now contains the
@@ -308,18 +307,16 @@
   (Github: OpenVPN/openvpn#704).

 - Use of ``--dh dh2048.pem`` in all sample configs has been replaced
-  with ``--dh none``.  The ``dh2048.pem`` file has been removed, and
-  has been replaced with ``ffdhe2048.pem`` for the benefit of the
-  t_server_null test (to test all variants of ``--dh``).
+  with ``--dh none``.  The ``dh2048.pem`` file has been removed.

-- the startup delay in ``t_client.sh`` has been reduced from 3s to 1s,
+- The startup delay in ``t_client.sh`` has been reduced from 3s to 1s,
   making a noticeable difference for setups with many tests.

-- changed from using ``uncrustify`` for code formatting and pre-commit che=
cks
+- Changed from using ``uncrustify`` for code formatting and pre-commit che=
cks
   to ``clang-format``.  This reformatted quite a bit of code, and requires
   that regular committers change their pre-commit checks accordingly.

-- on Linux, on interfaces where applicable, OpenVPN explicitly configures
+- On Linux, on interfaces where applicable, OpenVPN explicitly configures
   the broadcast address again.  This was dropped for 2.6.0 "because
   computers are smart and can do it themselves", but the kernel netlink
   interface isn't, and will install "0.0.0.0".  This does not normally
@@ -339,7 +336,7 @@
   Win-DCO as well), add printing of the hwid to all adapter outputs, and
   change the default adapter type created to ``ovpn-dco``.

-- the default for ``multihome`` egress interface handling has changed.
+- The default for ``multihome`` egress interface handling has changed.
   2.7.0 will default to ipi_ifindex=3D0, that is, leave the decision to the
   routing/policy setup of the operating system.  The pre-2.7 behaviour
   (force egress =3D ingress interface) can be achieved with the new
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 370c670..03ce651 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -90,7 +90,7 @@
   password from a script).

   **Note:** the username for ``--auth-gen-token`` can be overridden by
-  ``--override-user``. In this case the client will be pushed also the
+  ``--override-username``. In this case the client will be pushed also the
   ``--auth-token-user`` option and an auth token that is valid for that
   username instead of the original username that the client authenticated
   with.
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index bba77aa..c6540cb 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -13,7 +13,6 @@
 top_builddir=3D"${top_builddir:-..}"
 sample_keys=3D"${srcdir}/../sample/sample-keys"

-DH=3D"${sample_keys}/ffdhe2048.pem"
 CA=3D"${sample_keys}/ca.crt"
 CLIENT_CERT=3D"${sample_keys}/client.crt"
 CLIENT_KEY=3D"${sample_keys}/client.key"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1515?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idd079f42fac1189c08c6cf42ea84fa8c0383e1a8
Gerrit-Change-Number: 1515
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--PSvsa2jhRYE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1515?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Review Changes.rst for 2.7.0 releas=
e<br><br>Fixes various issues, either errors or things<br>that got outdated=
 during development.<br><br>Change-Id: Idd079f42fac1189c08c6cf42ea84fa8c038=
3e1a8<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked=
-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.ope=
nvpn.net/c/openvpn/+/1515<br>Message-Id: &lt;20260210162038.7915-1-gert@...493...=
1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1659...=
forge.net/msg35574.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&=
gt;<br>---<br>M Changes.rst<br>M doc/man-sections/server-options.rst<br>M t=
ests/t_server_null_default.rc<br>3 files changed, 20 insertions(+), 24 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/15/1515/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.=
rst</span><br><span>index d2c6716..7de5f10 100644</span><br><span>--- a/Cha=
nges.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -116,9 +116,9=
 @@</span><br><span>     `lwipovpn on Github &lt;https://github.com/OpenVPN=
/lwipovpn&gt;`_.</span><br><span> </span><br><span> Allow overriding userna=
me with ``--override-username``</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    This is intended to allow using auth-gen-token in scenarios w=
here the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    This is=
 intended to allow using ``--auth-gen-token`` in scenarios where the</span>=
<br><span>     clients use certificates and multi-factor authentication.  T=
his will</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    also gene=
rate a &#39;push &quot;auth-token-user newusername&quot;&#39; directives in=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    also generate a=
 ``push &quot;auth-token-user newusername&quot;`` directive in</span><br><s=
pan>     push replies.</span><br><span> </span><br><span> ``--port-share`` =
now properly supports IPv6</span><br><span>@@ -127,20 +127,18 @@</span><br>=
<span> </span><br><span> Support for Haiku OS</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-TLS1.3 support with mbedTLS (very=
 recent mbedTLS development versions only)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+TLS1.3 support with mbedTLS (requires mbedTLS &gt;=
=3D 3.6.4)</span><br><span> </span><br><span> PUSH_UPDATE client support</s=
pan><br><span>     It is now possible to update parts of the client-side co=
nfiguration</span><br><span>     (IP address, routes, MTU, DNS) by sending =
a new server-to-client</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    control message, PUSH_UPDATE,&lt;options&gt;.  Server-side support is<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    currently only sup=
ported by OpenVPN Inc commercial offerings, the</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    implementation for OpenVPN 2.x is still under=
 development.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
ntrol message, ``PUSH_UPDATE,&lt;options&gt;``.</span><br><span>     See al=
so: https://openvpn.github.io/openvpn-rfc/openvpn-wire-protocol.html</span>=
<br><span>     NOTE: PUSH_UPDATE client support is currently disabled if DC=
O</span><br><span>     is active (on all platforms).</span><br><span> </spa=
n><br><span> PUSH_UPDATE server support (minimal)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    new management interface commands ``push-up=
date-broad`` and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 New management interface commands ``push-update-broad`` and</span><br><spa=
n>     ``push-update-cid`` to send PUSH_UPDATE option updates to all</span>=
<br><span>     clients (&quot;there is a new DNS server&quot;) or only a sp=
ecific client ID</span><br><span>     (&quot;privileges have changed, here&=
#39;s a new IP address&quot;).  See</span><br><span>@@ -149,7 +147,7 @@</sp=
an><br><span>     is active (on all platforms).</span><br><span> </span><br=
><span> Support for user-defined routing tables on Linux</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    see the ``--route-table`` option in =
the manpage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    See =
the ``--route-table`` option in the manpage</span><br><span> </span><br><sp=
an> PQE support for WolfSSL</span><br><span> </span><br><span>@@ -166,7 +16=
4,7 @@</span><br><span>    use policies that direct &quot;everything that i=
s not OpenVPN&quot; into the</span><br><span>    tunnel, and have IP packet=
s to the VPN server address arrive as</span><br><span>    expected (no such=
 policies are currently installed by OpenVPN)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-   (github #669).</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+   (GH: OpenVPN/openvpn#669).</span><br><span> </span=
><br><span> COPYING: license details only relevant to our Windows installer=
s have</span><br><span>    been updated and moved to the openvpn-build repo=
</span><br><span>@@ -181,9 +179,10 @@</span><br><span>    (When a client is=
 older than n days or has no timestamp, the server</span><br><span>     wil=
l reject it)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-mbedTLS 4 support has been added.  Algorithms need to be translate=
d to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   mbedTLS 4 inte=
rnal IDs, and these tables are only very basic right now</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-   (but AES-GCM and ChaCha-Poly are in).=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedTLS 4 support h=
as been added.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   No=
te that with mbedTLS 4 algorithms need to be translated to</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+   mbedTLS 4 internal IDs by OpenVPN=
, and some names might be</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+   missing.</span><br><span> </span><br><span> </span><br><span> Depr=
ecated features</span><br><span>@@ -234,7 +233,7 @@</span><br><span>     ``=
--allow-compression asym``.</span><br><span> </span><br><span> ``--memstats=
`` feature removed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 The ``--mememstat`` was largely undocumented and there is no known</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    The ``--memstats`` opti=
on was largely undocumented and there is no known</span><br><span>     user=
 of this feature.  This feature provided very limited statistics</span><br>=
<span>     (number of users, link bytes read/written) and we do not except =
any</span><br><span>     usage because of this.</span><br><span>@@ -263,7 +=
262,7 @@</span><br><span>   By default ``--topology`` is pushed from server=
 to client.</span><br><span> </span><br><span> - ``--x509-username-field`` =
will no longer automatically convert fieldnames to</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  uppercase. This is deprecated since OpenVPN =
2.4, and has now been removed.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  uppercase. This was deprecated since OpenVPN 2.4, and has now =
been removed.</span><br><span> </span><br><span> - ``--dh none`` is now the=
 default if ``--dh`` is not specified. Modern TLS</span><br><span>   implem=
entations will prefer ECDH and other more modern algorithms anyway.</span><=
br><span>@@ -286,7 +285,7 @@</span><br><span> - ``--cryptoapicert`` now sup=
ports issuer name as well as Windows CA template</span><br><span>   name or=
 OID as selector string.</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-- TLS handshake debugging information contains much mo=
re details  now when</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+- TLS handshake debugging information contains much more details now when<=
/span><br><span>   using recent versions of OpenSSL.</span><br><span> </spa=
n><br><span> - The ``IV_PLAT_VER`` variable sent by Windows clients now con=
tains the</span><br><span>@@ -308,18 +307,16 @@</span><br><span>   (Github:=
 OpenVPN/openvpn#704).</span><br><span> </span><br><span> - Use of ``--dh d=
h2048.pem`` in all sample configs has been replaced</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  with ``--dh none``.  The ``dh2048.pem`` f=
ile has been removed, and</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  has been replaced with ``ffdhe2048.pem`` for the benefit of the</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  t_server_null test (to te=
st all variants of ``--dh``).</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  with ``--dh none``.  The ``dh2048.pem`` file has been removed.<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-- th=
e startup delay in ``t_client.sh`` has been reduced from 3s to 1s,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+- The startup delay in ``t_c=
lient.sh`` has been reduced from 3s to 1s,</span><br><span>   making a noti=
ceable difference for setups with many tests.</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-- changed from using ``uncrustify=
`` for code formatting and pre-commit checks</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+- Changed from using ``uncrustify`` for code forma=
tting and pre-commit checks</span><br><span>   to ``clang-format``.  This r=
eformatted quite a bit of code, and requires</span><br><span>   that regula=
r committers change their pre-commit checks accordingly.</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-- on Linux, on interfa=
ces where applicable, OpenVPN explicitly configures</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+- On Linux, on interfaces where applicabl=
e, OpenVPN explicitly configures</span><br><span>   the broadcast address a=
gain.  This was dropped for 2.6.0 &quot;because</span><br><span>   computer=
s are smart and can do it themselves&quot;, but the kernel netlink</span><b=
r><span>   interface isn&#39;t, and will install &quot;0.0.0.0&quot;.  This=
 does not normally</span><br><span>@@ -339,7 +336,7 @@</span><br><span>   W=
in-DCO as well), add printing of the hwid to all adapter outputs, and</span=
><br><span>   change the default adapter type created to ``ovpn-dco``.</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-- the de=
fault for ``multihome`` egress interface handling has changed.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+- The default for ``multihome`` =
egress interface handling has changed.</span><br><span>   2.7.0 will defaul=
t to ipi_ifindex=3D0, that is, leave the decision to the</span><br><span>  =
 routing/policy setup of the operating system.  The pre-2.7 behaviour</span=
><br><span>   (force egress =3D ingress interface) can be achieved with the=
 new</span><br><span>diff --git a/doc/man-sections/server-options.rst b/doc=
/man-sections/server-options.rst</span><br><span>index 370c670..03ce651 100=
644</span><br><span>--- a/doc/man-sections/server-options.rst</span><br><sp=
an>+++ b/doc/man-sections/server-options.rst</span><br><span>@@ -90,7 +90,7=
 @@</span><br><span>   password from a script).</span><br><span> </span><br=
><span>   **Note:** the username for ``--auth-gen-token`` can be overridden=
 by</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--override-use=
r``. In this case the client will be pushed also the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  ``--override-username``. In this case t=
he client will be pushed also the</span><br><span>   ``--auth-token-user`` =
option and an auth token that is valid for that</span><br><span>   username=
 instead of the original username that the client authenticated</span><br><=
span>   with.</span><br><span>diff --git a/tests/t_server_null_default.rc b=
/tests/t_server_null_default.rc</span><br><span>index bba77aa..c6540cb 1007=
55</span><br><span>--- a/tests/t_server_null_default.rc</span><br><span>+++=
 b/tests/t_server_null_default.rc</span><br><span>@@ -13,7 +13,6 @@</span><=
br><span> top_builddir=3D&quot;${top_builddir:-..}&quot;</span><br><span> s=
ample_keys=3D&quot;${srcdir}/../sample/sample-keys&quot;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-DH=3D&quot;${sample_ke=
ys}/ffdhe2048.pem&quot;</span><br><span> CA=3D&quot;${sample_keys}/ca.crt&q=
uot;</span><br><span> CLIENT_CERT=3D&quot;${sample_keys}/client.crt&quot;</=
span><br><span> CLIENT_KEY=3D&quot;${sample_keys}/client.key&quot;</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1515?usp=3Demail">change 1515</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1515?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idd079f42fac1189c08c6cf42ea8=
4fa8c0383e1a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1515 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--PSvsa2jhRYE=--

