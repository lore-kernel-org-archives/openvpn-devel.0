Date: Mon, 4 Aug 2025 10:25:38 +0200 (CEST)
Message-Id: <202508040825.5748Pcl9006499@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250803150143.3878-1-gert@...1296...>
References: <20250803150143.3878-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Define a .clang-format file for
 the project
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

So, this is the beginning of the Grand Reformatting of 2025 - here are
the rules, that have been out for review for a long time, and all the
more active community members have either signalled "yeah, fine, I do not
care much either way" or "this is ok for me".

We move from uncrustify to clang-format, because uncrustify has become
a maintenance chore - newer versions break our formatting in interesting
ways, and pinning buildbots/GHA to old versions is nontrivial effort.

*This* does not change any formatting, nor does it auto-install any new
hooks.  More commits will follow.

Your patch has been applied to the master branch.

commit bba057b0573fa788e400a8490b5375153df87141
Author: Frank Lichtenheld
Date:   Sun Aug 3 17:01:37 2025 +0200

     Define a .clang-format file for the project

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250803150143.3878-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32484.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


