Date: Fri, 13 Nov 2015 16:37:57 +0100 (CET)
Message-Id: <201511131537.tADFbvCh030931@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1447382487-26031-1-git-send-email-selva.nair@...277...>
References: <1447382487-26031-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not hard-code windows
	systemroot in env_block
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

ACK, and thanks again for cleaning up my sloppy code :-)

Your patch has been applied to the master and release/2.3 branch.

commit 7546cba4761b24f2195034dcd3407aecd43fd3be (master)
commit 9f87007d8997d8127b9ea5fb0cb6b6cb9c88a4f3 (release/2.3)

Author: Selva Nair
Date:   Thu Nov 12 21:41:27 2015 -0500

     Do not hard-code windows systemroot in env_block

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1447382487-26031-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10492
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


