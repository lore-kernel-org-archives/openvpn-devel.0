Date: Sun, 14 Sep 2025 14:21:21 +0200 (CEST)
Message-Id: <202509141221.58ECLLXt086655@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250911201658.25736-1-gert@...1296...>
References: <20250911201658.25736-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_common: Make sure ssl flags
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

Code change looks reasonable, BBs agree that nothing got broken, and
MaxF ACKed it with actually understanding SSL stuff.  In it goes :-)

One (unsigned int) cast remains, but that's needed because TLS_VER_BAD
is actually "-1" - so "int ver" initially, and on no-error, cast to
unsigned.

URL references to sf.net + gerrit.

Your patch has been applied to the master branch.

commit dd20c79d9d5dc38370eb8c6d796a558a269705ba
Author: Frank Lichtenheld
Date:   Thu Sep 11 22:16:52 2025 +0200

     ssl_common: Make sure ssl flags are treated as unsigned

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: MaxF <max@...2606...>
     Message-Id: <20250911201658.25736-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59232184/
     URL: https://gerrit.openvpn.net/c/openvpn/+/1104
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


