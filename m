Date: Thu, 29 Jan 2026 18:39:46 +0100 (CET)
Message-Id: <202601291739.60THdkib064544@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260128150640.13867-1-gert@...1296...>
References: <20260128150640.13867-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: tunnel_server_*(): close
 correct inotify fd
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

As it says on the lid, this is a backport of the master commit to multi.c,
to the "until 2.6" source files for separate UDP and TCP servers, mudp.c
and mtcp.c.  Verified with "run server, look at lsof -P -p $pid, send
SIGUSR1, look at lsof again" (and see the FD 0 now change roles).

..
openvpn 4513 root   0u     IPv4 61650705      0t0     UDP *:31194 
openvpn 4513 root   5r  a_inode     0,12        0    2066 inotify
openvpn 4513 root   6r  a_inode     0,12        0    2066 inotify
..

Patch has been applied to the release/2.6 and release/2.5 branches.

(It would apply and bugfix release/2.4 as well, but this is *so* out
of maintenance that I did do this.  2.3.x does not have inotify
support yet)

commit 172fe07129f02be2d3e6779c632ed1e8081c412c (release/2.6)
commit 477775b032c2c47322d1453bdfff11b607fbac91 (release/2.5)
Author: Gert Doering
Date:   Wed Jan 28 16:06:35 2026 +0100

     tunnel_server_*(): close correct inotify fd

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1499
     Message-Id: <20260128150640.13867-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35493.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


