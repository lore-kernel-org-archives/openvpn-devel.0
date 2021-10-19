Date: Tue, 19 Oct 2021 17:47:32 +0200 (CEST)
Message-Id: <202110191547.19JFlWPO091516@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019034118.28987-2-selva.nair@...277...>
References: <20211019034118.28987-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove error injection into
 OpenSSL from cryptoapi.c
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

I like patches that remove lots of #define s and makes the rest easier
to understand :-) - as for "does it work?", I leave that to Arne.  GH
at least tells me that it compiles fine.

Your patch has been applied to the master branch.

commit 6ad1fbce2bed1c5f8d2e29ab84f01b3939f8cca4
Author: Selva Nair
Date:   Mon Oct 18 23:41:17 2021 -0400

     Remove error injection into OpenSSL from cryptoapi.c

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20211019034118.28987-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22951.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


