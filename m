Subject: Re: [Openvpn-devel] Need 1.5 beta testers for *BSD, Linux 2.2, OS X
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1062309326.34391@...41...>
In-Reply-To: <3F4F33C6.3020201@...61...>
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
Date: Sat Aug 30 22:57:02 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: julien Touche <julien.touche@...61...>
Cc: openvpn-devel@lists.sourceforge.net

> question regarding windows openvpn (thanks a lot for this :), is it 
> possible to have some script executed (like add a route for the other 
> side subnet) ?

I'm thinking about something like this in a more generalized context, where
OpenVPN running as a server would actually generate the config file for the
client, and send it to the client via SSL after an initial authentication
handshake.  This would simplify the configuration on the client side, and
allow the server to send routes back to the client.

James


