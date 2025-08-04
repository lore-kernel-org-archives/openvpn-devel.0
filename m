Date: Mon, 4 Aug 2025 11:34:28 +0200 (CEST)
Message-Id: <202508040934.5749YSXm008852@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250804092739.16410-1-gert@...1296...>
References: <20250804092739.16410-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Update
 git-pre-commit-uncrustify.sh to handle clang-format
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

So this brings us a new pre-commit-hook that will (when installed!) look
at $ROOT/.clang-format and decide whether to run "clang-format" or
"uncrustify".  Which is important for people like me that have to
switch back and forth between branches with different formatting rules
(2.6 and earlier will stay on uncrustify, 2.7-ish and master-after-2.7
will have clang-format).

So, thanks for that.

(After the big reformatting, folks using this git-hook need to remember
to actually enable it with "dev-tools/git-pre-commit-format.sh install")

Your patch has been applied to the master branch.

commit d18f8e4e60aef5802006f7d33642b0cecbdfb255
Author: Frank Lichtenheld
Date:   Mon Aug 4 11:27:34 2025 +0200

     Update git-pre-commit-uncrustify.sh to handle clang-format

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250804092739.16410-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32497.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


