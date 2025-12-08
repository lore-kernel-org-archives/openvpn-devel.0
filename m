Date: Mon, 8 Dec 2025 20:28:37 +0100 (CET)
Message-Id: <202512081928.5B8JSbGw023165@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251208170320.4696-1-gert@...1296...>
References: <20251208170320.4696-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: socket: Initialize struct
 in_addr_t in getaddr()
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

This is somewhat of a silly-compiler-syndrome - especially since the 
last warning in this area was a true positive, now the addition of
the "if(ai)" clause - which has nothing whatsoever to do with the
return data or not - causes a warning (that we treat fatal) in mingw,
and only in the release builds...

But anyway, this is just a 32bit integer, not in the fast path, and
initializing things is generally a good idea :-)

Tested with the (upcoming) GHA mingw+release builds that reproduceably
fail without this change.

Your patch has been applied to the master branch.

commit e8dc7f35584df1f1cf920636cd5ac7232f0009a9
Author: Frank Lichtenheld
Date:   Mon Dec 8 18:03:13 2025 +0100

     socket: Initialize struct in_addr_t in getaddr()

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1420
     Message-Id: <20251208170320.4696-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34894.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


