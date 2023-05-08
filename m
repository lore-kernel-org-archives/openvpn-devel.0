Date: Mon, 8 May 2023 14:11:11 +0200 (CEST)
Message-Id: <202305081211.348CBB43004596@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230418134941.86637-1-frank@...2641...>
References: <20230418134941.86637-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: tests: do not include
 t_client.sh in dist
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

Acked-by: Gert Doering <gert@...1296...>

t_client.sh is built according to configure findings for @SHELL etc.,
so no good packing it.

Verified that the tarball before/after only differs in "t_client.sh",
that "distcheck" still passes, and that "make check" on the resulting
tarball builds & runs a t_client.sh as expected.

Your patch has been applied to the master and release/2.6 branch.

commit d75a2dfc3e11daa1650f838517b610e6632d0445 (master)
commit 477e7f5e91bfc66214c8d5466b24a424e2b401f4 (release/2.6)
Author: Frank Lichtenheld
Date:   Tue Apr 18 15:49:41 2023 +0200

     tests: do not include t_client.sh in dist

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230418134941.86637-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26596.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


