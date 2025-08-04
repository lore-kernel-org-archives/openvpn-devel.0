Date: Mon, 4 Aug 2025 21:42:03 +0200 (CEST)
Message-Id: <202508041942.574Jg3lS028670@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250804151853.10565-1-gert@...1296...>
References: <20250804151853.10565-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Reformat the whole project with
 clang-format
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

So this patch is huge, touches almost all files, and has the potential
to sneak in "innocent" changes - which is why we have the clang-format
rules published beforehand, so whoever wants can verify that this
patch is, indeed, only the result of clang-format (checkout the
commit before that, run "clang-format -i *.c *.h", then "diff" to
the files after this commit).

This said, I have pushed it to all test instruments we have, and
everything still compiles *and tests* fine.  Just to be sure.


It has a few ugly warts where the code "as it was before" did not
make it possible to apply the rules in a non-ugly way (like some
SetLastError() calls with long /* comments */ after them) - there will
be a few more commits coming that clean up these accidents, for example
by moving the comment before the line so it does not need wrapping.

Also, we'll change the setting of "ColumnLimit" to "0" in a subsequent
patch, as it turns out that the setting of "100" will also make 
clang-format un-wrap some multi-line statements in most interesting
ways - so these are better left to human common sense.  The limit we try
to achieve is still "80, if you can, 100, if wrapping at 80 would be more
ugly" (and we had heated discussions on which constructs are "ugly"...
as they say, the beauty lies in the eyes of the beholder).

For whatever reason, error.h, openvpnmsica.c and tapctl/main.c differ
here in function return type wrapping, but this will be addressed in
a followup patch.


Your patch has been applied to the master branch.

commit 3cca3367e6e0ffeccb8e39cb2c739d1dcb086701
Author: Frank Lichtenheld
Date:   Mon Aug 4 17:18:47 2025 +0200

     Reformat the whole project with clang-format

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250804151853.10565-1-gert@...1296...>
     URL: https://gerrit.openvpn.net/c/openvpn/+/791
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


