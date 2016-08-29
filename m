References: <CAHX+n4s+yo18TiCS_G2xLcbRwSh9Ox2vdmS+2c5MJJmaHEsTnQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <60592ae6-fc32-624b-2d51-45c9df974e04@...515...>
Date: Mon, 29 Aug 2016 11:21:16 +0300
MIME-Version: 1.0
In-Reply-To: <CAHX+n4s+yo18TiCS_G2xLcbRwSh9Ox2vdmS+2c5MJJmaHEsTnQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Updated build parameters to
 match openvpn-install-2.3.12-I601
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Bojan Komazec <bojan.komazec@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

> OpenVPN/openvpn-build has to be updated so it fetches and builds OpenVpn
> v2.3.12.
>
> From 87a0ca6307ea9c772fc5fa584efc2f2f0f3805a8 Mon Sep 17 00:00:00 2001
> From: Bojan Komazec <bojan.komazec@...277...
> <mailto:bojan.komazec@...277...>>
> Date: Sun, 28 Aug 2016 20:49:02 +0100
> Subject: [PATCH] Updated build parameters to match
> openvpn-install-2.3.12-I601
>
> Signed-off-by: Bojan Komazec <bojan.komazec@...277...
> <mailto:bojan.komazec@...277...>>
> ---
>  generic/build.vars | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/generic/build.vars b/generic/build.vars
> index ed93a0b..9d44d06 100644
> --- a/generic/build.vars
> +++ b/generic/build.vars
> @@ -5,7 +5,7 @@ OPENSSL_VERSION=3D"${OPENSSL_VERSION:-1.0.1t}"
>  PKCS11_HELPER_VERSION=3D"${PKCS11_HELPER_VERSION:-1.11}"
>  LZO_VERSION=3D"${LZO_VERSION:-2.09}"
>  TAP_WINDOWS_VERSION=3D"${TAP_WINDOWS_VERSION:-9.21.2}"
> -OPENVPN_VERSION=3D"${OPENVPN_VERSION:-2.3.11}"
> +OPENVPN_VERSION=3D"${OPENVPN_VERSION:-2.3.12}"
>  OPENVPN_GUI_VERSION=3D"${OPENVPN_GUI_VERSION:-10}"
>
>  OPENSSL_URL=3D"${OPENSSL_URL:-http://www.openssl.org/source/openssl-${OP=
ENSSL_VERSION}.tar.gz}"
> --
> 2.9.2.windows.1

I updated this in the "release/2.3" branch of openvpn-build. I don't=20
think updating the version to "2.3.12" makes sense for the "master"=20
branch, though, because of the more recent 2.3.x -incompatible commits:

"Register openvpnserv2 as a service during install"
"Do not allow starting OpenVPN-GUI as admin after the install"
"Improved Interactive Service integration"
"Register openvpnserv2 as a service during install"
"Add installation of openvpnserv2.exe"

We should probably update OPENVPN_VERSION to "2.3_git" in the "master"=20
branch for now, and make it "2.4_alpha1" when that is released. Right=20
now building 2.3.x installers from the "master" branch will not work as=20
intended.

Thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

