Date: Tue, 21 Jul 2020 22:46:54 +0200 (CEST)
Message-Id: <202007212046.06LKksqb087913@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200721154922.17144-1-arne@...1227...>
References: <20200721154922.17144-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement tls-groups option to
 specify eliptic curves/groups
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

Your patch has been applied to the master branch.

I have not actually tested EC functionality in any way, just
made sure it compiles and passes basic (scripted) testing.

commit 8353ae8075fb25d1935258a2f007e024c5e2c43f
Author: Arne Schwabe
Date:   Tue Jul 21 17:49:22 2020 +0200

     Implement tls-groups option to specify eliptic curves/groups

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200721154922.17144-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20521.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


