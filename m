Subject: Re: [Openvpn-devel] TINC and OpenVPN tunnel performance on a Windows client
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1068159046.77908@...41...>
In-Reply-To: <1068125943.20994.135.camel@...125...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Nov  6 14:51:18 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Teemu Kiviniemi <teemuki@...124...>, tinc-devel@...127...
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

> - Generic OpenVPN settings:
> cipher bf-cbc
> dev tap
> tun-mtu 1500
> tun-mtu-extra 32
> - OpenVPN-TCP settings:
> proto tcp-client
> - OpenVPN-UDP settings:
> proto udp
> - OpenVPN-UDP-LZO settings:
> proto udp
> comp-lzo

You could improve the UDP performance of this config with two changes:

(1) Use "dev tun".

(2) Clamp the TCP MSS using the --mssfix option.  You want to use the largest
mssfix value which will not cause fragmentation.  Try 1400 or 1450.

James


