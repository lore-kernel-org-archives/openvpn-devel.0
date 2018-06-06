References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <c107aa30-32d4-dfb6-96d9-9f7610399796@...2181...>
Date: Wed, 6 Jun 2018 10:30:33 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m4gVKgT9KZS8VNxtocdd64FamMgRMeLg0"
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m4gVKgT9KZS8VNxtocdd64FamMgRMeLg0
Content-Type: multipart/mixed; boundary="L2PKOEiy3EgNZjl1NFGPW7WMEdxLO8CiA";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <c107aa30-32d4-dfb6-96d9-9f7610399796@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
In-Reply-To: <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>

--L2PKOEiy3EgNZjl1NFGPW7WMEdxLO8CiA
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/06/18 03:38, Selva Nair wrote:
> Here is the diff of what I did for the Windows build run:
>=20
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 2e33880..75336a9 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -5824,9 +5824,9 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>=20
>      if (tt->type =3D=3D DEV_TYPE_TUN)
>      {
> -        if (!tt->did_ifconfig_setup)
> +        if (!tt->did_ifconfig_setup && !tt->did_ifconfig_ipv6_setup)
>          {
> -            msg(M_FATAL, "ERROR: --dev tun also requires --ifconfig");
> +            msg(M_WARN|M_INFO, "WARNING: neither ifconfig nor
> ifconfig-ipv6 specified");

Why converting this from M_FATAL to M_WARN|M_INFO?
Isn't just better to quit the client if we receive no IPv* settings?

Cheers,

--=20
Antonio Quartulli


--L2PKOEiy3EgNZjl1NFGPW7WMEdxLO8CiA--

--m4gVKgT9KZS8VNxtocdd64FamMgRMeLg0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsXR0kACgkQB6U8WA7y
zXSfpg/+L/yiE4swdEDYOqI4CuaXmBsdphY6f1E+K7MTveG8Dspn+HCgFCTFu0TW
HmTVMQgaJfFzzKyu8NMIlcft+92VP/oJDBxYt10YbeHUYOS00z41TvMPQeXNW3oS
To0j6xgL4j66ELjv9u5799CXX4fzNRwkFF0ibkheaOX2anVXLWNmiUIWF70xRtbR
H/riObzIPUF6CS6rb6np+4gaONBl2/KuUFRt3hHtW4hnV+NYKJbhWj2TWliJd738
2zbC39qXjNNJ6ArYH1PE213rnql8RJRX/x19LQYyd1ZDT5Vkcweo+RvatRf6ccpi
6EZhUVGVv79ha16tS8pU6xnkV9871ub21JUHRBQ4rqFn/AOF2LBKQNCUc3yjM0nW
T3xcR0HEMH02XFi99toPJqBWP54OkJh4hfvVzgmXIIpSGxc+1TXC1vo8apH+J3Pi
xLjIY8ZYivYsMk3WOqEsd1iED4sq7hVqeTyqkjsjLW4XpfidDio7CXaWpAe8pkKJ
RPwnGUUPSvDxxBsO/nbIguRa96KpOE20ESXx2bAaRKjWYDpXs27vg2Z7foSp4luu
joYF1YbFeomQ27RzNvrn2gBZQsXkbaWXEDOw/bsl+KXFmena+3xOGR26aM7EqOSZ
H+uTDIBF/PNxl9YkTnlsc7h5pPkdSLhEY9sNCXyTxeIcoEKcWkM=
=bwpn
-----END PGP SIGNATURE-----

--m4gVKgT9KZS8VNxtocdd64FamMgRMeLg0--

