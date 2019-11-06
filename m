Date: Wed, 6 Nov 2019 21:41:25 +0100 (CET)
Message-Id: <201911062041.xA6KfP8R010468@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20191009143422.9419-3-a@...2181...>
References: <20191009143422.9419-3-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: VLAN: add basic VLAN tagging
 support
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

Stared at the code (twice now), run t_client and t_server tests.

This patch does not really *do* much yet, but it lays the groundwork
for future work - the "broadcast only to clients in the same vlan"
part is there, but it's always called with "0" (= all clients).  As
far as I can see, the only notable behavioural change we have so far 
is "if a client is assigned a pvid (!= the global pvid), it will not 
be able to communicate with the TAP interface" (check in vlan.c, 
vlan_process_outgoing_tun()), but client-to-client is still allowed,
and there is no per-vlan MAC learning yet either.

(Most notably, it only adds options and code relevant for TAP mode)

Your patch has been applied to the master branch.

commit 99f28081477ca325a14b13c38abec2c9b619eb01
Author: Antonio Quartulli
Date:   Wed Oct 9 16:34:15 2019 +0200

     VLAN: add basic VLAN tagging support

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20191009143422.9419-3-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18924.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


