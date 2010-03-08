Date: Mon, 8 Mar 2010 18:43:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100308174321.GA25238@...1296...>
References: <4B9515FF.6000704@...41...>
Mime-Version: 1.0
In-Reply-To: <4B9515FF.6000704@...41...>
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
To: James Yonan <jim@...41...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

looking at the multitude of DHCP clients available for unix, the completely
different handling of DHCP on MacOS, and the issues that most unix clients
seem to have with "DHCP active on two different interfaces (ethX and tapY),
and both trying to set a default gateway", ...

On Mon, Mar 08, 2010 at 08:21:35AM -0700, James Yonan wrote:
> (2) Complex method: Write code in OpenVPN to simulate a DHCP client, 
> then translate the settings received in the DHCP reply to OpenVPN 
> push-style directives (such as ifconfig, route, etc.) as if they had 
> been pushed by the OpenVPN server.

... this seems to be the most portable way, as we already have the 
ifconfig/route code for all the platforms.

Well.  Let me rephrase.

The "simple way" is simple as far as the packet flow inside OpenVPN
goes (because OpenVPN only needs to transport packets, but not generate
them or parse them), but is, at the same time, the "most complex way" 
as far as getting it to work reliably across all supported operating 
systems.  Lots of testing and "configure" magic would be necessary to
reliably figure out how to do DHCP properly on each individual system.

I'm not saying it can't be done :-) - but just that the "simple way"
is not so simple, it's just complex in other places.

gert
-- 
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~gert/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

