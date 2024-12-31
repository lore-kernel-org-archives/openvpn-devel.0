Date: Tue, 31 Dec 2024 16:31:22 +0100 (CET)
Message-Id: <202412311531.4BVFVMuZ006215@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241231145417.12128-1-gert@...1296...>
References: <20241231145417.12128-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: simplify
 do_close_link_socket()
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Looks reasonable, does the same thing with less lines of code, adjusted
to multisocket.  Test compiled on ubuntu/mingw.

Your patch has been applied to the master branch.

commit 1452625bc364cb5847daedaad238c7a5eb3eff5e
Author: Lev Stipakov
Date:   Tue Dec 31 15:54:17 2024 +0100

     dco-win: simplify do_close_link_socket()

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241231145417.12128-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30328.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


