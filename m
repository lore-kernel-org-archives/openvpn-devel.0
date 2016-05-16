Date: Mon, 16 May 2016 13:40:04 +0200 (CEST)
Message-Id: <201605161140.u4GBe4Mj030335@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1463185884-4355-2-git-send-email-selva.nair@...277...>
References: <1463185884-4355-2-git-send-email-selva.nair@...277...>
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

ACK, thanks for taking this on.

I've stared at the patch and compiled on MinGW - did not actually test
the suspend/resume/tap gone/address deletion fail situation (hard to
reproduce with my current test setups), but the code looks sane and it
compiles fine.

Your patch has been applied to the master branch.

commit e3420d5683ffcc4386f78485bae3288a48f5cc17 (master)
Author: Selva Nair
Date:   Fri May 13 20:31:24 2016 -0400

     Make error non-fatal while deleting address using netsh

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1463185884-4355-2-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11656
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


