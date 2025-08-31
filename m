Date: Sun, 31 Aug 2025 18:44:23 +0200 (CEST)
Message-Id: <202508311644.57VGiNEL074063@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250831151133.25684-1-gert@...1296...>
References: <20250831151133.25684-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add new unit test module
 test_socket
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

Unit tests are good, especially if an integer-related change to
one of the slightly more obscure functions is coming up :-) (and
indeed, this function was so much nicer when it still had 32-bit
additions...)

This patch does not add or change code in "openvpn itself", just
adds a unit test module, based on the new socket_util.c in the 
previous commit.  So not much to test, except look at BB (all green
in v4) and test on GHA (also all green).

Your patch has been applied to the master branch.

commit 10d64c184404c532fe0861d5c57fb1613a608d4c
Author: Frank Lichtenheld
Date:   Sun Aug 31 17:11:26 2025 +0200

     Add new unit test module test_socket

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250831151133.25684-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32723.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


