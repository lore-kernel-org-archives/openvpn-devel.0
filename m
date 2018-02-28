Date: Wed, 28 Feb 2018 18:17:19 +0100 (CET)
Message-Id: <201802281717.w1SHHJCT085808@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1519534935-16053-1-git-send-email-selva.nair@...277...>
References: <1519534935-16053-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support EC certificates with
 cryptoapicert
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

Compile-tested on OpenBSD 6.0 (no EC/LibreSSL hickup, good :-) ) and
mingw / ubuntu 16.04.  All well.

Your patch has been applied to the master branch.

(Is there a strong case for including it in 2.4?)

commit a6f38bafbbbd291d57ecb3610c2844e7f7e01412
Author: Selva Nair
Date:   Sun Feb 25 00:02:15 2018 -0500

     Support EC certificates with cryptoapicert

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1519534935-16053-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16553.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


