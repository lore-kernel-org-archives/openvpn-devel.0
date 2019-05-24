From: David Sommerseth <openvpn@...2080...>
Message-ID: <9fa97fc4-b708-5131-3d27-deb7809404dd@...2080...>
Date: Sat, 25 May 2019 00:06:23 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4NVQJz1wLvCAz0V6HFbINLIxsBbLKKP1K"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v6 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, OpenVPN Users <Openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4NVQJz1wLvCAz0V6HFbINLIxsBbLKKP1K
Content-Type: multipart/mixed; boundary="t7bSL56FH8wTcROLyobamKYU7Fng5olwt";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>,
 OpenVPN Users <Openvpn-users@lists.sourceforge.net>
Message-ID: <9fa97fc4-b708-5131-3d27-deb7809404dd@...2080...>
Subject: OpenVPN 3 Linux client - v6 beta released

--t7bSL56FH8wTcROLyobamKYU7Fng5olwt
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

The OpenVPN 3 Linux v6 beta release has been pushed out.  This is available=
 in
our git repositories [0] and URLs for source tarballs are listed later in t=
his
e-mail.  RPM binaries for Fedora and RHEL/CentOS/Scientific Linux [1]
completed the build process quite recently too.  More details on Debian/Ubu=
ntu
packages further down in this mail.

The highlights of this release includes:

  # OpenSSL 1.1.0/1.1.1 support
    The OpenVPN 3 Core Library has been updated with full OpenSSL 1.1.0/1.1=
.1=20
    support.

  # Improved --persist-tun support
    This will avoid leaking traffic if using --redirect-gateway when switch=
ing=20
    to a new server.  It manages this by creating a new tun device setting =
up=20
    all the routes before removing the old (and now non-working) tun device=
=20
    and the related routes.  It also ensures the IP address to the new VPN=
=20
    server gets the appropriate bypass route to avoid pushing that traffic=
=20
    into the VPN tunnel.  This will normally work very fine, with the
    exception when programs binds to specific interfaces.

  # Improved service shut-down
    In all previous releases, the various backend services didn't exit as=20
    quickly as they could when being sent SIGINT or SIGTERM signals.  The
    whole idle-exit mechanism causing this bad behaviour has been revamped
    and improved resulting in an almost instant service shutdown.

OpenVPN 3 Linux is on track for prime-time production.  It will still come a
some more beta releases, to iron out last missing minor features and other
improvements.  But OpenVPN 3 Linux is essentially feature ready now.

If you are using OpenVPN 3 Linux, please report back if there are issues you
have or improvements you feel is important for the stable release.


* Debian and Ubuntu package repositories

There has been several requests for Debian and Ubuntu repositories with pre-
compiled binaries.  They are on the way now.  I hoped we would have them re=
ady
for this announcement, but we're still fighting with a few issues for the f=
inal
deployment.  Packages are built and ready for Debian 9, Ubuntu 16.04 LTS and
Ubuntu 18.04 LTS, we just need to figure out what went wrong when publishing
them into the public repositories.  Stay tuned, I hope this will be sorted =
out
in not too many days.


* Quick-start with OpenVPN 3 Linux once it has been installed

  $ openvpn2 --config my-vpn-config.conf --verb 6

This will start a VPN configuration profile with the most verbose logging. =
 If
the configuration does not contain --daemon, all logging will also be prese=
nt
in the console and the tunnel will be torn down with a simple CTRL-C.
Otherwise the VPN session will be running in the background and you get your
command prompt back again, and you need to manage this session using
`openvpn3 session-manage --config my-vpn-config.conf`

For more information see the various man-pages available [2].


* Install Fedora Copr packages for Fedora, RHEL, CentOS and Scientific Linux

Ensure you have the yum-plugin-copr or the dnf copr plugin installed.  For
RHEL/CentOS/Scientific Linux you will also need to have the Fedora EPEL
repository enabled [3].  Then run the following commands:

For yum users:

   $ yum copr enable dsommers/openvpn3
   $ yum install openvpn3-client

or for dnf users:

   $ dnf copr enable dsommers/openvpn3
   $ dnf install openvpn3-client



[0] <https://gitlab.com/openvpn/openvpn3-linux>
    <https://github.com/OpenVPN/openvpn3-linux>

[1] <https://copr.fedorainfracloud.org/coprs/dsommers/openvpn3/>
[2] <https://github.com/OpenVPN/openvpn3-linux/tree/master/docs/man/>
[3] <https://fedoraproject.org/wiki/EPEL>


---- Source tarballs ----------------------------------------------------
* OpenVPN 3 Linux v6 beta

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-6_beta.ta=
r.xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-6_beta.ta=
r.xz.asc>

---- SHA 256 Checksums --------------------------------------------------
7f92d294705b29f109a35ec6f7957f8b8eefe8829dc9be08751e428d90a8ccb0  openvpn3-=
linux-6_beta.tar.xz
0f6298e3b642aad675f5b155273952ccf857f57f0ef72f0a6854256758a16865  openvpn3-=
linux-6_beta.tar.xz.asc

---- git references -----------------------------------------------------
git tag: v6_beta
git commit: e6c66892ba0868206d558ad8b81351140c1195b4

---- Changes from v5 to v6 ----------------------------------------------
David Sommerseth (12):
      build: Add sitnl debug messages compile time switch
      ovpn3cli/sessions: Add --cleanup to session-manage
      sessionmgr: Improve backend Ping() error handling when registering
      dbus: Improve IdleCheck documentation
      dbus: Revamp IdleCheck to use std::condition_variable
      dbus/services: Clean up after IdleCheck signal handling changes
      dbus/services: Remove NOP SetPollTime()
      log: Make the log tag mechanism more generic
      Update Core library to latest upstream
      build: Strip out build date/time stamp by default
      docs: Update README.md
      client/netcfg: Add proper support for persist-tun

Lev Stipakov (3):
      netcfg: adapt to refactored TunLinuxSetup
      netcfg: implement addBypassRoute method
      client: take addBypassRoute into use

-------------------------------------------------------------------------


--=20
kind regards,

David Sommerseth
OpenVPN Inc


--t7bSL56FH8wTcROLyobamKYU7Fng5olwt--

--4NVQJz1wLvCAz0V6HFbINLIxsBbLKKP1K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJc6GrfAAoJEIbPlEyWcf3y6asQAK1ZYD+UwRHYm3bFfCmuppPA
44riQOXvTzTfug3vfnvlpKVF3lPv7QmlKHU4j92aSLax3b9huhhlphtNsL3DX8lD
LmgAN8vCfmfS7hW8TSN91v0UYWB0vNEp+VaotSdN/xh6ajrDTv0MomTV2FKA59i/
68GiW74DJuVJemKiubn0jHXh62iCmCWduBUNNhLZsS2+BLz0VPDT1xQkPAE4Siyt
S/lAjpkO1BnSNRx/RKqtUeY3OQliAZtVfWnHeMpLvIzWtWHrOStgoii8V/NVqtEI
WHLENfcGEea5I7HOLxW4BGjJeyfQmHCbqoAPTOXEVeKFrxCh4/0s+gctPTZurWf1
SuncWuh1MSb6FIK2IjBDyjiQBKHDK2Dapo4MlL+OQix/OAqQeJhJInyzpDT8ewRg
SIPHVix7UqqBQwdmvsNJivOX7nL5rW4mJd2PoXVC9nikOBogzScz8lNk0dovwQLt
pM3RUAeevLivZ7WBciLaRT7ryW+CWvnRxoOppGVI/gjV7X8nsDnbi5TQuqaXL4dV
0vqzmmoY8lD3BvRVZDqb7TSbXQr5nffpQ+iXxNzfamlvbf5XqUxwVBo893Qo8ihj
2gbT5u2v+79AseszmyqNCv7SXhXabWAkpoEmbP69CGA755o9VofqvT3kUWo/F8ky
3+JG949I6okCfPvZJfN5
=mY7b
-----END PGP SIGNATURE-----

--4NVQJz1wLvCAz0V6HFbINLIxsBbLKKP1K--

