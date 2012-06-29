Message-ID: <4FED650F.9090404@...515...>
Date: Fri, 29 Jun 2012 11:19:27 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1335639118-16671-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1335639118-16671-1-git-send-email-alon.barlev@...277...>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I tested building with "openvpn-build\msvc" with this patch applied, and
it still worked. I don't see any reason not to apply this, so it's an ACK.

The "cd /d %0\.." magic is very interesting... "cd %0\.." seems to work
exactly the same: both switch to the directory where msvc-build.bat is
located (i.e. openvpn build root).
If I understood correctly, the /d switch allows changing to a directory
on an another drive, right?

Samuli

> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  msvc-build.bat |    1 +
>  msvc-dev.bat   |    2 +-
>  msvc-env.bat   |    2 --
>  3 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/msvc-build.bat b/msvc-build.bat
> index 01417d1..fd6d558 100644
> --- a/msvc-build.bat
> +++ b/msvc-build.bat
> @@ -4,6 +4,7 @@ rem Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
>  @rem this stupid command needed for SetEnv.cmd to operate
>  setlocal ENABLEDELAYEDEXPANSION
>  
> +cd /d %0\..
>  call msvc-env.bat
>  
>  set PLATFORMS=Win32
> diff --git a/msvc-dev.bat b/msvc-dev.bat
> index 4dac172..dbd7be0 100644
> --- a/msvc-dev.bat
> +++ b/msvc-dev.bat
> @@ -1,7 +1,7 @@
>  @echo off
>  
>  setlocal
> -cd %0\..
> +cd /d %0\..
>  call msvc-env.bat
>  
>  if exist "%VSHOME%\Common7\IDE\VCExpress.exe" (
> diff --git a/msvc-env.bat b/msvc-env.bat
> index 3c9eb5b..2dd0f00 100644
> --- a/msvc-env.bat
> +++ b/msvc-env.bat
> @@ -1,7 +1,5 @@
>  @echo off
>  
> -cd %0\..
> -
>  rem Put your own settings at msvc-env-local.bat
>  if exist msvc-env-local.bat call msvc-env-local.bat
>  

