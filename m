Date: Mon, 22 Sep 2025 10:49:39 +0200 (CEST)
Message-Id: <202509220849.58M8ndEs060261@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250922080305.18477-1-gert@...1296...>
References: <20250922080305.18477-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix t_net.sh /
 networking_testdriver after 'broadcast' change
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Now this was actually tested and verified on a Linux system with "sitnl"
backend, and t_net.sh passes again... thanks Antonio for the quick +2.

Your patch has been applied to the master and release/2.6 branch.

commit 2bb658c826b19cba830328fd8ed8580838e51d5f (master) 
commit fb9a6808c10f773348e8818d28622dc8898560b3 (release/2.6)
Author: Gert Doering
Date:   Mon Sep 22 10:02:59 2025 +0200

     Fix t_net.sh / networking_testdriver after 'broadcast' change

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <antonio@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1203
     Message-Id: <20250922080305.18477-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59236810/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


