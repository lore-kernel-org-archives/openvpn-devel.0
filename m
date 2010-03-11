Date: Thu, 11 Mar 2010 20:21:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100311192119.GM25238@...1296...>
References: <4B9515FF.6000704@...41...>
	<20100308174321.GA25238@...1296...>
	<4B966A98.4000206@...41...>
	<jwvsk87dlhk.fsf-monnier+inbox@...1269...>
	<4B991541.3060603@...1147...>
Mime-Version: 1.0
In-Reply-To: <4B991541.3060603@...1147...>
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
Content-Disposition: inline
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Mar 11, 2010 at 05:07:29PM +0100, Jan Just Keijser wrote:
> Let's not add more complexity to openvpn itself, I'd be much happier if 

You just don't understand.

The complexity *WILL* be in OpenVPN, if we decide to support
"route-gateway dhcp" for non-Windows platforms.

The question is, *where* will it be?

a) figuring out how to properly run the system's DHCP client [which might 
   not even be installed] for *this* version of Linux or FreeBSD or 
   OpenBSD or NetBSD or Solaris or MacOS in the right way

b) contain the code to generate a DHCP request (trivial) and parse the
   response (fairly trivial), and use the already-existing IP configuration
   and route-setup bits

For people that only know their small local operating system island, 
"a)" seems like a trivial task.  For software that is so highly portable
as OpenVPN, "a)" is a truckload of pain.

I have been through the pain in implementing IPv6 support for all 
operating systems (except OpenBSD yet) that OpenVPN supports - and that
was harmless in regard to the variety of DHCP clients that exist and
all of them need to be twiddled and poked in different ways, most of them
*way out of control of OpenVPN*.


This might be the other big misunderstanding here.  As of today, if you
want to use "ifplugd + dhcp + ..." on a TAP interface, just do so - OpenVPN
won't stand in your way.  This is not the issue at hand - the issue is
that OpenVPN wants to be friendly to the users, and give them an option
to do DHCP-on-TAP without(!) having to fiddle with their local network
setup.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

