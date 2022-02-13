Date: Sun, 13 Feb 2022 14:43:43 +0100 (CET)
Message-Id: <202202131343.21DDhhcG065976@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220210104445.16767-1-frank@...2641...>
References: <20220210104445.16767-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: doc/Makefile: rebuild rst docs
 if input files change
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

Taking David's ACK on the "master" patch, adding my own for "yes, it's
the same patch, just not caring about example-fingerprint.rst" (plus,
remove the stray 0-byte file we acquired on the way).

thanks.

Your patch has been applied to the release/2.5 branch.

commit 71f7d5f00546a5667bcb62f4139eaf9666f1445a
Author: Frank Lichtenheld
Date:   Thu Feb 10 11:44:45 2022 +0100

     doc/Makefile: rebuild rst docs if input files change

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220210104445.16767-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23747.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


