References: <20200713094646.13929-1-arne@...1227...>
 <E1jvG3I-0001GB-W6@...2479...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <daf22a1f-dca1-0460-9a1d-c322b8837ad2@...1227...>
Date: Tue, 14 Jul 2020 10:34:11 +0200
MIME-Version: 1.0
In-Reply-To: <E1jvG3I-0001GB-W6@...2479...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EITA1yH366lJD5MYJDYPFv7nZob0lrTvm"
Subject: Re: [Openvpn-devel] [PATCH 1/3] Drop support for OpenSSL 1.0.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...2507...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EITA1yH366lJD5MYJDYPFv7nZob0lrTvm
Content-Type: multipart/mixed; boundary="cdfbG4cEOBCFp2BBlm00zL9UI0iapvi3k"

--cdfbG4cEOBCFp2BBlm00zL9UI0iapvi3k
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>=20
> Also, there's some export_keying_material and "security level" related
> #ifdefs that look liek they can go now. Just git grep for "0x10001" and
> "1\.0\.1" in the code and you'll see.

I missed that, will update the patch accordingly.

> Finally, did you check openssl_compat.h to see of we can get rid of some
> of the compat functions now?

Yes. And it is only the one I removed in this patch (EVP_PKEY_id) :(

Arne


--cdfbG4cEOBCFp2BBlm00zL9UI0iapvi3k--

--EITA1yH366lJD5MYJDYPFv7nZob0lrTvm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8NbgMACgkQFRhsZwKx
RFS5Yw/+MJmWd3G0uuJDKRP/pA7XMHS9OeScfXKDXClA+G/oKZrS3mjt94sFHaEP
DVkh3X7lLHZXI6xxEBvgC5Y38hhIhxToXVapJxVfv4EtDulWcrQG4hGV6TN83IMG
1x6sKYHDVqdO1RWkP3NsgsJPCGi1ZIkmR16SFqWafX0Ez+HcYyOH1fc5ad5ZstTV
VdpYTDEiDN0YG1wM3nrgiKF7Y+RB7ha3z7hfPzCY/5RPkXYemURStcDOS9Pgq7vd
ig8BXvT71ektQG5xYpz4H6ujYrQU0zyUZE28P2nx6BTxtzksmb2hGnSC96RGwyKc
bA1kdi8FoVI7OfXkolggqPxzm76sO2R0Dxr4ooh4f7XfPFNLjFf4hHXXBXRLjqX4
K0rw7nkE8mu3A4PcdWBrJd6FkulZixyBt4ivRXZ85D4Jrq8N8+qVMMovmnwpAcU+
T9uyINXSaqkDxeh3hC93nt9NWTLE0fVUyE/1dsW+Cbn79O7tFw0MddiDTwNE/7k6
cjZ/PoLaF3aJVq+utHKhsJbQzoy3jgE9JS6HjQpG9hB36+5smEoodl9khIUM/H1h
Urlc1O8JMCkAZ4RHaXYjI50L+latuVM3dq0WwwwT/MMQ6QmTRYVGszTw1kSJlKWa
Jm1C604jn8F0BVMM2owdv07Ve/Rejq3sSEVA/rfaD7pJUmHRocQ=
=hQlb
-----END PGP SIGNATURE-----

--EITA1yH366lJD5MYJDYPFv7nZob0lrTvm--

