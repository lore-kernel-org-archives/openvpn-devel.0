Date: Sat, 18 Apr 2026 20:32:26 +0200 (CEST)
Message-Id: <202604181832.63IIWQKZ032742@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260417164644.17897-1-gert@...1296...>
References: <20260417164644.17897-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: OpenSSL 4.0: Use
 X509_check_certificate_times instead of X509_cmp_time
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

So, for "non openssl 4.0" builds, this patch has no effect.  With 4.0, we
get compile warnings without this patch, and it compiles fine with it -
and for a profile I had around with an expired cert, it shows the expected
message.  All the error codes that are documented as possible return
values are handled, though I cannot test this (I guess you need to produce
a corrupt cert for two of them).

As for "add a default clause for yet-unknown error messages", we decided
against (because there are not really any other ways this could fail,
and even if, it's just a helper function to tell users that their 
certificate lifetime is in conflict with local date, which might or might
not lead to problems connecting).

Your patch has been applied to the master and release/2.7 branch.

commit 353ec724f9bc1dceb36760eceee0a128e140044c (master)
commit 8747fcf641214d4f05de53f9db825f396049e3d3 (release/2.7)
Author: Arne Schwabe
Date:   Fri Apr 17 18:46:38 2026 +0200

     OpenSSL 4.0: Use X509_check_certificate_times instead of X509_cmp_time

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1595
     Message-Id: <20260417164644.17897-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36651.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


