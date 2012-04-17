MIME-Version: 1.0
Sender: oksteev@...277...
Date: Tue, 17 Apr 2012 22:55:21 +0700
Message-ID: <CAHQHjk+Rc1sqpA8_ODdLB0L2iWJ3+UDA12aogNXSbfAc-X2KvA@...278...>
From: steve <coderrr.contact@...277...>
Subject: [Openvpn-devel] [PATCH] standalone management loop hangs forever
 during non blocking TCP connect
Reply-To: coderrr.contact@...277...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I caught a bug which seems to occur when a nonblocking connect() is
interrupted by a connection to the management port which causes the
standalone management event loop to be called via openvpn_sleep().
When polling the management port for connection status at an interval
of less than a second the management loop never exited and hung
forever.  This patch fixes it.  It didn't seem to cause any other
issues.  Does this patch look ok?

From 8f19f1088be171336840110cdd4365e18ea59d7c Mon Sep 17 00:00:00 2001
From: coderrr <coderrr.contact@...277...>
Date: Tue, 17 Apr 2012 22:12:24 +0700
Subject: [PATCH] don't stay in management event loop forever

---
 src/openvpn/manage.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1dddd41..574b111 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2871,7 +2871,8 @@ management_event_loop_n_seconds (struct
management *man, int sec)
            man_check_for_signals (&signal_received);
          if (signal_received)
            return;
-       } while (expire);
+          update_time();
+       } while (now >= expire);

       /* revert state */
       man->persist.standalone_disabled = standalone_disabled_save;
-- 
1.7.4.1

- coderrr
https://www.privateinternetaccess.com

