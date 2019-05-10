Date: Fri, 10 May 2019 15:03:45 +0200 (CEST)
Message-Id: <201905101303.x4AD3j6e081933@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <E1hON0G-0007yB-3H@...2508...>
References: <E1hON0G-0007yB-3H@...2508...>
Subject: [Openvpn-devel] [PATCH applied] Re: tests: remove dependency on
 base64
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"Does what it says, and succeeds on FreeBSD 10+11" (and should succeed
everywhere that has a halfway posix compliant shell).  As a side note,
"dd if=$0 bs=732 count=1" should also work on all unix plattforms and is 
*much* more efficient :-) (but then, we have more important work than
making a developer test perfectly efficient).

Your patch has been applied to the master branch.

commit 90c61ef3df7255637cf84b6a23e51742954acde8
Author: Steffan Karger
Date:   Wed May 8 15:52:20 2019 +0200

     tests: remove dependency on base64

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <E1hON0G-0007yB-3H@...2508...>
     URL: https://www.mail-archive.com/search?l=mid&q=E1hON0G-0007yB-3H@...2508...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


