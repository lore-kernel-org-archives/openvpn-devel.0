Date: Fri, 14 May 2021 15:10:23 +0200 (CEST)
Message-Id: <202105141310.14EDANj1093449@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210512131511.1309914-7-arne@...1227...>
References: <20210512131511.1309914-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add noreturn attribute for MSVC
 to assert_failed method.
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

I can't claim to understand the MSVC intricacies, but the explanation
is good, and it shouldn't break non-MSVC compiles.  The dangling ";" 
after an #endif is truly OpenVPN-style ugly, though...  we avoid
it elsewhere by defining

  #define __attribute__(x)

for MSVC builds, but error.h is special... the code would benefit from
a comment, though.

Your patch has been applied to the master branch.

commit ad2140e0337f99c183e732b61df03ae29bdec766
Author: Arne Schwabe
Date:   Wed May 12 15:15:08 2021 +0200

     Add noreturn attribute for MSVC to assert_failed method.

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210512131511.1309914-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22344.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


