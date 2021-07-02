Date: Fri, 2 Jul 2021 14:15:28 +0200 (CEST)
Message-Id: <202107021215.162CFS9k049661@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210630185134.144826-1-openvpn@...2080...>
References: <20210630185134.144826-1-openvpn@...2080...>
Subject: [Openvpn-devel] [PATCH applied] Re: doc: Use generic rules for
 man/html generation
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Tested on:
  - Linux, with docutils, including "make distcheck" + tarball check
  - FreeBSD 12, with no docutils, "make" succeeds, "distcheck" fails (ok)
  - FreeBSD 13, with docutils, including "make distcheck"

Your patch has been applied to the master and release/2.5 branch 
(no code change, eases our future maintenance).

commit 37cf98fa224a2ae5fc5cfa380bdb291e90d6413d (master)
commit 18211f1ba3124bde05ca11c5111989acdb27f957 (release/2.5)
Author: David Sommerseth
Date:   Wed Jun 30 20:51:34 2021 +0200

     doc: Use generic rules for man/html generation

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210630185134.144826-1-openvpn@...2080...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22604.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


