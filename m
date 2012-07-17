MIME-Version: 1.0
In-Reply-To: <21316332.O9di4uRdZn@...1526...>
References: <1342533472-30873-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz0wc=ZGhJnLfvd=AK6_Y=vTfebccmV29Fc5z2DGpJ8EWQ@...278...>
	<21316332.O9di4uRdZn@...1526...>
Date: Tue, 17 Jul 2012 18:11:25 +0300
Message-ID: <CAOazyz1eUXu-a=k9q+AvbD25swq=iBD7Okc18jBp0gZeRxojkA@...278...>
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

On Tue, Jul 17, 2012 at 6:09 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> On Tuesday 17 July 2012 17:25:25 Alon Bar-Lev wrote:
>> Just I don't like the CONNECT_IN_PROGRESS.
>> I think it is better to rebase first and then submit the
>> CONNECT_IN_PROGRESS afterwards, I think it would be simpler to just
>> compare to the two statuses.
>
> That would result in either something like
>
>   if (status == EINPROGRESS
>   #ifdef WIN32
>     || status == WSAEWOULDBLOCK
>   #endif
>   )
>
> or slightly less disturbing
>
>   #ifndef WSAEWOULDBLOCK
>   #define WSAEWOULDBLOCK 10035L
>   #endif
>
> I do prefer the suggested approach resolving this with configure over these.
> Or did you have something more attractive in mind?
>

or:
---
#define EWOULDBLOCK WSAWOULDBLOCK
---
in configure.ac

