Content-Type: multipart/signed;
 boundary="Apple-Mail=_262D4F9F-9F6B-42D3-B9B2-968BC3785189";
 protocol="application/pkcs7-signature"; micalg=sha-256
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
From: Sebastian Marsching <sebastian@...2913...>
In-Reply-To: <aMWo1HvleNGzIEDO@...1296...>
Date: Sat, 13 Sep 2025 22:10:41 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4C462D1-FB86-40BE-B218-C0242E946FFD@...2913...>
References: <65233605-9738-4B2C-8401-37AA5C43D797@...2913...>
 <aMWo1HvleNGzIEDO@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Bugfix: Set broadcast address on
 interface
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

--Apple-Mail=_262D4F9F-9F6B-42D3-B9B2-968BC3785189
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> This said, I see we have a "netbits_to_netmask(bits)" function in=20
> route.h -> please use that, it should be something like
>=20
> +    if (af_family =3D=3D AF_INET && local && !remote && prefixlen <=3D 3=
0)
> +    {
> +        inet_address_t broadcast =3D *local;
> +        broadcast.ipv4 |=3D ~netbits_to_netmask(prefixlen);
> +        ...
>=20
> (maybe with an htonl() wrapped around)


Thanks for pointing me to the netbits_to_netmask function. Using this funct=
ion, the code looks so much cleaner. See the updated patch below.

--Apple-Mail=_262D4F9F-9F6B-42D3-B9B2-968BC3785189--
