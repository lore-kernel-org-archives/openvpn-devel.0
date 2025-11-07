Date: Fri, 7 Nov 2025 17:31:59 +0100 (CET)
Message-Id: <202511071631.5A7GVxV5003208@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251107141333.12056-1-gert@...1296...>
References: <20251107141333.12056-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: FreeBSD DCO: repair incoming
 'delete peer' notifications in p2p client mode
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

Thanks for the review.  Tested on FreeBSD 14.3 with DCO.

As it says in the commit, we might want to make the other DCO backends
use "OVPN_CMD_NO_MESSAGE" as well, instead of "defaulting to 0", but
that's for another day.

Patch has been applied to the master branch.

commit c4fe7813d8b8eba99549a7b5e9499a31f91c8109
Author: Gert Doering
Date:   Fri Nov 7 15:13:27 2025 +0100

     FreeBSD DCO: repair incoming 'delete peer' notifications in p2p client mode

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1353
     Message-Id: <20251107141333.12056-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34237.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


