Date: Tue, 15 Sep 2020 09:02:30 +0200 (CEST)
Message-Id: <202009150702.08F72UNl084183@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1600126181-16364-1-git-send-email-selva.nair@...277...>
References: <1600126181-16364-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow --dhcp-option in config
 file when windows-driver is wintun
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.5 branch.

("Looks good to me" as well, Lev just beat me with testing and ACKing)

commit b8625abbd5be21a810b648058e6e411a7ff19702 (master)
commit 9fe13491de31fff127bdceb6026fc05732f7dfb3 (release/2.5)
Author: Selva Nair
Date:   Mon Sep 14 19:29:41 2020 -0400

     Allow --dhcp-option in config file when windows-driver is wintun

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <1600126181-16364-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21005.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


