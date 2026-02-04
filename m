Date: Wed, 4 Feb 2026 17:24:23 +0100 (CET)
Message-Id: <202602041624.614GONf0002426@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260204161322.149284-1-frank@...2641...>
References: <20260204161322.149284-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add missing header in unit
 tests Makefile.am
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

Confirm, with this patch "make distcheck" actually works.  Sorry for
that, usually I test before everything I tag & ship, and we really need
to have this in the automated release process...

Your patch has been applied to the release/2.6 branch.

commit 09ea8ce4d80ba97ffd65eb9db010af377f947a69
Author: Arne Schwabe
Date:   Wed Feb 4 17:13:22 2026 +0100

     Add missing header in unit tests Makefile.am

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1509
     Message-Id: <20260204161322.149284-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35534.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


