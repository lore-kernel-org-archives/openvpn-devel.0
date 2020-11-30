From: David Sommerseth <openvpn@...2080...>
Message-ID: <6fc85e8e-bb42-f46b-5b07-a1bae4b44fb9@...2080...>
Date: Mon, 30 Nov 2020 21:58:34 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Onv4U9MjggxueuhZxUP0kUjKDO2sMwva1"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v12 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Onv4U9MjggxueuhZxUP0kUjKDO2sMwva1
Content-Type: multipart/mixed; boundary="D9JGLLbWP4oVykDpYoKisO1SnWegUJFOs";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net
Message-ID: <6fc85e8e-bb42-f46b-5b07-a1bae4b44fb9@...2080...>
Subject: OpenVPN 3 Linux client - v12 beta released

--D9JGLLbWP4oVykDpYoKisO1SnWegUJFOs
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The OpenVPN 3 Linux v12 beta is now ready.

The highlights of this release includes:

* Feature: Web-based authentication
  For servers allowing web based authentication, OpenVPN 3 Linux
  will now pick up this authentication type request and handle
  it.  If the openvpn2 or openvpn3 user-front-end applications
  are able to open a browser window with the given URL, it will
  do so.  If not, it will present the URL needed for the further
  authentication process.  In addition, any VPN sessions awaiting
  web based authentication is also presented via the
  `openvpn3 sessions-list` command together with the authentication
  URL.

* Bugfix: OpenVPN 3 Linux configuration manager could crash
  If the openvpn3-service-configmgr program was started with the
  --state-dir argument pointing at an unreadable or non-existing
  directory, it would crash.  This has been fixed to provide a
  better error message and exit gracefully.  Front-end
  applications will still report that the net.openvpn.v3.configruations
  service is unavailable, this fix is not visible for end-users - just
  improving the behaviour of openvpn3-service-configmgr.

* Bugfix: Properly handle restart of paused sessions
  VPN sessions being paused (like via
  `openvpn3 session-manage --pause`) would not recover properly if
  it was recovered by using the `restart` method instead of `resume`.
  When trying to pause the session again, it would not do so as the
  session was considered paused already.  Resuming a VPN session
  via both the `resume` and the `restart` method are considered
  appropriate and is now handled correctly.

* Bugfix: openvpn2 running in the foreground could exit with an error
  If the openvpn2 front-end was used to start a VPN session and it
  was running in the foreground (no use of --daemon), it would present
  and error message when closing the session *if* the VPN session
  was closed via another channel (such as `openvpn3 session-manage`).
  This has been fixed and it will now exit properly if this situation
  appears, without any additional error messages.

* Bugfix: openvpn2 would misinterpret --keepalive
  The OpenVPN option parser in the Python 3 openvpn module would not
  properly parse a few arguments which used multiple arguments - such
  as --keepalive.  This has been fixed.

* Enhancements: openvpn2 now understands --tls-version-{min,max}
  In prior releases, the Python 3 openvpn module did not understand
  the --tls-version-min and --tls-version-max options.  This has been
  resolved and these options are forwarded properly to the
  configuration manager.


--=20
kind regards,

David Sommerseth
OpenVPN Inc


[0] <https://gitlab.com/openvpn/openvpn3-linux>
    <https://github.com/OpenVPN/openvpn3-linux>

---- Source tarballs ----------------------------------------------------
* OpenVPN 3 Linux v11 beta

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-12_beta.t=
ar.xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-12_beta.t=
ar.xz.asc>

---- SHA256 Checksums ---------------------------------------------------

899a4211e883682f5d1fb50dad4425c743283c117b068d3af3d1189f65c2e0ce  openvpn3-=
linux-12_beta.tar.xz
7b592b652daa7f4119019d9764005a019765bc4a2ab5de65cf5faf982d0617f4  openvpn3-=
linux-12_beta.tar.xz.asc

---- git references -----------------------------------------------------

git tag: v12_beta
git commit: be65151677fa854080a563a52d1a96b38ab29544

---- Changes from v11 to v12 --------------------------------------------

David Sommerseth (11):
      client: Properly reset the paused flag on session restart
      python: Improve parsing of options with multiple arguments
      python: Extend argument parser with support for --tls-version-min/max
      dbus: Add web-auth constant to ClientAttentionGroup
      client: Enable web-auth support and URL extraction
      python: Add support for handling web-auth in openvpn2
      python: Resolve error in openvpn2 on disconnect with pre-closed sessi=
ons
      common: Implement function for opening up URIs on the host
      ovpn3cli: Add support web auth via openvpn3
      ovpn3cli: Improve 'sessions-list' for sessions awaiting web auth
      configmgr: Abort properly if --state-dir processing fails

-------------------------------------------------------------------------



--D9JGLLbWP4oVykDpYoKisO1SnWegUJFOs--

--Onv4U9MjggxueuhZxUP0kUjKDO2sMwva1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfxVz6AAoJEIbPlEyWcf3yuucP/RZ1GY+lShlWHLLYGxbq+3uS
MD7a5ZmiwSKmlB1v5P6eECXNAW8sRrnhcRNG6g3D+w+l8iHutp9NaLU9v22jaX01
cATv9oQMfh6yzmWyCZM7WMQIuwhIqIwL00ShC09syD/itv+4FSctdzZHMQyryAC8
dJ0/3WWyibFd1WHbQoMNyURlRrAk10rQrSs3gEn5ph4E7S6EXASRT/tQhzK0427E
TI3lpugPtzjtcdNmr9E2qRel5L3Pr6Kx/MU6pZBhcQmKXcc6y3Q7krIUAX501Msh
2CHdBJZ+PAaKIMBcvkPihjJ8naAgA8UfJQ5jRCfDpeYHGpiU/wxqNw/9xNQl2zKt
pgXH7IWnyDR2ogvuIDncA7kdgNPsADbm83hSG1+qp9OW+MpVJJwKDlkw3484x2Xa
nVbzmunscTKlE4l73HN8+XqrlePtdB5Y3k2+14a9UldTSkRaF4KGEczSJtt4hmtl
mcMERNkhKjGkxisZv9Ij+n1vted0sbg2545liMY1rWkx2MSblihVB0dWdCu6JlM7
w7efnZge/2PEtBoGOgdlkFdYU3ck1YBS++a8Vr4CLf2rN/pTYwj7KcfXo++N3d0U
NZQIV96lAyK25SYnKIaCwRWeZvmMsJXlP2sG+Eor+bi6GavEUU+wWdeAhI4mCrYZ
s0eZVORInEiPxfQ/oifd
=dNs4
-----END PGP SIGNATURE-----

--Onv4U9MjggxueuhZxUP0kUjKDO2sMwva1--

