Date: Fri, 19 May 2023 08:39:14 +0200 (CEST)
Message-Id: <202305190639.34J6dE65014988@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230518110058.1382-1-lstipakov@...277...>
References: <20230518110058.1382-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: support for --dev-node
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

Acked-by: Gert Doering <gert@...1296...>

The patch is actually quite trivial - just prevent the "if (dco)"
option checker from unsetting --dev-node...

I have not tested it beyond "stare-at-code" and "do a MinGW test compile".

Your patch has been applied to the master and release/2.6 branch.

commit c543cf464e97866e20345feb46c82752fedc9d71 (master)
commit ea9382d7b41849a92a9d18fa3f5420925277144e (release/2.6)
Author: Lev Stipakov
Date:   Thu May 18 14:00:58 2023 +0300

     dco-win: support for --dev-node

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230518110058.1382-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26702.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


