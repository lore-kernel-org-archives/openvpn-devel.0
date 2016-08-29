References: <CAHX+n4s+yo18TiCS_G2xLcbRwSh9Ox2vdmS+2c5MJJmaHEsTnQ@...278...>
	<CAHX+n4t4oBqvL7Jee7hjRAp13VKHcHjXw+=AP=6nXXLyjsVqBA@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5311bce1-b384-25d8-8c8c-89d9cbe4ff59@...515...>
Date: Mon, 29 Aug 2016 11:26:21 +0300
MIME-Version: 1.0
In-Reply-To: <CAHX+n4t4oBqvL7Jee7hjRAp13VKHcHjXw+=AP=6nXXLyjsVqBA@...278...>
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

Il 29/08/2016 11:05, Bojan Komazec ha scritto:
> This is my first attempt to contribute to OpenVpn project. Please let me
> know if I am doing it right.

Forgot to thank you for your contribution, so here it comes: thank you! :)

When you contribute to openvpn-gui, openvpn-build or easy-rsa you can=20
use GitHub pull requests. These PRs will be reviewed an merged in the=20
typical GitHub fashion.

Even when contributing to the main OpenVPN project you can send a PR,=20
which will then get reviewed in GitHub. Later, when/if the PR has been=20
ACKed (=3Daccepted), the patch needs to be sent to this list using=20
git-send-email for the final comments (if any), and merged to the=20
codebase. =C4lternatively you can just send the patch to this list, like=20
you did now.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


>
> Thanks,
> Bojan
>
> On Sun, Aug 28, 2016 at 9:18 PM, Bojan Komazec <bojan.komazec@...277...
> <mailto:bojan.komazec@...277...>> wrote:
>
>     OpenVPN/openvpn-build has to be updated so it fetches and builds
>     OpenVpn v2.3.12.
>
>     From 87a0ca6307ea9c772fc5fa584efc2f2f0f3805a8 Mon Sep 17 00:00:00 2001
>     From: Bojan Komazec <bojan.komazec@...277...
>     <mailto:bojan.komazec@...277...>>
>     Date: Sun, 28 Aug 2016 20:49:02 +0100
>     Subject: [PATCH] Updated build parameters to match
>     openvpn-install-2.3.12-I601
>
>     Signed-off-by: Bojan Komazec <bojan.komazec@...277...
>     <mailto:bojan.komazec@...277...>>
>     ---
>      generic/build.vars | 2 +-
>      1 file changed, 1 insertion(+), 1 deletion(-)
>
>     diff --git a/generic/build.vars b/generic/build.vars
>     index ed93a0b..9d44d06 100644
>     --- a/generic/build.vars
>     +++ b/generic/build.vars
>     @@ -5,7 +5,7 @@ OPENSSL_VERSION=3D"${OPENSSL_VERSION:-1.0.1t}"
>      PKCS11_HELPER_VERSION=3D"${PKCS11_HELPER_VERSION:-1.11}"
>      LZO_VERSION=3D"${LZO_VERSION:-2.09}"
>      TAP_WINDOWS_VERSION=3D"${TAP_WINDOWS_VERSION:-9.21.2}"
>     -OPENVPN_VERSION=3D"${OPENVPN_VERSION:-2.3.11}"
>     +OPENVPN_VERSION=3D"${OPENVPN_VERSION:-2.3.12}"
>      OPENVPN_GUI_VERSION=3D"${OPENVPN_GUI_VERSION:-10}"
>
>      OPENSSL_URL=3D"${OPENSSL_URL:-http://www.openssl.org/source/openssl-=
${OPENSSL_VERSION}.tar.gz
>     <http://www.openssl.org/source/openssl-$%7BOPENSSL_VERSION%7D.tar.gz>=
}"
>     --
>     2.9.2.windows.1
>
>
>
>



