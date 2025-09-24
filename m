Date: Wed, 24 Sep 2025 17:05:56 +0200 (CEST)
Message-Id: <202509241505.58OF5uIN077894@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250924145715.28701-1-gert@...1296...>
References: <20250924145715.28701-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: event: Silence conversion
 warning in tv_to_ms_timeout
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

Trivial enough... and ACK from MaxF, so not testing anything beyond 
a quick local compile.

Your patch has been applied to the master branch.

commit da1d0064ae590213f0245125d6974850fecaa943
Author: Frank Lichtenheld
Date:   Wed Sep 24 16:57:09 2025 +0200

     event: Silence conversion warning in tv_to_ms_timeout

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: MaxF <max@...2606...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1178
     Message-Id: <20250924145715.28701-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33193.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


