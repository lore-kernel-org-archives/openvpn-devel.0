Date: Tue, 14 Nov 2023 16:07:55 +0100 (CET)
Message-Id: <202311141507.3AEF7tYa053759@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231114141653.10486-1-gert@...1296...>
References: <20231114141653.10486-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: config.h: fix incorrect defines
 for _wopen()
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

I've not actually tested it, but since we had to fix this once before,
it's "obviously correct".  Also Lev understands Windows :-)

Your patch has been applied to the master and release/2.6 branch.

commit 2fcfb77a8111cce9308bb893f52ecdb77de91e7c (master)
commit 0c174e4e7b6caa1111fbf4773acdfbbcf122489d (release/2.6)
Author: Lev Stipakov
Date:   Tue Nov 14 15:16:53 2023 +0100

     config.h: fix incorrect defines for _wopen()

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20231114141653.10486-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27393.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


