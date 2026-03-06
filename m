Date: Fri, 6 Mar 2026 17:18:41 +0100 (CET)
Message-Id: <202603061618.626GIf3F008659@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260305084610.1038-1-gert@...1296...>
References: <20260305084610.1038-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Improve sanity
 check for addr_len in HandleWINSConfigMessage
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

Stared-at-code, reasonable change.  Make checks explicit.
Compiler happy, BB happy.  One #pragma gone, Gert happy.

Your patch has been applied to the master branch.

commit be26f9a28c38d9c190388d3922db79a3957bb74d
Author: Frank Lichtenheld
Date:   Thu Mar 5 09:46:04 2026 +0100

     openvpnserv: Improve sanity check for addr_len in HandleWINSConfigMessage

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1496
     Message-Id: <20260305084610.1038-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35923.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


