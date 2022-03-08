Message-ID: <f4d55b82-4a9d-fd09-a8d9-f4ec6a8692d1@...2181...>
Date: Tue, 8 Mar 2022 15:16:37 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220224165557.22060-1-kprovost@...2661...>
 <20220224165557.22060-3-kprovost@...2661...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220224165557.22060-3-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Kristof,

A quick question for you, see below

On 24/02/2022 17:55, Kristof Provost via Openvpn-devel wrote:
> --- a/configure.ac
> +++ b/configure.ac
> @@ -787,7 +787,20 @@ dnl
>   			AC_DEFINE(ENABLE_DCO, 1, [Enable data channel offload for Linux])
>   			AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
>   		;;
> -
> +		*-*-freebsd*)
> +			DCO_CFLAGS="-I${DCO_SOURCEDIR}"
> +			saved_CFLAGS="${CFLAGS}"
> +			CFLAGS="${CFLAGS} ${DCO_CFLAGS}"
> +			AC_CHECK_HEADERS(
> +					 [if_ovpn.h],
> +					 ,
> +					 [AC_MSG_ERROR([if_ovpn.h is missing (use DCO_SOURCEDIR to set path to it, CFLAGS=${CFLAGS})])]
> +					 )
> +			CFLAGS=${saved_CFLAGS}
> +			LIBS="${LIBS} -lnv"
> +			AC_DEFINE(ENABLE_DCO, 1, [Enable data channel offload for FreeBSD])
> +			AC_MSG_NOTICE([Enabled ovpn-dco support for FreeBSD])
> +		;;

If you double check the latest dco branch, you will see that I have 
dropped the DCO_SOURCEDIR variable and I have rather switched to "let's 
include the kernel API header in the openvpn repository all the time and 
be happy with it".

The idea is that the kernel API will always be backwards compatible, 
therefore having a stale header will never be a problem. It can be 
updated when a new feature is implemented in openvpn itself. (a similar 
approach is taken by hostapd or iw on Linux, where they ship a copy of 
nl80211.h)

On the other hand, we drastically simplify the configure logic and avoid 
having to deal with this variable which may have different pitfalls on 
different platforms.

Do you have any opinion about the above? or shipping a copy of the 
header with openvpn source code is fine with you?

Regards,


p.s. as a side note, the rest of the code contains some "code style" 
issues. Nothing major, but wanted to mention it (we can discuss on IRC 
if you want).

-- 
Antonio Quartulli

