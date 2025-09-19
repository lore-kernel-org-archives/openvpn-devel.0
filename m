Date: Fri, 19 Sep 2025 14:32:56 +0200 (CEST)
Message-Id: <202509191232.58JCWu79024935@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250919112424.24728-1-gert@...1296...>
References: <20250919112424.24728-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: fix building of
 openvpnsrvmsg.dll from eventmsg.mc in mingw builds
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

As discussed in Gerrit, this might not be the most beautiful construct,
but it works for cmake+mingw and for in- and out-of-tree autoconf+mingw
builds - and this is all it needs to do (and unlike v1, it does not 
break "non WIN32" builds ;-) ).

I have tested this by building on an ubuntu 2204 and copying openvpnserv.exe
and openvpnservmsg.exe to a Win10 machine "that had never seen the new
event log code",  registered the DLL, and event log works.  Yay.

Lev has tested the cmake+mingw builds (and the cmake+MSVC builds, of
course, that were also broken in v3).

Your patch has been applied to the master and release/2.6 branch
(necessary to enable mingw building of 2.6 again).

commit 744a2bd556833cf5e65d737e1bcffd2cb89a6d2f (master)
commit 9d89e750d3e07b401e042b5456dec5d1187e346f (release/2.6)
Author: Gert Doering
Date:   Fri Sep 19 13:24:19 2025 +0200

     fix building of openvpnsrvmsg.dll from eventmsg.mc in mingw builds

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1197
     Message-Id: <20250919112424.24728-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33083.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


