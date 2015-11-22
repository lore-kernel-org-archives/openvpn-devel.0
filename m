Date: Sun, 22 Nov 2015 20:09:48 +0100 (CET)
Message-Id: <201511221909.tAMJ9m0j031189@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1447752827-16720-1-git-send-email-lstipakov@...277...>
References: <1447752827-16720-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Notify clients about server's
	exit/restart
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, and thanks for your patience and persistance

Since v4 is functionally the same as v3 (just a few #ifdef ENABLE_OCC
shuffled around, and different "adjacent" code due to rebasing), I've 
taken Arne's ACK as valid for v4, too - and add my own for the v3->v4
changes.

Your patch has been applied to the master branch.  

Awaiting the client-side patch now :-)  (and maybe something to make the
server block incoming reconnects while in shut-down phase, see Arne's
comment)

commit 8dd9ff8ca062de34bcd16e34847d106ee9b992ff (master)

Author: Lev Stipakov
Date:   Tue Nov 17 11:33:47 2015 +0200

     Notify clients about server's exit/restart

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1447752827-16720-1-git-send-email-lstipakov@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10515
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


