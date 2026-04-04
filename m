Date: Sat, 4 Apr 2026 16:00:23 +0200 (CEST)
Message-Id: <202604041400.634E0NmX067862@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260404072336.30014-1-gert@...1296...>
References: <20260404072336.30014-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use ASN1_BIT_STRING_get_bit to
 check for netscape certificate usage
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

Fortunately I do not need to understand any of this netscape cert purpose
OpenSSL compat foo... but I do see an ACK from Frank, green builds in 
gerrit, and a localized change with good comment updates.

Mildly client-side tested on Linux, with OpenSSL 3.x.

As we agreed before, OpenSSL 4 compat is considered "long term compat"
so goes to 2.7 as well.

Your patch has been applied to the master and release/2.7 branch.

commit 8ce6f8d166acf02d6833b9f37fb5cd2ca903a4a5 (master)
commit 86d272cd6d30ece26e34482f9be02de6744e3694 (release/2.7)
Author: Arne Schwabe
Date:   Sat Apr 4 09:23:30 2026 +0200

     Use ASN1_BIT_STRING_get_bit to check for netscape certificate usage

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1587
     Message-Id: <20260404072336.30014-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36446.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


