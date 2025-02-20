Date: Thu, 20 Feb 2025 08:12:26 +0100 (CET)
Message-Id: <202502200712.51K7CQNS096706@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250219215417.18260-1-gert@...1296...>
References: <20250219215417.18260-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: multipeer support
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

So, finally, on v20 :-)

This has received quite a bit of stare-at-code review, and I also tested
this on a windows VM with a mingw-bult openvpn.exe, using Lev's most
recent DCO driver.  "It works, what shall I say" ;-)

#815 on itself works, but lacks --timeout handling - so if a client
disconnects (without sending EEN), kernel can not notify userland and
the peer will "stick".  #816 will add that functionality.  Nothing
will crash or misbehave in other ways, though.

NOTE: for server functionality, one needs to turn on IP forwarding on
the windows system ("as usual").  For IPv4 this is a registry key + reboot,
for IPv6 it's a magic netsh call (and no reboot, and after a reboot the
netsh setting seems to return to "disabled").  This is all a bit ugly, so
we need to see if we can make it better for the user (or at least have more
documentation in our shiny new wiki).

NOTE2: on commit, uncrustify complains about ovpn_dco_win.h - which I have
ignored, as this is "import an external .h file describing the API", as
for the Linux file.  dev-tools/special-files.list has the appropriate
exclude, but the commit-hook does not know that.

Your patch has been applied to the master branch.

commit 1625d927fc79e2926015ded06a01fd8e460a4bc7
Author: Lev Stipakov
Date:   Wed Feb 19 22:54:17 2025 +0100

     dco-win: multipeer support

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250219215417.18260-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30935.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


