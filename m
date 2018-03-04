Date: Sun, 4 Mar 2018 10:04:16 +0100 (CET)
Message-Id: <201803040904.w2494GP6033148@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1519936484-26102-1-git-send-email-selva.nair@...277...>
References: <1519936484-26102-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Delete the IPv6 route to the
 connected network on tun close
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

Acked-by: Gert Doering <gert@...1296...>

Test compiled, not actually run - but "stare at code" is convincing enough.

Your patch has been applied to the master and release/2.4 branch.

commit b607900ba937b5f45796d2e3810ef91a32826927 (master)
commit 716fdb24be7857e242c3174a51485446502481ea (release/2.4)
Author: Selva Nair
Date:   Thu Mar 1 15:34:44 2018 -0500

     Delete the IPv6 route to the connected network on tun close

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1519936484-26102-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16598.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


