Date: Fri, 17 Apr 2026 12:21:13 +0200 (CEST)
Message-Id: <202604171021.63HALDEn000348@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260416174142.28918-1-gert@...1296...>
References: <20260416174142.28918-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: ssl_openssl: Fix some CRL mixups
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
To: David Benjamin <davidben@...410...>
Cc: openvpn-devel@lists.sourceforge.net

So, finally.  Thanks for helping us fix our OpenSSL interfacing code :-)

It took a bit, because of this and that, and releases getting in the
way, and then finding a second pair of eyes to review the adjustments
Arne did.  But now we have nice code that makes buildbot and my local
tests happy (which do not use CRLs... but that should be somewhat
easy to add to the CI testing - create a dedicated client cert that
is then revoked right away, file that under "must fail" t_client tests).

Your patch has been applied to the master and release/2.7 branch
(long-term compat with OpenSSL 4.0).

I'm not sure about 2.6 - it's not a "hard bug" as the existing code
sort-of-works, and 2.6 will never see OpenSSL 4.0 compat fixes now
that 2.7 is the main release under maintenance.  So I went for "not
needed, and only real bugfixes go to 2.6 now".  Further, it wouldn't
work as is anyway (gerrit 1431 is not in 2.6)...

commit 2befad4de1b4da3c06c5fb3537a767ac1d058eb3 (master)
commit 0588668f4d12f6a1b87f1cf94f4d8ee96cadbf26 (release/2.7)
Author: David Benjamin
Date:   Thu Apr 16 19:41:35 2026 +0200

     ssl_openssl: Fix some CRL mixups

     Signed-off-by: David Benjamin <davidben@...410...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: MaxF <max@...2606...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1289
     Message-Id: <20260416174142.28918-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36641.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


