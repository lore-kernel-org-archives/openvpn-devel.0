Date: Fri, 23 Jan 2015 22:21:05 +0100 (CET)
Message-Id: <201501232121.t0NLL5Vj011735@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1422042761-10014-1-git-send-email-steffan@...1856...>
References: <1422042761-10014-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Account for peer-id in frame
	size calculation
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.3 branches.

While the conditions under which this can happen are rare today (git master
server, compression no or an uncompressible max-mtu packet sent from client
to server) it's severe enough to warrant a new 2.3 release.  I'll look
into this soonish, currently traveling.

commit f95010ad247a8998e0c39e394236251fca316849 (master)
commit 4ec70ca227370380011d072c09b739135e236183 (release/2.3)

Author: Steffan Karger
Date:   Fri Jan 23 20:52:41 2015 +0100

     Account for peer-id in frame size calculation

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <1422042761-10014-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9418
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


