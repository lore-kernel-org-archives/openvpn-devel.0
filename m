Date: Wed, 8 Oct 2025 15:32:16 +0200
Message-Id: <202510081332.598DWGQN023548@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251008131101.21498-1-gert@...1296...>
References: <20251008131101.21498-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: GHA: Run options_parse test for
 MinGW
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

Tested on my GH instance, does what it says.  Thanks.

Your patch has been applied to the master branch.

(I will push this together with the commit for gerrit #1256, no need
to trigger yet another 20 OpenBSD cmocka build fails)

commit cdbb3e4339f315b610cca95546c231c94363a4c9
Author: Frank Lichtenheld
Date:   Wed Oct 8 15:10:54 2025 +0200

     GHA: Run options_parse test for MinGW

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1257
     Message-Id: <20251008131101.21498-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59243956/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


