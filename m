Date: Thu, 4 Aug 2022 15:30:25 +0200 (CEST)
Message-Id: <202208041330.274DUPeo032611@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220804071401.12410-1-a@...2181...>
References: <20220804071401.12410-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: implement dco support for
 p2p/client code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

After all the preliminary infrastructure building, *this* is the beginning
of the real thing :-)

I have tested

 - full set of server side tests, without --enable-dco
   (this system does not have kernel DCO, so it does not matter)
   --> all works

 - full set of client side tests, with --enable-dco, but no kernel DCO
   ("existing setup")
   --> all works

 - full set of client side tests, with --enable-dco AND kernel DCO
   (wohoo!)
   --> some test instances disable DCO (like, SOCKS or HTTP proxy, or
       TAP mode), and the fallback works ("pings succeed")

	1b:openvpn.log  Note: --http-proxy disables data channel offload.
	1c:openvpn.log  Note: --http-proxy disables data channel offload.
	1d:openvpn.log  Note: --socks-proxy disables data channel offload.
	1e:openvpn.log  Note: --socks-proxy disables data channel offload.
	1z:openvpn.log  Note: Using compression disables data channel offload.
	2a:openvpn.log  Note: cipher 'BF-CBC' in --data-ciphers is not supported by ovpn-dco, disabling data channel offload.
	2d:openvpn.log  Note: --socks-proxy disables data channel offload.
	2e:openvpn.log  Note: --socks-proxy disables data channel offload.
	2z:openvpn.log  Note: Using compression disables data channel offload.
	3z:openvpn.log  Note: Using compression disables data channel offload.
	4:openvpn.log  Note: dev-type not tun, disabling data channel offload.
	4a:openvpn.log  Note: dev-type not tun, disabling data channel offload.
	4b:openvpn.log  Note: dev-type not tun, disabling data channel offload.
	6:openvpn.log  Note: --fragment disables data channel offloa .
	8:openvpn.log  Note: Using compression disables data channel offload.
	9:openvpn.log  Note: dev-type not tun, disabling data channel offload.
	23:openvpn.log  Note: --data-cipher-fallback with cipher 'BF-CBC' disables data channel offload.
	23a:openvpn.log  Note: Using compression disables data channel offload.
	23s:openvpn.log  Note: --data-cipher-fallback with cipher 'BF-CBC' disables data channel offload.
	24:openvpn.log  Note: Using compression disables data channel offload.
	24a:openvpn.log  Note: Using compression disables data channel offload.

   --> other instances claim to are using DCO ("ip -d link show"
       shows "ovpn-dco") *and* packets are moved, so I guess it's
       using DCO...

   these tests include "normal --client clients", "p2p --secret",
   "p2p --tls-secret", and "p2p --tls-secret with P2P NCP", using
   varying ciphers (-> BF-CBC/none forcing non-DCO, etc.)

	Test sets succeeded: 1 1a 1b 1c 1d 1e 1z 2 2a 2d 2e 2z 3 3z 4 4a 4b 5 6 8 9 23 23a 23s 24 24a.
	Test sets failed: 2b 2c 2f.

   The 3 failures (2b, 2c, 2f) are all "IPv6 UDP fragments" (ping -s 3000,
   encapsulated in IPv6 UDP), which needs closer investigation.  This works
   on a "--disable-dco" build, but the whole topic of UDP fragmentation
   is "outside OpenVPN", so this is not something a patch to OpenVPN
   can affect.  tcpdump on an intermediate host can see outgoing fragments
   in the DCO case, but no replies - different from the non-DCO case, so
   this is going to be an interesting root cause hunt...


 - I have not done performance tests, because the current test
   environment is not really suited for it yet (server instances
   are all non-DCO)


Plus, stared at the code and discussed with Antonio on IRC :-) - 
(especially the process_outgoing_link() change confused me a bit - the
obvious answer to this is "these are control channel packets, which are
still created by userland, but the design requires to avoid accessing
the socket directly, so send to DCO module, and that one forwards").

I removed one spurious blank line from dco_p2p_add_new_peer().

Your patch has been applied to the master branch.

commit b6f7b285767e66f5cbd3854cf0ff918e87b31202
Author: Antonio Quartulli
Date:   Thu Aug 4 09:14:01 2022 +0200

     dco: implement dco support for p2p/client code path

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220804071401.12410-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24798.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


