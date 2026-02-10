Date: Tue, 10 Feb 2026 16:28:24 +0100 (CET)
Message-Id: <202602101528.61AFSOED031350@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260210152035.1273-1-gert@...1296...>
References: <20260210152035.1273-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: crypto: Do not claim we will
 remove support for BF-CBC in 2.7
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

Arguably we didn't... so this makes sense, and it makes sense to have it
in 2.7.0.  The change is 1 digit in a string, so the risk of introducing
breakage is very low.

Your patch has been applied to the master branch.

commit f6004dc45e686fd2f0d9b5f9ffd342dfa85543f9
Author: Frank Lichtenheld
Date:   Tue Feb 10 16:20:30 2026 +0100

     crypto: Do not claim we will remove support for BF-CBC in 2.7

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1511
     Message-Id: <20260210152035.1273-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35565.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


