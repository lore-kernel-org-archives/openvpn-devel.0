Date: Thu, 23 Jun 2016 13:48:39 +0200 (CEST)
Message-Id: <201606231148.u5NBmdxR005518@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1466132093-1178-1-git-send-email-selva.nair@...277...>
References: <1466132093-1178-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix management-external-cert
	option parsing error
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

ACK.  I wonder when this got broken, or whether it was never fully
implemented...

(I feel comfortable ACKing something "crypto-related" because it 
effectively isn't - it's option parsing, and validating combinations of
options that need to be "both there" or "both not there")

Your patch has been applied to the master branch.

commit d023fb661cca578dc977c9bd5e7d681de15e38a3
Author: Selva Nair
Date:   Thu Jun 16 22:54:53 2016 -0400

     Fix management-external-cert option parsing error

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1466132093-1178-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11929
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


