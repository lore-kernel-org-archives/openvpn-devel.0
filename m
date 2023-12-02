Date: Sat, 2 Dec 2023 15:12:43 +0100 (CET)
Message-Id: <202312021412.3B2ECh3P071641@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231201123649.18127-1-frank@...2641...>
References: <20231201123649.18127-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: clean up libressl builds
 with newer libressl
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

Your patch has been applied to the master and release/2.6 branch.

Tested in my local GH repo, and only the expected failures (ASAN) were
seen.

commit 664dde85be91a5432efe52c90089fcf2bf5d6a3c (master)
commit 1a6aef37781975ea9cc18dde6083ebb2683e6251 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Dec 1 13:36:49 2023 +0100

     GHA: clean up libressl builds with newer libressl

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20231201123649.18127-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27635.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


