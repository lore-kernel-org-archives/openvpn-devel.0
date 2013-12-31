Date: Tue, 31 Dec 2013 12:44:11 +0100
Message-Id: <201312311144.rBVBiBfk007747@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <52ADF633.8040003@...1856...>
References: <52ADF633.8040003@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use RSA_generate_key_ex()
	instead of deprecated, RSA_generate_key()
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

Your patch has been applied to the release/2.3 branch.

commit 8c5c58742c72fd20febace14047fbb0f54c2c421
Author: Steffan Karger
Date:   Sun Dec 15 19:34:27 2013 +0100

     Use RSA_generate_key_ex() instead of deprecated, RSA_generate_key()

     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <52ADF633.8040003@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8110
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


