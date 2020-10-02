Date: Fri, 2 Oct 2020 21:33:08 +0200 (CEST)
Message-Id: <202010021933.092JX8FB099292@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200924091004.29065-1-themiron@...2010...>
References: <20200924091004.29065-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH applied] Re: Selectively reformat too long
 lines
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
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.5 branch.

I am not particularily happy about merging this sort of "cleanup"
patch so late before 2.5 release - *but* I have very carefully
checked that it's really all just re-wrapping long function
calls, or long text strings, so the danger to 2.5 stability is
minimal.  OTOH, not merging this to release/2.5 means more work
for all future bugfixes that happen to be close enough to one
of these changes so the "diff context" is changed.  So, in it
goes.

As a side note - but too late to stop it, as Arne and Antonio
have spoken - I do not think this sort of change is actually
making the code *more* readable:

-        msg(M_WARN, "DEPRECATED OPTION: --inetd mode is deprecated "
-            "and will be removed in OpenVPN 2.6");
+        msg(M_WARN,
+            "DEPRECATED OPTION: --inetd mode is deprecated and will be removed "
+            "in OpenVPN 2.6");

it's basically making 3 lines out of two, while the text still needs 
to be wrapped.  So instead of "two lengthy" lines, we now have "one
very short line, one very long line, and one short line again" - I find
that *less* readable, and since the old code conformed to the 80 character
limit, it's commit noise which makes "git blame" harder to follow, with
questionable benefit.

We need to cover this in the style guide, to make clear which variant
is preferred (if the text fits into one line if putting it onto its
own line, this is a different story).


commit a5409c0d34bf02cacdee61d61ba7b3e1f72e132f (master)
commit c055e28654f340c617a2b0eece7fa28c79c1a9fc (release/2.5)
Author: Vladislav Grishenko
Date:   Thu Sep 24 14:10:04 2020 +0500

     Selectively reformat too long lines

     Signed-off-by: Vladislav Grishenko <themiron@...2010...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200924091004.29065-1-themiron@...2010...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21083.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


