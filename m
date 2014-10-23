Date: Thu, 23 Oct 2014 07:48:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141023054824.GJ396@...1296...>
References: <11460032.199978.1414042248849.JavaMail.root@...1893...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V39eZ3eeYcE7QFDY"
Content-Disposition: inline
In-Reply-To: <11460032.199978.1414042248849.JavaMail.root@...1893...>
Subject: Re: [Openvpn-devel] Are OpenVPN 2.3.4 I005 and I605 builit with
	OpenSSL 1.0.1j and "no-ssl3" flag?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lisa Minogue <lminogue@...1892...>
Cc: openvpn-devel@lists.sourceforge.net

--V39eZ3eeYcE7QFDY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 23, 2014 at 07:30:48AM +0200, Lisa Minogue wrote:
> I'm no expert of OpenVPN or OpenSSL and it be nice of you if you could te=
ll me whether the latest OpenVPN's installers for Microsoft Windows OS have=
 been built with "no-ssl3" flag in OpenSSL 1.0.1j.

No, they haven't.

Because it is not relevant for OpenVPN, as Steffan explained.

(OpenVPN gets build with default flags, as you can see when you look
into the build scripts in git)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--V39eZ3eeYcE7QFDY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVEiWqKkuBuNlUUl1AQJtFgQAqb19OsYcDhdUX9rDCDB5/5H6fzRWe2JB
ZZPI44n+jRdQkgGqwZJXFejk5JagNciCeb67gYwRJB1OXBN/rXog4WWDBgh3SOBw
nrjo8QWq/nEOKpXRc8NmBmFrQnho3zGSdfVTMEAoveDlkRBjtMDaTabywX6/sE/G
d9hl0IesJaQ=
=545B
-----END PGP SIGNATURE-----

--V39eZ3eeYcE7QFDY--

