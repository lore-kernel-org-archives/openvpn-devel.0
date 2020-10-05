From: "Vladislav Grishenko" <themiron@...2010...>
References: <20201001225319.25125-1-themiron@...2010...>
 <202010041219.094CJNKk043968@...2054...>
 <007b01d69b3c$2321a980$6964fc80$@yandex-team.ru>
 <20201005172827.GQ976@...1296...>
In-Reply-To: <20201005172827.GQ976@...1296...>
Date: Mon, 5 Oct 2020 22:33:48 +0500
Message-ID: <008801d69b3d$af743ff0$0e5cbfd0$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Speedup TCP remote hosts
 connections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Gert Doering' <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

> "--tcp-server"
Yep, mean it, even poll doesn't used there. Have no any prio about it tho,
just related thoughts.

--
Best Regards, Vladislav Grishenko

> -----Original Message-----
> From: Gert Doering <gert@...1296...>
> Sent: Monday, October 5, 2020 10:28 PM
> To: Vladislav Grishenko <themiron@...2010...>
> Cc: 'Gert Doering' <gert@...1296...>; openvpn-
> devel@lists.sourceforge.net
> Subject: Re: [PATCH applied] Re: Speedup TCP remote hosts connections
> 
> Hi,
> 
> On Mon, Oct 05, 2020 at 10:22:43PM +0500, Vladislav Grishenko wrote:
> > Perhaps same approach can be applied to server's tcp listening, would
> > require testing of more management cases.
> 
> There's two code paths here
> 
>  --tcp-server
> 
> and
> 
>  --mode server + --tcp
> 
> I think the "mode server" code path is already very quick (= if I test
with your fast
> TCP client, against a "git master" server, I get 0.16s connection setup
time).  This
> is what people use on "more than one client" servers, so it's already
fine.
> 
> The "--tcp-server" code path is "point to point".  Not sure we currently
test this
> at all (I have UDP p2p instance, but no TCP yet... seems I need to add
one).  This
> might indeed be slow, I had a look at the
> accept() path in socket.c recently and was wondering "how can this work at
all?"
> - but that's "socket.c" vs. "mtcp.c", I think.
> 
> 
> Since this is somewhat of a niche case, I'd put that into the "2.6" bin
:-)
> - the other one, TCP on the client, is much more heavily used, so 2.5
> for that was appropriate.
> 
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
Mistress
> 
> Gert Doering - Munich, Germany
gert@...1296...


