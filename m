Date: Tue, 5 Apr 2022 16:58:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YkxZAMfjxnrTTx3e@...1296...>
References: <20220402070902.30282-1-a@...2181...>
 <20220402070902.30282-4-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="s9aQt2qoYQDHVEJi"
Content-Disposition: inline
In-Reply-To: <20220402070902.30282-4-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/7] networking: implement net_iface_new
 and net_iface_del APIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--s9aQt2qoYQDHVEJi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 02, 2022 at 09:08:58AM +0200, Antonio Quartulli wrote:
> +++ b/src/openvpn/networking_iproute2.c
> @@ -38,6 +38,12 @@
>  #include <stdbool.h>
>  #include <netinet/in.h>
>=20=20
> +static const char *iface_type_str[] =3D {
> +    [IFACE_DUMMY] =3D "dummy",
> +    [IFACE_TUN] =3D "tun",
> +    [IFACE_OVPN_DCO] =3D "ovpn-dco",
> +};

I find this notation surprising - I guess it's "ensure that array
indexes match enum values", but it's a construct we do not use anywhere
else in OpenVPN (I think).


> +net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, enum iface_type=
 type,
> +              void *arg)
> +{
> +    struct argv argv =3D argv_new();
> +
> +    argv_printf(&argv, "%s link add %s type %s", iproute_path, iface,
> +                iface_type_str[type]);

Also, there is no array bounds check here...

>  #ifdef ENABLE_SITNL
> +
> +static const char *iface_type_str[] =3D {
> +    [IFACE_DUMMY] =3D "dummy",
> +    [IFACE_TUN] =3D "tun",
> +    [IFACE_OVPN_DCO] =3D "ovpn-dco",
> +};

Plus, it is repeated here...  (and no bounds check either).

Can we come up with something more in line with the rest of OpenVPN,
like a static function that will return the name of that thing, for
consumers that want a name, and "dummy" or "unknown" for out-of-bounds
access?

(Right now, all consumers want a string, and the caller passes in
a single-use enum, which is not used for anything but "convert back
to string", so the value of having an enum here is not really obvious)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--s9aQt2qoYQDHVEJi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiTFkAAAoJEB2Cnv7KVigSb74L/jKNr1ETb/JP/53H+tkDwtsK
5LENmFoBB0tVw/GKMxscWWGmlK9SJRhr+WTYB3dWd6ovB1pIbM3JRwrtCA4Ei/cI
XJXI51NqgXPMkQ4OZxqD9CXVqVkyvZ11/XkK5JB2PcLQZO9Qo7XMxro2jVaxG3G5
G8c7vovQ2OMziINcF5rQh2R5SxSno2dIj76NqHqS0RAaz/am+oHWgMejuqhlBwD6
ocZxNxxnKJqL0vf88VDd+aV4WNfgLWfdC/4Fy1q9OM2AZuFDYr1gvVOca8OMRakS
DcyNYa3E0fDQntVXruhiguZ1/CFZGtvU/LInc5C/vI3/gLWrtLLq5ENBSzEBBW46
rnYQpcAPQbncAJXKhlW+gtU0vOvpJ5Z6IHhEe3vxtAee2ovOp+MtEW7jDYSriHqA
Q5b6iC+qyTcc1C+6FniiFfhbgcLPRKI878ZYOYwnAf5KETHfYUlYBSWGJgsc+HBs
1HdvVnsZqQZWJTD5at9RkYs9RZN//y9t09Z9olsvnw==
=hdL6
-----END PGP SIGNATURE-----

--s9aQt2qoYQDHVEJi--

