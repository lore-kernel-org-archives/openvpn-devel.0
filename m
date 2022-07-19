Date: Tue, 19 Jul 2022 18:52:58 +0200 (CEST)
Message-Id: <202207191652.26JGqwBm040623@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220624083809.23487-17-a@...2181...>
References: <20220624083809.23487-17-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: GitHub Actions: add Linux DCO
 build (on Ubuntu 20.04)
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Indeed, this one is independent from the rest *and* the current tree
compiles fine with --enable-dco *and* we want to ensure it stays that
way :-) -> in it goes!

Your patch has been applied to the master branch.

commit d2b0c011300c66055764b8f43c272342d2b82584
Author: Antonio Quartulli
Date:   Fri Jun 24 10:38:00 2022 +0200

     GitHub Actions: add Linux DCO build (on Ubuntu 20.04)

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Message-Id: <20220624083809.23487-17-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24523.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


