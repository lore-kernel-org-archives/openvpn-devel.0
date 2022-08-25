Date: Thu, 25 Aug 2022 22:16:36 +0200 (CEST)
Message-Id: <202208252016.27PKGaU0083663@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220825131449.260-1-lstipakov@...277...>
References: <20220825131449.260-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: implement ovpn-dco
 support in P2P Windows code path
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for the test reports.  I had stared-at-code in v102, and the
changes 102->105 are still fine with me.

I have subjected this to build tests on github (fine), and had my test
machinery chew on the linux and freebsd DCO and non-DCO builds very
thoroughly, as this touches "related" code paths.  Things definitely
look good now .-)

Your patch has been applied to the master branch.

commit 3adbc5c6a221f686764c0ff841daf1c95b90abcc
Author: Antonio Quartulli
Date:   Thu Aug 25 16:14:49 2022 +0300

     dco-win: implement ovpn-dco support in P2P Windows code path

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Lev Stipakov <lev@...515...>
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220825131449.260-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25108.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


