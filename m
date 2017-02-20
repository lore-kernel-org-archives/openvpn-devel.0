Date: Mon, 20 Feb 2017 13:31:27 +0100 (CET)
Message-Id: <201702201231.v1KCVRAD009713@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1484428589-7882-1-git-send-email-selva.nair@...277...>
References: <1484428589-7882-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix user's group membership
	check in interactive service to work with domains
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

ACK, based on "according to MSDN documentation these are the correct
functions and are called properly", and on the test results in #810.

I have only compile tested this (which succeeds).

Your patch has been applied to the master and release/2.4 branch.

commit e82733a1ab78062feca28578fe505b275a2356a6 (master)
commit a9743bf25e661d66ca7537adfe457e75afc947c4 (release/2.4)
Author: Selva Nair
Date:   Sat Jan 14 16:16:29 2017 -0500

     Fix user's group membership check in interactive service to work with domains

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1484428589-7882-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13877.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


