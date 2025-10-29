Date: Wed, 29 Oct 2025 19:05:33 +0100 (CET)
Message-Id: <202510291805.59TI5XdN069993@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251029163849.446-1-gert@...1296...>
References: <20251029163849.446-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove --memstats feature
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

"Because it makes sense" :-) - if nobody uses this, and it has code that
is hard to make secure without knowing what "users could be doing", we
can just kick it out.  (Background: this was an OpenVPN AS internal
interface to query OpenVPN process utilization, which is no longer used
today).

Our buildbot went fishing, so I stared at the code for a bit, and then
pushed to GHA for a test compile.  All green.

Your patch has been applied to the master branch.

commit 70627949b5e77dfee14d778bd3988f04ce35cf2b
Author: Arne Schwabe
Date:   Wed Oct 29 17:38:43 2025 +0100

     Remove --memstats feature

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1329
     Message-Id: <20251029163849.446-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34021.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


