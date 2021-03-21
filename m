Date: Sun, 21 Mar 2021 18:20:14 +0100 (CET)
Message-Id: <202103211720.12LHKEom075859@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210321144627.1621-5-simon@...2293...>
References: <20210321144627.1621-5-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: Resolve MSVC C4996
 warnings
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Tested on Ubuntu 18 / MinGW, compiles.

Checked with the MSVC documentation, seems to make sense :-) - I do notice
that we use wcscat_s() in one of these hunks, and _tcscat_s() in another,
which seems to be the same thing if _UNICODE is defined (which, I think
we do).  Maybe an opportunity for another round of cleanup - unify the
windows string functions used to "just one variant".

From: line fixed, so Author: is right for this commit.

Your patch has been applied to the master branch.

commit df471f4de8af0cbcf23a4e36910554bea7bd9058
Author: Simon Rozman
Date:   Sun Mar 21 15:46:27 2021 +0100

     iservice: Resolve MSVC C4996 warnings

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210321144627.1621-5-simon@...2293...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210321144627.1621-5-simon@...2293...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


