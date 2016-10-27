Date: Thu, 27 Oct 2016 18:54:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161027165414.GL28918@...1296...>
References: <1477586981-5047-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c6YcJYqqMhegfX14"
Content-Disposition: inline
In-Reply-To: <1477586981-5047-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Remove last rest of INSTALL-win32.txt
 references
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--c6YcJYqqMhegfX14
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 27, 2016 at 06:49:41PM +0200, David Sommerseth wrote:
> Commit 04341beb1d8e0fad3425bfec5f281fe431895cd6 removed the
> INSTALL-win32.txt file.  But there were crucial parts left in
> Makefile.am which broke building OpenVPN.  In addition, removed
> other references in INSTALL and README to the same file to be
> complete.
>=20
> Signed-off-by: David Sommerseth <davids@...515...>

ACK!  Make the buildbots green again :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--c6YcJYqqMhegfX14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWBIxNakuBuNlUUl1AQLEPwP9Fbvd2cfRAUiBBzcGbDCxAzeKoGsmHEe9
66va3g26aj6zsZqR5+LHbXdnkhPjHVCh0DdDFVi0/ShdnK92bCDMFINend7dcfY6
Jjf8CQqiVVZQCHHqkwuGEk2R6qlU3gIFXq4Woz1JpMG1pOPRE2WbWzWcsTCdHUEP
zPjP/zLt6dU=
=lCxL
-----END PGP SIGNATURE-----

--c6YcJYqqMhegfX14--

