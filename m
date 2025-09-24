Date: Wed, 24 Sep 2025 14:39:32 +0200 (CEST)
Message-Id: <202509241239.58OCdWSn064539@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250924081811.22859-1-gert@...1296...>
References: <20250924081811.22859-1-gert@...1296...>
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
testbeds either.


Your patch has been applied to the master branch.

commit 13a156a694573c9edb342b4af36976bceeb4aca2 (master)
Author: Frank Lichtenheld
Date:   Wed Sep 24 10:18:05 2025 +0200

     Enable -Wconversion -Wno-sign-conversion by default

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1168
     Message-Id: <20250924081811.22859-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59237916/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


