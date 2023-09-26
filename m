Date: Tue, 26 Sep 2023 18:11:29 +0200 (CEST)
Message-Id: <202309261611.38QGBT1m038709@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230926095118.29924-1-frank@...2641...>
References: <20230926095118.29924-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove all traces of the
 previous MSVC build system
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

And gone with the wind... :-) - getting rid of these complicated .xml
files that we never managed to update on "there is a new source file!"
is a big win.

Tested via GH build (pass), local MinGW build (pass), and a linux
"make dist(check)", since this fixes a number of "make dist does not
include what it should" bugs.

The actual source code changes here are all 'get rid of the #ifdef
and #include "config-msvc.h"' - big win again.

Your patch has been applied to the release/2.6 branch.

commit f04ce77e8da54b6dbf3e016506b7ffdba0713004
Author: Frank Lichtenheld
Date:   Tue Sep 26 11:51:18 2023 +0200

     Remove all traces of the previous MSVC build system

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230926095118.29924-1-frank@...2641...>
     URL: https://www.mail-archive.com/search?l=mid&q=20230926095118.29924-1-frank@...2641...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


