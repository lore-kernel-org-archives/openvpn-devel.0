Message-ID: <4FF20B85.9030002@...1227...>
Date: Mon, 02 Jul 2012 22:58:45 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <FC681D68-2E03-45B9-BF9D-42AF615FDC3F@...1458...>
In-Reply-To: <FC681D68-2E03-45B9-BF9D-42AF615FDC3F@...1458...>
Subject: Re: [Openvpn-devel] Android ICS openvpn client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Seth Mos <seth.mos@...1458...>
Cc: openvpn-devel@lists.sourceforge.net

Am 02.07.12 22:18, schrieb Seth Mos:
> Hi Everyone,
>
> We just did some tests with the Android OpenVPN client against the OpenVPN 2.2 with IPv6 patches we have in pfSense 2.1 and IPv4 and IPv6 tunneling from the phone and/or tablet works. Yay! (Windows 7 already worked)
>
> We also added some wits for the inline format so you can just mail yourself one file and the Android OpenVPN client will just import it and go from there. Excellent work.
>
> Forward!

Thanks. The next version will also allow opening the attachment from the
email app :)

>
> How about fixing them Mac OS clients, I feel poor. Plus my dual stack servers at work break because my Viscosity is just v4 and I have v6 on my LAN at home breaking a lot because it's trying to send all the traffic over the internet instead of a tunnel.
>

I am not the author of Tunnelblick but it worked very well for me . The
latest beta of Tunnelblick includes openvpn-2.3alpha1 which also
supports ipv6.

Arne


