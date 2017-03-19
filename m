Date: Sun, 19 Mar 2017 19:46:46 +0100 (CET)
Message-Id: <201703191846.v2JIkkLp043022@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20170225020229.17287-1-davids@...515...>
References: <20170225020229.17287-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: cleanup: Remove faulty env
	processing functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
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

ACK.

While I'm always cautious about "cleanups", this one is really 
straightforward :-) - unreferenced, not even from #if 0 testing code,
gone with the wind...

Your patch has been applied to the master and release/2.4 branch.

commit a87f119afcfcc1c855a6ea2ba3d765966f1f2591
commit 860d79bc4eadd934390829bee0de37e5ded8907a
Author: David Sommerseth
Date:   Sat Feb 25 03:02:29 2017 +0100

     cleanup: Remove faulty env processing functions

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20170225020229.17287-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14195.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


