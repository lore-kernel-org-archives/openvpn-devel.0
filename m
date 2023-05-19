Date: Fri, 19 May 2023 08:31:32 +0200 (CEST)
Message-Id: <202305190631.34J6VWN7014740@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230518212139.1261-1-chipitsine@...277...>
References: <20230518212139.1261-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: src/openvpn/dco_freebsd.c:
 handle malloc failure
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
To: Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

As discussed.

Tested with a basic client run on FreeBSD14 with DCO.

Your patch has been applied to the master and release/2.6 branch.

commit 5e79aed439d4e1b101c768aabfd695cd1c0a54ce (master)
commit 73ce6ac984e3ab496f97979e41f2a27569a432fd (release/2.6)
Author: Ilya Shipitsin
Date:   Thu May 18 23:21:39 2023 +0200

     src/openvpn/dco_freebsd.c: handle malloc failure

     Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230518212139.1261-1-chipitsine@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26707.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


