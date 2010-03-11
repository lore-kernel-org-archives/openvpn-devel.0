From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvy6hybicq.fsf-monnier+inbox@...1269...>
References: <4B9515FF.6000704@...41...>
	<20100308174321.GA25238@...1296...> <4B966A98.4000206@...41...>
	<jwvsk87dlhk.fsf-monnier+inbox@...1269...> <4B991541.3060603@...1147...>
	<20100311192119.GM25238@...1296...>
Date: Thu, 11 Mar 2010 17:42:07 -0500
In-Reply-To: <20100311192119.GM25238@...1296...> (Gert Doering's message
	of "Thu, 11 Mar 2010 20:21:19 +0100")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

>> Let's not add more complexity to openvpn itself, I'd be much happier if 
> You just don't understand.
> The complexity *WILL* be in OpenVPN, if we decide to support
> "route-gateway dhcp" for non-Windows platforms.

I'm not sure what "route-gateway dhcp" does, so maybe that's part of the
reason why we disagree.  I thought the discussion was about how to make
DHCP work over an OpenVPN bridge (i.e. a TAP device) under systems like
GNU/Linux.  On those systems, the only thing you need to do is to make
sure that things like ifplugd correctly receive the info about when the
tunnel goes up and down.

> a) figuring out how to properly run the system's DHCP client [which might 
>    not even be installed] for *this* version of Linux or FreeBSD or 
>    OpenBSD or NetBSD or Solaris or MacOS in the right way

That's not something OpenVPN should worry about.  It's the
distribution's job to do that.

> This might be the other big misunderstanding here.  As of today, if you
> want to use "ifplugd + dhcp + ..." on a TAP interface, just do so - OpenVPN
> won't stand in your way.  This is not the issue at hand - the issue is
> that OpenVPN wants to be friendly to the users, and give them an option
> to do DHCP-on-TAP without(!) having to fiddle with their local network
> setup.

I find the effort would be better spent on working with other people
trying to make sure that ifplugd/NetworkManager/distributions/... make
this setup as troublefree as possible.  E.g. make sure that ifplugd
works well with tap devices (e.g. that it tries to handle them by
default) and that NetworkManager can easily use OpenVPN and correctly
(re)starts dhcp clients for the corresponding tap devices.


        Stefan

