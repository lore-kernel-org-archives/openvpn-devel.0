Date: Thu, 26 Mar 2026 15:10:42 +0100 (CET)
Message-Id: <202603261410.62QEAg10044436@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260322111207.8346-1-gert@...1296...>
References: <20260322111207.8346-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Do not support
 tls_ctx_set_cert_profile on AWS-LC
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

Yep, good catch - having non-working functionality that also causes compile
warnings is not desirable...

The patch itself is not big, but clang-format adjusted whitespace... and
because it's not intrusive, application to 2.7 makes sense.

Your patch has been applied to the master and release/2.7 branch.

commit 07954eea058996d753f7196859c25a0e076ef896 (master)
commit 4577a0dc21ddae9c7eaf269e91194ffdf2ab31b3 (release/2.7)
Author: Arne Schwabe
Date:   Sun Mar 22 12:12:01 2026 +0100

     Do not support tls_ctx_set_cert_profile on AWS-LC

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1579
     Message-Id: <20260322111207.8346-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36243.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


