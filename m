Date: Thu, 2 May 2024 17:15:16 +0200 (CEST)
Message-Id: <202405021515.442FFGQk090674@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240502095322.9433-1-gert@...1296...>
References: <20240502095322.9433-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix 'binary or' vs 'boolean or'
 related to server_bridge_proxy_dhcp
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Code looks good, old code happened to work but was "logically wrong",
so this is a reasonable fix.  As it's not really a *bug* I've kept it
to master.

Tested on the server test rig, for good measure, though that one
doesn't actually have a --server-bridge config - the TAP server test
uses VLANs and scripts to do IP-and-VLAN assignments... meh.

Your patch has been applied to the master branch.

commit 9d92221eb4e773cae913752af6d70082ae305fe8
Author: Frank Lichtenheld
Date:   Thu May 2 11:53:22 2024 +0200

     Fix 'binary or' vs 'boolean or' related to server_bridge_proxy_dhcp

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240502095322.9433-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28601.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


