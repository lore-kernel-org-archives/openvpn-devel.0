From: "James Yonan" <jim@...41...>
Message-ID: <twig.1080758385.28854@...41...>
In-Reply-To: <3g1m601tpk17aspv8aqck8fufppj7td0k7@...105...>
Subject: [Openvpn-devel] Re: [Openvpn-users] OpenVPN 2.0 and firewall
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Mar 31 10:40:05 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arkadiusz Patyk <areq@...104...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Arkadiusz Patyk <areq@...104...> said:

> Hi
> 
> Two very significant things for me are:
> 1. In my configurations, VPN users have different rights to resources
> (access list on firewall - iptables).   I have to know client IP to
> correctly setup firewall, how can i do this in 2.x ?   How can i
> achieve this, in case of dynamic IP assignment

You can use the --ipchange script which is passed the common name and source
IP address every time a client connects.  I probably need to add a new
environmental variable that contains the dynamically allocated --ifconfig-pool
subnet.

> 2. Is it possible to run few servers (each of them on their own tap)
> on the same machine?

Yes, it is possible to run many '--mode server' servers on the same machine,
each having their own tun interface (tap interfaces are not supported yet in
--mode server mode).

This would be a good way to differentiate access rights for different client
classes.

James

> -- 
> Arkadiusz Patyk [areq(at)pld-linux.org] [http://rescuecd.pld-linux.org/]
> [IRC:areq ICQ:16231667  GG:1383]  [AP3-6BONE] [AP14126-RIPE]
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Openvpn-users mailing list
> Openvpn-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-users
> 



-- 




