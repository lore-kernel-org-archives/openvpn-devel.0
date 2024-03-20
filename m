Date: Wed, 20 Mar 2024 09:55:21 +0100 (CET)
Message-Id: <202403200855.42K8tLgh076939@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240320082000.284-2-lev@...515...>
References: <20240320082000.284-2-lev@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: interactive.c: Fix potential
 stack overflow issue
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Verified that this is the same conceptual patch as we have in master and
release/2.6, just the lines look a bit different because the 2.5 code is
different - the union has less members, and there is ring_buffer related
stuff in the context that was changed for 2.6

Test compiled on MinGW + GHA.

Your patch has been applied to the release/2.5 branch.

commit d29496cce2d91a74706e3d5e4c48773715b10812
Author: Lev Stipakov
Date:   Wed Mar 20 10:19:45 2024 +0200

     interactive.c: Fix potential stack overflow issue

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Heiko Hund <heiko@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240320082000.284-2-lev@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28433.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


