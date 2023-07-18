Date: Tue, 18 Jul 2023 15:22:42 +0200 (CEST)
Message-Id: <202307181322.36IDMgD8014171@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230718105233.620193-1-frank@...2641...>
References: <20230718105233.620193-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: refactor mingw UTs and add
 missing tls_crypt
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

Tested in my GHA instance -> does the job, thanks.

(There is lots of individual results in the left column now, but as
long as it's all green, it does not really matter... as long as it's
not burning 10 times the credits now?)

Your patch has been applied to the master branch.

commit 26c663f12815f55c483dbe660e28448dc63221d1
Author: Frank Lichtenheld
Date:   Tue Jul 18 12:52:33 2023 +0200

     GHA: refactor mingw UTs and add missing tls_crypt

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20230718105233.620193-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26868.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


