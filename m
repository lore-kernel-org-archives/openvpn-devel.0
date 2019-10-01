References: <20190917121115.13966-1-arne@...1227...>
 <201910011111.x91BB0r0086995@...2054...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <319d8f3c-da43-5b06-a9fc-a246cb0439c3@...2080...>
Date: Tue, 1 Oct 2019 13:44:26 +0200
MIME-Version: 1.0
In-Reply-To: <201910011111.x91BB0r0086995@...2054...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bkVDR6Vh1IHvXGzcXFULSbgb9VpfgQZnU"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Sent indication that a
 session is expired to clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bkVDR6Vh1IHvXGzcXFULSbgb9VpfgQZnU
Content-Type: multipart/mixed; boundary="403ZObvYy1DY4DafzuqvzkOsnCRHmBChx";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <319d8f3c-da43-5b06-a9fc-a246cb0439c3@...2080...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Sent indication that a
 session is expired to clients
References: <20190917121115.13966-1-arne@...1227...>
 <201910011111.x91BB0r0086995@...2054...>
In-Reply-To: <201910011111.x91BB0r0086995@...2054...>

--403ZObvYy1DY4DafzuqvzkOsnCRHmBChx
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 01/10/2019 13:11, Gert Doering wrote:
>=20
> The patch itself looks like a very nice approach to the problem with
> "how can we communicate authentication fail reasons to the client?" issue
> that had a few (fairly intrusiv) patch sets flying around... someone=20
> needs to go through the open patches and see what has become obsolete.

This patch should obsolete the older patches resolving the same issue.

It's a simpler approach, storing the reason in a session context object whi=
ch
is then picked up when sending AUTH_FAILED.  I had one more intrusive chang=
e,
which changed the internal APIs fairly much, an approach not even I didn't
really liked that much.  I don't think there were any other proposals on the
mailing list.

I don't know what the various GUIs does, but they should also now be able to
pick up these rejections via the management interface as well; even on 2.4.x
clients connecting to a server with this patch.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--403ZObvYy1DY4DafzuqvzkOsnCRHmBChx--

--bkVDR6Vh1IHvXGzcXFULSbgb9VpfgQZnU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdkzwhAAoJEIbPlEyWcf3y9iAP+gIajDpSsRT10gbAE5VMsTdr
UmhRL5GCSqKuVtN8hZO0JQpgt77zSQ44zE3qdfunvTXRTfQAIMzs7wAlKd7cWO6q
qK1cuMgAa+8YYqA085gdSm36C7vW3yJLS6DZ4gBLFzF6pB95D3PakjZhHtWvhvpx
0o+xRTxag4f89ITOha+oJmGjXbyzbCVsQQ2D5IvaEaGMnKsW01FjvfQepb7lwg6L
P58gTa2LEGFG7ZHHTaWSM7qkb8ehJiL5H8LW9YDGUXmG8FT3yuDbUAZY/JDJ1iwl
g9leTyayxBx38fs3064s7JOEXk1heG8Sbewr3y3i7iekNDxjuonCKbth3f4x+lda
tcfOqGjW/dhctkMTaaxxPltP3sm9frB05ftoCLxkrMgLnI+9cvrVGA02fcqlYK1B
pzSyOwVL8j7ZiAn/iNXELpCdEKBfoNCVye7WhRzewmGnay0pJaXYTb7aq/ZWQjhm
ob6nc2E5ha1nnMVlXO++NOGhz89nEtVGqpWUFdmxXUBf3I8jQK+coeQbPNUUtRqP
uNm255+mHwDVM16Jmq/Uv3S+ISYFG0Qd7fSZ5g8kKBVGthksmShWLziLwvH/8Mnx
uri7dk8HZfo87U8KApCx5R9kJaHPebNHyc6RoTF2g8afIfSoRKcEeoyCZ8FKMyHX
rTmEgxVoidhOp8f+9yet
=EBMT
-----END PGP SIGNATURE-----

--bkVDR6Vh1IHvXGzcXFULSbgb9VpfgQZnU--

