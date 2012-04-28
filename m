MIME-Version: 1.0
In-Reply-To: <1335637741-15721-1-git-send-email-alon.barlev@...277...>
References: <1335637741-15721-1-git-send-email-alon.barlev@...277...>
Date: Sat, 28 Apr 2012 21:34:23 +0300
Message-ID: <CAOazyz1d9Pq5uoodyPNsr69+xveceocF_YNT4maU09G5EQByHw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: windows: convert resources to
	UTF-8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn.list@...1114...>

On Sat, Apr 28, 2012 at 9:29 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Visual Studio 2010 editor supports UTF-8 files, we can store files in
> standard encoding.
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
> =C2=A0src/openvpn/openvpn_win32_resources.rc =C2=A0 | =C2=A0 =C2=A04 +++-
> =C2=A0src/openvpnserv/openvpnserv_resources.rc | =C2=A0 =C2=A04 +++-
> =C2=A02 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/openvpn_win32_resources.rc b/src/openvpn/openvpn=
_win32_resources.rc
> index e1cd959..d092e21 100644
> --- a/src/openvpn/openvpn_win32_resources.rc
> +++ b/src/openvpn/openvpn_win32_resources.rc
> @@ -5,6 +5,8 @@
> =C2=A0#endif
> =C2=A0#include <winresrc.h>
>
> +#pragma code_page(65001) /* UTF8 */
> +
> =C2=A0LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
>
> =C2=A0VS_VERSION_INFO VERSIONINFO
> @@ -28,7 +30,7 @@ BEGIN
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "FileDescription", "OpenV=
PN Daemon"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "FileVersion", PACKAGE_VE=
RSION ".0"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "InternalName", "OpenVPN"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "LegalCopyright", "Copyr=
ight =C2=A9 The OpenVPN Project"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "LegalCopyright", "Copyr=
ight =C2=A9 The OpenVPN Project"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "OriginalFilename", "open=
vpn.exe"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "ProductName", "OpenVPN"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "ProductVersion", PACKAGE=
_VERSION ".0"
> diff --git a/src/openvpnserv/openvpnserv_resources.rc b/src/openvpnserv/o=
penvpnserv_resources.rc
> index 9b79cb7..7980193 100644
> --- a/src/openvpnserv/openvpnserv_resources.rc
> +++ b/src/openvpnserv/openvpnserv_resources.rc
> @@ -5,6 +5,8 @@
> =C2=A0#endif
> =C2=A0#include <winresrc.h>
>
> +#pragma code_page(65001) /* UTF8 */
> +
> =C2=A0LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
>
> =C2=A0VS_VERSION_INFO VERSIONINFO
> @@ -28,7 +30,7 @@ BEGIN
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "FileDescription", "OpenV=
PN Service"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "FileVersion", PACKAGE_VE=
RSION ".0"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "InternalName", "OpenVPN"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "LegalCopyright", "Copyr=
ight =C2=A9 The OpenVPN Project"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VALUE "LegalCopyright", "Copyr=
ight =C2=A9 The OpenVPN Project"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "OriginalFilename", "open=
vpnserv.exe"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "ProductName", "OpenVPN"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VALUE "ProductVersion", PACKAGE=
_VERSION ".0"
> --
> 1.7.3.4
>

David,

You probably need to pull[1] this one, as there is no way to send
files in two different encoding using S/MIME.

At least one thing that is good about visual C 2010... :)

Alon.

[1] https://github.com/alonbl/openvpn/commit/07f346fe2960e343e9dc9f94a6f295=
1c0814e168.patch

