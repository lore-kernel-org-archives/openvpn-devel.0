Message-ID: <01f701c1dbca$7d542db0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <1017760165.9891.85.camel@...2...><008901c1da97$e4ce0b70$1000000a@...4...><1017818817.1524.56.camel@...2...> <01ba01c1dbb5$2a3367a0$1000000a@...4...><1017910625.1562.14.camel@...2...>  <01d701c1dbba$1db49b20$1000000a@...4...> <1017915300.1563.18.camel@...2...>
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
Date: Thu Apr  4 03:19:19 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Janne Johansson <jan.johansson@...1...>, openvpn-devel@lists.sourceforge.net

>I think the solution would be to have openvpn disable TUN_NO_IP for
Linux tun devices and just not care about the actual value when
the packets arrive.

So if the linux side disables TUN_NO_PI, does the problem go away when
connecting to BSD?

James



