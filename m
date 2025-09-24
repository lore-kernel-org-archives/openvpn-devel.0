Date: Wed, 24 Sep 2025 22:35:11 +0200 (CEST)
Message-Id: <202509242035.58OKZBMw088552@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250924201601.25304-1-gert@...1296...>
References: <20250924201601.25304-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Validate DNS parameters
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

This fixes a security issue that has been the "master" branch for a few
months (not in any released 2.5 or 2.6 version), including 2.7_beta1.

To exploit this, a client needs to be using --dns-updown on an unix OS,
and needs to connect to a server that presents a trusted certificate
and then sends a PUSH_REPLY with malicious intent.

Alternatively, if the client is on Windows, you need to run openvpn.exe
without using the interactive service (because the unsave powershell
call only happens in the "fallback" code in openvpn itself). The
problematic code in windows is much more recent (replacement of wmic.exe
with powershell), but the fix is the same - sanitize input data.

In other words: do not use a "devel" OpenVPN with --dns-updown without
this patch, do not run a recent openvpn.exe without iservice, unless
you trust the server operator.

The actual validation code is the same as in 2.6 in commit 6c3afe508b15,
so it has already been tested quite a bit (the CVE is only in master).

Thanks to Stanislav Fort <disclosure@...2935...> for reporting this to
security@...2830...  CVE 2025-10680 has been assigned to track and
document this.

Your patch has been applied to the master branch.

commit 3a66045b407321c9d1c096227db164df3955ab40
Author: Lev Stipakov
Date:   Wed Sep 24 22:15:56 2025 +0200

     Validate DNS parameters

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1213
     Message-Id: <20250924201601.25304-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59238367/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


