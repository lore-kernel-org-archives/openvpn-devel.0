Date: Sat, 31 May 2025 22:53:15 +0200 (CEST)
Message-Id: <202505312053.54VKrFhS079275@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250531204720.28156-1-gert@...1296...>
References: <20250531204720.28156-1-gert@...1296...>
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

This is a more proper version of the patch I quickly hacked into
the v2.7_alpha1 commit "to make it pass 'make distcheck'".  I rebased
so it would apply, and the resulting Makefile.am is what Arne had in
his patch.

(I fixed one "space + tab at the beginning of the line" whitespace error)

Tested with "make distcheck".  Passes :-)

Your patch has been applied to the master branch.

commit c2776ee0ff03832bb2213ebd19e9a14d37445bed
Author: Arne Schwabe
Date:   Sat May 31 22:47:14 2025 +0200

     Add missing header in unit tests Makefile.am

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250531204720.28156-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31830.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


