Date: Fri, 6 Sep 2024 22:13:39 +0200 (CEST)
Message-Id: <202409062013.486KDdSM076066@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240906172112.87148-1-frank@...2641...>
References: <20240906172112.87148-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: configure: Allow to detect git
 checkout if .git is not a directory
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

Have done a bit of testing with "in-tree build, git", "out of tree build,
git" and "in-tree build, tarball" and it seems to always do the right
thing.  Haven't a need for git submodules, so I have not tested that.

Your patch has been applied to the master branch.

commit dac076fe406adace826766f6cc3cfdadc5f06be4
Author: Frank Lichtenheld
Date:   Fri Sep 6 19:21:12 2024 +0200

     configure: Allow to detect git checkout if .git is not a directory

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
     Message-Id: <20240906172112.87148-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29092.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


