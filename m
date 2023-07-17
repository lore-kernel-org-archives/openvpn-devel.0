Date: Mon, 17 Jul 2023 20:44:39 +0200 (CEST)
Message-Id: <202307171844.36HIidLA093430@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230712095529.570306-1-arne@...1227...>
References: <20230712095529.570306-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Check if the -wrap argument is
 actually supported by the platform's ld
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

Tested with GHA mingw/msvc builds, and the resulting unit test runs - all
looks green.

(As a side note, we *build* test_tls_crypt on Windows now, but the GHA
"mingw unittests" runs do not seem to run it yet -> patch to build.yaml
missing?)

Your patch has been applied to the master branch.

commit 4ef76f0ee4e122dcd616e1b1e2d652562ab10756
Author: Arne Schwabe
Date:   Wed Jul 12 11:55:29 2023 +0200

     Check if the -wrap argument is actually supported by the platform's ld

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20230712095529.570306-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26850.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


