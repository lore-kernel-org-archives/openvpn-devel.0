From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 10 Feb 2026 16:16:55 +0000
References: <gerrit.1770740212000.Idd079f42fac1189c08c6cf42ea84fa8c0383e1a8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5ce17e21a5799d041871ef2173d5db0e78cea3fd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/xHr4CYeQfM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/xHr4CYeQfM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1515?usp=3Demail

to review the following change.


Change subject: Review Changes.rst for 2.7.0 release
......................................................................

Review Changes.rst for 2.7.0 release

Fixes various issues, either errors or things
that got outdated during development.

Change-Id: Idd079f42fac1189c08c6cf42ea84fa8c0383e1a8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M Changes.rst
M doc/man-sections/server-options.rst
M tests/t_server_null_default.rc
3 files changed, 20 insertions(+), 24 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/1515/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idd079f42fac1189c08c6cf42ea84fa8c0383e1a8
Gerrit-Change-Number: 1515
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--/xHr4CYeQfM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1515?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Review Changes.rst for 2.7.0 release<br><br=
>Fixes various issues, either errors or things<br>that got outdated during =
development.<br><br>Change-Id: Idd079f42fac1189c08c6cf42ea84fa8c0383e1a8<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M Chan=
ges.rst<br>M doc/man-sections/server-options.rst<br>M tests/t_server_null_d=
efault.rc<br>3 files changed, 20 insertions(+), 24 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/15/1515/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.rst</span><br><span>=
index d2c6716..7de5f10 100644</span><br><span>--- a/Changes.rst</span><br><=
span>+++ b/Changes.rst</span><br><span>@@ -116,9 +116,9 @@</span><br><span>=
     `lwipovpn on Github &lt;https://github.com/OpenVPN/lwipovpn&gt;`_.</sp=
an><br><span> </span><br><span> Allow overriding username with ``--override=
-username``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    This i=
s intended to allow using auth-gen-token in scenarios where the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    This is intended to allow u=
sing ``--auth-gen-token`` in scenarios where the</span><br><span>     clien=
ts use certificates and multi-factor authentication.  This will</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    also generate a &#39;push &qu=
ot;auth-token-user newusername&quot;&#39; directives in</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    also generate a ``push &quot;auth-t=
oken-user newusername&quot;`` directive in</span><br><span>     push replie=
s.</span><br><span> </span><br><span> ``--port-share`` now properly support=
s IPv6</span><br><span>@@ -127,20 +127,18 @@</span><br><span> </span><br><s=
pan> Support for Haiku OS</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-TLS1.3 support with mbedTLS (very recent mbedTLS deve=
lopment versions only)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+TLS1.3 support with mbedTLS (requires mbedTLS &gt;=3D 3.6.4)</span><br><=
span> </span><br><span> PUSH_UPDATE client support</span><br><span>     It =
is now possible to update parts of the client-side configuration</span><br>=
<span>     (IP address, routes, MTU, DNS) by sending a new server-to-client=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    control message, =
PUSH_UPDATE,&lt;options&gt;.  Server-side support is</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    currently only supported by OpenVPN Inc=
 commercial offerings, the</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    implementation for OpenVPN 2.x is still under development.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    control message, ``PUSH=
_UPDATE,&lt;options&gt;``.</span><br><span>     See also: https://openvpn.g=
ithub.io/openvpn-rfc/openvpn-wire-protocol.html</span><br><span>     NOTE: =
PUSH_UPDATE client support is currently disabled if DCO</span><br><span>   =
  is active (on all platforms).</span><br><span> </span><br><span> PUSH_UPD=
ATE server support (minimal)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    new management interface commands ``push-update-broad`` and</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    New management inter=
face commands ``push-update-broad`` and</span><br><span>     ``push-update-=
cid`` to send PUSH_UPDATE option updates to all</span><br><span>     client=
s (&quot;there is a new DNS server&quot;) or only a specific client ID</spa=
n><br><span>     (&quot;privileges have changed, here&#39;s a new IP addres=
s&quot;).  See</span><br><span>@@ -149,7 +147,7 @@</span><br><span>     is =
active (on all platforms).</span><br><span> </span><br><span> Support for u=
ser-defined routing tables on Linux</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    see the ``--route-table`` option in the manpage</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    See the ``--route-table``=
 option in the manpage</span><br><span> </span><br><span> PQE support for W=
olfSSL</span><br><span> </span><br><span>@@ -166,7 +164,7 @@</span><br><spa=
n>    use policies that direct &quot;everything that is not OpenVPN&quot; i=
nto the</span><br><span>    tunnel, and have IP packets to the VPN server a=
ddress arrive as</span><br><span>    expected (no such policies are current=
ly installed by OpenVPN)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-   (github #669).</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+   (GH: OpenVPN/openvpn#669).</span><br><span> </span><br><span> COPYING: =
license details only relevant to our Windows installers have</span><br><spa=
n>    been updated and moved to the openvpn-build repo</span><br><span>@@ -=
181,9 +179,10 @@</span><br><span>    (When a client is older than n days or=
 has no timestamp, the server</span><br><span>     will reject it)</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedTLS 4 su=
pport has been added.  Algorithms need to be translated to</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-   mbedTLS 4 internal IDs, and these t=
ables are only very basic right now</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-   (but AES-GCM and ChaCha-Poly are in).</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+mbedTLS 4 support has been added.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   Note that with mbedTLS =
4 algorithms need to be translated to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+   mbedTLS 4 internal IDs by OpenVPN, and some names migh=
t be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   missing.</sp=
an><br><span> </span><br><span> </span><br><span> Deprecated features</span=
><br><span>@@ -234,7 +233,7 @@</span><br><span>     ``--allow-compression a=
sym``.</span><br><span> </span><br><span> ``--memstats`` feature removed</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    The ``--mememstat`` =
was largely undocumented and there is no known</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    The ``--memstats`` option was largely undocu=
mented and there is no known</span><br><span>     user of this feature.  Th=
is feature provided very limited statistics</span><br><span>     (number of=
 users, link bytes read/written) and we do not except any</span><br><span> =
    usage because of this.</span><br><span>@@ -263,7 +262,7 @@</span><br><s=
pan>   By default ``--topology`` is pushed from server to client.</span><br=
><span> </span><br><span> - ``--x509-username-field`` will no longer automa=
tically convert fieldnames to</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  uppercase. This is deprecated since OpenVPN 2.4, and has now been=
 removed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  uppercas=
e. This was deprecated since OpenVPN 2.4, and has now been removed.</span><=
br><span> </span><br><span> - ``--dh none`` is now the default if ``--dh`` =
is not specified. Modern TLS</span><br><span>   implementations will prefer=
 ECDH and other more modern algorithms anyway.</span><br><span>@@ -286,7 +2=
85,7 @@</span><br><span> - ``--cryptoapicert`` now supports issuer name as =
well as Windows CA template</span><br><span>   name or OID as selector stri=
ng.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
- TLS handshake debugging information contains much more details  now when<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+- TLS handshake debu=
gging information contains much more details now when</span><br><span>   us=
ing recent versions of OpenSSL.</span><br><span> </span><br><span> - The ``=
IV_PLAT_VER`` variable sent by Windows clients now contains the</span><br><=
span>@@ -308,18 +307,16 @@</span><br><span>   (Github: OpenVPN/openvpn#704)=
.</span><br><span> </span><br><span> - Use of ``--dh dh2048.pem`` in all sa=
mple configs has been replaced</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  with ``--dh none``.  The ``dh2048.pem`` file has been removed, a=
nd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  has been replaced=
 with ``ffdhe2048.pem`` for the benefit of the</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  t_server_null test (to test all variants of ``--=
dh``).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  with ``--dh=
 none``.  The ``dh2048.pem`` file has been removed.</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-- the startup delay in ``t_=
client.sh`` has been reduced from 3s to 1s,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+- The startup delay in ``t_client.sh`` has been red=
uced from 3s to 1s,</span><br><span>   making a noticeable difference for s=
etups with many tests.</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-- changed from using ``uncrustify`` for code formatting =
and pre-commit checks</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+- Changed from using ``uncrustify`` for code formatting and pre-commit ch=
ecks</span><br><span>   to ``clang-format``.  This reformatted quite a bit =
of code, and requires</span><br><span>   that regular committers change the=
ir pre-commit checks accordingly.</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-- on Linux, on interfaces where applicable,=
 OpenVPN explicitly configures</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+- On Linux, on interfaces where applicable, OpenVPN explicitly c=
onfigures</span><br><span>   the broadcast address again.  This was dropped=
 for 2.6.0 &quot;because</span><br><span>   computers are smart and can do =
it themselves&quot;, but the kernel netlink</span><br><span>   interface is=
n&#39;t, and will install &quot;0.0.0.0&quot;.  This does not normally</spa=
n><br><span>@@ -339,7 +336,7 @@</span><br><span>   Win-DCO as well), add pr=
inting of the hwid to all adapter outputs, and</span><br><span>   change th=
e default adapter type created to ``ovpn-dco``.</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-- the default for ``multihome``=
 egress interface handling has changed.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+- The default for ``multihome`` egress interface handli=
ng has changed.</span><br><span>   2.7.0 will default to ipi_ifindex=3D0, t=
hat is, leave the decision to the</span><br><span>   routing/policy setup o=
f the operating system.  The pre-2.7 behaviour</span><br><span>   (force eg=
ress =3D ingress interface) can be achieved with the new</span><br><span>di=
ff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-op=
tions.rst</span><br><span>index 370c670..03ce651 100644</span><br><span>---=
 a/doc/man-sections/server-options.rst</span><br><span>+++ b/doc/man-sectio=
ns/server-options.rst</span><br><span>@@ -90,7 +90,7 @@</span><br><span>   =
password from a script).</span><br><span> </span><br><span>   **Note:** the=
 username for ``--auth-gen-token`` can be overridden by</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  ``--override-user``. In this case the c=
lient will be pushed also the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  ``--override-username``. In this case the client will be pushed=
 also the</span><br><span>   ``--auth-token-user`` option and an auth token=
 that is valid for that</span><br><span>   username instead of the original=
 username that the client authenticated</span><br><span>   with.</span><br>=
<span>diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_def=
ault.rc</span><br><span>index bba77aa..c6540cb 100755</span><br><span>--- a=
/tests/t_server_null_default.rc</span><br><span>+++ b/tests/t_server_null_d=
efault.rc</span><br><span>@@ -13,7 +13,6 @@</span><br><span> top_builddir=
=3D&quot;${top_builddir:-..}&quot;</span><br><span> sample_keys=3D&quot;${s=
rcdir}/../sample/sample-keys&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-DH=3D&quot;${sample_keys}/ffdhe2048.pem&quo=
t;</span><br><span> CA=3D&quot;${sample_keys}/ca.crt&quot;</span><br><span>=
 CLIENT_CERT=3D&quot;${sample_keys}/client.crt&quot;</span><br><span> CLIEN=
T_KEY=3D&quot;${sample_keys}/client.key&quot;</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1515=
?usp=3Demail">change 1515</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1515?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idd079f42fac1189c08c6cf42ea8=
4fa8c0383e1a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1515 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--/xHr4CYeQfM=--

