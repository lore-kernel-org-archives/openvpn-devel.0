Message-ID: <547CB1A4.1070708@...515...>
Date: Mon, 01 Dec 2014 20:21:24 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060401010004060407040502"
Subject: [Openvpn-devel] OpenVPN 2.3.6 released - fixes a critical DoS issue
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-announce@lists.sourceforge.net" <openvpn-announce@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060401010004060407040502
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The OpenVPN community project team is proud to release OpenVPN 2.3.6. It
can be downloaded from here:

<http://openvpn.net/index.php/open-source/downloads.html>

This release fixes a critical denial of service vulnerability in OpenVPN
servers (CVE-2014-8104). The vulnerability can be exploited by
authenticated clients only. Also note that confidentiality and
authenticity of traffic are not affected. More information about this
vulnerability is available on the Trac Wiki:

<https://community.openvpn.net/openvpn/wiki/SecurityAnnouncement-97597e732b>

This release also includes a few other fixes and enhancements.

A full list of changes is available here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>

The changelog is also attached to this email.

The 2.2 branch in Git has also been patched for the DoS vulnerability.
Fixed source packages (2.2.3) are also provided, primarily for the
benefit of OpenVPN package maintainers. Official Windows installers
based on 2.2.3 will not be released.

For generic help use these support channels:

- - - Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
- - - Wiki: <https://community.openvpn.net>
- - - Forums: <https://forums.openvpn.net>
- - - User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- - - User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

- - - Bug tracker and Wiki: <https://community.openvpn.net>
- - - Developer mailing list: <http://sourceforge.net/mail/?group_id=3D4897=
8>
- - - Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
  Freenode registration)

- - --
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlR8saQACgkQwp2X7RmNIqN63wCfWzr5rN60BoHuir//x0jSkvtQ
7n8An2ppL7+1QQ/3VxGMwlYbdEgBzu3q
=3DX0lz
-----END PGP SIGNATURE-----


--------------060401010004060407040502
Content-Type: text/plain; charset=UTF-8;
 name="openvpn-2.3.6-changelog"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="openvpn-2.3.6-changelog"

David Sommerseth (1):
      systemd: Reworked the systemd unit file to handle server and client=
 configs better

Gert Doering (2):
      Add client-only support for peer-id.
      Preparing for release v2.3.6 (ChangeLog, version.m4)

Samuli Sepp=C3=A4nen (1):
      Fix to --shaper documentation on the man-page

Steffan Karger (4):
      Fix assertion error when using --cipher none
      Add --tls-version-max
      Modernize sample keys and sample configs
      Drop too-short control channel packets instead of asserting out.


--------------060401010004060407040502
Content-Type: application/pgp-signature;
 name="openvpn-2.3.6-changelog.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-2.3.6-changelog.sig"

iEYEABECAAYFAlR8saQACgkQwp2X7RmNIqMNaQCeK8gq1G+zfpzvF+HTf+jdDx9bIIUAoJgi
wTsnk4jvt9xoA+qjdSj0IVqT
--------------060401010004060407040502--

