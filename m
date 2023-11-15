Date: Wed, 15 Nov 2023 15:45:18 +0100 (CET)
Message-Id: <202311151445.3AFEjICx099652@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231115120623.6442-1-gert@...1296...>
References: <20231115120623.6442-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make --dns options apply for
 tap-windows6 driver
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Haven't tested this for real, but it looks very reasonable.  Just inject
the proper flag on "--dns", the backend data structures are already
filled, we just didn't know that we should use them.

Sanity tested via GHA build.

Your patch has been applied to the master and release/2.6 branch 
(bugfix, --dns functionality not working right on Windows).

commit 60def50420b050e628f4388e3c9ff771eb70a549 (master)
commit 0acba3cc64064841224f7ea4484e4d9715a42897 (HEAD -> release/2.6)
Author: Lev Stipakov
Date:   Wed Nov 15 13:06:23 2023 +0100

     Make --dns options apply for tap-windows6 driver

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20231115120623.6442-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27402.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


