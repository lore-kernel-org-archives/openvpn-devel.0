From: Jan Just Keijser <janjust@...1147...>
Date: Fri,  9 Oct 2015 17:43:01 +0200
Message-Id: <1444405381-27502-1-git-send-email-janjust@...1147...>
Subject: [Openvpn-devel] [PATCH] Add support for TFTP and WPAD DHCP options.
	These DHCP options are picked up by the client-side (Windows)
	adapter and made available to other applications.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

---
 doc/openvpn.8         |    8 ++++++++
 src/openvpn/options.c |   14 ++++++++++++++
 src/openvpn/tun.c     |   29 +++++++++++++++++++++++++++++
 src/openvpn/tun.h     |    9 ++++++++-
 4 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e213f5a..87ac26c 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5481,6 +5481,14 @@ is pushed via
 to a non-windows client, the option will be saved in the client's
 environment before the up script is called, under
 the name "foreign_option_{n}".
+
+.B TFTP addr --
+Set TFTP server address (Trivial File Transer Protocol).
+This option sets both the RFC2132 DHCP option (66) and the Cisco option (150).
+
+.B WPAD url --
+Set the WPAD url (Windows Proxy Auto Detection) for proxy autodetection. 
+The URL should be of the format "http://example.org/wpad.dat".
 .\"*********************************************************
 .TP
 .B \-\-tap\-sleep n
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index de4fa38..fb0cd71 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -674,11 +674,13 @@ static const char usage_message[] =
   "                    DNS addr    : Set domain name server address(es)\n"
   "                    NTP         : Set NTP server address(es)\n"
   "                    NBDD        : Set NBDD server address(es)\n"
+  "                    TFTP        : Set TFTP server address(es)\n"
   "                    WINS addr   : Set WINS server address(es)\n"
   "                    NBT type    : Set NetBIOS over TCP/IP Node type\n"
   "                                  1: B, 2: P, 4: M, 8: H\n"
   "                    NBS id      : Set NetBIOS scope ID\n"
   "                    DISABLE-NBT : Disable Netbios-over-TCP/IP.\n"
+  "                    WPAD url    : Set WebProxy AutoDiscovery url\n"
   "--dhcp-renew       : Ask Windows to renew the TAP adapter lease on startup.\n"
   "--dhcp-pre-release : Ask Windows to release the previous TAP adapter lease on\n"
 "                       startup.\n"
@@ -1098,11 +1100,13 @@ show_tuntap_options (const struct tuntap_options *o)
   SHOW_STR (netbios_scope);
   SHOW_INT (netbios_node_type);
   SHOW_BOOL (disable_nbt);
+  SHOW_STR (wpad_url);
 
   show_dhcp_option_addrs ("DNS", o->dns, o->dns_len);
   show_dhcp_option_addrs ("WINS", o->wins, o->wins_len);
   show_dhcp_option_addrs ("NTP", o->ntp, o->ntp_len);
   show_dhcp_option_addrs ("NBDD", o->nbdd, o->nbdd_len);
+  show_dhcp_option_addrs ("TFTP", o->tftp, o->tftp_len);
 }
 
 #endif
@@ -5282,6 +5286,8 @@ add_option (struct options *options,
 	{
 	  if (ip_or_dns_addr_safe (p[1], options->allow_pull_fqdn) || is_special_addr (p[1])) /* FQDN -- may be DNS name */
 	    {
+	      struct tuntap_options *o = &options->tuntap_options;
+
 	      options->route_default_gateway = p[1];
 	    }
 	  else
@@ -6079,6 +6085,14 @@ add_option (struct options *options,
 	{
 	  o->disable_nbt = 1;
 	}
+	  else if (streq (p[1], "TFTP") && p[2])
+	{
+	  dhcp_option_address_parse ("TFTP", p[2], o->tftp, &o->tftp_len, msglevel);
+	}
+	  else if (streq (p[1], "WPAD") && p[2])
+	{
+	  o->wpad_url = p[2];
+	}
       else
 	{
 	  msg (msglevel, "--dhcp-option: unknown option type '%s' or missing or unknown parameter", p[1]);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 24a61ec..0ba3e8a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4967,6 +4967,11 @@ static bool
 build_dhcp_options_string (struct buffer *buf, const struct tuntap_options *o)
 {
   bool error = false;
+  const char *tftp_str = NULL;
+  int i;
+
+  struct gc_arena gc = gc_new ();
+
   if (o->domain)
     write_dhcp_str (buf, 15, o->domain, &error);
 
@@ -4997,6 +5002,30 @@ build_dhcp_options_string (struct buffer *buf, const struct tuntap_options *o)
     buf_write_u8 (buf,  4);  /* length of the vendor specified field */
     buf_write_u32 (buf, 0x002);
   }
+
+  /* Set both the RFC2132 and Cisco DHCP options for a TFTP server */
+  if (o->tftp_len > 0)
+  {
+	tftp_str = print_in_addr_t (o->tftp[0], 0, &gc);
+	write_dhcp_str (buf, 66, tftp_str, &error);
+  }
+  write_dhcp_u32_array (buf, 150, (uint32_t*)o->tftp, o->tftp_len, &error);
+  
+  /* IE6 seems to requires an extra character at the end of the URL */
+  if (o->wpad_url)
+  {
+#ifdef WIN32
+    char str[256];
+    strncpy( str, o->wpad_url, 255 );
+    strcat( str, "\r" );
+    write_dhcp_str (buf, 252, str, &error);
+#else
+    write_dhcp_str (buf, 252, o->wpad_url, &error);
+#endif
+  }
+
+  gc_free (&gc);
+
   return !error;
 }
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 65bacac..93be13e 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -78,7 +78,6 @@ struct tuntap_options {
 
 #define N_DHCP_ADDR 4        /* Max # of addresses allowed for
 			        DNS, WINS, etc. */
-
   /* DNS (6) */
   in_addr_t dns[N_DHCP_ADDR];
   int dns_len;
@@ -98,6 +97,14 @@ struct tuntap_options {
   /* DISABLE_NBT (43, Vendor option 001) */
   bool disable_nbt;
 
+  /* TFTP (66&150), RFC2132 states that it does not have to be an in_addr_t 
+                    but option 150 (Cisco) *does* */
+  in_addr_t tftp[N_DHCP_ADDR];
+  int tftp_len;
+
+  /* WPAD automatic proxy URL (252) */
+  const char *wpad_url;
+
   bool dhcp_renew;
   bool dhcp_pre_release;
   bool dhcp_release;
-- 
1.7.1


