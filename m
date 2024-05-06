Date: Mon, 6 May 2024 17:27:52 +0200 (CEST)
Message-Id: <202405061527.446FRqLl072618@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240506102710.8976-1-gert@...1296...>
References: <20240506102710.8976-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove openvpn_snprintf and
 similar functions
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

Stared a bit at the difference of v2 and v5 (windows pipe cast plus
clang pragma).  All the rest is identical to v2, and trivial in itself
("git show -w -I snprintf").

Self test passes, and compilation / GHA also passes.

I have adapted the "We know that the results truncated" comment
(added "will be") - I think that was in v2 already, or in Antonio's
comment on v2, but it's a comment, so no good in asking for a v6.

Your patch has been applied to the master branch.

commit 130548fe4d23afac5d2948d4e5ee164eef635cfd
Author: Arne Schwabe
Date:   Mon May 6 12:27:10 2024 +0200

     Remove openvpn_snprintf and similar functions

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240506102710.8976-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28617.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


