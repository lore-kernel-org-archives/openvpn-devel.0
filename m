Date: Sat, 2 Dec 2023 17:02:35 +0100 (CET)
Message-Id: <202312021602.3B2G2Zwd085549@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231128103740.61160-1-frank@...2641...>
References: <20231128103740.61160-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure.ac: Remove unused
 AC_TYPE_SIGNAL macro
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

"makes sense" :-) - removing cruft from autoconf, and so on.

Your patch has been applied to the master branch and release/2.6
(long-term compat).

commit be05b590e8d5edebd8e35d97af34b0ba7e5350e6 (master)
commit 64703e72df371dabecc8ab83a19621fd9f27c56b (release/2.6)
Author: Frank Lichtenheld
Date:   Tue Nov 28 11:37:40 2023 +0100

     configure.ac: Remove unused AC_TYPE_SIGNAL macro

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20231128103740.61160-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27572.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


