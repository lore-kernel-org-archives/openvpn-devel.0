Date: Sun, 2 Jul 2023 10:34:31 +0200 (CEST)
Message-Id: <202307020834.3628YVHj031918@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230701202453.3517822-2-arne@...1227...>
References: <20230701202453.3517822-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid unused function
 warning/error on FreeBSD (and potientially others)
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

Acked-by: Gert Doering <gert@...1296...>

Checked route.c: is_on_link() shows up 4 times, Linux, WIN32 and 2x DARWIN,
so this should be fine.  Tested by pushing to buildbot and GHA.

Your patch has been applied to the master and release/2.6 branch.

commit 99035769233fb1186b72cd8e1e9966a0d077e53d (master)
commit 6cadac3cf86da918f1f83f77e9ab2129c7b60954 (release/2.6)
Author: Arne Schwabe
Date:   Sat Jul 1 22:24:53 2023 +0200

     Avoid unused function warning/error on FreeBSD (and potientially others)

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230701202453.3517822-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26804.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


