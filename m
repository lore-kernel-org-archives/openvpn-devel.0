From: "Doncho N. Gunchev" <mr700@...184...>
Reply-To: mr700@...184...
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1794394.inAsotRX1z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412141748.01332@...187...>
Subject: [Openvpn-devel] OpenVPN samples and rpm requirements - subpackage?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Dec 14 07:49:00 2004
To: openvpn-devel@lists.sourceforge.net

--nextPart1794394.inAsotRX1z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

    Hello all,
    the samples from openvpn's rpm package raise dependencies on perl
and some perl modules with Fedora. I assume it is problematic for other
distros also, so I suggest to move them in separate sub-package.
I splitted the package into two packages - openvpn-2.0...i386.rpm and
openvpn-samples-2.0...rpm. This way I can use 'AutoReq: 0' and
'Requires: %name =3D %version' within '%package samples' and have right
and authomatic dependencies for the main package at the same time.
Is this acceptable for all?

    Also, for Fedora/Red Hat the right group is not Networking/Tunnels
but maybe Applications/Internet (/usr/share/doc/rpm-*/GROUPS is refered
as source for groups in fedora), but this is not a big problem... Maybe
I'm too pedantic and there's another %if is not needed?

--=20
Regards,
  Doncho N. Gunchev    Registered Linux User #291323 at counter.li.org
  GPG-Key-ID: 1024D/DA454F79                        http://pgp.mit.edu
  Key fingerprint =3D 684F 688B C508 C609 0371  5E0F A089 CB15 DA45 4F79

--nextPart1794394.inAsotRX1z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBvwsxoInLFdpFT3kRAt7GAKDa8BrFiH2kGUwma8bUMUctujsEfwCg+jfX
DtXURh785CbsJoF1HDjts/k=
=mw7R
-----END PGP SIGNATURE-----

--nextPart1794394.inAsotRX1z--

