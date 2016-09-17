Date: Sat, 17 Sep 2016 12:45:09 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160917104509.GT78279@...1296...>
References: <1474105455-26414-1-git-send-email-davids@...515...>
	<1474107573-31381-1-git-send-email-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H9RgKGg/uJzkChT4"
Content-Disposition: inline
In-Reply-To: <1474107573-31381-1-git-send-email-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCHv2] t_client.sh: Add support for
 Kerberos/ksu
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

--H9RgKGg/uJzkChT4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 17, 2016 at 01:19:33PM +0300, David Sommerseth wrote:
> +        klist -l &> /dev/null

NAK :)

(bashism, on ksh it will just put "klist -l" into the background)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--H9RgKGg/uJzkChT4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV90es6kuBuNlUUl1AQIu0gQApxb4PtVBM/BKSqF04ONEIsvAnBKsAw1N
iEAiOkUS7VH1APTYTWj7rIeNr2z/zYJYgyfR90UR4Yazg1VRei6rJpxjnYDiqMyg
w7W51FBtOjzwcCYUie16ccmjSZDQ1n61dKn96Uv9ncjGZi6tIEdCLJATux2CxPzg
rnT2/BOWdlI=
=CsjE
-----END PGP SIGNATURE-----

--H9RgKGg/uJzkChT4--

