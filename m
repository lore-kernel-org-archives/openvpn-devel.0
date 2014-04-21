Date: Mon, 21 Apr 2014 12:51:28 +0200 (CEST)
Message-Id: <201404211051.s3LApSPT004030@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <5354F0F2.5080200@...1856...>
References: <5354F0F2.5080200@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Update openvpn-plugin.h for
	PolarSSL 1.3.
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

ACK (as in "fixes the build for me".  None of the default plugins will
actually *use* this, and any plugin using x509 stuff would have to be
adapted to the 1.3 API - yes, this is the way it is)

Your patch has been applied to the master branch.

commit cc1cee74c683ce92e56bb6a6170988fb6520b803
Author: Steffan Karger
Date:   Mon Apr 21 11:52:51 2014 +0200

     Update openvpn-plugin.h for PolarSSL 1.3.

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <5354F0F2.5080200@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8567
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


