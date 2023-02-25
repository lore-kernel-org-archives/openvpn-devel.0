Date: Sat, 25 Feb 2023 17:51:24 +0100 (CET)
Message-Id: <202302251651.31PGpOPL078159@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230203191440.136050-6-frank@...2641...>
References: <20230203191440.136050-6-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Windows: fix signedness errors
 with recv/send
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I'm not a big fan of adding (cast) to silence compiler warnings,
but this signed/unsigned char * nonsense is really hard to avoid -
casting to (void *) is the right fix here.

I have only test compiled on MinGW - and my MinGW did not warn
about these anyway (maybe not enough -Wthing switches).  But it 
did not break anything, and does not introduce new warnings.

Your patch has been applied to the master and release/2.6 branch.

commit 7acd93a6bef2dd9b660571c29b5f41c8ca351161 (master)
commit e9ae7cee2ca9b9ab78de01f1d3c562610e5624d2 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Feb 3 20:14:40 2023 +0100

     Windows: fix signedness errors with recv/send

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230203191440.136050-6-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26144.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


