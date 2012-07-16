MIME-Version: 1.0
In-Reply-To: <67127607.nWmV6CCAbv@...1526...>
References: <1342173317-8542-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz31T1pEoCGLs-Raq=MgYsuYmiPBtW+8d0VDD7k12Az+uA@...278...>
	<67127607.nWmV6CCAbv@...1526...>
Date: Mon, 16 Jul 2012 12:12:24 +0300
Message-ID: <CAOazyz3Sma+A3MnXB=KyasT_EvxLbRyJePHtL2Csd-482anUqw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Jul 16, 2012 at 11:39 AM, Heiko Hund <heiko.hund@...1489...> wrote:
> Hi Alon
>
> On Friday 13 July 2012 20:00:49 Alon Bar-Lev wrote:
>> In my projects I always compare to the two values EWOULDBLOCK and
>> EINPROGRESS and it works without much conditionals.
>>
>> So simply do:
>> ---
>>   if (status == EINPROGRESS || status == EWOULDBLOCK)
>
> While this surly compiles with mingw, I don't think it works as intended, as
> the numerical values of the constants differ:
>
>         #define EWOULDBLOCK 140       (errno.h)
>         #define WSAEWOULDBLOCK 10035L (winerror.h)
>
> The error returned from WinSock2 is really 10035 in case of a unfinished non-
> blocking connect.
>

Hi,

That's correct.... and applies to all winsock errors in this case:
---
#define WSAEWOULDBLOCK 10035L
#define WSAEINPROGRESS 10036L
---

It depends if you take error from errno or from
GetLastError()/WSAGetLastError().
If we do not use errno, we can have autoconf to define emulation for
errno as WSA constants.

Alon.

