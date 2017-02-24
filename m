References: <20170224135222.44640-1-gert@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <caa34845-d758-4c93-4974-40728ff7f2ae@...515...>
Date: Fri, 24 Feb 2017 16:32:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170224135222.44640-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix "--dev null"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 24/02/2017 15:52, Gert Doering wrote:
> To test whether a server is reachable and all the key handling is
> right, openvpn can connect with "--dev null --ifconfig-noexec" to
> avoid needing to the client with elevated privileges.

There seems to be a typo here. Did you mean "to avoid needing to
_connect to_ the client with elevated privileges"?

>=20
> This was erroring out for no good reason (because the "set environment
> variables appropriately" code didn't know if this is a tun or tap
> device...) - treat --dev null as "tap", done.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/tun.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 31585b32..12ce99d5 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -560,7 +560,9 @@ is_tun_p2p(const struct tuntap *tt)
>  {
>      bool tun =3D false;
>=20=20
> -    if (tt->type =3D=3D DEV_TYPE_TAP || (tt->type =3D=3D DEV_TYPE_TUN &&=
 tt->topology =3D=3D TOP_SUBNET))
> +    if (tt->type =3D=3D DEV_TYPE_TAP ||
> +        (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNET)=
 ||
> +	tt->type =3D=3D DEV_TYPE_NULL )
>      {
>          tun =3D false;
>      }
>=20


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

