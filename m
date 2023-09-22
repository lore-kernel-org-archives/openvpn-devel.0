Date: Fri, 22 Sep 2023 14:16:07 +0200 (CEST)
Message-Id: <202309221216.38MCG7Ed031800@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230922103900.37205-1-frank@...2641...>
References: <20230922103900.37205-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: CMake: fix HAVE_DAEMON
 detection on Linux
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

As discussed on IRC - the previous "cmake related" patch related to
"compat-daemon.c" was triggered by cmake not finding daemon() on Linux,
and this is fixing it.

Your patch has been applied to the master branch.

commit e363b393f2d1b72590666554e17d928c1603f8d5 (master)
Author: Lev Stipakov
Date:   Fri Sep 22 12:39:00 2023 +0200

     CMake: fix HAVE_DAEMON detection on Linux

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230922103900.37205-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27058.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


