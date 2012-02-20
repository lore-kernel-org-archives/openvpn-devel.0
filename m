Date: Mon, 20 Feb 2012 11:05:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120220100502.GJ7024@...1296...>
References: <1329730625-21681-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o99acAvKqrTZeiCU"
Content-Disposition: inline
In-Reply-To: <1329730625-21681-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Revamp check_file_access() checks in
	stdin scenarios
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--o99acAvKqrTZeiCU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 20, 2012 at 10:37:05AM +0100, David Sommerseth wrote:
> It was discovered that --management also can take stdin as argument
> instead of a file.  Enabled this by revamping the check_file_access()
> flags by adding CHKACC_ACPTSTDIN.  Setting this flag will then consider
> filenames as 'stdin' as always present.
>=20
> The other place where 'stdin' was accepted is also modified to use this
> flag instead.

I like this better than the old one for --auth-user-pass, and of course,
the patch solves a problem, so ack :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--o99acAvKqrTZeiCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0IazqkuBuNlUUl1AQKTOAP/Sb99Me1ZUtk4rfJ5Pa3dfLWlpJKdWHI+
qJWeRhD3C72Bk9ZLdB6BKHN63WDpdhd+kwnwpdbCXnOIRieBzIfrjAsMtCZOOwlg
u6FyokegSzeqVuVRIFm9T2P5A2JT1pB+ijcAy8wqgwp1c7eIeQg9Vf3W4R+JUe2M
IxLduyavnjU=
=62Jd
-----END PGP SIGNATURE-----

--o99acAvKqrTZeiCU--

