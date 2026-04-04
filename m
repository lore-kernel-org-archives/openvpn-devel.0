Date: Sat, 4 Apr 2026 17:51:28 +0200 (CEST)
Message-Id: <202604041551.634FpSNH070262@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260402121049.41102-1-frank@...2641...>
References: <20260402121049.41102-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL 4.0: Make X509 objects
 const
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

Most of these changes are easy enough (it really needs the comments to
explain why the cast :-) )

The second change in ssl_openssl.c looks a bit spurious, but then, not
overwriting our initial "xn" in the dup looks like good housekeeping...
- finding useful documentation about the functions involved is hard,
though.

Tested by pushing to GHA which builds with all these different library
versions...

Your patch has been applied to the master and release/2.7 branch
(long-term compat).

commit 9b663a08245d92527059c9681e9d429badd6cdef (master)
commit 120bc506b0c61f5353cacbcbdb4a371e0330eeb3 (release/2.7)
Author: Arne Schwabe
Date:   Thu Apr 2 14:10:49 2026 +0200

     OpenSSL 4.0: Make X509 objects const

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1596
     Message-Id: <20260402121049.41102-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36437.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


