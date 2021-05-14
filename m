Date: Fri, 14 May 2021 16:09:53 +0200 (CEST)
Message-Id: <202105141409.14EE9rIE094253@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210512131511.1309914-8-arne@...1227...>
References: <20210512131511.1309914-8-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move utility function from
 win32.c to win32-util.c
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Looks reasonable, no code changes, just moves.

Subjected this to a "make distcheck" on linux (new files...), and to
an Ubuntu18/MinGW cross build.  Both passed.

Your patch has been applied to the master branch.

commit 5a571fb0f68ce6961cddfa495af2cedf3ee0e216
Author: Arne Schwabe
Date:   Wed May 12 15:15:09 2021 +0200

     Move utility function from win32.c to win32-util.c

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210512131511.1309914-8-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22348.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


