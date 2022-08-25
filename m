Date: Thu, 25 Aug 2022 22:47:22 +0200 (CEST)
Message-Id: <202208252047.27PKlMQk084586@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220824165718.102002-1-arne@...1227...>
References: <20220824165718.102002-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix declaration of pubkeys in
 test_provider.c in MSVC builds
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

I have removed the godbolt reference, and fixed "declaration" :-) - the
godbolt thing is not truly relevant in git history, but can be found via
the URL: when going to the discussion (if someone is really interested)

Your patch has been applied to the master branch.

commit 7286a7e1a23146607ce94841afae8b1f4b75859e
Author: Arne Schwabe
Date:   Wed Aug 24 18:57:18 2022 +0200

     Fix declaration of pubkeys in test_provider.c in MSVC builds

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220824165718.102002-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25102.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


