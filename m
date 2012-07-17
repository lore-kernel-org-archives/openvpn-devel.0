MIME-Version: 1.0
In-Reply-To: <2989627.j049xi4nqB@...1526...>
References: <1342533472-30873-1-git-send-email-heiko.hund@...1489...>
	<21316332.O9di4uRdZn@...1526...>
	<CAOazyz1eUXu-a=k9q+AvbD25swq=iBD7Okc18jBp0gZeRxojkA@...278...>
	<2989627.j049xi4nqB@...1526...>
Date: Tue, 17 Jul 2012 18:22:59 +0300
Message-ID: <CAOazyz3oV0JBZPZFhgwtUUX4oO3OSQMa+GhpErad7cM3ochotA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] don't treat socket related errors
	special anymore
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, Jul 17, 2012 at 6:15 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> On Tuesday 17 July 2012 18:11:25 Alon Bar-Lev wrote:
>> #define EWOULDBLOCK WSAWOULDBLOCK
>
> EWOULDBLOCK is already defined in errno.h (also in Windows) and shouldn't be
> redefined in my opinion.

So if this is in one place, better a simple #ifdef
---
if (
#ifdef WIN32
    status == WSAEWOULDBLOCK
#else
    status == EINPROGRESS
#endif
) {
}
---

I don't think we are using errno.h values in windows, have no time to
check it now. If not, simplest is to #define WSA* as E*.

Alon.

