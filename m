Date: Tue, 26 Mar 2024 12:28:21 +0100 (CET)
Message-Id: <202403261128.42QBSLsd082161@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240326104101.531291-1-frank@...2641...>
References: <20240326104101.531291-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix snprintf/swnprintf related
 compiler warnings
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

Lightly stared at code and ran client side tests (that excercise proxy).

Your patch has been applied to the master branch.

commit 6889d9e2f1458272ded4c035df40378ace3d7395 (master)
Author: Arne Schwabe
Date:   Tue Mar 26 11:41:01 2024 +0100

     Fix snprintf/swnprintf related compiler warnings

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240326104101.531291-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28475.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


