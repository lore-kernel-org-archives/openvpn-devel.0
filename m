Date: Sun, 31 Aug 2025 18:27:06 +0200 (CEST)
Message-Id: <202508311627.57VGR6pq073446@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250831155939.29240-1-gert@...1296...>
References: <20250831155939.29240-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Create socket_util with
 non-socket functions
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

Decluttering socket.c is a good thing (and introducing a unit test in
#1160 quite welcome).  Stared at the change with "git show --color-moved"
and it's quite clear that this is only moves, no code change - and the
BBs confirm that it still compiles and passes all relevant tests.

Pushed to GHA for good measure (all green).

Your patch has been applied to the master branch.

commit cdd61ffbccfcc81b560d2bec54c9a431ab6a025a
Author: Frank Lichtenheld
Date:   Sun Aug 31 17:59:32 2025 +0200

     socket: Create socket_util with non-socket functions

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250831155939.29240-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32727.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


