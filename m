Date: Mon, 13 Mar 2023 17:55:00 +0100 (CET)
Message-Id: <202303131655.32DGt03g003870@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230309122332.92490-1-kprovost@...2661...>
References: <20230309122332.92490-1-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: print FreeBSD version
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
To: Kristof Provost <kp@...1376...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Tested on FreeBSD 14

  DCO version: FreeBSD 14.0-CURRENT #10 main-n259930-e898a3af97f9: Wed Jan  4 13:33:06 CET 2023     root@...2693...:/usr/obj/usr/src/amd64.amd64/sys/GENERIC

and on 12 (nothing, as expected).  Learned about $UNAME_v today :-)

I have added your s-o-b: line, and fixed one whitespace detail
uncrustify was complaining about.

Your patch has been applied to the master and release/2.6 branch.

commit fe0853d2e72dd3a639a95e420ad7eeed6b49e81b (master)
commit 5617f0f01837ffa01b81dfb2c5c7da8ee4c42072 (release/2.6)
Author: Kristof Provost
Date:   Thu Mar 9 13:23:32 2023 +0100

     dco: print FreeBSD version

     Signed-off-by: Kristof Provost <kp@...1376...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230309122332.92490-1-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26367.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


