Date: Wed, 21 Nov 2018 10:34:43 +0100 (CET)
Message-Id: <201811210934.wAL9YhYM092344@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1541757573-30178-1-git-send-email-lstipakov@...277...>
References: <1541757573-30178-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove extra token after #endif
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks.

Regarding Christian's comment about "#endif" vs. "#endif /* ENABLE_CRYPTO /*"
- well, we have both in our tree, so neither is "correct" or "wrong".

For such a short #ifdef/#endif span, I'd see it as optional because the
corresponding #ifdef is easily spotted.  For something spanning more
code, possibly nested #ifdef, a comment after the #endif would definitely
be better, though.

Your patch has been applied to the release/2.4 branch.

commit ca962f3837ab05b0e8a4382960391f289497eaa2
Author: Lev Stipakov
Date:   Fri Nov 9 11:59:33 2018 +0200

     Remove extra token after #endif

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1541757573-30178-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17883.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


