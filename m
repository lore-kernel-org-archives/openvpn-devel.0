Date: Fri, 30 Apr 2010 20:12:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100430181202.GG12312@...1296...>
References: <4BDAD39A.1030906@...515...> <4BDAD78B.3090805@...515...>
	<4BDAEAB9.8080806@...1114...>
	<201004301824.21244.dave_br@...1278...>
Mime-Version: 1.0
In-Reply-To: <201004301824.21244.dave_br@...1278...>
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
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi,

On Fri, Apr 30, 2010 at 06:24:20PM +0100, Davide Brini wrote:
> Well, the obvious (and probably wrong, probably inefficient) way could be to 
> just check if the packet at hand is a ping message, and if it is do not record 
> it as "activity", eg
> 
> if (! is_ping_msg (&c->c2.buf))
>    register_activity (c, size);

Looks good to me :-) (without having looked at the code in question at all).

> This is in two places: in process_outgoing_tun() and process_outgoing_link(). 

As you wrote in the next e-mail, this won't ever be "outgoing on tun",
so only one place needs changing...

> However, I'm not sure about the overhead of performing that for each and every 
> processed packet. is_ping_msg() calls buf_string_match(), which in turn calls 
> memcmp().
> But, it should also be noted that process_incoming_link() DOES call 
> is_ping_msg() for every incoming packet, so... 

I'm a big fan of symmetry here - if the incoming packet path explictly
not-counts ping packets, it's a bit hard to explain to users why the
outgoing packet path *does* count them, and they have to fiddle with
byte counts to get "inactivity".

I'd go that route... 

Efficiency is a valid concern, of course.  Since is_ping_msg() and
buf_string_match() are both (very short) inline functions, and memcmp() 
on "normal" architectures is also inlined by gcc, this "should not" add 
unduly overhead.  (Of course, down that road is hell and windows vista).

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

