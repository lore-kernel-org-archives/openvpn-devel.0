Date: Sat, 7 Oct 2023 13:17:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZSE-U-Ibe8qxaQMm@...1296...>
References: <20231006111910.3541180-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+QYNWOmxDJPxWuHb"
Content-Disposition: inline
In-Reply-To: <20231006111910.3541180-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Remove openssl engine method for
 loading the key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--+QYNWOmxDJPxWuHb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 06, 2023 at 01:19:10PM +0200, Arne Schwabe wrote:
> This is a contribution for loading engine key. OpenSSL engine is
> deprecated since OpenSSL 3.0 and James Bottomlehy has not agreed
> to the proposed license chagne. He is also okay with removing
> with the feature from the current code base as it is obsolete with
> OpenSSL 3.0.

JFTR, this patch breaks CentOS 7 and OpenBSD 6.8 builds, so I assume
"it breaks OpenSSL 1.0.2 builds".

So, alas, NAK... :-(

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+QYNWOmxDJPxWuHb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlIT5TAAoJEB2Cnv7KVigSbokL+wWRaEomMXnsnvD4Na5w+PFv
1IzmTbp8hpU7PW09EH/IKE0AYrCbh2l+C+Sccjl9LNsjESvk6K/ua1205xq7wPKl
b9ZuViHHsUO7bKxGFcCWHoiINQw+V/y1K1omb6WphwHwFLfZx5489V8MSZUGbWjQ
yLli0s5GXwt1CtUkIFei+B2g7o4xV5KoAolJG0iTZb0MxduXfHYumrEzs+WiLCvv
vmnkr053TKG7kUdLdK1cMB+2YJe1PNfsPHOZTVe91+ziXtb8TIhm9Ns6+la2hPPm
qQVnQ2HxH0lXn/I9lXZsJ5O8cHVRV7rprII3JvyXRNzMt5iVIybel2CxlG9oQ54c
yL6mnoi6/YWU35Texhlnh//oMlRjGorIr+4hrv1GM+7O160LmJ3YrmywYg0FEAlu
rbUrl9f1EomqgVDZybHVRBVFcVhWtcKA7zoF9r7oNdbx5Nv8zjSyi1IUKjM2Pd3O
xleS6MkTxj7TD4vX5ikeYPnNkkIfzgehmuYlHOZdGw==
=zR+b
-----END PGP SIGNATURE-----

--+QYNWOmxDJPxWuHb--

