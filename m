Message-ID: <4002F85B.9010103@...61...>
From: Julien TOUCHE <julien.touche@...61...>
MIME-Version: 1.0
Subject: [Openvpn-devel] No buffer space available (code=105)
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
Date: Mon Jan 12 11:42:04 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Recently, i gate the following error with openvpn 1.5

un Jan 11 21:29:40 2004 554: write UDPv4 []: No buffer space available 
(code=105)
Sun Jan 11 21:29:40 2004 555: write UDPv4 []: No buffer space available 
(code=105)
Sun Jan 11 21:29:42 2004 556: 352 variation(s) on previous 3 message(s) 
suppressed by --mute
Sun Jan 11 21:29:42 2004 557: Adaptive compression state OFF
Sun Jan 11 21:29:42 2004 558: write UDPv4 []: No buffer space available 
(code=105)
Sun Jan 11 21:29:42 2004 559: write UDPv4 []: No buffer space available 
(code=105)
Sun Jan 11 21:29:42 2004 560: write UDPv4 []: No buffer space available 
(code=105)

and tcpdump shows a lot of frag whereas there is no traffic ...

20:31:38.484979 10.0.1.1.16884 > 10.0.1.2.16884:  udp 204 (DF) (ttl 64, 
id 0, len 232)
20:31:38.489019 10.0.1.1.16884 > 10.0.1.2.16884:  udp 1292 (frag 
64509:1232@...150...+) (ttl 64, len 1252)
20:31:38.491403 10.0.1.1 > 10.0.1.2: (frag 64509:68@...151...) (ttl 64, len 88)
20:31:38.497492 10.0.1.1.16884 > 10.0.1.2.16884:  udp 1292 (frag 
64510:1232@...150...+) (ttl 64, len 1252)
20:31:38.499898 10.0.1.1 > 10.0.1.2: (frag 64510:68@...151...) (ttl 64, len 88)

any ideas ?

Regards

		Julien

