Message-ID: <OF16C98C16.EEA12E96-ONC12576FD.006F673E-C12576FD.00713519@...1343...>
From: Johan Ymerson <johan.ymerson@...1342...>
Date: Tue, 6 Apr 2010 22:36:31 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] DNS problems with openvpn 2.1 on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net


Hi,

I have been testing OpenVPN 2.1.1 for a while and have came across a strange DNS problem.
Other people seem to have seen the same problem (ex. http://www.astaro.org/astaro-gateway-products/vpn-site-site-remote-access/21387-new-sslvpn-client-dns-problems.html), and a work-around is available, but I have not seen any real fix for this or discussion on how to find the actual problem.

The problem is that with OpenVPN 2.1.1 (and all 2.1_rcX I have tested so far), Windows doesn't seem to use the connection specific DNS servers. All DNS information (as seen by ipconfig /all) is correct, and nslookup uses the correct server. All other applications however, does not. Eventually (after
5-30 minutes or so), Windows starts to use the correct DNS servers.

Note, this is _not_ the problem http://openvpn.net/faq.html#dhcpcaveats, although it sounds like it. I have tested that work-around and it doesn't work in this case.

The work-around that always seem to work is to do an "ipconfig /renew" in a route-up script.

I have tested on 3 PC's with Windows XP, all 3 show the same problem, at almost 100% of my connection attempts.
OpenVPN 2.0.9 does not have this issue (ie. reverting back to 2.0.9 on the same machines with the same config never show the problem).

Is this problem known, and is someone working on it?
I can of course help debugging this, but I don't have the development environment needed to compile the Windows binaries.

/Johan Ymerson


