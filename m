References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-2-James.Bottomley@...2316...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <27402071-0dd8-2e54-d7f0-2538859ed6e7@...1227...>
Date: Fri, 5 Jun 2020 13:35:44 +0200
MIME-Version: 1.0
In-Reply-To: <20200528225920.6983-2-James.Bottomley@...2316...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="swYlP37xHMfijTkn9gixyCQXkIxfGkbBo"
Subject: Re: [Openvpn-devel] [PATCH v6 1/3] openssl: add engine method for
 loading the key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2316...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--swYlP37xHMfijTkn9gixyCQXkIxfGkbBo
Content-Type: multipart/mixed; boundary="2uLXLu5OzDSKSKbjQ9EWi3VXoA4pPlBU0"

--2uLXLu5OzDSKSKbjQ9EWi3VXoA4pPlBU0
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 29.05.20 um 00:59 schrieb James Bottomley:
> As well as doing crypto acceleration, engines can also be used to load
> key files.  If the engine is set, and the private key loading fails
> for bio methods, this patch makes openvpn try to get the engine to
> load the key.  If that succeeds, we end up using an engine based key.
> This can be used with the openssl tpm engines to make openvpn use a
> TPM wrapped key file.
>=20


Acked-By: Arne Schwabe <arne@...1227...>

This looks good now.

Arne




--2uLXLu5OzDSKSKbjQ9EWi3VXoA4pPlBU0--

--swYlP37xHMfijTkn9gixyCQXkIxfGkbBo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7aLhAACgkQFRhsZwKx
RFS7whAAja2YBl0jUG/pikkBJBzuwSLXINnBXh/VzNSqauZ61YuiCDTiXieL7ZvM
aipkEVp3dZ+vnCrEnHtxfYIFNPgH3PKZx5/Yl5801PXODTNjMa8cv9Id7nCVtXH+
xkoD+KZet+Obt9SSwL++yntZNbsTA+cN5ljPkchE9ERXATRCxafTwykiQecVbpkC
JaTm25jl0CH5Qn4JF7XEQ3uVxR4LyjfLLcHLXLpKqMXflCrKHpIjRbl/Tp6b5ik8
FWCSWibt9uKueDI6JAb9iKtj8nWeenUION1f3INUuxy3YvXcSdjiyNcZkaqCRJm6
DkcuW5xKCdn9njSSlzenpOjpASrGclAdIl+p5dSvUtf0yh0J7YbSDnJP2VKFPZw+
nWJjqZnpj6HwIaZlFtU96fg7r1ZOKOFxHYul7zYR+pEqnhBcyMOIdZsGI4+Erczx
1bpIhs9wa1Lo12WtofqdA++JjIy1zJiNhG8h27/IQcq/jC95XfdUeuODMPJ41anQ
YlmJ/I7qp0rBwECUMwCFUQDxHq1pUKeVfqMVMtX1xw5Z646PQ+jqnionb9ZjaCTN
P9jss6YBGQK2yaykV/1vLKp8Gfzk6Rn+SYbKllpTvoxdRkuXosh4TOnBKgHNGkhL
SQttrFsYdVSVk+zEWuSkDq+JmUMimR4E6jcJqa4KZirbhdi3ZIw=
=d6XV
-----END PGP SIGNATURE-----

--swYlP37xHMfijTkn9gixyCQXkIxfGkbBo--

