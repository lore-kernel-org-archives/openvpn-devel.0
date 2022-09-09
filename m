Date: Fri, 9 Sep 2022 10:39:38 +0200 (CEST)
Message-Id: <202209090839.2898dc0P084561@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220905115639.379-1-lstipakov@...277...>
References: <20220905115639.379-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: msvc: remove .filters files
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

Acked-by: Gert Doering <gert@...1296...>

I have no idea what that stuff does, but it's not related to "openvpn code"
(obviously), and getting rid of files that are only there - and need to
maintained - for build functionality we do not use sounds like a good
idea.

I have not tested anything, just verified the correlation between
"Makefile.am" changes and ".filters removal"

Your patch has been applied to the master branch.

commit 25695c5537fa5464f49a809eae96d7de0d4ca33b
Author: Lev Stipakov
Date:   Mon Sep 5 14:56:39 2022 +0300

     msvc: remove .filters files

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220905115639.379-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25149.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


