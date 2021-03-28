Date: Sun, 28 Mar 2021 16:38:19 +0200 (CEST)
Message-Id: <202103281438.12SEcJ17000855@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210328142038.8826-2-arne@...1227...>
References: <20210328142038.8826-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove support for non ISO C99
 vararg support
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

Taking Steffan's ACK on the v1, and mine on the single-line change in
v2 (which gets rid of these warnings).  Buildbot army tested v1, so
I'm reasonably sure nothing bad will happen on v2 either :-)

Your patch has been applied to the master branch.

commit f91e21163708b5dc01115806cb71643144d6c3d1
Author: Arne Schwabe
Date:   Sun Mar 28 16:20:38 2021 +0200

     Remove support for non ISO C99 vararg support

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan.karger@...2507...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210328142038.8826-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21883.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


