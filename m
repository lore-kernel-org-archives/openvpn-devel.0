From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.60.0408081003350.17418@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Patch: Output log message after routes is added
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Aug  8 01:11:02 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

--- forward-orig.c      Fri Jul 30 22:08:22 2004
+++ forward.c   Sun Aug  8 09:48:21 2004
@@ -243,6 +243,7 @@
        update_time ();
        event_timeout_clear (&c->c2.route_wakeup);
        event_timeout_clear (&c->c2.route_wakeup_expire);
+      msg (M_INFO, "Finished adding routes to system.");
      }
    else
      {


James, could you include this in next beta?

If not, do you have a better idea for a log-message we can write after 
routes have been added to the system, so I can report "Connected" in the 
GUI after routes have been added?

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

