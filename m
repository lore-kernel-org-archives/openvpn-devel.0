Date: Sun, 13 Dec 2015 22:00:34 +0100 (CET)
Message-Id: <201512132100.tBDL0Ywm007645@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1449780695-3879-1-git-send-email-iam@...2070...>
References: <1449780695-3879-1-git-send-email-iam@...2070...>
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

ACK.  Lots of people have reviewed this, and it made the patch better :-)
- so I list them all, and take the final blame (ACK) on me...

Your patch has been applied to the release/2.3 branch.

commit dd628d2e0d786e478fd99d54000dceaa42d53855 (release/2.3)
Author: ValdikSS
Date:   Thu Dec 10 23:51:35 2015 +0300

     Add Windows DNS Leak fix using WFP ('block-outside-dns')

     Reviewed-by: Selva Nair <selva.nair@...277...>
     Reviewed-by: Lev Stipakov <lstipakov@...277...>
     Reviewed-by: James Yonan <james@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1449780695-3879-1-git-send-email-iam@...2070...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10743
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


