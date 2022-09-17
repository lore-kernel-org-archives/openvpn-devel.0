Date: Sat, 17 Sep 2022 13:54:22 +0200 (CEST)
Message-Id: <202209171154.28HBsMHE072314@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220915104028.188-1-lstipakov@...277...>
References: <20220915104028.188-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use DCO on Windows by default
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

"Anything that touches DCO" is suspect :-) - so I've submitted this
to Linux and FreeBSD DCO server tests, and everything passed (or,
precisely, only well-known problems failed).  Instances still use
DCO where they should.

The whole "msglevel" thing passed to functions like dco_available() might
need a bit of extra review when the dust has settled - is this still useful,
or do we (now) always pass the same thing anyway (since windows and M_USAGE
is gone now)?  dco_check_option() is called with D_DCO and D_MULTI_ERRORS,
but the call tree with dco_check_startup_option() is only called once...

The whole "--windows-driver" thing is also something we might want to
revisit.  It's quite a bit of code spilling to places that do not really
want to know (like, options.c)...

Nevertheless, this patch is doing quite a bit of good for removing #ifdef
relating to "DCO platforms", which is good :-)

Your patch has been applied to the master branch.

commit e9a156a160bb71e03ae03ba0bf4f31ced7282a13
Author: Lev Stipakov
Date:   Thu Sep 15 13:40:28 2022 +0300

     Use DCO on Windows by default

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220915104028.188-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25221.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


