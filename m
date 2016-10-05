Date: Wed, 5 Oct 2016 15:00:20 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20161005130020.GT78279@...1296...>
References: <1475671681-2864-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mV0x5vRiaQJFucaF"
Content-Disposition: inline
In-Reply-To: <1475671681-2864-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] man page: Update the --cipher section
 to reflect recommendations after SWEET32
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

--mV0x5vRiaQJFucaF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 05, 2016 at 02:48:01PM +0200, David Sommerseth wrote:
> We should no longer make users believe Blowfish is a 'very secure' cipher.
> Update this section to reflect our recommendations after the SWEET32
> announcement.

NAK, as it conflicts with=20

commit 5a1daf533ae283e258732260c96461e820e61fe6
Author: Steffan Karger <steffan@...1856...>
Date:   Sun Sep 11 16:50:31 2016 +0200

    Update cipher-related man page text

    As reported in trac #732, the man page text for --cipher is no longer
    accurate.  Update the text to represent current knowledge, about NCP and
    SWEET32.


gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mV0x5vRiaQJFucaF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV/T5Y6kuBuNlUUl1AQL98QQAp/Wzmfc6bCb55ELSvjhpfwDta6vrCIm3
8N5jMCN8Aa/OLDvAUZsN6FPEkip0X1XoxQNnSkTX+QenWZE8NDbWSYeIMGMkjPxF
8+HYDf2XVG0KekfchSZxeXiwut7jXWE3Ernmlik1mkbutg7B1Izil0DrFVeNW5EX
h7frnxN0moU=
=sBPy
-----END PGP SIGNATURE-----

--mV0x5vRiaQJFucaF--

