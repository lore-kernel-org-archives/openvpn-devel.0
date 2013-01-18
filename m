Date: Fri, 18 Jan 2013 23:31:40 +0100
From: Marcel =?ISO-8859-1?Q?Pennewi=DF?= <mailinglists@...1145...>
Message-ID: <20130118233140.0e5f2742@...1801...>
In-Reply-To: <50F78297.2030801@...515...>
References: <50F78297.2030801@...515...>
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
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

On Wed, 16 Jan 2013 21:48:23 -0700
James Yonan <james@...515...> wrote:

> The client is based on the new C++ OpenVPN core that is also used in
> the OpenVPN Connect client for Android.  The C++ core is a portable, 
> lightweight class library for building OpenVPN clients and is 100% 
> protocol-compatible with the 2.x branch.

It seems, that the client does not support net_gateway in pushed routes:

2013-01-17 16:55:59 EVENT: ASSIGN_IP
2013-01-17 16:55:59 TUN Error: tun_builder_error: error parsing IPv4
route: [route] [141.24.xxx.xxx] [255.255.255.255] [net_gateway] :
tun_builder_route_error: only tunnel routes supported
2013-01-17 16:55:59 EVENT: TUN_SETUP_FAILED tun_builder_error: error
parsing IPv4 route: [route] [141.24.xxx.xxx] [255.255.255.255]
[net_gateway] : tun_builder_route_error: only tunnel routes supported
[ERR]
2013-01-17 16:55:59 EVENT: DISCONNECTED  

This works as expected on Win, Linux and Android 4 (reported by user
that there are no connection issues).

Will net_gateway be available in iOS-Client in future?

Best regards,
Marcel

