Date: Wed, 14 Dec 2022 23:28:51 +0100 (CET)
Message-Id: <202212142228.2BEMSpw5066599@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221205164103.9190-5-kprovost@...2661...>
References: <20221205164103.9190-5-kprovost@...2661...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: cleanup FreeBSD
 dco_do_read()
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

Tested on FreeBSD with/without DCO, client/server, all works as before.

The formatting of the switch/case bits was not what uncrustify wanted
to see, so I've adjusted this (only indenting).  This makes "git show"
a bit hard to read, but "git show -w" shows that most of the patch
is very straightforward.

Your patch has been applied to the master and release/2.6 branch.

commit 235161cd2bcd5403c807e66432c421114c896b74 (master)
commit 67e7846134bd8119737c3f80d958f401b5128cef (release/2.6)
Author: Kristof Provost
Date:   Mon Dec 5 17:41:03 2022 +0100

     dco: cleanup FreeBSD dco_do_read()

     Signed-off-by: Kristof Provost <kprovost@...2661...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221205164103.9190-5-kprovost@...2661...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25616.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


