References: <20190923133224.13899-1-arne@...1227...>
 <20190923143431.GF40538@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <225f622e-885d-9603-22b5-282e0f6013e0@...1227...>
Date: Sat, 9 Nov 2019 18:36:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190923143431.GF40538@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RRRLlkZma33wg7bBvGoF3xYvFDv6R5FOr"
Subject: Re: [Openvpn-devel] [PATCH] Only announce IV_NCP=2 when we are
 willing to support these ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RRRLlkZma33wg7bBvGoF3xYvFDv6R5FOr
Content-Type: multipart/mixed; boundary="uSgGyIMMzCT93Dy7iYmKTQ07w9xHmfZrh"

--uSgGyIMMzCT93Dy7iYmKTQ07w9xHmfZrh
Content-Language: de-DE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 23.09.19 um 16:34 schrieb Gert Doering:
> Hi,
>=20
> On Mon, Sep 23, 2019 at 03:32:24PM +0200, Arne Schwabe wrote:
>> +        if (!(tls_item_in_cipher_list("AES-128-GCM", options->ncp_ciphe=
rs)
>> +              && tls_item_in_cipher_list("AES-256-GCM", options->ncp_ci=
phers)))
>=20
> What about AES-192-GCM?  What *exactly* does IV_NCP=3D2 guarantee?
>=20

Our manpage says only 128 and 256 are in the default ncp-cihper list, so
lets not guarantee 192.

Arne


--uSgGyIMMzCT93Dy7iYmKTQ07w9xHmfZrh--

--RRRLlkZma33wg7bBvGoF3xYvFDv6R5FOr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3G+QYACgkQFRhsZwKx
RFSa0xAAhHnjCS6O4Z6YrMnF1z9fEL0c1DFkEp/ouBgarPlpDJGq0VI1Usn4S2eH
0XliEEkTCkQ7wKQhh6UTGgkET3Fy2TXy1zkerMiBUwS2S9+b/jbpuEEmHU/4tREX
kkiw5fpybH89vEBGerkTiNpwoY/4EgJa3BZp/zanvvBUWAL3lUF1lIM1EiwJHW/N
+mDNqXPSQQV4LecNmUROTPnn2qIbTgl5iyOHNHVrvYuMnyqTGH9mvey00ThkJeTz
xba74YoeV54OmAWS3ShfWisVqf6LPSBcxpYFpXRbtX8ImVHFk6kj+jsbjFmzmFqa
Tu8aFqvAaFWkncR70fT6KBC7WlJsXkKWQ5mxJbV8fmIkz9oDvS04DoxxzsURIG7+
DyY9/3lTPrIfz03XWYlqlnjclBjV2+XcSbOAawpv8P4C6avsE32PKbnBfKriQ0Mq
dXcKjKtcnzCmJa80WdLbxQ6YfQW0wNWAVbttohAorEc5fJaFXUD3cE1IDTt6VWlV
YikdLitKV8VteyCdsca3zpM3Z9pwUiy16J/KUqgD1UnbDyJyEQgDbHK9W2fmBiYc
UXviOiq/DPWG4pRK5aRKU+C+AaK6jy5iD+JNSE4Bexq2LXdJ0mc9jcVNd/zncoPO
zGtwUOtnj9KinzCxn8zPzdWL5C/xxdIqd2VStJMgi6Cl4GTIwXc=
=N3xK
-----END PGP SIGNATURE-----

--RRRLlkZma33wg7bBvGoF3xYvFDv6R5FOr--

