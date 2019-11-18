References: <20191117181243.28919-1-arne@...1227...>
 <20191117181243.28919-4-arne@...1227...>
 <CACDCbPqnzYuboqeXZ=Pw0rVFMDS5Ery7h3PtjsUX+iWLpe91zA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a4a1f660-73c4-9592-5b3f-a724d79d04df@...1227...>
Date: Mon, 18 Nov 2019 08:20:07 +0100
MIME-Version: 1.0
In-Reply-To: <CACDCbPqnzYuboqeXZ=Pw0rVFMDS5Ery7h3PtjsUX+iWLpe91zA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7WJh2UpQSX5GwPfFyBzZg64Wb17pV6IV9"
Subject: Re: [Openvpn-devel] [PATCH 4/4] Normalise ncp-ciphers option and
 restrict it to 127 bytes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7WJh2UpQSX5GwPfFyBzZg64Wb17pV6IV9
Content-Type: multipart/mixed; boundary="e1oD6qJGfFrotLsdByoeWQjgIeeGVjL4q"

--e1oD6qJGfFrotLsdByoeWQjgIeeGVjL4q
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>=20
> Second thing, more of a comment: 127 feels really low.=C2=A0 'AES-256-GCM=
' is
> 11 characters, so 127 / 12 (11 chars and a separator) says you're
> limiting to about 10 ciphers.=C2=A0 If I do `openvpn --show-ciphers` ther=
e's
> a LOT of data there.=C2=A0 I'd think, for future-proofing, you'd want to
> allow for a lot more possibilities.=C2=A0 Just an opinion though.
>

The main problem is the wire protocol at the moment. The whole packet
with IVs has to fit into one control channel packet with 1280 bytes. So
I want to be conservative here.

And limiting to 10 ciphers should be more than enough. I don't think any
reasonable setup should have that many allowed ciphers. At the moment we
have AES-GCM-256 or AES-GCM-128 and ChaCha20-Poly1305. Maybe 2 others.
For your VPN setup you probably pick one of those, maybe 2. Then there
is still more than enough room for the future expansions.

And if I look at show-ciphers of my OpenSSL 1.1.1 compiled OpenVPN and
ignore duplicate/weak ciphers and limit myself to one block size, the
list is not very long:

ARIA-256-CBC, ChaCha20-Poly1305, AES-256-GCM, CAMELLIA-256-CBC,
SEED-CBC, SM4-CBC.

Arne


--e1oD6qJGfFrotLsdByoeWQjgIeeGVjL4q--

--7WJh2UpQSX5GwPfFyBzZg64Wb17pV6IV9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3SRigACgkQFRhsZwKx
RFQ+oA//aQ9FwGVKepsC/b5w9I7X9O9WieJqGsHcxzysg1PzNGp1EhHWJgEuEScp
ZCRInh13yw2QFAJIrdyPUjz+FUK/wadKadrE2jpO5LcuLtAB29ysEL8EnZcxe/UN
5ixiZqsAzx25Oj3YUii5ad5DRSMoVSMhKYVUzmnPTn109UUjBH9l9ha/8TcqDfm/
4/7NUy9zsT7vR1NmJDw6L9PvictGKIa+p/YbgXhOgNS2hiUOi5NZrSN+0OjzT+lk
ag4BOgLbQVkKvHDP+bVEFxY2+gS+4U7RggEbKm+n8SOPSWi6MJb+H4vPlQEGodWx
L0mDrBNCBZP8VwvanoSNbmyppCSksFySqQIbLp4TpgRjY7HA8Zu75QlwGFEUG8Tv
Wplvt40CQJKr9e6P5dhQ7l3SFzPWwYaoo8DfIq5yMK/GUTE0kZn2lMN6IdZXfJ9+
kR+yng0ojvVxNYlvm5SNKO85WbIT3yf9oMP7lU97H2vzdHFWa9t+E2mV8eeEpbTK
6en3Eo5xJR5GWscCXyoKoMuBo+TaKIPLzuggmUUY9B4IDN2Hy7J0AJpJ1OqiTWLl
yKuPLEgUCrCQgcNolV1kWQxxv4tfDU1yHEDnqXC9sETqERSRbdNKM41efvC9b2gv
wWm/u41ifwQjK+FHwTCoBOmLWoQGXBPW+8l+xyFUU5Mahxzd0/Q=
=u2Kg
-----END PGP SIGNATURE-----

--7WJh2UpQSX5GwPfFyBzZg64Wb17pV6IV9--

