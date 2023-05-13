Date: Sat, 13 May 2023 11:16:35 +0200 (CEST)
Message-Id: <202305130916.34D9GZav076155@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230512155023.444406-1-frank@...2641...>
References: <20230512155023.444406-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: properly close dco
 version file
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

Acked-by: Gert Doering <gert@...1296...>

"Obviously correct in hindsight"...  (there is other weirdness in
this function, like, "why use a struct buffer if all you want is 
a gc-allocated char[256]?", but that's for a different day to fix).

Have stared-at-code and test compiled on Linux.

Your patch has been applied to the master and release/2.6 branch.

commit cf496476b364f8613bacd48e10d6a1bbbf0aceda (master)
commit 26ea58f94ce10e108aa7c607b0a7dcb3419449fc (release/2.6)
Author: Frank Lichtenheld
Date:   Fri May 12 17:50:23 2023 +0200

     dco_linux: properly close dco version file

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230512155023.444406-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26650.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


