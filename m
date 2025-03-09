Date: Sun, 9 Mar 2025 17:41:56 +0100 (CET)
Message-Id: <202503091641.529Gfup8053861@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250309153017.5163-1-gert@...1296...>
References: <20250309153017.5163-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: pass remoteaddr only for
 UDP peers
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Tested with and without DCO on Ubuntu 20.04.

Not tested on FreeBSD (no TCP support in DCO) or Windows (in this 
particular code path, it's a no-op call).

Your patch has been applied to the master branch.

commit 90d7881e32ec371874c020f756bd35d1959e9698
Author: Antonio Quartulli
Date:   Sun Mar 9 16:30:17 2025 +0100

     dco: pass remoteaddr only for UDP peers

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250309153017.5163-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31078.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


