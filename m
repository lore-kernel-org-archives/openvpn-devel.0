References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...> <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
 <20180622094635.GI57262@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
Date: Fri, 22 Jun 2018 17:49:57 +0800
MIME-Version: 1.0
In-Reply-To: <20180622094635.GI57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mGJsnOz7HPA8qJ98traFKEMVEONGLsJX1"
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
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
--mGJsnOz7HPA8qJ98traFKEMVEONGLsJX1
Content-Type: multipart/mixed; boundary="7TsWCyOW6KYhx3GZQz3io5A8PbJa5IzLQ";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...> <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
 <20180622094635.GI57262@...1296...>
In-Reply-To: <20180622094635.GI57262@...1296...>

--7TsWCyOW6KYhx3GZQz3io5A8PbJa5IzLQ
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 22/06/18 17:46, Gert Doering wrote:
> Hi,
>=20
> On Fri, Jun 22, 2018 at 03:27:02PM +0800, Antonio Quartulli wrote:
>> Fri Jun 22 13:43:51 2018 us=3D116232 PUSH: Received control message: 'PU=
SH_REPLY,redirect-gateway !ipv4 ipv6,tun-ipv6,ping 10,ping-restart 120,ifco=
nfig-ipv6 2002::1001/112 2002::2,peer-id 0,cipher AES-256-GCM'
>=20
> As an afterthought - the error could be totally unrelated to the changes,
> and the win32 API refusing 2002:: addresses because it knows that they
> are not "free for grabs"...  (6to4, normally auto-configured unless
> disabled, with 2002:<ipv4>:: being the prefix that a host on <ipv4> or
> a network behind a router on <ipv4> can use - but that's old stuff and
> should no longer be used in any case).

After changing the prefix to 2001:db8:cafe::/112 the error is gone.

However, the assert at the end of the log in argv.c:299 is still there.
This might be some argv_new()/reset() that has been misplaced (maybe?).

Cheers,


--=20
Antonio Quartulli


--7TsWCyOW6KYhx3GZQz3io5A8PbJa5IzLQ--

--mGJsnOz7HPA8qJ98traFKEMVEONGLsJX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlssxkUACgkQB6U8WA7y
zXTJ2hAAjMNUKC1MNSrhcxwF0SCJPd382Nb3SU5DrpaE8ifAjqhakCmJM969fJVv
KzqQs2+2TYGmMocWeKapm5fW2R/YJQu605z1ylO9GcHZrHYtTe/rC93dMOPOps69
LqMTBpIfpj+dN3e6kUTC3epRc4/2HD+Xu3vgUn9QcuvJQRi0KY5y0NzXQwX6aj5z
JhP9r83yq8p8KSnrJbjU/7qVZpnzPyOmqiX6co/xpaPsv6xcfFpb0qgZcVJvhN7Y
r52wCmzeBi065x8Nmb9QdfhqAMsVslHacfoWOG4q/WLRW+30v7y6g8GgBvkFiT1S
6S/u1DlTqd1ohzVzsDamb5FNJmy7egRnImHcA9C7RvuyjkYTrCVmZnmKMlT+BVlf
HuvFxc8LrLqnkEaCrQOsxs90aGUyADGjsMccQU+ZwFu5nsZngU5+Fh3+g23SVMjT
tGQOhHJXEIjaya/4f+yN5IWmnvr9MydFTp0j7sAIAW1OebxS1VBKDU2bVA3/5hpy
MvjRBJ7ESBANF/QCDmM5Fju9hCNNo3ccez0uMOhLSPkreCxP1D+4G81vmxXMobDM
jaa43gYfctOB5AWLQRxovNeNdNK7jLJaverQ0gkBo6Rd+jnzJx5c4Fs/HHsX+WYC
dhhHnh2ME69brq86v/F/sSyc382/JP4+eSybWn7wm+wNmYlx/AM=
=Safo
-----END PGP SIGNATURE-----

--mGJsnOz7HPA8qJ98traFKEMVEONGLsJX1--

