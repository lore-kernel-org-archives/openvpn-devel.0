Date: Tue, 14 Jun 2016 22:31:56 +0200 (CEST)
Message-Id: <201606142031.u5EKVudV063510@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1465934403-22226-1-git-send-email-steffan@...1856...>
References: <1465934403-22226-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: don't set debug
	threshold if compiled without MBEDTLS_DEBUG_C
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

ACK.  An easy one for a change :-)

Your patch has been applied to the master branch.

commit b63f98633dbe2ca92cd43fc6f8597ab283a600bf
Author: Steffan Karger
Date:   Tue Jun 14 22:00:03 2016 +0200

     mbedtls: don't set debug threshold if compiled without MBEDTLS_DEBUG_C

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1465934403-22226-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11922
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


