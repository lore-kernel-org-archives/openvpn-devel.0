Date: Sat, 31 May 2025 22:42:14 +0200 (CEST)
Message-Id: <202505312042.54VKgE5O078686@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250531203546.26593-1-gert@...1296...>
References: <20250531203546.26593-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Update copyright statements to
 2025
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

Verified that this, indeed, only changes lines with "Copyright" in 
them ("git show -I Copyright.*202[45]").  Interestingly multi_io.[ch]
sort of sidestepped the 2024 update :-) and ovpn_dco_win.h got stuck
in 2021...

Your patch has been applied to the master branch.

commit 022f0a438772f265b6416fa25282cfea74a49725
Author: Frank Lichtenheld
Date:   Sat May 31 22:35:39 2025 +0200

     Update copyright statements to 2025

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250531203546.26593-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31826.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


