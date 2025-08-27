Date: Wed, 27 Aug 2025 20:50:23 +0200 (CEST)
Message-Id: <202508271850.57RIoNK2014651@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250826183941.21338-1-gert@...1296...>
References: <20250826183941.21338-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: Make sure option types
 are treated as unsigned
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

This is actually an interesting one, where we have hit (1<<31) already...
and some of the OPT_P_* things are labeled /* TODO */ though long 
implemented... so there is more cleanup lurking.

For the patch at hand, the only thing where the "u" change might have an
effect is combinations with OPT_P_ROUTE_TABLE - but this was more at risk
beforehand (and did work).

Your patch has been applied to the master branch.

commit 487103a8ea67e4263b0d916029184ece30f44b56
Author: Frank Lichtenheld
Date:   Tue Aug 26 20:39:33 2025 +0200

     options: Make sure option types are treated as unsigned

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250826183941.21338-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32685.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


