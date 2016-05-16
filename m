Date: Mon, 16 May 2016 13:42:52 +0200 (CEST)
Message-Id: <201605161142.u4GBgquF030397@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1463185884-4355-1-git-send-email-selva.nair@...277...>
References: <1463185884-4355-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make error non-fatal while
	deleting address using netsh
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

The patch is effectively exactly the same changes as for master, but the
context is different enough (due to the XP-related stuff in 2.3) that I'm 
not sure if cherrypicking would work - so, just taking your 2.3 patch :-)

Your patch has been applied to the release/2.3 branch.

commit d368abbecf0a67ba5c29dec28fc724655629ef70 (release/2.3)
Author: Selva Nair
Date:   Fri May 13 20:31:23 2016 -0400

     Make error non-fatal while deleting address using netsh

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1463185884-4355-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11655
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


