Date: Wed, 3 Jul 2013 21:22:45 +0200 (CEST)
Message-Id: <201307031922.r63JMjNE014729@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1372879030-10576-1-git-send-email-dazo@...384...>
References: <1372879030-10576-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH applied] Re: plugin: Extend the plug-in v3
	API to identify the SSL implementation used
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, as discussed on IRC in parallel.

Patch has been applied to the master and release/2.3 branches (as 
discussed in the context of earlier revisions - considered a bugfix 
for the new plugin v3 infrastructure introduced in 2.3.0, and bugfixes 
go into 2.3).

commit 587df08abda3c8f1f85ccdba4d8b82a736c11e2d (master)
commit 570da542877a1f42ed6549a6ca3f54df9ec53c1f (release/2.3)

Author: David Sommerseth
Date:   Wed Jul 3 21:17:10 2013 +0200

     plugin: Extend the plug-in v3 API to identify the SSL implementation used

     Signed-off-by: David Sommerseth <davids@...1347...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1372879030-10576-1-git-send-email-dazo@...384...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/7754
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


