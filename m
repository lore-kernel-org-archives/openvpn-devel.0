From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 27 May 2025 11:34:51 +0000
In-Reply-To: <gerrit.1748268615000.I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91@...2715...>
References: <gerrit.1748268615000.I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277..., gert@...1296...
Message-ID: <0fc0514706fc9237cc4e10883e0c9b5b8213cdeb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0Dpzgcs1QZA="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, stipa <lstipakov@...277...>

--0Dpzgcs1QZA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail

to look at the new patch set (#3).


Change subject: Changes.rst: Collect, fix, and improve entries for 2.7 rele=
ase
......................................................................

Changes.rst: Collect, fix, and improve entries for 2.7 release

Change-Id: I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M Changes.rst
1 file changed, 121 insertions(+), 34 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/1032/3

diff --git a/Changes.rst b/Changes.rst
index e297334..83a210b 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -2,25 +2,58 @@
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
+    OpenVPN servers now can listen on multiple sockets at the same time.
+    Multiple ``--local`` statements in the configuration can be used to
+    configure this. This way the same server can e.g. listen for UDP
+    and TCP connections at the same time, or listen on multiple addresses
+    and/or ports.

-Support for tun/tap via unix domain socket and lwipovpn support
-    To allow better testing and emulating a full client with a full
-    network stack OpenVPN now allows a program executed to provide
-    a tun/tap device instead of opening a device.
+Client implementations for DNS options sent by server for Linux/BSD
+    Linux and BSD versions of OpenVPN now ship with a default ``dns-updown=
``
+    script that implements proper handling of DNS configuration sent
+    by the server. The scripts should work on systems that use
+    ``systemd`` or ``resolveconf`` to manage the DNS setup, as well as
+    raw ``/etc/resolv.conf`` files. However, the exact features supported
+    will depend on the configuration method. On Linux this should usually
+    mean that split-DNS configurations are supported out-of-the-box now.

-    The co-developed lwipovpn program based on lwIP stack allows to
-    simulate full IP stack and an OpenVPN client using
-    ``--dev-node unix:/path/to/lwipovpn`` can emulate a full client that
-    can be pinged, can serve a website and more without requiring any
-    elevated permission. This can make testing OpenVPN much easier.
+    Note that this new script will not be used by default if a ``--up``
+    script is already in use to reduce problems with
+    backwards compatibility.

-    For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/l=
wipovpn).
+    See documentation for ``--dns-updown`` and ``--dns`` for more details.
+
+New client implementation for DNS options sent by server for Windows
+    The Windows client now uses NRPT (Name Resolution Policy Table) to
+    handle DNS configurations. This adds support for split-DNS and DNSSEC
+    and improves the compatbility with local DNS resolvers. Requires the
+    interactive service.
+
+On Windows the ``block-local`` flag is now enforced with WFP filters.
+    The ``block-local`` flag to ``--redirect-gateway`` and
+    ``--redirect-private`` is now also enforced via the Windows Firewall,
+    making sure packets can't be sent to the local network.
+    This provides stronger protection against TunnelCrack-style attacks.
+
+Windows network adapters are now generated on demand
+    This means that on systems that run multiple OpenVPN connections at
+    the same time the users don't need to manually create enough network
+    adapters anymore (in addition to the ones created by the installer).
+
+Windows automatic service now runs as an unpriviledged user
+    All tasks that need privileges are now delegatedt to the interactive
+    service.
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
@@ -30,11 +63,6 @@

     https://datatracker.ietf.org/doc/draft-irtf-cfrg-aead-limits/

-Default ciphers in ``--data-ciphers``
-    Ciphers in ``--data-ciphers`` can contain the string DEFAULT that is
-    replaced by the default ciphers used by OpenVPN, making it easier to
-    add an allowed cipher without having to spell out the default ciphers.
-
 Epoch data keys and packet format
     This introduces the epoch data format for AEAD data channel
     ciphers in TLS mode ciphers. This new data format has a number of
@@ -49,15 +77,46 @@
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
     also generate a 'push "auth-token-user newusername"' directives in
     push replies.

+``--port-share`` now properly supports IPv6
+    Issues with logging of IPv6 addresses were fixed. The feature now allo=
ws
+    IPv6 connections towards the proxy receiver.
+
+Support for Haiku OS
+
 Deprecated features
 -------------------
-``secret`` support has been removed by default.
+``secret`` support has been removed (by default).
     static key mode (non-TLS) is no longer considered "good and secure eno=
ugh"
     for today's requirements.  Use TLS mode instead.  If deploying a PKI CA
     is considered "too complicated", using ``--peer-fingerprint`` makes
@@ -67,6 +126,14 @@
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
@@ -78,21 +145,11 @@
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
@@ -100,6 +157,16 @@

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

@@ -108,6 +175,26 @@
   And finite field Diffie Hellman is in the proces of being deprecated
   (see draft-ietf-tls-deprecate-obsolete-kex)

+- ``--lport 0`` does not imply ``--bind`` anymore.
+
+- ``--redirect--gateway`` now works correctly if the VPN remote is not
+  reachable by the default gateway.
+
+- ``--show-gateway`` now supports querying the gateway for IPv4 addresses.
+
+- ``--static-challenge`` option now has a third parameter ``format`` that
+  can change how password and challenge response should be combined.
+
+- ``--key`` and ``--cert`` now accept URIs if the SSL library supports it,
+  which is the case for many OpenSSL 3 providers.
+
+- TLS handshake debugging information contains much more details  now when
+  using recent versions of OpenSSL.
+
+- The ``IV_PLAT_VER`` variable sent by Windows clients now contains the
+  full Windows build version to make it possible to determine the
+  Windows 10 or Windows 11 version used.
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--0Dpzgcs1QZA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Changes.rst: Collect, fix, and improve entries for 2.7 release<br=
><br>Change-Id: I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M Changes.rst<br>1 fi=
le changed, 121 insertions(+), 34 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/32/1032/3</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/C=
hanges.rst b/Changes.rst</span><br><span>index e297334..83a210b 100644</spa=
n><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><=
span>@@ -2,25 +2,58 @@</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span> New features=
</span><br><span> ------------</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-TLS alerts</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  OpenVPN 2.7 will send out TLS alerts to peers informing them if the TLS</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    session shuts down =
or when the TLS implementation informs the peer about</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    an error in the TLS session (e.g. misma=
tching TLS versions). This improves</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    the user experience as the client shows an error instead =
of running into</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a =
timeout when the server just stops responding completely.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+Multi-socket support for servers</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN servers now =
can listen on multiple sockets at the same time.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    Multiple ``--local`` statements in the con=
figuration can be used to</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    configure this. This way the same server can e.g. listen for UDP<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    and TCP connecti=
ons at the same time, or listen on multiple addresses</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    and/or ports.</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-Support for tun/tap via uni=
x domain socket and lwipovpn support</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    To allow better testing and emulating a full client with=
 a full</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    network st=
ack OpenVPN now allows a program executed to provide</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    a tun/tap device instead of opening a d=
evice.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Client implem=
entations for DNS options sent by server for Linux/BSD</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    Linux and BSD versions of OpenVPN no=
w ship with a default ``dns-updown``</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    script that implements proper handling of DNS configur=
ation sent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    by th=
e server. The scripts should work on systems that use</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ``systemd`` or ``resolveconf`` to man=
age the DNS setup, as well as</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    raw ``/etc/resolv.conf`` files. However, the exact features s=
upported</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will de=
pend on the configuration method. On Linux this should usually</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    mean that split-DNS configur=
ations are supported out-of-the-box now.</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    The co-developed lwipovpn program =
based on lwIP stack allows to</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    simulate full IP stack and an OpenVPN client using</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ``--dev-node unix:/path/to/lwi=
povpn`` can emulate a full client that</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    can be pinged, can serve a website and more without re=
quiring any</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    elevat=
ed permission. This can make testing OpenVPN much easier.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    Note that this new script will no=
t be used by default if a ``--up``</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    script is already in use to reduce problems with</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    backwards compatibility=
.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/lwip=
ovpn).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    See docum=
entation for ``--dns-updown`` and ``--dns`` for more details.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+New client implementation for DNS options sent by se=
rver for Windows</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 The Windows client now uses NRPT (Name Resolution Policy Table) to</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    handle DNS configuratio=
ns. This adds support for split-DNS and DNSSEC</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    and improves the compatbility with local DNS=
 resolvers. Requires the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    interactive service.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+On Window=
s the ``block-local`` flag is now enforced with WFP filters.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    The ``block-local`` flag to ``=
--redirect-gateway`` and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ``--redirect-private`` is now also enforced via the Windows Firewa=
ll,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    making sure =
packets can&#39;t be sent to the local network.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    This provides stronger protection against T=
unnelCrack-style attacks.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Windows netwo=
rk adapters are now generated on demand</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    This means that on systems that run multiple OpenVP=
N connections at</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 the same time the users don&#39;t need to manually create enough network</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    adapters anymore =
(in addition to the ones created by the installer).</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+Windows automatic service now runs as an unpriviledged user<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    All tasks that n=
eed privileges are now delegatedt to the interactive</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    service.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+Support for new version of Linux DCO module</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OpenVPN DCO module is moving upstream=
 and being merged into the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    main Linux kernel. For this process some API changes were requir=
ed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN 2.7 =
will only support the new API. The new module is called</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ``ovpn``. Out-of-tree builds for ol=
der kernels are available. Please</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    see the release announcements for futher information.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Support for server mode in win-dco driver=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    On Windows the =
win-dco driver can now be used in server setups.</span><br><span> </span><b=
r><span> Enforcement of AES-GCM usage limit</span><br><span>     OpenVPN wi=
ll now enforce the usage limits on AES-GCM with the same</span><br><span>@@=
 -30,11 +63,6 @@</span><br><span> </span><br><span>     https://datatracker=
.ietf.org/doc/draft-irtf-cfrg-aead-limits/</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-Default ciphers in ``--data-ciphers`=
`</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    Ciphers in ``--d=
ata-ciphers`` can contain the string DEFAULT that is</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    replaced by the default ciphers used by=
 OpenVPN, making it easier to</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    add an allowed cipher without having to spell out the default c=
iphers.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> Epoch data keys and packet format</span><br><span>     This introduces =
the epoch data format for AEAD data channel</span><br><span>     ciphers in=
 TLS mode ciphers. This new data format has a number of</span><br><span>@@ =
-49,15 +77,46 @@</span><br><span>     - IV constructed with XOR instead of =
concatenation to not have (parts) of</span><br><span>       the real IV on =
the wire</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+Default ciphers in ``--data-ciphers``</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    Ciphers in ``--data-ciphers`` can contain the =
string DEFAULT that is</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    replaced by the default ciphers used by OpenVPN, making it easier to=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add an allowed =
cipher without having to spell out the default ciphers.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+TLS alerts</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    OpenVPN 2.7 will send out TLS alerts to peers informing them if=
 the TLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session=
 shuts down or when the TLS implementation informs the peer about</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    an error in the TLS sessi=
on (e.g. mismatching TLS versions). This improves</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    the user experience as the client shows a=
n error instead of running into</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    a timeout when the server just stops responding completely.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+Support for tun/tap via unix domain so=
cket and lwipovpn support</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    To allow better testing and emulating a full client with a full</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    network stack Ope=
nVPN now allows a program executed to provide</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    a tun/tap device instead of opening a device.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    The co-developed lwipovpn program =
based on lwIP stack allows to</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    simulate full IP stack. An OpenVPN client using</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ``--dev-node unix:/path/to/lw=
ipovpn`` can emulate a full client that</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    can be pinged, can serve a website and more without=
 requiring any</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
levated permission. This can make testing OpenVPN much easier.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    For more details see [lwipovpn on Gihtub](https=
://github.com/OpenVPN/lwipovpn).</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> Allow overriding username with ``--override-=
username``</span><br><span>     This is intended to allow using auth-gen-to=
ken in scenarios where the</span><br><span>     clients use certificates an=
d multi-factor authentication.  This will</span><br><span>     also generat=
e a &#39;push &quot;auth-token-user newusername&quot;&#39; directives in</s=
pan><br><span>     push replies.</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+``--port-share`` now properly supports IPv6<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Issues with logg=
ing of IPv6 addresses were fixed. The feature now allows</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    IPv6 connections towards the proxy=
 receiver.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+Support for Haiku OS</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Deprecate=
d features</span><br><span> -------------------</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-``secret`` support has been removed by default.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+``secret`` support ha=
s been removed (by default).</span><br><span>     static key mode (non-TLS)=
 is no longer considered &quot;good and secure enough&quot;</span><br><span=
>     for today&#39;s requirements.  Use TLS mode instead.  If deploying a =
PKI CA</span><br><span>     is considered &quot;too complicated&quot;, usin=
g ``--peer-fingerprint`` makes</span><br><span>@@ -67,6 +126,14 @@</span><b=
r><span>     ``--allow-deprecated-insecure-static-crypto`` but will be remo=
ved in</span><br><span>     OpenVPN 2.8.</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+Support for wintun Windows driver ha=
s been removed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
OpenVPN 2.6 added support for the new dco-win driver, so it supported</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    three different devic=
e drivers: dco-win, wintun, and tap-windows6.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    OpenVPN 2.7 now drops the support for wintun =
driver. By default</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   all modern configs should be supported by dco-win driver. In all</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    other cases OpenVPN wil=
l fall back automatically to tap-windows6</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    driver.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> NTLMv1 authentication support for HTTP prox=
ies has been removed.</span><br><span>     This is considered an insecure m=
ethod of authentication that uses</span><br><span>     obsolete crypto algo=
rithms.</span><br><span>@@ -78,21 +145,11 @@</span><br><span> ``persist-key=
`` option has been enabled by default.</span><br><span>     All the keys wi=
ll be kept in memory across restart.</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-Default for ``--topology`` changed to ``su=
bnet`` for ``--mode server``</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    Previous releases always used ``net30`` as default. This only af=
fects</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    configs with=
 ``--mode server`` or ``--server`` (the latter implies the</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    former), and ``--dev tun``, and on=
ly if IPv4 is enabled.</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    Note that this changes the semantics of ``--ifconfig``, so if you have=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    manual settings f=
or that in your config but not set ``--topology``</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    your config might fail to parse with the ne=
w version. Just adding</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ``--topology net30`` to the config should fix the problem.</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    By default ``--topology`` is =
pushed from server to client.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-OpenSSL 1.0.2=
 support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenSSL 1.0=
.2 support has been removed.</span><br><span>     Support for building with=
 OpenSSL 1.0.2 has been removed. The minimum</span><br><span>     supported=
 OpenSSL version is now 1.1.0.</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-Compression on send</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+Compression on send has been removed.</span><br>=
<span>     OpenVPN 2.7 will never compress data before sending. Decompressi=
on of</span><br><span>     received data is still supported.</span><br><spa=
n>     ``--allow-compression yes`` is now an alias for</span><br><span>@@ -=
100,6 +157,16 @@</span><br><span> </span><br><span> User-visible Changes</s=
pan><br><span> --------------------</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+- Default for ``--topology`` changed to ``subnet`` for ``--=
mode server``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Pre=
vious releases always used ``net30`` as default. This only affects</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  configs with ``--mode serv=
er`` or ``--server`` (the latter implies the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  former), and ``--dev tun``, and only if IPv4 is =
enabled.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Note that=
 this changes the semantics of ``--ifconfig``, so if you have</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  manual settings for that in you=
r config but not set ``--topology``</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  your config might fail to parse with the new version. Jus=
t adding</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--topol=
ogy net30`` to the config should fix the problem.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  By default ``--topology`` is pushed from se=
rver to client.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> - ``--x509-username-field`` will no longer automatically conv=
ert fieldnames to</span><br><span>   uppercase. This is deprecated since Op=
enVPN 2.4, and has now been removed.</span><br><span> </span><br><span>@@ -=
108,6 +175,26 @@</span><br><span>   And finite field Diffie Hellman is in t=
he proces of being deprecated</span><br><span>   (see draft-ietf-tls-deprec=
ate-obsolete-kex)</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+- ``--lport 0`` does not imply ``--bind`` anymore.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+- ``--redirect--gateway`` now works correctly i=
f the VPN remote is not</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  reachable by the default gateway.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+- ``--show-gateway`` now supports querying the gateway for IPv4 addresses.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+- ``--static-challenge`` option now ha=
s a third parameter ``format`` that</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  can change how password and challenge response should be =
combined.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+- ``--key`` and ``--cert`` no=
w accept URIs if the SSL library supports it,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  which is the case for many OpenSSL 3 providers.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+- TLS handshake debugging information =
contains much more details  now when</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  using recent versions of OpenSSL.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+- The ``IV_PLAT_VER`` variable sent by Windows clients now c=
ontains the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  full W=
indows build version to make it possible to determine the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  Windows 10 or Windows 11 version us=
ed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
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
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--0Dpzgcs1QZA=--

