Date: Sat, 3 Apr 2021 15:53:47 +0200 (CEST)
Message-Id: <202104031353.133DrlUn092398@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210403122444.17090-1-arne@...1227...>
References: <20210403122444.17090-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix async push broken after
 auth deferred refactor
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

Acked-by: Gert Doering <gert@...1296...>

Yeah, right.  Sorry for not noticing.  None of my current client tests
build with --enable-async-push, and the server testbed only does this
on other days (some of the build options are varied by day of the week), 
so I shouldn't have tested this on a Saturday...  "today is 
--enable-iproute2 day".

Anyway, the patch makes very obvious sense, and fixes the breakage
observed.

Your patch has been applied to the master branch.

commit 5ac8c3c7a2a761b8430ad2a494afcda8b48fca76
Author: Arne Schwabe
Date:   Sat Apr 3 14:24:44 2021 +0200

     Fix async push broken after auth deferred refactor

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210403122444.17090-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22007.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


