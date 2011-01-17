Date: Mon, 17 Jan 2011 22:30:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20110117213043.GH12114@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
Subject: [Openvpn-devel] configure not finding lzo (Solaris, NetBSD)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--CblX+4bnyfN0pR09
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

since there's folks on this list that understand configure way better
than I do...

Building OpenVPN on Solaris and on NetBSD fails "as is" because configure
does not find the lzo headers and library.

On NetBSD, these are (usually) installed by pkgsrc, and live in
/usr/pkg/include and /usr/pkg/lib.

On Solaris, if installed "from the source", the LZO stuff lives in
/usr/local/include and /usr/local/lib (same place the libraries would
end up on NetBSD if installed manually, not from pkgsrc).

"Other packages" don't seem to have problems finding libraries in=20
"the usual places for this operating system", even if it's not plain
/usr/include + /usr/lib.

So - should this be fixed?  If yes, what's the "right" way to get it
fixed?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTTS1AqkuBuNlUUl1AQI8XwP8CTK5z9oKUizROF+46ZkBrGHftRcJqoRV
HKkgGCSxwcaTjSHOqAYqIDBM7T7MYFgR6F+fc4XmVVbgX+/QW9Puk0LCQMktMSpB
R+LHRt4R4bInxSq/BTbk1TSljGOmMvRDladp8cVkam0NMIj9HkGHPlgDcV3NnBn9
ag4JbeJDlGM=
=yZvW
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--

