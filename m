From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 16 Jul 2012 11:42:09 +0200
Message-ID: <5209432.A6I0dUJoxS@...1526...>
In-Reply-To: <CAOazyz3Sma+A3MnXB=KyasT_EvxLbRyJePHtL2Csd-482anUqw@...278...>
References: <1342173317-8542-1-git-send-email-heiko.hund@...1489...>
	<67127607.nWmV6CCAbv@...1526...>
	<CAOazyz3Sma+A3MnXB=KyasT_EvxLbRyJePHtL2Csd-482anUqw@...278...>
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

On Monday 16 July 2012 12:12:24 Alon Bar-Lev wrote:
> On Mon, Jul 16, 2012 at 11:39 AM, Heiko Hund <heiko.hund@...1489...> wrote:
> > On Friday 13 July 2012 20:00:49 Alon Bar-Lev wrote:
> >> In my projects I always compare to the two values EWOULDBLOCK and
> >> EINPROGRESS and it works without much conditionals.
> >> 
> >> So simply do:
> >> ---
> >> 
> >>   if (status == EINPROGRESS || status == EWOULDBLOCK)
> > 
> > While this surly compiles with mingw, I don't think it works as intended,
> > as the numerical values of the constants differ:
> >         #define EWOULDBLOCK 140       (errno.h)
> >         #define WSAEWOULDBLOCK 10035L (winerror.h)
> > 
> > The error returned from WinSock2 is really 10035 in case of a unfinished
> > non- blocking connect.
> 
> That's correct.... and applies to all winsock errors in this case:
> ---
> #define WSAEWOULDBLOCK 10035L
> #define WSAEINPROGRESS 10036L
> ---
> 
> It depends if you take error from errno or from
> GetLastError()/WSAGetLastError().

I wonder if GetLastError() works reliably with WinSock2 operations as 
msdn.microsoft.com/en-us/library/windows/desktop/ms737828%28v=vs.85%29.aspx 
and
msdn.microsoft.com/en-us/library/windows/desktop/ms737625%28v=vs.85%29.aspx do 
explicitly state to use WSAGetLastError(). Maybe it only breaks with 
multithreaded applications?!

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


