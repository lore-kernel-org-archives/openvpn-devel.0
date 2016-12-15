Date: Thu, 15 Dec 2016 17:50:48 +0100
From: Thomas Glanzmann <thomas@...1029...>
Message-ID: <20161215165048.GA23728@...1029...>
References: <20161215160841.GA21203@...1029...>
	<20161215162019.GP35892@...2215...>
MIME-Version: 1.0
In-Reply-To: <20161215162019.GP35892@...2215...>
Subject: Re: [Openvpn-devel] ngx_stream_ssl_preread_module does not seem to
 extract the server_name when connecting with openconnect
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
To: nginx@...2214...
Cc: openvpn devel <openvpn-devel@lists.sourceforge.net>

Hello Roman,

> You can try logging $ssl_preread_server_name in access_log.

thank you. It seems that nginx is not able to extract the server_name
from openconnect correctly:

2a01:598:8181:37ef:95e1:682:4c98:449e - [15/Dec/2016:17:45:57 +0100] ""

When I connect with a browser:

2a01:598:8181:37ef:95e1:682:4c98:449e - [15/Dec/2016:17:46:20 +0100] "vpn.gmvl.de"

This seems to be one problem. And another problem seems that backend
communication between nginx and ocserv using the proxy protocol.

Here is tcpdump of the openconnect ssl handshake with nginx:

https://thomas.glanzmann.de/tmp/openconnect_sni.pcap

I'm using the command line 'openconnect vpn.gmvl.de'.

Cheers,
        Thomas

