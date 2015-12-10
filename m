Date: Thu, 10 Dec 2015 17:26:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151210162651.GI24952@...1296...>
References: <5661686A.4090305@...2070...>
	<1449656275-24934-1-git-send-email-iam@...2070...>
	<56694C04.6020904@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZLPkqyGOTypMs5ma"
Content-Disposition: inline
In-Reply-To: <56694C04.6020904@...277...>
Subject: Re: [Openvpn-devel] [PATCH v8-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--ZLPkqyGOTypMs5ma
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 10, 2015 at 11:55:16AM +0200, Lev Stipakov wrote:
> Sorry for the late response.
[..]
> FwpmSubLayerDeleteByKey0 will likely fail if there is a filter=20
> associated with sublayer. On the other side, FwpmEngineClose0 seems to=20
> be enough to remove blocking.

So, is this something that needs to be fixed before we release 2.3.9, or
can it wait for improvement later on?

I just agreed with Samuli that we are going to release 2.3.9 on Monday,
and this should go in - so either I get a v9 "with nice and shiny" until
Sunday, or someone tells me "v8 is good enough, go for it"...

Thanks :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZLPkqyGOTypMs5ma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmmnyqkuBuNlUUl1AQIzAgP9G62wMUxrLx9qHNpwZJYI1vhsqkucIAA4
ON4ad5O8Ar0GwW+rn21CQTGpGdGWf2UljwKljyBWT2zmjPgXgfcsMOJuIZG8kjhO
29oS9LbZPIHFLPfwdyInoZy2YtALuU7D96EkLlELfvaBFLmZe+zcq0+NSb4pfGPA
lDDIGLaK3bY=
=vDr4
-----END PGP SIGNATURE-----

--ZLPkqyGOTypMs5ma--

