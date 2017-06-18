Date: Sun, 18 Jun 2017 11:51:15 +0200 (CEST)
Message-Id: <201706180951.v5I9pF0l050883@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170618092244.8801-1-gert@...1296...>
References: <20170618092244.8801-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix edge case with clients
 failing to set up cipher on empty PUSH_REPLY.
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

Patch has been applied to the master and release/2.4 branch.

commit bd230079d98bfe6aec70b7aedefdffcdbd0e56da (master)
commit e82f7005256f77a63a3191ab7fef67e0cf0a9d02 (release/2.4)
Author: Gert Doering
Date:   Sun Jun 18 11:22:44 2017 +0200

     Fix edge case with clients failing to set up cipher on empty PUSH_REPLY.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <20170618092244.8801-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14856.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


