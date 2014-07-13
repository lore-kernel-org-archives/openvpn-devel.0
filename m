Date: Sun, 13 Jul 2014 13:44:47 +0200 (CEST)
Message-Id: <201407131144.s6DBilad001906@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <53C251E2.7050605@...1856...>
References: <53C251E2.7050605@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Define dummy SSL_OP_NO_TICKET
	flag if not present in OpenSSL.
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

ACK.  RHEL5 is still supported, and with the additional background, this
is good enough.

Your patch has been applied to the master branch.

commit 97bd862ed5c22956cb4405eabae64cf55cabb0d3

Author: Steffan Karger
Date:   Sun Jul 13 11:26:32 2014 +0200

     Define dummy SSL_OP_NO_TICKET flag if not present in OpenSSL.

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <53C251E2.7050605@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8902
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


