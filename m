Message-ID: <048101c4c5b5$655eca80$0600000a@...139...>
From: "Gisle Vanem" <giva@...258...>
MIME-Version: 1.0
Subject: [Openvpn-devel] undefined get_netsh_id
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
Date: Mon Nov  8 10:14:44 2004
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

I tried building latest beta16 with gcc 3.4.1 and MingW and
struck what I suspect is a gcc bug. While linking I got:

tun.o(.stab+0x11024): In function `ipset2ascii_all':
G:/MingW32/src/inet/OpenVPN/tun.c:3321: undefined reference to `get_netsh_id'
tun.o(.stab+0x110b4):G:/MingW32/src/inet/OpenVPN/tun.c:3321: 
undefined reference to `get_netsh_id'

Line 3321 has no reference to get_netsh_id(). And what is this ".stab" section
doing there?

Seems gcc has problems with prototypes at > 1 scope. Moving the protype to
file-scope or removing 'static' from the prototype and definition of get_netshid()
fixed it though. Anybody else seen this?

--gv



