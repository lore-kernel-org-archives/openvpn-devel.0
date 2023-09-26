Date: Tue, 26 Sep 2023 17:55:02 +0200 (CEST)
Message-Id: <202309261555.38QFt2JO037241@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230926095030.29779-1-frank@...2641...>
References: <20230926095030.29779-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: CMake: backport CMake
 buildsystem from master to release/2.6
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

A quick review shows that this is really only "Windows buildsystem and
CMake" related stuff, no code changes - a number of "master" patches
squashed together (introducing new files, now we've ironed out the bugs
in master - let's not do the step-by-step thing here again, littel benefit
and just extra work for me).

If I read the "build.yaml" change right, we lose testing mingw+ossl 1.1.1q
in this change - OTOH, 1.1.1 is EOL, our official installers ship 3.0.x,
and other parts of the test matrix *do* test 1.1.1 - just not for windows
builds.  So, saving a few CPU cycles (good), no real loss here.

Tested local MinGW/autoconf build (still works fine) plus GHA build
("looks different, but all builders succeed").  Good enough.

Your patch has been applied to the release/2.6 branch.

commit 96ca5a5a2a0b278f6cc47199fc3311143fd9a6b7
Author: Frank Lichtenheld
Date:   Tue Sep 26 11:50:30 2023 +0200

     CMake: backport CMake buildsystem from master to release/2.6

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230926095030.29779-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27107.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


