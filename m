Date: Sat, 11 Oct 2025 10:40:43 +0200 (CEST)
Message-Id: <202510110840.59B8ehHr015079@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251011082232.27602-1-gert@...1296...>
References: <20251011082232.27602-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dhcp: Replace DHCP Option types
 with defines
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

"Because it makes sense".  Magic numbers are never good.

Verified that the new constants match the old magic number (not checked
the RFC, but "the old numbers" are what we had, so those should be fine).

Your patch has been applied to the master branch.

commit e03d53842b5494d8caf19fc47ea788a32a3544c7
Author: Frank Lichtenheld
Date:   Sat Oct 11 10:22:26 2025 +0200

     dhcp: Replace DHCP Option types with defines

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1266
     Message-Id: <20251011082232.27602-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59245241/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


