Date: Fri, 25 Jul 2025 21:51:57 +0200 (CEST)
Message-Id: <202507251951.56PJpvNv023245@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250725194147.17517-1-gert@...1296...>
References: <20250725194147.17517-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: add flag to print addresses in
 a consistent format during float
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

"Because it makes sense" - as agreed, this still distinguishes between
"v4 on a v6 socket" and "v4 on a v4 socket", because for troubleshooting
it can make a difference.  But having both old and new address printed
by the same function in the same format is definitely an improvement :-)

Tested v4 on a v4-only socket, v4+v6 on a dual-stack v6 socket, all looks
nice and consistent now.  Thanks.

Your patch has been applied to the master branch.

commit 7d5ec053f0f30c6cd27b60ed76859a09f6dbf5e4
Author: Ralf Lici
Date:   Fri Jul 25 21:41:39 2025 +0200

     add flag to print addresses in a consistent format during float

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250725194147.17517-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32345.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


