Date: Wed, 17 Jul 2024 22:04:49 +0200 (CEST)
Message-Id: <202407172004.46HK4n07089473@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240710160306.190351-1-frank@...2641...>
References: <20240710160306.190351-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Switch to C11 by
 default
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

As discussed before, this breaks OpenBSD 6.8 builds (and, generally,
other systems with very old compilers).  Not sure the benefit of getting
rid of a few hoops for anonymous unions is worth it, but then, it's not
like people on those systems couldn't just update...

Your patch has been applied to the master branch.

commit 37b696a207548df88fe65aa130fe6d522e7ce920 (master)
Author: Frank Lichtenheld
Date:   Wed Jul 10 18:03:06 2024 +0200

     configure: Switch to C11 by default

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240710160306.190351-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28916.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


