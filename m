References: <20210321144627.1621-1-simon@...2293...>
 <20210321144627.1621-4-simon@...2293...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5bc735d5-32f6-6baf-97a9-149c27adda17@...1227...>
Date: Sun, 21 Mar 2021 17:29:08 +0100
MIME-Version: 1.0
In-Reply-To: <20210321144627.1621-4-simon@...2293...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 4/5] tapctl: Resolve MSVC C4996 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Simon Rozman <simon@...2293...>, openvpn-devel@lists.sourceforge.net

Am 21.03.21 um 15:46 schrieb Simon Rozman via Openvpn-devel:
> wcsncat() was declared unsafe in favour of wcsncat_s(). However, the
> string concatenation follows the string length check, making wcsncat()
> safe too. Code analysis is just not smart enough (yet) to detect this.
> 
> The code was refactored to use wcscat_s() MSVC is considering as "safe".
> 
> Signed-off-by: Simon Rozman <simon@...2293...>
> ---
>  src/tapctl/tap.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
> index dd4a10a3..3f76c43a 100644
> --- a/src/tapctl/tap.c
> +++ b/src/tapctl/tap.c
> @@ -2,7 +2,7 @@
>   *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
>   *            https://community.openvpn.net/openvpn/wiki/Tapctl
>   *
> - *  Copyright (C) 2018-2020 Simon Rozman <simon@...2293...>
> + *  Copyright (C) 2018-2021 Simon Rozman <simon@...2293...>
>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License version 2
> @@ -73,14 +73,13 @@ find_function(const WCHAR *libname, const char *funcname, HMODULE *m)
>         return NULL;
>      }
>  
> -    size_t len = _countof(libpath) - wcslen(libpath) - 1;
> -    if (len < wcslen(libname) + 1)
> +    if (wcslen(libpath) + 1 /*\*/ + wcslen(libname) >= _countof(libpath))

This random inline comment feels extremely weird.

Arne

