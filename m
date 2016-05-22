Date: Sun, 22 May 2016 09:26:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160522072623.GU53051@...1296...>
References: <CAKuzo_g1jx2JkxP2BSVYPW4axnMUQgVe=WvBSzC+x8n6LR_A9g@...278...>
	<1463892387-4793-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="54IhRO6Q6H7PICCg"
Content-Disposition: inline
In-Reply-To: <1463892387-4793-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix handling of out of memory error in
 interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--54IhRO6Q6H7PICCg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

thanks for digging into this.  Overall, the patch makes sense, I'm just
wondering about this:

On Sun, May 22, 2016 at 12:46:27AM -0400, Selva Nair wrote:
> Other changes:
> - Use minimal initial allocation size so that the realloc code path
>   gets exercised (2 or more connections will cause realloc).

I can see that this is useful for testing, but do we want this in productio=
n?

It won't make a difference for most usages ("only one connection active"),
but then, the extra memory use for 10 is minimal, and realloc() *can* fail,
so just keeping at 10 won't need the realloc() path generally...

Dunno, just thinking loud.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--54IhRO6Q6H7PICCg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV0FfHqkuBuNlUUl1AQKRNwQAlaV1K97skJ4FaFhaCy0b9FsjFkqSJ0Je
XusEx23F7EQZDl0TrsMcwegvbZIzM5NVZIlhujJ43Ipv3dtXCk8TsPm62isAUvni
ZYj4+/NhDjuVtPMQPOADoXe8s6f0u1q1KbQ/SFzY+wbqtwjAcr34QkRtM/5uHebg
7wscyrpIbeE=
=WrzZ
-----END PGP SIGNATURE-----

--54IhRO6Q6H7PICCg--

