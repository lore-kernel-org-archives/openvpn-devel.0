Date: Wed, 21 Feb 2018 19:04:25 +0100 (CET)
Message-Id: <201802211804.w1LI4PZA085714@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1519231562-5641-1-git-send-email-selva.nair@...277...>
References: <1519231562-5641-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Disable external ec key support
 when building with libressl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
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

Acked-by: Gert Doering <gert@...1296...>

Tested on the OpenBSD 6.0 buildslave that was failing previously, and
things are happy now (did not test "FreeBSD + LibreSSL", that's a 
different issue which we might want to fix, but since it's not the
default SSL library there, it's not as annoying as OpenBSD breakage.
FTR, OpenBSD 6.0 has LibreSSL 2.4.2, so that could explain the 
difference...).

Your patch has been applied to the master branch.

commit 028b501734b4a57dc53edb8b11a4b370f5b99e38
Author: Selva Nair
Date:   Wed Feb 21 11:46:02 2018 -0500

     Disable external ec key support when building with libressl

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1519231562-5641-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16510.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


