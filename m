Date: Sat, 28 Jan 2023 19:55:26 +0100 (CET)
Message-Id: <202301281855.30SItQBc022056@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230127203208.305638-1-matthias.andree@...68...>
References: <20230127203208.305638-1-matthias.andree@...68...>
Subject: [Openvpn-devel] [PATCH applied] Re: make dist: Ship
 ovpn_dco_freebsd.h, too
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
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

To see the actual failure, one needs to build a tarball ("make dist"),
and from that tarball, compile with "configure --enable-dco", on FreeBSD
- so a pure "make distcheck" did not see it.  Apologies for that oversight.

Your patch has been applied to the master and release/2.6 branch.

commit ffcf20ca7070027ccb16c3697b2a0e263cbc78a4 (master)
commit 680ba43355f6d9e4dcdf6c6eb9ace09946dba8f3 (HEAD -> release/2.6)
Author: Matthias Andree
Date:   Fri Jan 27 21:32:08 2023 +0100

     make dist: Ship ovpn_dco_freebsd.h, too

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230127203208.305638-1-matthias.andree@...68...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26085.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


