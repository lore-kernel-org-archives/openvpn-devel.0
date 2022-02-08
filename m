Date: Tue, 8 Feb 2022 22:10:09 +0100 (CET)
Message-Id: <202202082110.218LA9Qq023411@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220208114905.100-1-lstipakov@...277...>
References: <20220208114905.100-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: msvc: cleanup
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

Have not tested anything, but it shouldn't break anything but MSVC
building, and that's your field of expertise anyway :) - Makefile.am
change to avoid breaking "make dist", thanks.

Your patch has been applied to the master branch.

commit ff5723c4ddfee28564500d28a1bd78766171ea3e
Author: Lev Stipakov
Date:   Tue Feb 8 13:49:05 2022 +0200

     msvc: cleanup

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220208114905.100-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23730.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


