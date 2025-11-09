Date: Sun, 9 Nov 2025 12:10:54 +0100 (CET)
Message-Id: <202511091110.5A9BAsDN085692@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251107174810.31851-1-gert@...1296...>
References: <20251107174810.31851-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_freebsd.c: fix integer
 warnings
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the review.  Re-Tested on FreeBSD 14.3, no other platforms
affected.

(... and with that ends my "write my own code" spree, and back to reviewing
and complaining about other people's code... ;-) )

Patch has been applied to the master branch.

commit 7e0b68aeeaebeed71b902299c436371ebc83170e
Author: Gert Doering
Date:   Fri Nov 7 18:48:05 2025 +0100

     dco_freebsd.c: fix integer warnings

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1361
     Message-Id: <20251107174810.31851-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34256.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


