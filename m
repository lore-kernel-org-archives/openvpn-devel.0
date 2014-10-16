Message-ID: <543FECF6.2000200@...1114...>
Date: Thu, 16 Oct 2014 18:06:14 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="rJ2vVpEvfbUj6xlqLLC0bERn2pNtOgRMM"
Subject: [Openvpn-devel] Some systemd patches backported from master to
	release/2.3
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rJ2vVpEvfbUj6xlqLLC0bERn2pNtOgRMM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


This is just an short update on a few cherry-picks I've done to improve
the systemd implementation in OpenVPN 2.3.x.  All the commits have been
cherry picked from the master branch into the stable release/2.3 branch.

* Commit 027dd7f6368d7a7fc8a4ca5e0fadd8de2c7c88da
  systemd: Use systemd functions to consider systemd availability

  Merged backport of master commit 55480682b9bfa5894402954f4c740
  + master commit f33ee6bcb12fdc3869b17b7c528a2


* Commit a83103043c11d66099565bcf4b63f54db0629913
  Add systemd unit file for OpenVPN

  Master commit 8a4566ce4f01a434ac9ea841eae74330368398a0


* Commit f54cdc9f5316906c664a782abf8fdac028a80860
  Don't let openvpn_popen() keep zombies around

  Master commit d886d468849051af525bb8ff1b9080f6c934e3ab

* Commit ef21281b290c2984523c36be06f62b24ca253001
  Add configure check for the path to systemd-ask-password

  Master commit ba79c71d1255651bfcb8570519b4033c763d47d3


--=20
kind regards,

David Sommerseth


--rJ2vVpEvfbUj6xlqLLC0bERn2pNtOgRMM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQ/7PgACgkQDC186MBRfroNGQCcDXYDqfS78QPCDJBtA1pc3Rrs
g+4AoIzqTsEIp3YCdd/Rrvny1HqyWd3g
=vp8z
-----END PGP SIGNATURE-----

--rJ2vVpEvfbUj6xlqLLC0bERn2pNtOgRMM--

