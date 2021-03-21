Date: Sun, 21 Mar 2021 18:05:19 +0100 (CET)
Message-Id: <202103211705.12LH5Jab075585@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210321144627.1621-3-simon@...2293...>
References: <20210321144627.1621-3-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: interactive.c: Resolve MSVC
 C4996 warning
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
To: Simon Rozman via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: openvpn-devel@lists.sourceforge.net

I seem to remember we had that discussion in the context of openpvpn-gui
already - Problems with the "POSIX compatible" function names, which end
up acting on narrow or wide strings depending on compiler settings, compiler
version, phase of the moon...  can't find that commit, but if MS docs says
"this is how windows code should look like", so be it...

I have test compiled stuff on Ubuntu 18 / MinGW, and it compiles.  Not tested.

Your patch has been applied to the master branch.

commit 709c3810a1d67e2c4049e852529a0a0d1338c797
Author: Simon Rozman via Openvpn-devel
Date:   Sun Mar 21 15:46:25 2021 +0100

     interactive.c: Resolve MSVC C4996 warning

     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20210321144627.1621-3-simon@...2293...>
     URL: https://www.mail-archive.com/search?l=mid&q=20210321144627.1621-3-simon@...2293...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


