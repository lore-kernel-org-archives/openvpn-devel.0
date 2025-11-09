Date: Sun, 9 Nov 2025 11:59:55 +0100 (CET)
Message-Id: <202511091059.5A9AxtQC084958@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251109084130.11463-1-gert@...1296...>
References: <20251109084130.11463-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_freebsd: implement
 dco_get_peer_stats()
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

Thanks for the review.

Re-Tested on FreeBSD 14.3 + DCO, still works :-)

Patch has been applied to the master branch.

commit ce99cd6cfc091e17701b471a88644cb45ab21681
Author: Gert Doering
Date:   Sun Nov 9 09:41:23 2025 +0100

     dco_freebsd: implement dco_get_peer_stats()

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Ralf Lici <ralf@...2726...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1350
     Message-Id: <20251109084130.11463-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34273.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


