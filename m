Date: Wed, 25 Sep 2024 18:36:26 +0200 (CEST)
Message-Id: <202409251636.48PGaQ88048804@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240925151342.13307-1-gert@...1296...>
References: <20240925151342.13307-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix check for CMake not
 detecting struct cmsg
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

Haven't tested this beyond "buildbot says it's fine" :-) - and have 
changed the Subject: line as suggested.

Your patch has been applied to the master branch.

commit f77f298979851687ab8fe3948b82cfac27c95cf8
Author: Arne Schwabe
Date:   Wed Sep 25 17:13:42 2024 +0200

     Fix check for CMake not detecting struct cmsg

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20240925151342.13307-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29448.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


