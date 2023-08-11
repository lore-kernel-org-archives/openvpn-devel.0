Date: Fri, 11 Aug 2023 18:24:28 +0200 (CEST)
Message-Id: <202308111624.37BGOSrJ088694@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230802113149.36497-1-dazo+openvpn@...2108...>
References: <20230802113149.36497-1-dazo+openvpn@...2108...>
Subject: [Openvpn-devel] [PATCH applied] Re: ntlm: Clarify details on NTLM
 phase 3 decoding
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

No functional change, just clarifying "yes we know that this could
happen, but if it does, this is still well-defined".

Test compiled on Linux, just in case I overlooked something.

Your patch has been applied to the master and release/2.6 branch.

commit f19391139836aa07312cf5b3ebbd00941d22ddc7 (master)
commit 781fa8f200d0e3428a7e4da693707529eeaa66cc (release/2.6)
Author: David Sommerseth
Date:   Wed Aug 2 13:31:49 2023 +0200

     ntlm: Clarify details on NTLM phase 3 decoding

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230802113149.36497-1-dazo+openvpn@...2108...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26919.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


