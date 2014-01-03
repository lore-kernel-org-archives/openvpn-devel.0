Date: Fri, 3 Jan 2014 15:21:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140103142105.GU226@...1296...>
References: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>
	<52B75C6B.9080100@...1847...> <52B76494.5010903@...1847...>
	<20131223113229.GB161@...1296...>
	<52B84C1F.8010500@...1847...>
	<CAHqXQkMpp9ayVdfgnyvvFjUy-HcmS0BYO--N_SDEbOUDUE9zbw@...278...>
	<52C1ADF7.2050702@...1227...>
	<loom.20140103T122843-610@...171...>
	<52C6BB13.30804@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/IQTGW+1SjCkQmn"
Content-Disposition: inline
In-Reply-To: <52C6BB13.30804@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3] Floating: Add support for floating
	in TLS mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--W/IQTGW+1SjCkQmn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 03, 2014 at 02:28:51PM +0100, Arne Schwabe wrote:
> > 2) What you mean by "hack"? Do you mean new packet format or something =
else?
> The byte juggling the compress does.

Actually the "compress byte swap hack" is for the de-crypted material,
while *this* discussion is concernced about the encrypted material, which
is also unaligned and also wants a byte swap hack :-)

What I'd like to see is a definition of the new data frame format from
James (with and without session ID), and then we can go and hack that in
- but before we agree on the frame format, we don't really know what to
implement.

Meeting topic... (Samuli, are you listening?).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--W/IQTGW+1SjCkQmn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUsbHUakuBuNlUUl1AQKfYwP/Rw7Apv1w7TYZv3QKHwFyChHYudHfh8YY
bbNZEfapVnA7tELm8jvkdmc7qS3lo+R4Opzqd7/erxRW3rDOajs1YWVmuga9XaXS
uf3Hq4lGVWxa3hfo2kZJOMsR/GdB7TMkIjWKBa0HBvRqFmdPX/0rli9XZlM/lrTp
L+u0kVOXOtE=
=gJ9p
-----END PGP SIGNATURE-----

--W/IQTGW+1SjCkQmn--

