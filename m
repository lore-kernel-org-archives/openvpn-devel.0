Date: Fri, 26 Jun 2020 15:02:23 +0200 (CEST)
Message-Id: <202006261302.05QD2NZo004539@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200626125332.15385-1-arne@...1227...>
References: <20200626125332.15385-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Reformat files using uncrustify
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

Acked-by: Gert Doering <gert@...1296...>

Verified that this is all whitespace.  "The usual".  I'll add a new commit
to update .git-blame-ignore-revs with this commit (which needs to be an
extra commit, recursion for beginners :-))

Sorry for those that I caused or ACKed...

I left out the hunk to option.c since that was in "asymmetric compression v5"
already.

Your patch has been applied to the master branch.

commit c1ff8f247f91c88a2df5502eeedf42857f9a6831
Author: Arne Schwabe
Date:   Fri Jun 26 14:53:32 2020 +0200

     Reformat files using uncrustify

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200626125332.15385-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20142.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


