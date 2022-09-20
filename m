Date: Tue, 20 Sep 2022 15:49:06 +0200 (CEST)
Message-Id: <202209201349.28KDn6HE052758@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220830104958.91-1-lstipakov@...277...>
References: <20220830104958.91-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-win: support for
 --persist-tun
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

As with everything related to DCO, I've fed this to the Linux and
FreeBSD DCO client/server testbeds (and it fails in the usual places,
with p2p DCO reconnection).  Haven't tested Windows -> thanks, Frank :-)

Stare-at-code wise, this is an interesting excercise in moving around
initializations, return types, etc. :-)

The code in init.c isn't exactly becoming easier to read over time, 
though... :-/

Your patch has been applied to the master branch.

commit cac18de7a1245918431d1677618a2f50dc79643f
Author: Lev Stipakov
Date:   Tue Aug 30 13:49:58 2022 +0300

     dco-win: support for --persist-tun

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220830104958.91-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25136.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


