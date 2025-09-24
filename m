Date: Wed, 24 Sep 2025 14:39:36 +0200 (CEST)
Message-Id: <202509241239.58OCdaBQ064544@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250924122755.14391-1-gert@...1296...>
References: <20250924122755.14391-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Enable -Wconversion
 -Wno-sign-conversion by default
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

This patch does not change any code - it just turns on extra -Warnings,
and then turns them off again on a section-by-section basis with pragmas.

We discussed this in the community meeting, and the intent is

 - we can turn on -Werror with these warnings enabled
 - all *new* code that gets written and violates -Wconversion can be
   fixed on day 1

if we just turn on the warnings today, without -Werror, it's "500 lines"
that nobody looks at - so a new warning won't be noticed.  If we do not
turn on the warnings, nobody will see...

And yes, this is quite a bit future work to get rid of the pragmas again,
by fixing one source file after the other, or one group of warnings
(less-than-well defined API calls, like the "msglevel" thing).


I have stared at the patch, it is long, but does not do anything more
than push/pop "ignore -Wconversion warnings" (magic), and then enable
them globally.  BB and GHA say that this does not break any of our
testbeds either (v13 *did* break two special cases, namely LibreSSL
builds on macOS and pkcs11-helper builds - the former has been postponed
and a #pragma added, the second one has been fixed as it's only in
the unit test code).

Your patch has been applied to the master branch.

commit 3ac840942b54b7159d993c86842efa16a9abbd98
Author: Frank Lichtenheld
Date:   Wed Sep 24 14:27:47 2025 +0200

     Enable -Wconversion -Wno-sign-conversion by default

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1168
     Message-Id: <20250924122755.14391-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33181.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


