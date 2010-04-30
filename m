From: Davide Brini <dave_br@...1278...>
Date: Fri, 30 Apr 2010 19:28:47 +0100
References: <4BDAD39A.1030906@...515...> <201004301824.21244.dave_br@...1278...>
	<20100430181202.GG12312@...1296...>
In-Reply-To: <20100430181202.GG12312@...1296...>
MIME-Version: 1.0
Message-Id: <201004301928.47595.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] [TESTING NEEDED] Using
	--inactive and --ping seems to defeat each other
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

On Friday 30 April 2010, Gert Doering wrote:

> On Fri, Apr 30, 2010 at 06:24:20PM +0100, Davide Brini wrote:
> > Well, the obvious (and probably wrong, probably inefficient) way could be
> > to just check if the packet at hand is a ping message, and if it is do
> > not record it as "activity", eg
> >
> > if (! is_ping_msg (&c->c2.buf))
> >    register_activity (c, size);
> 
> Looks good to me :-) (without having looked at the code in question at
>  all).
> 
> > This is in two places: in process_outgoing_tun() and
> > process_outgoing_link().
> 
> As you wrote in the next e-mail, this won't ever be "outgoing on tun",
> so only one place needs changing...

Yes of course, but I realized that too late :) It makes no sense at all to 
send OpenVPN pings to the kernel.
 
> > However, I'm not sure about the overhead of performing that for each and
> > every processed packet. is_ping_msg() calls buf_string_match(), which in
> > turn calls memcmp().
> > But, it should also be noted that process_incoming_link() DOES call
> > is_ping_msg() for every incoming packet, so...
> 
> I'm a big fan of symmetry here - if the incoming packet path explictly
> not-counts ping packets, it's a bit hard to explain to users why the
> outgoing packet path *does* count them, and they have to fiddle with
> byte counts to get "inactivity".
> 
> I'd go that route...
> 
> Efficiency is a valid concern, of course.  Since is_ping_msg() and
> buf_string_match() are both (very short) inline functions, and memcmp()
> on "normal" architectures is also inlined by gcc, this "should not" add
> unduly overhead.  (Of course, down that road is hell and windows vista).

Ok, thanks for the remarks! 

I will try to implement it that way then, and see how it goes (perhaps 
including some basic benchmarking - not entirely sure how to go about that 
apart from generating loads of traffic and see, but I'll figure out). Then 
I'll post back (possibly with a patch including changing the description in 
the man etc.)

-- 
D.

