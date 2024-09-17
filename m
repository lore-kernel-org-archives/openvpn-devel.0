Date: Tue, 17 Sep 2024 15:37:05 +0200 (CEST)
Message-Id: <202409171337.48HDb50b050265@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240917133253.19616-1-gert@...1296...>
References: <20240917133253.19616-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Handle libnl-genl
 and libcap-ng consistent with other libs
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

Tested on ubuntu 2004 which needs all these, looked at the resulting
Makefile.am/Makefile.in/Makefile and it works.

I do wonder why we double all these variables, though...

Your patch has been applied to the master branch.

commit b236261f9ce14bc9fffbb81c61938e0e24b200d6
Author: Frank Lichtenheld
Date:   Tue Sep 17 15:32:53 2024 +0200

     configure: Handle libnl-genl and libcap-ng consistent with other libs

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240917133253.19616-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29282.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


