Date: Fri, 25 Oct 2024 13:21:54 +0200 (CEST)
Message-Id: <202410251121.49PBLsu6064612@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241025103632.4413-1-gert@...1296...>
References: <20241025103632.4413-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_server_null: forcibly kill
 misbehaving servers
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
To: samuli.seppanen@...277...
Cc: openvpn-devel@lists.sourceforge.net

Tested this quite extensively up to v9 ;-) - by intentionally making
openvpn server misbehave (ignoring first 2 signals sent to it) with
this patch

--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3864,6 +3864,10 @@ multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
 bool
 multi_process_signal(struct multi_context *m)
 {
+static int n=0;
+    if (n++ < 1 )
+       { msg(M_INFO, "MPS: ignore signal"); signal_reset(m->top.sig,0); return false; }
+

.. and v9 now properly reports this as "test fail" plus shows the
(previously root-owned and unreadable) log file, so we can more easily
see from the buildbot fail mails what happened and if this is "infra 
problem" or "incoming patch problem".

BB + GHA agree that this is fine, for the non-broken-server case ;-)

Your patch has been applied to the master branch.

commit 37db7fe37afb555de651314a04c537fd7fbaa280
Author: Samuli Seppänen
Date:   Fri Oct 25 12:36:31 2024 +0200

     t_server_null: forcibly kill misbehaving servers

     Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241025103632.4413-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29655.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


