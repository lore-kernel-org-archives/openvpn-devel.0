Date: Fri, 26 Sep 2025 22:50:27 +0200 (CEST)
Message-Id: <202509262050.58QKoRnQ090736@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250924150300.29318-1-gert@...1296...>
References: <20250924150300.29318-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_openssl: Use uint16_t
 internally for TLS versions
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

Looked at this as well, makes sense, MaxF was faster with the +2 ;-)

Your patch has been applied to the master branch.

commit 04d24fbeb529991734cc0951037cd4a94376b025
Author: Frank Lichtenheld
Date:   Wed Sep 24 17:02:55 2025 +0200

     ssl_openssl: Use uint16_t internally for TLS versions

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: MaxF <max@...2606...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1212
     Message-Id: <20250924150300.29318-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59238230/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


