Date: Tue, 7 Jun 2016 23:01:57 +0200 (CEST)
Message-Id: <201606072101.u57L1vqK037126@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1465274660-11009-2-git-send-email-selva.nair@...277...>
References: <1465274660-11009-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ignore SIGUSR1/SIGHUP during
	exit notification
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Stared at the code, and managed to reproduce the race by pressing ctrl-c
at exactly the right spot (shortly before the "pull-filter reject" would
trigger a SIGUSR1) and saw my ctrl-c being ignored - with the patch, things
work as expected:

Tue Jun  7 23:00:08 2016 us=714409 Ignoring SIGUSR1 received during exit notification


As we have discussed, this is not "the perfect solution" yet, but I think
it solves the "large" race condition (during the explicit-exit-notify 
time window) without making code elsewhere even more complicated.  We
should continue working on this, though, and eventually get rid of this
workaround again :-)

As this is bugfix it goes into release/2.3.

Your patch has been applied to the master and release/2.3 branch.

commit 63b3e000c9141f4ca03a374354da26334257bc18 (master)
commit 859c9f412455665635964519f3e44a0b4151a787 (release/2.3)
Author: Selva Nair
Date:   Tue Jun 7 00:44:20 2016 -0400

     Ignore SIGUSR1/SIGHUP during exit notification

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1465274660-11009-2-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11814
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


