References: <20190917121039.13791-1-arne@...1227...>
 <201910011054.x91AsGeD072215@...2054...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f79fe2fc-9165-821b-570a-225947d51f99@...2080...>
Date: Tue, 1 Oct 2019 13:51:27 +0200
MIME-Version: 1.0
In-Reply-To: <201910011054.x91AsGeD072215@...2054...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6X6Ypv9JA4aJzNyohY2C9bqLKCJfiiaaj"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Implement a permanent
 session id in auth-token
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
--6X6Ypv9JA4aJzNyohY2C9bqLKCJfiiaaj
Content-Type: multipart/mixed; boundary="eYg7nfBSzKJ4NILntFFilX6GH0GXqqawc";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <f79fe2fc-9165-821b-570a-225947d51f99@...2080...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Implement a permanent session
 id in auth-token
References: <20190917121039.13791-1-arne@...1227...>
 <201910011054.x91AsGeD072215@...2054...>
In-Reply-To: <201910011054.x91AsGeD072215@...2054...>

--eYg7nfBSzKJ4NILntFFilX6GH0GXqqawc
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 01/10/2019 12:54, Gert Doering wrote:
>=20
> Not exactly sure why we need a workaround for an OpenVPN3 bug in 2.5,
> though...  when 2.5 comes close to release, there should no longer be
> any buggy OpenVPN3 client around that mishandles username sending?=20=20
> So maybe we want to take that part *out* again...?

I don't know the history around this behavioural change in OpenVPN 3, but i=
t's
the OpenVPN 3 Core library (used by OpenVPN Connect, openvpn3-linux, etc
clients)  which has this behaviour.  But I have a feeling this is also rela=
ted
to how Access Server expects things to be in specific situations.

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--eYg7nfBSzKJ4NILntFFilX6GH0GXqqawc--

--6X6Ypv9JA4aJzNyohY2C9bqLKCJfiiaaj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdkz2/AAoJEIbPlEyWcf3yB08P/2rJHAC2U3efh+hoiupnneZN
KYD3iVb1OrQc/KtisgwWpuvPo8iiALLgzIkWEvPDWCbSqRELQ7HE06XHr1nyOeGj
bWN2Ryl5lBwKPKhv0ivwbOXJz438OUrkEvM4lqMGmvLekbLo/k/XnZ5dxaEsWhSG
jQ7P0d19VYrGLvtQ8did9jW87hNcfpuHIOQ+wy1J6RRtSafbxos3EH8OSDQouBjZ
aaadfE9CjI0CVh56k71VbuNqHXqhm8fxVmM9xTlIuZN1KQbtESx+uZQP0nNRUIzQ
3ljTy3hqMDlh/dy4o+xS9WJE27xYJOlCP/g1wiHKgQvwhGwMFNJuKYSt/momiR8T
0bjpm89v7Maccnynjd/CkvSnFPgRwuCKBVixlV7D8DxXfHTOCQo+HBG/dxT+swN0
vKOtnv1y9qjEONM2EaoPTqqcCaAB5mIk6s3+m/2sjWv7KHW9fw+3nCFtLbCz2Dfd
s/4oQDtN1b1Pzdafktv9WU20bFlFELCkdkR+BnP0hSl/cmVPjuN/VzTtEerulOUV
u14BdqGyrj09eYlJDlp43HsrHAYt36ifAoxiQ0o9X3HFSbcyLQD+SA2u26R9Jm3h
Powv83bFILYz3uHhm7MajOpB+/SoLrQWroUYWTWzaRBwDbTzV3tes8HegvOEaX61
2MKHKdOLzV+sRO55hm70
=IPzh
-----END PGP SIGNATURE-----

--6X6Ypv9JA4aJzNyohY2C9bqLKCJfiiaaj--

