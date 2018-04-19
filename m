Resent-Message-ID: <20180425061419.GP69387@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Thu, 19 Apr 2018 17:24:49 +0200 (CEST)
Message-Id: <201804191524.w3JFOnGd007014@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180414072617.25075-1-gert@...1296...>
References: <20180414072617.25075-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix potential double-free() in
 Interactive Service (CVE-2018-9336)
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

Your patch has been applied to the master and release/2.4 branch.

commit 1394192b210cb3c6624a7419bcf3ff966742e79b (master)
commit da242af8d3750a231bfd687d0a92cf2004dae988 (release/2.4)
Author: Gert Doering
Date:   Sat Apr 14 09:26:17 2018 +0200

     Fix potential double-free() in Interactive Service (CVE-2018-9336)

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20180414072617.25075-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20180414072617.25075-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


