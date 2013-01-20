Date: Sun, 20 Jan 2013 12:47:59 +0100
From: Marcel =?ISO-8859-1?Q?Pennewi=DF?= <mailinglists@...1145...>
Message-ID: <20130120124759.292dd233@...1801...>
In-Reply-To: <50FB897F.2090003@...515...>
References: <50F78297.2030801@...515...>
	<20130118233140.0e5f2742@...1801...>
	<50FB897F.2090003@...515...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN client released for iOS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Sat, 19 Jan 2013 23:06:55 -0700
James Yonan <james@...515...> wrote:

> Also... You mentioned Android 4 --

A user tested it and told me, that VPN works well. Our VPN-Server is
inside a /16 which is routed over VPN. So without the hostroute the
connection will die and VPN works well.

> I don't think the Android 4 VPN
> API has the capability to support net_gateway.  OpenVPN Connect for
> Android definitely doesn't support it.  And looking at Arne Schwabe's
> FAQ for ics-openvpn, in the Routing/Interface Configuration, it
> specifically mentions net_gateway as not being supported.  I think
> that VpnService.Builder would have to add an excludeRoute method to
> make this possible.

FAQ says, that VPNService API will create a hostroute itsself and
OpenVPN on ICS ignores net_gateway-routes. I neither own a Android 4
nor a iOS device to test this ;) So maybe this will work on iOS as well?

Best regards,
Marcel

