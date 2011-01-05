Message-ID: <20110105140943.27570.qmail@...1287...>
Date: Wed, 5 Jan 2011 15:09:43 +0100
From: Peter Stuge <peter@...1287...>
References: <4D24703E.70504@...515...>
MIME-Version: 1.0
In-Reply-To: <4D24703E.70504@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Changed snprintf to _snprintf
	in	service-win32/openvpnserv.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Samuli Seppänen wrote:
> +++ b/service-win32/openvpnserv.c
> @@ -86,7 +86,7 @@ static HANDLE exit_event = NULL;
>  /* snprintf with guaranteed null termination */
>  #define mysnprintf(out, ...) \
>          { \
> -           snprintf (out, sizeof(out), __VA_ARGS__); \
> +           _snprintf (out, sizeof(out), __VA_ARGS__); \
>             out [sizeof (out) - 1] = '\0'; \
>          }

> Does this change affect the automake/gcc-based Windows builds?

My MinGW compiles both snprintf() and _snprintf() fine.


//Peter

