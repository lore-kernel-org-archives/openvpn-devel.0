Message-ID: <50FB897F.2090003@...515...>
Date: Sat, 19 Jan 2013 23:06:55 -0700
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <50F78297.2030801@...515...>
	<20130118233140.0e5f2742@...1801...>
In-Reply-To: <20130118233140.0e5f2742@...1801...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN client released for iOS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On 18/01/2013 15:31, Marcel Pennewi=DF wrote:
> On Wed, 16 Jan 2013 21:48:23 -0700
> James Yonan <james@...515...> wrote:
>
>> The client is based on the new C++ OpenVPN core that is also used in
>> the OpenVPN Connect client for Android.  The C++ core is a portable,
>> lightweight class library for building OpenVPN clients and is 100%
>> protocol-compatible with the 2.x branch.
>
> It seems, that the client does not support net_gateway in pushed routes:
>
> 2013-01-17 16:55:59 EVENT: ASSIGN_IP
> 2013-01-17 16:55:59 TUN Error: tun_builder_error: error parsing IPv4
> route: [route] [141.24.xxx.xxx] [255.255.255.255] [net_gateway] :
> tun_builder_route_error: only tunnel routes supported
> 2013-01-17 16:55:59 EVENT: TUN_SETUP_FAILED tun_builder_error: error
> parsing IPv4 route: [route] [141.24.xxx.xxx] [255.255.255.255]
> [net_gateway] : tun_builder_route_error: only tunnel routes supported
> [ERR]
> 2013-01-17 16:55:59 EVENT: DISCONNECTED
>
> This works as expected on Win, Linux and Android 4 (reported by user
> that there are no connection issues).
>
> Will net_gateway be available in iOS-Client in future?

It's tricky to make some of these features like net_gateway work on=20
mobile devices, because they don't let you add routes directly, except=20
through a limited API.

I'll take another look at the iOS VPN API and see if this is doable.

Also... You mentioned Android 4 -- I don't think the Android 4 VPN API=20
has the capability to support net_gateway.  OpenVPN Connect for Android=20
definitely doesn't support it.  And looking at Arne Schwabe's FAQ for=20
ics-openvpn, in the Routing/Interface Configuration, it specifically=20
mentions net_gateway as not being supported.  I think that=20
VpnService.Builder would have to add an excludeRoute method to make this=20
possible.

James

