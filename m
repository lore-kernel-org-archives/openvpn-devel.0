Date: Tue, 23 Mar 2021 16:56:39 +0100 (CET)
Message-Id: <202103231556.12NFudJf059765@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210317160038.25828-3-arne@...1227...>
References: <20210317160038.25828-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Restore also ping related
 options on a reconnect
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

The patch is visually fine, and I was actually successfull in testing
pre/post behaviour.  As in: client with multiple <connection> blocks,
and using the management interface to make it connect to server A
("push ping, ping-restart") first, then server B ("do not push anything
ping-related").  Without the patch, the client would die with --ping-restart
timeout, with the patch it happily does "no ping restart".

It needs SIGUSR1 restarts to trigger the issue.  SIGHUP restarts do a
"full config reload" and never display "lingering pushed config" problems.

Testing has uncovered more save & restore bugs, related to compression
and "--route-gateway".  At least...

Your patch has been applied to the master and release/2.5 branch (bugfix),
but I'm not sure I want to really backport it to 2.4 - it's not a crucial
crashbug, not easy to trigger, and if you're annoyed by it, just upgrade.

I have not tested the 2.5 backport in full depth, just a basic t_client 
run (but the change is straightforward enough, and it applied without
much friction).

commit 5a2ed714d14acb2312d27fe40e300be96d970c27 (master)
commit a0e844c892d6f67977bf8e9162cbc43a3f64ba46 (release/2.5)
Author: Arne Schwabe
Date:   Wed Mar 17 17:00:38 2021 +0100

     Restore also ping related options on a reconnect

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20210317160038.25828-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21675.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


