Date: Wed, 18 Oct 2023 12:37:41 +0200 (CEST)
Message-Id: <202310181037.39IAbfoc062827@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231009105336.34267-1-frank@...2641...>
References: <20231009105336.34267-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add warning if a p2p NCP client
 connects to a p2mp server
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Lightly tested on the regular server testbed - "normal" connections
work just fine, connections from a client without --client fail (as
expected), and the server logs

  2023-10-18 11:56:42 Note: peer reports running in P2P mode (no --pull/--clientoption). It will not negotiate ciphers with this server. Expect this connection to fail.

"old" P2P NCP mode still works just fine, with no spurious messages.

Your patch has been applied to the master and release/2.6 branch
(mini-feature with minimal impact, aid troubleshooting).

commit 2574ae5e6961ed5b39531a7f98e537f72f87bcfb (master)
commit 3985da96215b8107111d2c0a1cd810e86b210cd1 (release/2.6)
Author: Arne Schwabe
Date:   Mon Oct 9 12:53:36 2023 +0200

     Add warning if a p2p NCP client connects to a p2mp server

     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231009105336.34267-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27191.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


