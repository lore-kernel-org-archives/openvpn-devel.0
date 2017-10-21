Date: Sat, 21 Oct 2017 08:49:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20171021064912.GH958@...1296...>
References: <1508520356-18277-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z118w8IfbP8nVdqq"
Content-Disposition: inline
In-Reply-To: <1508520356-18277-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid illegal memory access when
 malformed data is read from the pipe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--z118w8IfbP8nVdqq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 20, 2017 at 01:25:56PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - If only 1 byte is read from the interactive service client pipe, that
>   evaluates to zero wide characters and subsequent check for NUL
>   termination in the data buffer segfaults.
>   Fix: reject clients that send less than a complete wide character.

ACK.

(Not merging right now due to time constraints, but the patch does what
it says on the lid - thanks)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--z118w8IfbP8nVdqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ6u3nAAoJEB2Cnv7KVigSIgIL/2QqYJafY3vRfJwchA+bsRuH
nFvFhgKgbIq+BrGrZPZYt8WQB848FHh6ef/uuhecUt69kyDqlB7qAlMx33Ml9fm7
u4Arb0k3cgRlKtU1OmZlBVeJD+DnPkCOvbx5JNPdYPjcXcq8RkzBhbzBlcHeNUXR
RCjSJVgrZ0G3uaKQ6u+D8WUs+WjYDd2fbto5At7kJweWf+282OilWXAjm8iHtQLZ
ChHZNqziVBTpjbaIJqmxwh+AyC/23yKXKBLS6q78IhapDDFK0oGm55RiCeAHt7g7
08ZQzHnOz47WwHmK6IuYNDv5j1J7d4LRL2foYeRtkBg4HgVe4cxFNE7RHx/peV++
pcbRhEOpzpb+g7OfjB7+Tu5le4wNtDXIC3XHzS3WaxdxsuTKbDIiq+MSC0PvcvgS
0wLVJXWmL9MpqYiWqoSC3A4j+iTrxl+tIRAy2OTaM2xt2iwbkdXBAl8T2fiN9Prg
V1OUUFgzRP3iHkOM2gDNjL6pAwbOlbjsNjTM6wWuRA==
=+QHd
-----END PGP SIGNATURE-----

--z118w8IfbP8nVdqq--

