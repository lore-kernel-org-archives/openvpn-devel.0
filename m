Message-ID: <00a501c1f9ea$20081a70$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <3CDEAE7B.3000609@...18...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: [Openvpn-users] encryption problems
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
Date: Sun May 12 12:20:04 2002
Content-Type: text/plain;
	charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
To: Kai Dupke <kdupke@...18...>, openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

> thank you very much. I just tried 1.1.1.13 and I got a working tunnel
> even using my axp-box. For this the tunnel is between an 1.1.1-i386 and
> an 1.1.1.13-axp.

Cool.  The latest beta version of OpenVPN has lots of portability fixes
which make minimal assumptions about word sizes, and use uint8_t and
uint32_t for all network types, while being fully protocol compatible with
1.1.0 and 1.1.1.

> BTW: Is there someone building a config file for openvpn? I'm just
> playing with a small set of scripts and an config file with one line per
> connection. At this time I only apply on preshared secrets.

Config files are supported in the current beta releases, and will be
supported in the next stable release which will be 1.2.0.

Right now there's also a "beta version" of the web site which will go live
when 1.2.0 is released that has a new HOWTO and lots of config file
examples:

http://openvpn.sourceforge.net/beta/www/howto.html

James





