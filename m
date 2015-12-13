Date: Sun, 13 Dec 2015 22:04:10 +0100 (CET)
Message-Id: <201512132104.tBDL4ACI007670@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1449780715-4027-1-git-send-email-iam@...2070...>
References: <1449780715-4027-1-git-send-email-iam@...2070...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add Windows DNS Leak fix using
	WFP ('block-outside-dns')
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
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  I verified that this patch is identical to the 2.3 patch except
for the option check in options.c, and the #ifdef for VISTA+ - so same
ACK here, and same list of reviewers.  Thanks.

Your patch has been applied to the master branch.

commit 38c8565810f892a41a2ea0d18a707676119f1af0 (master)

Author: ValdikSS
Date:   Thu Dec 10 23:51:55 2015 +0300

     Add Windows DNS Leak fix using WFP ('block-outside-dns')

     Reviewed-by: Selva Nair <selva.nair@...277...>
     Reviewed-by: Lev Stipakov <lstipakov@...277...>
     Reviewed-by: James Yonan <james@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1449780715-4027-1-git-send-email-iam@...2070...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10744
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


