Date: Fri, 12 Mar 2010 09:03:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100312080322.GP25238@...1296...>
References: <4B9515FF.6000704@...41...>
	<20100308174321.GA25238@...1296...>
	<4B966A98.4000206@...41...>
	<jwvsk87dlhk.fsf-monnier+inbox@...1269...>
	<4B991541.3060603@...1147...>
	<20100311192119.GM25238@...1296...>
	<jwvy6hybicq.fsf-monnier+inbox@...1269...>
Mime-Version: 1.0
In-Reply-To: <jwvy6hybicq.fsf-monnier+inbox@...1269...>
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
To: Stefan Monnier <monnier@...1268...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Thu, Mar 11, 2010 at 05:42:07PM -0500, Stefan Monnier wrote:
> >> Let's not add more complexity to openvpn itself, I'd be much happier if 
> > You just don't understand.
> > The complexity *WILL* be in OpenVPN, if we decide to support
> > "route-gateway dhcp" for non-Windows platforms.
> 
> I'm not sure what "route-gateway dhcp" does, so maybe that's part of the
> reason why we disagree.  

In that case it might be helpful to read the mail from James Yonan that
started this thread.

> I thought the discussion was about how to make
> DHCP work over an OpenVPN bridge (i.e. a TAP device) under systems like
> GNU/Linux.  On those systems, the only thing you need to do is to make
> sure that things like ifplugd correctly receive the info about when the
> tunnel goes up and down.

This is the trivial bit.

[..]
> I find the effort would be better spent on working with other people
> trying to make sure that ifplugd/NetworkManager/distributions/... make
> this setup as troublefree as possible.  E.g. make sure that ifplugd
> works well with tap devices (e.g. that it tries to handle them by
> default) and that NetworkManager can easily use OpenVPN and correctly
> (re)starts dhcp clients for the corresponding tap devices.

The world is a bit larger than "Linux distributions having ifplugd".

OpenVPN runs on Linux, 5 different *BSD variants, Solaris, MacOS X 
and Window - and it's not OpenVPN's job to fix the local equivalent of
ifplugd on each of these systems.  OpenVPN's aim is to provide an 
easy-to-use VPN environment for people that do not want to endlessly
fiddle with operating system settings.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

