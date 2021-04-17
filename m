Date: Sat, 17 Apr 2021 11:47:07 +0200 (CEST)
Message-Id: <202104170947.13H9l78f000439@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210416133512.1176870-1-arne@...1227...>
References: <20210416133512.1176870-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Also restore/save
 route-gatreway options in reconnects
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

Acked-by: Gert Doering <gert@...1296...>

Stared-at-code (looks good) and subjected to the test rig that breaks
(server with topology subnet, pushing route-gateway, SIGUSR1, advance
to server that uses top net30, stuck route-gateway breaks route 
installation).  Good :-)

Backport to 2.5 was fairly trivial (rename pre_connect to pre_pull
and adjust indent) - tested there as well, fixes that as well.

Your patch has been applied to the master branch and release/2.5.

commit 57c8d220aab14b661bafd4fafc40c195326b8d8f (master)
commit 7b594d4980f696583397a3b87e5c928acba17081 (release/2.5)
Author: Arne Schwabe
Date:   Fri Apr 16 15:35:12 2021 +0200

     Also restore/save route-gateway options on SIGUSR1 reconnects

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210416133512.1176870-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22132.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


