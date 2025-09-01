Date: Mon, 1 Sep 2025 23:16:53 +0200 (CEST)
Message-Id: <202509012116.581LGr3O031700@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250901194531.13683-1-gert@...1296...>
References: <20250901194531.13683-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: forward: Make sure pip flags
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

One of the easy ones, again.  Well constrained numbers, and all users
already do "unsigned".  Tested by BB.

Your patch has been applied to the master branch.

commit 10476e240fcbaa1240ee04e2a6ae52a9cc0cea14
Author: Frank Lichtenheld
Date:   Mon Sep 1 21:45:25 2025 +0200

     forward: Make sure pip flags are treated as unsigned

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250901194531.13683-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32740.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


