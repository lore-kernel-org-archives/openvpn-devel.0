Date: Tue, 28 Jan 2025 20:05:59 +0100 (CET)
Message-Id: <202501281905.50SJ5xcC021448@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250128124026.108992-1-frank@...2641...>
References: <20250128124026.108992-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Haiku: Fix short interface path
 length
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
To: Alexander von Gluck <alex@...2837...>
Cc: openvpn-devel@lists.sourceforge.net

I'm not totally happy with another #ifdef added to that already-not-so-nice
#orgy, but I see no more elegant way.  One might consider to move the
#define IFNAMSIZ further up, and use it in the "iface[16]" definition
(getting rid of one #ifdef)...  but that's somewhat outside the scope
of this patch, so maybe I'll give it a go ;-)

Your patch has been applied to the master branch.

commit 34f302247c865827b7075422e32c272a203783cb
Author: Alexander von Gluck
Date:   Tue Jan 28 13:40:26 2025 +0100

     Haiku: Fix short interface path length

     Signed-off-by: Alexander von Gluck <alex@...2837...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20250128124026.108992-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30654.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


