Date: Wed, 29 Jan 2025 20:26:38 +0100 (CET)
Message-Id: <202501291926.50TJQcBl072173@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250129173007.3280-1-gert@...1296...>
References: <20250129173007.3280-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: options: add IPv4 support to
 '--show-gateway <arg>'
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

As the commit message states, there is not much meat behind this option
yet - it's there to help testing the coming implementations.  Lev tested
this against his windows implementations, and we spent quite some time
argueing host byte order, network byte order, and overall confusion on
things memory ;-) (none of which plagues IPv6, if I may say so).  Thanks.

Patch has been applied to the master branch.

commit 9df51cf56e27f6103ed5becbafd1f645726d9155
Author: Gert Doering
Date:   Wed Jan 29 18:30:07 2025 +0100

     options: add IPv4 support to '--show-gateway <arg>'

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20250129173007.3280-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30728.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


