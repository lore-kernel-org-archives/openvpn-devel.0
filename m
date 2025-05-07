Date: Wed, 7 May 2025 14:34:04 +0200 (CEST)
Message-Id: <202505071234.547CY4J5008611@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250507121226.13824-1-gert@...1296...>
References: <20250507121226.13824-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: CMake: Make sure to treat
 UNIT_TEST_SOURCEDIR as path
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

I have no idea what this is about :-) - but it's fixing build fails for
"we want to do automated tests on windows VMs via GHA", so this is
important.  No code change, only cmake build environment.

Your patch has been applied to the master branch.

commit b6af9b2841005cf139bf8d0c3ed40561903b59af
Author: Frank Lichtenheld
Date:   Wed May 7 14:12:20 2025 +0200

     CMake: Make sure to treat UNIT_TEST_SOURCEDIR as path

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20250507121226.13824-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31587.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


