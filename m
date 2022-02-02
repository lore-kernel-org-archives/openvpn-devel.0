Date: Wed, 2 Feb 2022 13:09:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yfp0bGkP7xqGw1Ec@...1296...>
References: <20220101162532.2251835-1-arne@...1227...>
 <20220124025459.1042317-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TaG4khFQ1/lhhYsj"
Content-Disposition: inline
In-Reply-To: <20220124025459.1042317-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5] Change buffer allocation calculation
 and checks to be more static
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

--TaG4khFQ1/lhhYsj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jan 24, 2022 at 03:54:59AM +0100, Arne Schwabe wrote:
> Currently we use half dynamic buffer sizes where we use have a fixed
> overhead for crypto (crypto_max_overhead) but use a dynamic overhead
> for the the other small header sizes.
>=20
> Patch v3: rebase
> Patch v4: add size of ack array to control channel frame size
> Patch v5: fix calculation of compression overhead calculated over 0 inste=
ad
>           of payload size

Generally this looks okayish, and *most* t_client / t_server tests work
beautifully.

It does break --tls-client --proto tcp for me, for big packets, though...

The client is called like this:

openvpn --ca ... --cert ... --key ... --comp-lzo --verb 3 --tls-client --de=
v tap --proto tcp-client --remote gentoo.ov.greenie.net 51204 --ifconfig 10=
.204.9.2 255.255.255.0 --comp-lzo --tun-ipv6 --ifconfig-ipv6 fd00:abcd:204:=
9::2/64 fd00:abcd:204:9::1 --route 10.204.0.0 255.255.0.0 10.204.9.1 --rout=
e-ipv6 fd00:abcd:204::/48 --data-ciphers BF-CBC

and will do

2022-02-02 12:56:52 peer info: IV_CIPHERS=3DBF-CBC:AES-256-GCM:AES-128-GCM
2022-02-02 12:56:52 peer info: IV_PROTO=3D42
2022-02-02 12:56:52 WARNING: 'tun-mtu' is used inconsistently, local=3D'tun=
-mtu 1500', remote=3D'tun-mtu 1532'
2022-02-02 12:56:52 P2P mode NCP negotiation result: TLS_export=3D1, DATA_v=
2=3D1, peer-id 897556, cipher=3DBF-CBC
2022-02-02 12:56:52 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GC=
M_SHA384, peer certificate: 2048 bit RSA, signature: RSA-SHA1
2022-02-02 12:56:52 [server] Peer Connection Initiated with [AF_INET6]2001:=
608:0:814::f000:11:51204
2022-02-02 12:56:53 OPTIONS IMPORT: adjusting link_mtu to 1579
2022-02-02 12:56:53 Outgoing Data Channel: Cipher 'BF-CBC' initialized with=
 128 bit key
2022-02-02 12:56:53 Outgoing Data Channel: Using 160 bit message hash 'SHA1=
' for HMAC authentication


when sending 1440 byte pings (t_client test) it will complain

2022-02-02 12:56:15 TCP/UDP packet too large on write to [AF_INET6]2001:608=
:0:814::f000:11:51204 (tried=3D1520,max=3D1499)
2022-02-02 12:56:15 TCP/UDP packet too large on write to [AF_INET6]2001:608=
:0:814::f000:11:51204 (tried=3D1520,max=3D1499)
2022-02-02 12:56:15 TCP/UDP packet too large on write to [AF_INET6]2001:608=
:0:814::f000:11:51204 (tried=3D1520,max=3D1499)


soo...  is this something that "should be fixed" by a later patch in the
series, or do we need a v6 of this one?


The same test works correctly with master as of right now (5b3c8ca86976).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--TaG4khFQ1/lhhYsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh+nRsAAoJEB2Cnv7KVigSKDoL/1nqrR8++1CuPhfmXXS7W4Je
6V3rBvhwNLRlM3+d+UuE+tdj7kmfpEvRTyjRBWLU9Xr16FOh9mOyRWEPIVQ5DNp0
3hM/1oZ1JNgsmDKpM+Ij/ipn1oHgFQyCsmO9i4j/EzE801G9PI47ZU7xxsm6JGf/
nkc61oLajJJEI9Kiu3JNzblUEjgaDn2sR3PAtfFrcrsm6WferxlaQBGKOcvPywcQ
fYy3KgHD1KWoljxE+5BeSXwMhoAtz2wjwprV9ILXhx6SbVhoevQXCl3irJghP9Z6
WaIeqy1s09n9Pe6LQ+uS4MbIRJQy99XVRLqIyKC/dDztcu1G9XXOVOPDFgIJqtOY
i27Mn0vfNUFdQJYPBJyEFz0AobeLgx+5JYrapyAqzUWYBgSItJdZaNwuf6zkQd5a
I/nzxWy54RzCBcZHzgaCPWiqBtoov21qNJW+OCTCN8U+nis31ci3YX0FHcQMnM13
rS7DaIPrjbQShY143YWxZ0E/t6Exwr4vNpwKnWIBUw==
=4Uv+
-----END PGP SIGNATURE-----

--TaG4khFQ1/lhhYsj--

