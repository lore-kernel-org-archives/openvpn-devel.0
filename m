Date: Thu, 21 Apr 2022 10:12:48 +0200 (CEST)
Message-Id: <202204210812.23L8Cm2f055988@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220420233148.2384208-1-heiko@...2662...>
References: <20220420233148.2384208-1-heiko@...2662...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add git pre-commit hook script
 to uncrustify
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I've minimally tested this

 - clone the repo
 - run "sh dev-tools/git-pre-commit-uncrustify.sh install"
 - edit a file, introduce some of our typical things (tab, c++ comment)
 - try to commit, get a refusal message, with diff, plus pointer-to-patch
 - run "git apply $thatpatch"
 - errors fixed, commit applies

.. and it does exactly what it says on the lid.  Great stuff.

Your patch has been applied to the master branch.

commit 01424c932115a1b159f304e97a2dead254dc4c6d
Author: Heiko Hund
Date:   Thu Apr 21 01:31:48 2022 +0200

     Add git pre-commit hook script to uncrustify

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220420233148.2384208-1-heiko@...2662...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24124.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


