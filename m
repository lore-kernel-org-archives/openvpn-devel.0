Date: Wed, 18 Oct 2023 19:46:44 +0200 (CEST)
Message-Id: <202310181746.39IHkiW3074551@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231008103415.19625-1-frank@...2641...>
References: <20231008103415.19625-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove last uses of inet_ntoa
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

I wouldn't claim to understand what management_post_tunnel_open() or
init_route() *does* here (why is it converting a numeric address back
to ascii, just to feed it to getaddrinfo() afterwards?), but the actual
code changes look reasonable.

Same for the "buffer" to "char *" changes, especially in print_in6_addr().

As this is "refactoring to appease compilers", and neither a bugfix nor
"real" compat stuff, it only goes to master.

Your patch has been applied to the master branch.

commit 7c637b35038e4cc7d2f16e07f413cfa2b0f1f97a
Author: Frank Lichtenheld
Date:   Sun Oct 8 12:34:15 2023 +0200

     Remove last uses of inet_ntoa

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20231008103415.19625-1-frank@...2641...>
     URL: https://www.mail-archive.com/search?l=mid&q=20231008103415.19625-1-frank@...2641...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


