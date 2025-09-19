Date: Fri, 19 Sep 2025 16:51:16 +0200 (CEST)
Message-Id: <202509191451.58JEpGgY030033@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250917170428.3310-1-gert@...1296...>
References: <20250917170428.3310-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Introduce msglvl_t to unify
 msglevel type handling
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

Huge patch, small actual change - turning all "int" msglevel uses (except
one) into "unsigned int".  To make this somewhat nicer to the eye, hide
"unsiged int" in "msglvl_t" (also this makes it very clear what type
a "msglevel" is supposed to have).

Stared long and hard at the diff, fed to GHA and t_server testbed for
"ok, so what did I overlook?" testing.  All green.

Your patch has been applied to the master branch.

commit cc8cd311749dc90bb056cfedd9129677090bc7b0
Author: Frank Lichtenheld
Date:   Wed Sep 17 19:04:19 2025 +0200

     Introduce msglvl_t to unify msglevel type handling

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1110
     Message-Id: <20250917170428.3310-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33028.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


