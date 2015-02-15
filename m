Date: Sun, 15 Feb 2015 21:16:53 +0100 (CET)
Message-Id: <201502152016.t1FKGrGQ026224@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1423390725-13438-1-git-send-email-gert@...1296...>
References: <1423390725-13438-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: New approach to handle peer-id
	related changes to link-mtu.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master branch.  

Release/2.3 needs a slightly different patch due to different buffer 
space reservation in the compression code (which means that the extra 
bytes we need are not there unless comp-lzo is used).

commit 9e0963c11aa439deb382d7d6bc40b6ade999401c (master)

Author: Gert Doering
Date:   Sun Feb 8 11:18:45 2015 +0100

     New approach to handle peer-id related changes to link-mtu.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1423390725-13438-1-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9450


--
kind regards,

Gert Doering


