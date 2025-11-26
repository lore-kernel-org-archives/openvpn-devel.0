Date: Wed, 26 Nov 2025 12:16:46 +0100 (CET)
Message-Id: <202511261116.5AQBGk6J026281@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251126104938.5612-1-gert@...1296...>
References: <20251126104938.5612-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: fix off by one error
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Looks reasonable, BB compiles.  Tests needed (and not really for this
particular case, but for a more generic function "copy buffer list in
<format a> to a new buffer list in <format b>, with a skip list"
which would get used here... doing this in a single buffer just makes
everything much more complicated, for the gain of saving a single
malloc/free...).

Your patch has been applied to the master branch.

commit dc5baf8039b37095109f22632a2ca02da805b548
Author: Heiko Hund
Date:   Wed Nov 26 11:49:32 2025 +0100

     iservice: fix off by one error

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1395
     Message-Id: <20251126104938.5612-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34678.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


