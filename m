Date: Wed, 4 Mar 2026 17:20:39 +0100 (CET)
Message-Id: <202603041620.624GKdAc063730@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260302181627.29008-1-gert@...1296...>
References: <20260302181627.29008-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_ncp: Fix length check in
 mutate_ncp_cipher_list
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

"Makes sense, has an ACK from Arne, and BB confirms it's all green"...

(The inversion of the comparison confused me for a bit, but it also
says "fix an off-by-one", and indeed, that's what changes ;-) )

Your patch has been applied to the master branch.

commit 984bd3952e991f186bc51cfac3c15b9b56aa72b3
Author: Frank Lichtenheld
Date:   Mon Mar 2 19:16:22 2026 +0100

     ssl_ncp: Fix length check in mutate_ncp_cipher_list

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1503
     Message-Id: <20260302181627.29008-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35828.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


