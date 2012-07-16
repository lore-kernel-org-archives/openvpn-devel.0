From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 16 Jul 2012 10:39:21 +0200
Message-ID: <67127607.nWmV6CCAbv@...1526...>
In-Reply-To: <CAOazyz31T1pEoCGLs-Raq=MgYsuYmiPBtW+8d0VDD7k12Az+uA@...278...>
References: <1342173317-8542-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz31T1pEoCGLs-Raq=MgYsuYmiPBtW+8d0VDD7k12Az+uA@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] make non-blocking connect work on
	Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Alon

On Friday 13 July 2012 20:00:49 Alon Bar-Lev wrote:
> In my projects I always compare to the two values EWOULDBLOCK and
> EINPROGRESS and it works without much conditionals.
> 
> So simply do:
> ---
>   if (status == EINPROGRESS || status == EWOULDBLOCK)

While this surly compiles with mingw, I don't think it works as intended, as 
the numerical values of the constants differ:

	#define EWOULDBLOCK 140       (errno.h)
	#define WSAEWOULDBLOCK 10035L (winerror.h)

The error returned from WinSock2 is really 10035 in case of a unfinished non-
blocking connect.

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


