Date: Sun, 5 Jun 2016 19:13:17 +0200 (CEST)
Message-Id: <201606051713.u55HDH0D060672@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1465070945-5426-1-git-send-email-selva.nair@...277...>
References: <1465070945-5426-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Set WFP engine handle to NULL
	in win_wfp_uninit()
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

ACK, making engine state explicit is good style - and it protects against
crashes if calling win_wfp_uninit() twice without opening it in between
again.

Your patch has been applied to the master branch.

commit 895d75cf99bf8f3b95b01d6e19df30208cec27a9
Author: Selva Nair
Date:   Sat Jun 4 16:09:05 2016 -0400

     Set WFP engine handle to NULL in win_wfp_uninit()

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1465070945-5426-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11789
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


