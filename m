Date: Tue, 27 Jun 2023 20:35:33 +0200 (CEST)
Message-Id: <202306271835.35RIZX0m000071@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230620135310.94455-3-frank@...2641...>
References: <20230620135310.94455-3-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: CMake: Add complete MinGW and
 MSVC build
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

I have tested this by pushing to GHA (as there are quite significant
changes to build.yaml) - it seems to still pass, which is good :-)

I do wonder why all unit tests now produce differently-named .exe
files (packet_id_testdriver.exe -> test_packet_id.exe etc)?  Is this
a side effect of a new cmocka version, or...?

This patch also adds bundling of the CMake related files to tarballs
(which I missed in 1/5).  Good :-) - besides this, there should be no
change to "autoconf based building", and there are also no code changes.

Your patch has been applied to the master branch.

commit e8881ec6dd63bd80ce05202573eac54ab8657fcb
Author: Frank Lichtenheld
Date:   Tue Jun 20 15:53:07 2023 +0200

     CMake: Add complete MinGW and MSVC build

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230620135310.94455-3-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26754.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


