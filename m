From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 16 Jul 2012 13:15:44 +0200
Message-ID: <2037127.h1WFi1iMxn@...1526...>
In-Reply-To: <CAOazyz3OKiVEbY+WTko4VPi+L9XiF2xqzoPGBxkY0PE5TKYWog@...278...>
References: <1342173317-8542-1-git-send-email-heiko.hund@...1489...>
	<5209432.A6I0dUJoxS@...1526...>
	<CAOazyz3OKiVEbY+WTko4VPi+L9XiF2xqzoPGBxkY0PE5TKYWog@...278...>
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

On Monday 16 July 2012 13:02:11 Alon Bar-Lev wrote:
>On Mon, Jul 16, 2012 at 12:42 PM, Heiko Hund <heiko.hund@...1489...> wrote:
>> I wonder if GetLastError() works reliably with WinSock2 operations as
>> msdn.microsoft.com/en-us/library/windows/desktop/ms737828%28v=vs.85%29.aspx
>> and
>> msdn.microsoft.com/en-us/library/windows/desktop/ms737625%28v=vs.85%29.aspx
>> do explicitly state to use WSAGetLastError(). Maybe it only breaks with
>> multithreaded applications?!
> 
> Starting at windows nt 4, winsock2 there is no difference between
> WSAGetLastError() and GetLastError().

After looking at the disassembly of ws2_32.dll on my Windows 7, I can confirm 
this. Thanks for the hint.

WSAGetLastError() simply returns GetLastError(), which in turn means 
GetLastError() itself returns WSAEWOULDBLOCK (10035). So, we can't simply 
check for EWOULDBLOCK (140). Is the proposed AC_DEFINE approach something you 
agree with?

With all that in mind we can now get rid of openvpn_errno_socket() as 
openvpn_errno() will do the exact same thing. I'll send a removal patch soon.

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


