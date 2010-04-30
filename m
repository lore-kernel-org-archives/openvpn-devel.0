From: Davide Brini <dave_br@...1278...>
Date: Fri, 30 Apr 2010 18:24:20 +0100
References: <4BDAD39A.1030906@...515...> <4BDAD78B.3090805@...515...>
	<4BDAEAB9.8080806@...1114...>
In-Reply-To: <4BDAEAB9.8080806@...1114...>
MIME-Version: 1.0
Message-Id: <201004301824.21244.dave_br@...1278...>
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
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: Samuli, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

On Friday 30 April 2010, David Sommerseth wrote:

> >> I agree that that would be a wise change. However, I wonder: why change
> >> the amount of bytes, if you can also simply not count the ping packets?
> >> To me, it would seem a much more accurate way of determining whether the
> >> connection is idle or not, because there's always the possibility of
> >> duplicate ping packets (even although that's unlikely) or other errors.
> >> Or would that cause a too great load on the server?
> >
> > Sounds like a good idea. Do any devs have an idea how difficult
> > (code-vise) that'd be?
> 
> I've not gone too deep into this code path yet, but I believe from what
> I could see, the byte counter is located on a different place than the
> "ping initiator".  That means that telling the "byte counter code" that
> "this is our own packet, don't count it" is not as trivial to fix as it
> sounds like.
> 
> It looks like we just put 16 bytes of "static randomness" (defined in
> ping.c) and push that into the some session buffers.  Then later on, in
> another function pushes what ever is queued up for transmission.
> 
> But this need to be investigated further ... and if someone is quicker
> than me to figure it out, patches are, as always, more than welcome!

Well, the obvious (and probably wrong, probably inefficient) way could be to 
just check if the packet at hand is a ping message, and if it is do not record 
it as "activity", eg

if (! is_ping_msg (&c->c2.buf))
   register_activity (c, size);

This is in two places: in process_outgoing_tun() and process_outgoing_link(). 

However, I'm not sure about the overhead of performing that for each and every 
processed packet. is_ping_msg() calls buf_string_match(), which in turn calls 
memcmp().
But, it should also be noted that process_incoming_link() DOES call 
is_ping_msg() for every incoming packet, so... 

-- 
D.

