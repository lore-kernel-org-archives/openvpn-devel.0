Date: Tue, 2 Sep 2025 16:56:28 +0200 (CEST)
Message-Id: <202509021456.582EuSBt066769@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250902122542.31023-1-gert@...1296...>
References: <20250902122542.31023-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: add support for
 multipeer stats
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

I have not actually tested this - just test compiled (ubuntu 22, mingw),
and stared long and hard at the change ("makes sense").  Someone should
test this with an "OpenVPN Server on Windows" setup, with _beta1 or so
(Samuli? ;-) ).

I have fixed a word in an error message ("returnted" -> "returned"), as
agreed beforehand on IRC.

Your patch has been applied to the master branch.

commit 6d450085c6a66d0c9e59eafddb83759166fb48c7
Author: Lev Stipakov
Date:   Tue Sep 2 14:25:36 2025 +0200

     dco-win: add support for multipeer stats

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250902122542.31023-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32744.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


