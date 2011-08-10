MIME-version: 1.0
Message-id: <4FAA35BD289B4FD989857452D4E18777@...139...>
From: Gisle Vanem <gvanem@...139...>
References: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
	<1312980908-25157-2-git-send-email-heiko.hund@...1489...>
Date: Wed, 10 Aug 2011 15:47:36 +0200
Subject: Re: [Openvpn-devel] [PATCH 1/2] define IN6_ARE_ADDR_EQUAL macro
	for	WIN32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; CHARSET=US-ASCII; charset="US-ASCII"; format=flowed;
 reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

"Heiko Hund" <heiko.hund@...1489...> wrote:

> +#ifndef IN6_ARE_ADDR_EQUAL
> +#define IN6_ARE_ADDR_EQUAL(a,b) \
> +    ((((__const uint32_t *) (a))[0] == ((__const uint32_t *) (b))[0]) \
> +  && (((__const uint32_t *) (a))[1] == ((__const uint32_t *) (b))[1]) \
> +  && (((__const uint32_t *) (a))[2] == ((__const uint32_t *) (b))[2]) \
> +  && (((__const uint32_t *) (a))[3] == ((__const uint32_t *) (b))[3]))
> +#endif

A little more readable:
  #define IN6_ARE_ADDR_EQUAL(a, b)   \
              (!memcmp ((const void*)(a), (const void*)(b), sizeof (struct in6_addr)))

(almost the same as in MingW's <ws2tcpip.h>).

--gv

