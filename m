Date: Sat, 10 Jul 2010 14:17:55 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100710121754.GB361@...1296...>
References: <4C3843A5.50700@...1388...> <20100710102921.GZ361@...1296...>
	<4C3862BF.40401@...1388...>
Mime-Version: 1.0
In-Reply-To: <4C3862BF.40401@...1388...>
Subject: Re: [Openvpn-devel] feat_ipv6_payload problems on Solaris 10
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
To: Michal Ludvig <mludvig@...1388...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On Sun, Jul 11, 2010 at 12:08:31AM +1200, Michal Ludvig wrote:
> >> I'm having a problem with feat_ipv6_payload branch (checked out from git
> >> yesterday). One end is Solaris 10 (sparc) and the other end is Linux.
> > Which version of the tun driver are you using for Solaris?
> >
> > My test solaris machine (Solaris 10 on Sparc64, but not the very latest
> > version) uses the driver from http://www.whiteboard.ne.jp/~admin2/tuntap/
> > and IPv6 works fine there.  The web page says that this driver did not
> > support IPv6 before 11/16/2009 - so maybe this is the problem.
> That was it! Works now:
> 
> [Linux] ~ # ping6 -n 2001:cafe::1
> PING 2001:cafe::1(2001:cafe::1) 56 data bytes
> 64 bytes from 2001:cafe::1: icmp_seq=343 ttl=255 time=54.3 ms
> 64 bytes from 2001:cafe::1: icmp_seq=344 ttl=255 time=50.1 ms
> ^C

Cool :-) - congratulations!

(And thanks for testing point-to-point tun mode - I assumed it would
work, but it's still on my test-plan...)

> I used to have CSWtun from Blastwave - it's labeled as version 1.1 as 
> well so I believed it was the right thing.

Hmmm.  I wasn't aware that that one exists - but it might be worth a try
to send them a note that they might want to do some updates.

> Is there any way to check that the right module is loaded at runtime? 
> That may help avoid some confusion in the future...

Good questions.  I don't know right now, but I'll try to find out.

> (BTW is there any work in progress for a v6 transport?)

Well, there's feat_ipv6_transport by jjo, and of course, the "allmerged" 
branch which has both v6 payload and v6 transport.  As far as I understand, 
the v6 transport stuff works on all "major" platforms supported by 
OpenVPN and generally gets the job done :-)

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

