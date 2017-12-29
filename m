References: <e063898a-6b6c-d716-824f-8e10b859d692@...2181...>
 <1514541240-19536-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <82f7caeb-a821-e17f-a551-0a723a161030@...2181...>
Date: Fri, 29 Dec 2017 18:01:24 +0800
MIME-Version: 1.0
In-Reply-To: <1514541240-19536-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="U9epLflPWGtyXpFYHmkmsHPErPwDCG08w"
Subject: Re: [Openvpn-devel] [PATCH 4/5 v2]
 buffer_list_aggregate_separator(): prevent 0-byte malloc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U9epLflPWGtyXpFYHmkmsHPErPwDCG08w
Content-Type: multipart/mixed; boundary="iveiad5nzCicL1c1mxypwM1l0NNscjS6I";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <82f7caeb-a821-e17f-a551-0a723a161030@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 4/5 v2] buffer_list_aggregate_separator():
 prevent 0-byte malloc
References: <e063898a-6b6c-d716-824f-8e10b859d692@...2181...>
 <1514541240-19536-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1514541240-19536-1-git-send-email-steffan.karger@...1435...>

--iveiad5nzCicL1c1mxypwM1l0NNscjS6I
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/12/17 17:54, Steffan Karger wrote:
> As pointed out in finding OVPN-05 of the cryptograpy engineering audit
> (funded by Private Internet Access), buffer_list_aggregate_separator()
> could perform a 0-byte malloc when called with a list of 0-length buffers
> and a "" separator.  If other could would later try to access that buffer
> memory, this would result in undefined behaviour.  To prevent this, always
> malloc() 1 byte.
>=20
> To simplify as we go, use alloc_buf() to allocate the buffer.  This has
> the additional benefit that the actual buffer data (not the contents) is
> zero-terminated, because alloc_buf() calls calloc() and we have 1 extra
> byte of data.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

Acked-by: Antonio Quartulli <a@...2181...>

--=20
Antonio Quartulli


--iveiad5nzCicL1c1mxypwM1l0NNscjS6I--

--U9epLflPWGtyXpFYHmkmsHPErPwDCG08w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpGEnQACgkQB6U8WA7y
zXSWww/9H+2AdSypdKZ0jC6heGgztsB68xHWLINinppg57GSD4w0h+uLmEtXmclz
KknGH3hfSrYQNtZVVC/czliMYNdF6bJjXA3MfphmBGQtYsflv4MSbJCIsgyBv7Z5
T9t1q2ahq1l6eC7PE8ts4WIEdg3IePYjUFDuY8B0K+tSnLA+jhpnDsipGrWQ+wau
1Qa5FiY8jwno6LagyLCSpL9t8O2LwgnPSYb5ygxm9jOqgtRQNre8sHzGiKaNKhG/
igtKzfEj1ffv74J3Cp6qtcRjqp17wDn07x3se9T9PiA7KuW9x0GuvFRT0hP28Lo9
l34pxS4ye+amo6jAfrOWX1KvcsgBxg6PyRoEeZQLqbMqxEBZcs5EuF267ttiMHoP
ResYGCFlmpkJnuqUG/QH4lSKcszERBt8it6HbibkhV22SBdEr81Ch+pUewFD8BLQ
zHNUpOwBO7EeP6J7Iw8vsXNbXTTUyRfWh22d7hzaSZT/EKh596Fo0bgnUJewaDsw
WbUBtCFnS2LOnbJTQTT5t/45OyeAOuwwoNvL1+6NQvLJhKuWywpseu3uhuJ7jOM4
1mfizqaRFhLXY+Die52g4i/PR159C5xAfqEsa8TdtMYG5+vKiQN9349UXBtmHtCa
3fpg+5+3yGIhJFUuXIyRoEob4ISMjJofx/3NvAo6TY1FZWzegZ8=
=GjIC
-----END PGP SIGNATURE-----

--U9epLflPWGtyXpFYHmkmsHPErPwDCG08w--

