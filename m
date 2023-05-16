Date: Tue, 16 May 2023 12:23:45 +0200 (CEST)
Message-Id: <202305161023.34GANj2n046117@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230516093534.26384-1-frank@...2641...>
References: <20230516093534.26384-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: sample-plugins: Fix memleak in
 client-connect example plugin
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

I do not really think this is *necessary* (if malloc() fails for a
few bytes, how relevant are these free() calls, and how likely is that
the next malloc() inside OpenVPN will just make everything stop?) - but
it's good practice, and if it silences semi-irrelevant warnings, the
check tools can show us the *real* issues...

I have only test compiled the plugins, not actually run anything.

Your patch has been applied to the master and release/2.6 branch.

commit 2d36678a2be15f7c00a44354ab71e4521ee3a4f3 (master)
commit 13b8e155af702a25e86f20da694867c76c169673 (release/2.6)
Author: Frank Lichtenheld
Date:   Tue May 16 11:35:34 2023 +0200

     sample-plugins: Fix memleak in client-connect example plugin

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230516093534.26384-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26668.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


