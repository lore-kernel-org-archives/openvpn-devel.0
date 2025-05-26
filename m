From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 May 2025 14:10:17 +0000
References: <gerrit.1748268615000.I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e9675894afc4be2fff89a687f98f72bb43294785-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="enkoLHapZQo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Changes.rst: Collect, fix,
 and improve entries for 2.7 release
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

--enkoLHapZQo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail

to review the following change.


Change subject: Changes.rst: Collect, fix, and improve entries for 2.7 rele=
ase
......................................................................

Changes.rst: Collect, fix, and improve entries for 2.7 release

Change-Id: I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M Changes.rst
1 file changed, 88 insertions(+), 34 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/1032/1

diff --git a/Changes.rst b/Changes.rst
index e297334..c326c0d 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -2,25 +2,43 @@
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
 New features
 ------------
-TLS alerts
-    OpenVPN 2.7 will send out TLS alerts to peers informing them if the TLS
-    session shuts down or when the TLS implementation informs the peer abo=
ut
-    an error in the TLS session (e.g. mismatching TLS versions). This impr=
oves
-    the user experience as the client shows an error instead of running in=
to
-    a timeout when the server just stops responding completely.
+Multi-socket support for servers
+   OpenVPN servers now can listen on multiple sockets at the same time.
+   Multiple ``--local`` statements in the configuration can be used to
+   configure this. This way the same server can e.g. listen for UDP
+   and TCP connections at the same time, or listen on multiple addresses
+   and/or ports.

-Support for tun/tap via unix domain socket and lwipovpn support
-    To allow better testing and emulating a full client with a full
-    network stack OpenVPN now allows a program executed to provide
-    a tun/tap device instead of opening a device.
+Client implementations for DNS options sent by server for Linux/BSD
+   Linux and BSD versions of OpenVPN now ship with a default ``dns-updown``
+   script that implements proper handling of DNS configuration sent
+   by the server. The scripts should work on systems that use
+   ``systemd`` or ``resolveconf`` to manage the DNS setup, as well as
+   raw ``/etc/resolv.conf`` files. However, the exact features supported
+   will depend on the configuration method. On Linux this should usually
+   mean that split-DNS configurations are supported out-of-the-box now.

-    The co-developed lwipovpn program based on lwIP stack allows to
-    simulate full IP stack and an OpenVPN client using
-    ``--dev-node unix:/path/to/lwipovpn`` can emulate a full client that
-    can be pinged, can serve a website and more without requiring any
-    elevated permission. This can make testing OpenVPN much easier.
+   Note that this new script will not be used by default if a ``--up``
+   script is already in use to reduce problems with
+   backwards compatibility.

-    For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/l=
wipovpn).
+   See documentation for ``--dns-updown`` and ``--dns`` for more details.
+
+New client implementation for DNS options sent by server for Windows
+   The Windows client now uses NRPT (Name Resolution Policy Table) to
+   handle DNS configurations. This adds support for split-DNS and DNSSEC
+   and improves the compatbility with local DNS resolvers. Requires the
+   interactive service.
+
+Support for new version of Linux DCO module
+    OpenVPN DCO module is moving upstream and being merged into the
+    main Linux kernel. For this process some API changes were required.
+    OpenVPN 2.7 will only support the new API. The new module is called
+    ``ovpn``. Out-of-tree builds for older kernels are available. Please
+    see the release announcements for futher information.
+
+Support for server mode in win-dco driver
+    On Windows the win-dco driver can now be used in server setups.

 Enforcement of AES-GCM usage limit
     OpenVPN will now enforce the usage limits on AES-GCM with the same
@@ -30,11 +48,6 @@

     https://datatracker.ietf.org/doc/draft-irtf-cfrg-aead-limits/

-Default ciphers in ``--data-ciphers``
-    Ciphers in ``--data-ciphers`` can contain the string DEFAULT that is
-    replaced by the default ciphers used by OpenVPN, making it easier to
-    add an allowed cipher without having to spell out the default ciphers.
-
 Epoch data keys and packet format
     This introduces the epoch data format for AEAD data channel
     ciphers in TLS mode ciphers. This new data format has a number of
@@ -49,6 +62,31 @@
     - IV constructed with XOR instead of concatenation to not have (parts)=
 of
       the real IV on the wire

+Default ciphers in ``--data-ciphers``
+    Ciphers in ``--data-ciphers`` can contain the string DEFAULT that is
+    replaced by the default ciphers used by OpenVPN, making it easier to
+    add an allowed cipher without having to spell out the default ciphers.
+
+TLS alerts
+    OpenVPN 2.7 will send out TLS alerts to peers informing them if the TLS
+    session shuts down or when the TLS implementation informs the peer abo=
ut
+    an error in the TLS session (e.g. mismatching TLS versions). This impr=
oves
+    the user experience as the client shows an error instead of running in=
to
+    a timeout when the server just stops responding completely.
+
+Support for tun/tap via unix domain socket and lwipovpn support
+    To allow better testing and emulating a full client with a full
+    network stack OpenVPN now allows a program executed to provide
+    a tun/tap device instead of opening a device.
+
+    The co-developed lwipovpn program based on lwIP stack allows to
+    simulate full IP stack. An OpenVPN client using
+    ``--dev-node unix:/path/to/lwipovpn`` can emulate a full client that
+    can be pinged, can serve a website and more without requiring any
+    elevated permission. This can make testing OpenVPN much easier.
+
+    For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/l=
wipovpn).
+
 Allow overriding username with ``--override-username``
     This is intended to allow using auth-gen-token in scenarios where the
     clients use certificates and multi-factor authentication.  This will
@@ -57,7 +95,7 @@

 Deprecated features
 -------------------
-``secret`` support has been removed by default.
+``secret`` support has been removed (by default).
     static key mode (non-TLS) is no longer considered "good and secure eno=
ugh"
     for today's requirements.  Use TLS mode instead.  If deploying a PKI CA
     is considered "too complicated", using ``--peer-fingerprint`` makes
@@ -67,6 +105,14 @@
     ``--allow-deprecated-insecure-static-crypto`` but will be removed in
     OpenVPN 2.8.

+Support for wintun Windows driver has been removed.
+    OpenVPN 2.6 added support for the new dco-win driver, so it supported
+    three different device drivers: dco-win, wintun, and tap-windows6.
+    OpenVPN 2.7 now drops the support for wintun driver. By default
+    all modern configs should be supported by dco-win driver. In all
+    other cases OpenVPN will fall back automatically to tap-windows6
+    driver.
+
 NTLMv1 authentication support for HTTP proxies has been removed.
     This is considered an insecure method of authentication that uses
     obsolete crypto algorithms.
@@ -78,21 +124,11 @@
 ``persist-key`` option has been enabled by default.
     All the keys will be kept in memory across restart.

-Default for ``--topology`` changed to ``subnet`` for ``--mode server``
-    Previous releases always used ``net30`` as default. This only affects
-    configs with ``--mode server`` or ``--server`` (the latter implies the
-    former), and ``--dev tun``, and only if IPv4 is enabled.
-    Note that this changes the semantics of ``--ifconfig``, so if you have
-    manual settings for that in your config but not set ``--topology``
-    your config might fail to parse with the new version. Just adding
-    ``--topology net30`` to the config should fix the problem.
-    By default ``--topology`` is pushed from server to client.
-
-OpenSSL 1.0.2 support
+OpenSSL 1.0.2 support has been removed.
     Support for building with OpenSSL 1.0.2 has been removed. The minimum
     supported OpenSSL version is now 1.1.0.

-Compression on send
+Compression on send has been removed.
     OpenVPN 2.7 will never compress data before sending. Decompression of
     received data is still supported.
     ``--allow-compression yes`` is now an alias for
@@ -100,6 +136,16 @@

 User-visible Changes
 --------------------
+- Default for ``--topology`` changed to ``subnet`` for ``--mode server``.
+  Previous releases always used ``net30`` as default. This only affects
+  configs with ``--mode server`` or ``--server`` (the latter implies the
+  former), and ``--dev tun``, and only if IPv4 is enabled.
+  Note that this changes the semantics of ``--ifconfig``, so if you have
+  manual settings for that in your config but not set ``--topology``
+  your config might fail to parse with the new version. Just adding
+  ``--topology net30`` to the config should fix the problem.
+  By default ``--topology`` is pushed from server to client.
+
 - ``--x509-username-field`` will no longer automatically convert fieldname=
s to
   uppercase. This is deprecated since OpenVPN 2.4, and has now been remove=
d.

@@ -108,6 +154,14 @@
   And finite field Diffie Hellman is in the proces of being deprecated
   (see draft-ietf-tls-deprecate-obsolete-kex)

+- ``--lport 0`` does not imply ``--bind`` anymore.
+
+- ``--static-challenge`` option now has a third parameter ``format`` that
+  can change how password and challenge response should be combined.
+
+- ``--key`` and ``--cert`` now accept URIs if the SSL library supports it,
+  which is the case for many OpenSSL 3 providers.
+
 Overview of changes in 2.6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91
Gerrit-Change-Number: 1032
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--enkoLHapZQo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Changes.rst: Collect, fix, and improve entries for 2.7 relea=
se<br><br>Change-Id: I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91<br>Signed-of=
f-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M Changes.rst<br=
>1 file changed, 88 insertions(+), 34 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/32/1032/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/Changes.rst b/Changes.rst</span><br><span>index e297334..c326c0d 1006=
44</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</spa=
n><br><span>@@ -2,25 +2,43 @@</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span> New fe=
atures</span><br><span> ------------</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-TLS alerts</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    OpenVPN 2.7 will send out TLS alerts to peers informing them if the=
 TLS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    session shuts=
 down or when the TLS implementation informs the peer about</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    an error in the TLS session (e.g.=
 mismatching TLS versions). This improves</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    the user experience as the client shows an error in=
stead of running into</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    a timeout when the server just stops responding completely.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+Multi-socket support for server=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   OpenVPN servers=
 now can listen on multiple sockets at the same time.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   Multiple ``--local`` statements in the=
 configuration can be used to</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   configure this. This way the same server can e.g. listen for U=
DP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   and TCP connec=
tions at the same time, or listen on multiple addresses</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+   and/or ports.</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-Support for tun/tap via un=
ix domain socket and lwipovpn support</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    To allow better testing and emulating a full client wit=
h a full</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    network s=
tack OpenVPN now allows a program executed to provide</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    a tun/tap device instead of opening a d=
evice.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Client implem=
entations for DNS options sent by server for Linux/BSD</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+   Linux and BSD versions of OpenVPN now=
 ship with a default ``dns-updown``</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+   script that implements proper handling of DNS configurat=
ion sent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   by the s=
erver. The scripts should work on systems that use</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+   ``systemd`` or ``resolveconf`` to manage =
the DNS setup, as well as</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+   raw ``/etc/resolv.conf`` files. However, the exact features suppor=
ted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   will depend o=
n the configuration method. On Linux this should usually</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+   mean that split-DNS configurations =
are supported out-of-the-box now.</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    The co-developed lwipovpn program based=
 on lwIP stack allows to</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    simulate full IP stack and an OpenVPN client using</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ``--dev-node unix:/path/to/lwipovpn=
`` can emulate a full client that</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    can be pinged, can serve a website and more without requiri=
ng any</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    elevated pe=
rmission. This can make testing OpenVPN much easier.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   Note that this new script will not be =
used by default if a ``--up``</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   script is already in use to reduce problems with</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+   backwards compatibility.</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    For m=
ore details see [lwipovpn on Gihtub](https://github.com/OpenVPN/lwipovpn).<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+   See documentation=
 for ``--dns-updown`` and ``--dns`` for more details.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+New client implementation for DNS options sent by server for=
 Windows</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   The Wind=
ows client now uses NRPT (Name Resolution Policy Table) to</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+   handle DNS configurations. This a=
dds support for split-DNS and DNSSEC</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+   and improves the compatbility with local DNS resolvers.=
 Requires the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   int=
eractive service.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+Support for new versi=
on of Linux DCO module</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OpenVPN DCO module is moving upstream and being merged into the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    main Linux kernel. F=
or this process some API changes were required.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OpenVPN 2.7 will only support the new API. =
The new module is called</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ``ovpn``. Out-of-tree builds for older kernels are available. Plea=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    see the relea=
se announcements for futher information.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+Support for server mode in win-dco driver</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    On Windows the win-dco driver can now be used i=
n server setups.</span><br><span> </span><br><span> Enforcement of AES-GCM =
usage limit</span><br><span>     OpenVPN will now enforce the usage limits =
on AES-GCM with the same</span><br><span>@@ -30,11 +48,6 @@</span><br><span=
> </span><br><span>     https://datatracker.ietf.org/doc/draft-irtf-cfrg-ae=
ad-limits/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-Default ciphers in ``--data-ciphers``</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    Ciphers in ``--data-ciphers`` can contain the st=
ring DEFAULT that is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   replaced by the default ciphers used by OpenVPN, making it easier to</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    add an allowed cipher=
 without having to spell out the default ciphers.</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> Epoch data keys and packet fo=
rmat</span><br><span>     This introduces the epoch data format for AEAD da=
ta channel</span><br><span>     ciphers in TLS mode ciphers. This new data =
format has a number of</span><br><span>@@ -49,6 +62,31 @@</span><br><span> =
    - IV constructed with XOR instead of concatenation to not have (parts) =
of</span><br><span>       the real IV on the wire</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+Default ciphers in ``--data=
-ciphers``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Ciphe=
rs in ``--data-ciphers`` can contain the string DEFAULT that is</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    replaced by the default cip=
hers used by OpenVPN, making it easier to</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    add an allowed cipher without having to spell out=
 the default ciphers.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TLS alerts</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN 2.7 will send =
out TLS alerts to peers informing them if the TLS</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    session shuts down or when the TLS implem=
entation informs the peer about</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    an error in the TLS session (e.g. mismatching TLS versions)=
. This improves</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
the user experience as the client shows an error instead of running into</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    a timeout when the=
 server just stops responding completely.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+Support for tun/tap via unix domain socket and lwipovpn support</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    To allow better testing =
and emulating a full client with a full</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    network stack OpenVPN now allows a program executed=
 to provide</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a tu=
n/tap device instead of opening a device.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    The co-developed lwipovpn program based on lwIP stack allows to</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    simulate full IP sta=
ck. An OpenVPN client using</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ``--dev-node unix:/path/to/lwipovpn`` can emulate a full client=
 that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    can be pin=
ged, can serve a website and more without requiring any</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    elevated permission. This can make =
testing OpenVPN much easier.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    For mo=
re details see [lwipovpn on Gihtub](https://github.com/OpenVPN/lwipovpn).</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> All=
ow overriding username with ``--override-username``</span><br><span>     Th=
is is intended to allow using auth-gen-token in scenarios where the</span><=
br><span>     clients use certificates and multi-factor authentication.  Th=
is will</span><br><span>@@ -57,7 +95,7 @@</span><br><span> </span><br><span=
> Deprecated features</span><br><span> -------------------</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-``secret`` support has been removed by=
 default.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``secret``=
 support has been removed (by default).</span><br><span>     static key mod=
e (non-TLS) is no longer considered &quot;good and secure enough&quot;</spa=
n><br><span>     for today&#39;s requirements.  Use TLS mode instead.  If d=
eploying a PKI CA</span><br><span>     is considered &quot;too complicated&=
quot;, using ``--peer-fingerprint`` makes</span><br><span>@@ -67,6 +105,14 =
@@</span><br><span>     ``--allow-deprecated-insecure-static-crypto`` but w=
ill be removed in</span><br><span>     OpenVPN 2.8.</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+Support for wintun Window=
s driver has been removed.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OpenVPN 2.6 added support for the new dco-win driver, so it supp=
orted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    three diff=
erent device drivers: dco-win, wintun, and tap-windows6.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OpenVPN 2.7 now drops the support =
for wintun driver. By default</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    all modern configs should be supported by dco-win driver. In =
all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    other cases =
OpenVPN will fall back automatically to tap-windows6</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    driver.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> NTLMv1 authentication support f=
or HTTP proxies has been removed.</span><br><span>     This is considered a=
n insecure method of authentication that uses</span><br><span>     obsolete=
 crypto algorithms.</span><br><span>@@ -78,21 +124,11 @@</span><br><span> `=
`persist-key`` option has been enabled by default.</span><br><span>     All=
 the keys will be kept in memory across restart.</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-Default for ``--topology`` cha=
nged to ``subnet`` for ``--mode server``</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    Previous releases always used ``net30`` as default. =
This only affects</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
configs with ``--mode server`` or ``--server`` (the latter implies the</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    former), and ``--dev t=
un``, and only if IPv4 is enabled.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    Note that this changes the semantics of ``--ifconfig``, so=
 if you have</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    manua=
l settings for that in your config but not set ``--topology``</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    your config might fail to parse=
 with the new version. Just adding</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ``--topology net30`` to the config should fix the problem.=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    By default ``--to=
pology`` is pushed from server to client.</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-O=
penSSL 1.0.2 support</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+OpenSSL 1.0.2 support has been removed.</span><br><span>     Support for b=
uilding with OpenSSL 1.0.2 has been removed. The minimum</span><br><span>  =
   supported OpenSSL version is now 1.1.0.</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-Compression on send</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+Compression on send has been removed=
.</span><br><span>     OpenVPN 2.7 will never compress data before sending.=
 Decompression of</span><br><span>     received data is still supported.</s=
pan><br><span>     ``--allow-compression yes`` is now an alias for</span><b=
r><span>@@ -100,6 +136,16 @@</span><br><span> </span><br><span> User-visibl=
e Changes</span><br><span> --------------------</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+- Default for ``--topology`` changed to ``subne=
t`` for ``--mode server``.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  Previous releases always used ``net30`` as default. This only affe=
cts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  configs with `=
`--mode server`` or ``--server`` (the latter implies the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  former), and ``--dev tun``, and only=
 if IPv4 is enabled.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  Note that this changes the semantics of ``--ifconfig``, so if you have</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  manual settings for=
 that in your config but not set ``--topology``</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  your config might fail to parse with the new =
version. Just adding</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  ``--topology net30`` to the config should fix the problem.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  By default ``--topology`` is pu=
shed from server to client.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> - ``--x509-username-field`` will no longer automa=
tically convert fieldnames to</span><br><span>   uppercase. This is depreca=
ted since OpenVPN 2.4, and has now been removed.</span><br><span> </span><b=
r><span>@@ -108,6 +154,14 @@</span><br><span>   And finite field Diffie Hel=
lman is in the proces of being deprecated</span><br><span>   (see draft-iet=
f-tls-deprecate-obsolete-kex)</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+- ``--lport 0`` does not imply ``--bind`` anymo=
re.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+- ``--static-challenge`` option now=
 has a third parameter ``format`` that</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  can change how password and challenge response should =
be combined.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+- ``--key`` and ``--cert``=
 now accept URIs if the SSL library supports it,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  which is the case for many OpenSSL 3 provide=
rs.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> Overview of changes in 2.6</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span> </span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1032?usp=3Demail">change 1032</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1032?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80a14b77fcc2fabf51af9f2d5ea=
0c36362cccb91 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1032 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--enkoLHapZQo=--

