Date: Sat, 1 Jul 2023 22:15:22 +0200 (CEST)
Message-Id: <202307012015.361KFMAf019689@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230630123908.82588-1-frank@...2641...>
References: <20230630123908.82588-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_tls_crypt: Improve mock()
 usage to be more portable
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

I tried to read up what mock() and the rest of these functions do,
and it seems the necessary amount of coffee has worn out... but
anyway, you and Arne understand that stuff, it's testing code, and
it passes (Linux) "make check", so good enough.

Your patch has been applied to the master and release/2.6 branch.

commit e87e44f7bcdffc208292cce9d314e2e52a175026 (master)
commit 4f24f71f6a1f491fe404370707cc6a4f549fcab3 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Jun 30 14:39:08 2023 +0200

     test_tls_crypt: Improve mock() usage to be more portable

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230630123908.82588-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26796.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


