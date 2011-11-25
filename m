Date: Fri, 25 Nov 2011 11:29:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111125102900.GW8496@...1296...>
References: <1322172626-18434-1-git-send-email-davids@...1347...>
	<1322172626-18434-2-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hA/Q17QpEixUYHyZ"
Content-Disposition: inline
In-Reply-To: <1322172626-18434-2-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Do some file/directory tests before
	really starting openvpn
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

--hA/Q17QpEixUYHyZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 24, 2011 at 11:10:26PM +0100, David Sommerseth wrote:
> This patch tries to catch as many of these files as soon as possible, kin=
d of
> to "smoke-test" the files and directories to avoid the most likely errors.

ACK, both on the concept and the implementation, though I didn't verify
every single instance of the "check_file_access()" calls to see that
options + filename + text match.

It might be interesting to build a test script to see that these errors
actually get triggered...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hA/Q17QpEixUYHyZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTs9t7KkuBuNlUUl1AQK0IwP/RgWf6I6/b4gqVdWI/ANBD5OsqNGGjkog
7ONbmvD+ETgcp3Zqqv7MxVnHiNtmgDQNm8ErjcYl00L4OV3HOM/iVjlbkWx2Vhaz
BkTJKZK1hprhwpesrYx6yE1j0SeQj0bRegXgr1PAYL2MWc8QUfBgd+6SD19VzWmn
Hvebq6QOdhs=
=SomU
-----END PGP SIGNATURE-----

--hA/Q17QpEixUYHyZ--

