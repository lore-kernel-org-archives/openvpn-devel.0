MIME-Version: 1.0
In-Reply-To: <1335639118-16671-1-git-send-email-alon.barlev@...277...>
References: <1335639118-16671-1-git-send-email-alon.barlev@...277...>
Date: Tue, 26 Jun 2012 13:21:15 +0300
Message-ID: <CAOazyz3kUyktfQmM9DHyaAVvrdeDLj4ygD9hkHuVfy+3FS0L+g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: msvc: chdir with change drive to
	script location
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
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn.list@...1114...>, =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>

Please apply.
https://github.com/alonbl/openvpn/commit/692c35a3cce6226dd36bbc6b9138a353d1=
d14634

On Sat, Apr 28, 2012 at 9:51 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
> =C2=A0msvc-build.bat | =C2=A0 =C2=A01 +
> =C2=A0msvc-dev.bat =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0msvc-env.bat =C2=A0 | =C2=A0 =C2=A02 --
> =C2=A03 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/msvc-build.bat b/msvc-build.bat
> index 01417d1..fd6d558 100644
> --- a/msvc-build.bat
> +++ b/msvc-build.bat
> @@ -4,6 +4,7 @@ rem Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...493...=
277...>
> =C2=A0@...1738... this stupid command needed for SetEnv.cmd to operate
> =C2=A0setlocal ENABLEDELAYEDEXPANSION
>
> +cd /d %0\..
> =C2=A0call msvc-env.bat
>
> =C2=A0set PLATFORMS=3DWin32
> diff --git a/msvc-dev.bat b/msvc-dev.bat
> index 4dac172..dbd7be0 100644
> --- a/msvc-dev.bat
> +++ b/msvc-dev.bat
> @@ -1,7 +1,7 @@
> =C2=A0@...1657... off
>
> =C2=A0setlocal
> -cd %0\..
> +cd /d %0\..
> =C2=A0call msvc-env.bat
>
> =C2=A0if exist "%VSHOME%\Common7\IDE\VCExpress.exe" (
> diff --git a/msvc-env.bat b/msvc-env.bat
> index 3c9eb5b..2dd0f00 100644
> --- a/msvc-env.bat
> +++ b/msvc-env.bat
> @@ -1,7 +1,5 @@
> =C2=A0@...1657... off
>
> -cd %0\..
> -
> =C2=A0rem Put your own settings at msvc-env-local.bat
> =C2=A0if exist msvc-env-local.bat call msvc-env-local.bat
>
> --
> 1.7.3.4
>

