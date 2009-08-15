From: Rob Lemley <rob@...1256...>
Content-Type: multipart/mixed; boundary="=-Ic5BgTSORh3EGRTLvlHj"
Date: Fri, 14 Aug 2009 17:47:40 -0700
Message-Id: <1250297260.23302.30.camel@...1257...>
Mime-Version: 1.0
Subject: [Openvpn-devel] nclients patch for 2.1_rc19
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-Ic5BgTSORh3EGRTLvlHj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I noticed that building OpenVPN with --disable-server fails. Turns out
to be a problem with the management server and the commands it allows.
I've attached a simple patch which fixes it, not sure if it's "right" or
not...



--=-Ic5BgTSORh3EGRTLvlHj
Content-Disposition: attachment; filename="fix_nclients.diff"
Content-Type: text/x-patch; name="fix_nclients.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -Naur openvpn-2.1_rc18/manage.c openvpn-2.1_rc18-dynamic/manage.c
--- openvpn-2.1_rc18/manage.c   2009-05-30 21:34:12 +0000
+++ openvpn-2.1_rc18-dynamic/manage.c   2009-07-11 10:26:03 +0000
@@ -995,10 +995,12 @@
     {
       msg (M_CLIENT, "SUCCESS: pid=%d", openvpn_getpid ());
     }
+#ifdef MANAGEMENT_DEF_AUTH
   else if (streq (p[0], "nclients"))
     {
       man_client_n_clients (man);
     }
+#endif
   else if (streq (p[0], "signal"))
     {
       if (man_need (man, p, 1, 0))


--=-Ic5BgTSORh3EGRTLvlHj--


