Message-ID: <01ba01c1dbb5$2a3367a0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <1017760165.9891.85.camel@...2...> <008901c1da97$e4ce0b70$1000000a@...4...> <1017818817.1524.56.camel@...2...>
Subject: Re: [Openvpn-devel] More BSD TUN info.
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Thu Apr  4 00:47:08 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Janne Johansson <jan.johansson@...1...>
Cc: openvpn-devel@lists.sourceforge.net

>I don't know the openvpn data format, but if 45000054 is some sort of
openvtun identifier, you/we/I could add some code that checked for
00000002 followed by 45000054 and then strip the first u_int_32 from
the packet and go on. Perhaps a --remote-is-bsd or something similar?

Openvpn doesn't look at the tunnel data... it just encrypts, decrypts,
forwards etc.  The 45000054 is the beginning of the IP header of the packets
going over the tunnel.

Yeah, an option might be right thing.  So --remote-is-bsd would remove the
AF_INET from incoming packets and add them to outgoing packets.  A bit of a
kludge.

>I wonder if Vtun ever did work between linux-vs-bsd ?

I doubt it.  I did a grep on vtun sources for AF_INET and didn't find any
usage other than the usual places.

James



