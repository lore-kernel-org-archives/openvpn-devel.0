Date: Sun, 6 Mar 2016 19:35:25 +0100 (CET)
Message-Id: <201603061835.u26IZP4a051479@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1456457091-3872-2-git-send-email-selva.nair@...277...>
References: <1456457091-3872-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add support for
	block-outside-dns through the interactive service
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

ACK.

The OpenVPN changes are fairly straightforward and fully in-line with 
the other service-using modules.  Same for the iservice changes - look
reasonable and are fully in-line with the the other function calls.

Again, I did not test, just stared at the code and did a test compile
(mingw 32bit on ubuntu 14.04) which worked.

Your patch has been applied to the master branch.

commit 2282b1be7968ef44accde705ccc64addab6d77ba
Author: Selva Nair
Date:   Thu Feb 25 22:24:51 2016 -0500

     Add support for block-outside-dns through the interactive service

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1456457091-3872-2-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11265
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


