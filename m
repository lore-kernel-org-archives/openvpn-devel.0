Date: Mon, 21 Nov 2016 17:18:32 +0100 (CET)
Message-Id: <201611211618.uALGIWgC023644@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1479676734-21630-1-git-send-email-selva.nair@...277...>
References: <1479676734-21630-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not set ipv6 address if
	'--ip-win32 manual' is used
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

This solves the issue at hand for the time being, without breaking
people's configs by removing "ip-win32 manual", and without changing
expectations "how things work on Windows".  

For 2.5, we should look at removing the "ip-win32 manual" code path (and 
maybe map it in the other direction, setting "--ifconfig_nexec" instead)

Your patch has been applied to the master branch.

(It does not apply cleanly to release/2.3 as the surrounding code is too 
different - the actual change is trivially adjusted, but I think it should 
see review - thus, not doing on-the-fly here)

commit d6ad8cac443f7f7540da595a3dbe7082d0f0a0cf (master)
Author: Selva Nair
Date:   Sun Nov 20 16:18:54 2016 -0500

     Do not set ipv6 address if '--ip-win32 manual' is used

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1479676734-21630-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13143.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


