Date: Mon, 28 Jul 2025 13:00:09 +0200 (CEST)
Message-Id: <202507281100.56SB09aF047714@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250728104234.29797-1-gert@...1296...>
References: <20250728104234.29797-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: unit_tests/plugins/auth-pam:
 fix stdint.h related build error on fedora 42
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

It seems this would also affect feodora-42 on amd64, we just missed on
the "updates that bring in the breaking change" - but now we are prepared ;-)

Patch has been applied to the master branch.

commit 035d47e6d80996a4cde8af1b35f9ba40b676c825
Author: Gert Doering
Date:   Mon Jul 28 12:42:29 2025 +0200

     unit_tests/plugins/auth-pam: fix stdint.h related build error on fedora 42

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250728104234.29797-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32384.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


