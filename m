Date: Fri, 22 Jul 2022 17:09:08 +0200 (CEST)
Message-Id: <202207221509.26MF98lA032041@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220722134902.22092-1-frank@...2641...>
References: <20220722134902.22092-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_client: Allow to force FAIL
 on prerequisite fails
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

"makes sense" - in a buildbot (or any other CI) environment, do not 
silently skip missing prereqs, but fail hard.

Tested with "make check" ;-) - with and without TCLIENT_SKIP_RC=1
and RUN_SUDO=doas / RUN_SUDO=false, etc.

Your patch has been applied to the master branch.

commit 79932b94513303567fdd5d1c4e0abb79e6642b6e
Author: Frank Lichtenheld
Date:   Fri Jul 22 15:49:02 2022 +0200

     t_client: Allow to force FAIL on prerequisite fails

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220722134902.22092-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24723.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


