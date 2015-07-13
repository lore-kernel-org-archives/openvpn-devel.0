Message-ID: <55A3DBF8.5010003@...1147...>
Date: Mon, 13 Jul 2015 17:40:40 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <55950ACC.1000909@...1147...> <20150702123852.GS382@...1296...>
	<55953B78.8090904@...1147...> <559D4FD9.4090006@...1147...>
In-Reply-To: <559D4FD9.4090006@...1147...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add TFTP and WPAD DHCP options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Jan Just Keijser wrote:
> Jan Just Keijser wrote:
>> Gert Doering wrote:
>>> On Thu, Jul 02, 2015 at 11:56:28AM +0200, Jan Just Keijser wrote:
>>>  
>>>> +    write_dhcp_str (buf, 66, o->tftp, &error);
>>>> +    write_dhcp_str (buf, 150, o->tftp, &error);
>>>>     
>>>
>>> This does not look safe to me (or I'm overlooking something) - if 
>>> o->tftp is not set, it will do "strlen(o->tftp)" inside 
>>> write_dhcp_str()...
>>>
>>> (And we generally shouldn't set options that we do not have anything 
>>> to say for :) ).
>>>
>>>   
>> I fully agree. Here's v2 with Jonathan's remarks addressed as well.
>
> I just discovered that my patch does not set the (poorly documented) 
> Cisco TFTP options; I'm working on rev3 which does set them correctly 
> (at least, Wireshark says I am setting them now correctly). Stay tuned :)

here's rev3 of the patch; this time the Cisco DHCP options are fully 
understood by Whireshark ;)

share and enjoy,

JJK

--- openvpn-2.3.7/src/openvpn/options.c 2015-06-02 10:01:24.000000000 +0200
+++ /tmp/build-x86_64/openvpn-2.3.7/src/openvpn/options.c       
2015-07-13 14:55:43.805931105 +0200
@@ -692,11 +692,13 @@
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
   "--dhcp-renew       : Ask Windows to renew the TAP adapter lease on 
startup.\n"
   "--dhcp-pre-release : Ask Windows to release the previous TAP adapter 
lease on\n"
 "                       startup.\n"
@@ -1119,6 +1121,8 @@
   SHOW_STR (netbios_scope);
   SHOW_INT (netbios_node_type);
   SHOW_BOOL (disable_nbt);
+  SHOW_STR (tftp);
+  SHOW_STR (wpad_url);
 
   show_dhcp_option_addrs ("DNS", o->dns, o->dns_len);
   show_dhcp_option_addrs ("WINS", o->wins, o->wins_len);
@@ -5354,7 +5358,11 @@
        {
          if (ip_or_dns_addr_safe (p[1], options->allow_pull_fqdn) || 
is_special_addr (p[1])) /* FQDN -- may be DNS name */
            {
+             struct tuntap_options *o = &options->tuntap_options;
+
              options->route_default_gateway = p[1];
+        
+             dhcp_option_address_parse ("GW", p[1], o->gw, &o->gw_len, 
msglevel);
            }
          else
            {
@@ -6153,6 +6161,14 @@
        {
          o->disable_nbt = 1;
        }
+         else if (streq (p[1], "TFTP") && p[2])
+       {
+         dhcp_option_address_parse ("TFTP", p[2], o->tftp, 
&o->tftp_len, msglevel);
+       }
+         else if (streq (p[1], "WPAD") && p[2])
+       {
+         o->wpad_url = p[2];
+       }
       else
        {
          msg (msglevel, "--dhcp-option: unknown option type '%s' or 
missing parameter", p[1]);
--- openvpn-2.3.7/src/openvpn/tun.h     2015-06-02 10:01:24.000000000 +0200
+++ /tmp/build-x86_64/openvpn-2.3.7/src/openvpn/tun.h   2015-07-13 
14:55:43.806930944 +0200
@@ -78,7 +78,6 @@
 
 #define N_DHCP_ADDR 4        /* Max # of addresses allowed for
                                DNS, WINS, etc. */
-
   /* DNS (6) */
   in_addr_t dns[N_DHCP_ADDR];
   int dns_len;
@@ -98,6 +97,14 @@
   /* DISABLE_NBT (43, Vendor option 001) */
   bool disable_nbt;
 
+  /* TFTP (66&150), RFC2132 states that it does not have to be an 
in_addr_t
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
--- openvpn-2.3.7/src/openvpn/tun.c     2015-06-08 08:16:35.000000000 +0200
+++ /tmp/build-x86_64/openvpn-2.3.7/src/openvpn/tun.c   2015-07-13 
14:55:43.807930787 +0200
@@ -4662,6 +4662,11 @@
 build_dhcp_options_string (struct buffer *buf, const struct 
tuntap_options *o)
 {
   bool error = false;
+  const char *tftp_str = NULL;
+  int i;
+
+  struct gc_arena gc = gc_new ();
+
   if (o->domain)
     write_dhcp_str (buf, 15, o->domain, &error);
 
@@ -4692,6 +4697,30 @@
     buf_write_u8 (buf,  4);  /* length of the vendor specified field */
     buf_write_u32 (buf, 0x002);
   }
+
+  /* Set both the RFC2132 and Cisco DHCP options for a TFTP server */
+  if (o->tftp_len > 0)
+  {
+       tftp_str = print_in_addr_t (o->tftp[0], 0, &gc);
+       write_dhcp_str (buf, 66, tftp_str, &error);
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
 
--- openvpn-2.3.7/doc/openvpn.8 2015-06-02 10:01:34.000000000 +0200
+++ /tmp/build-x86_64/openvpn-2.3.7/doc/openvpn.8       2015-07-13 
14:56:51.148556280 +0200
@@ -5413,6 +5413,14 @@
 to a non-windows client, the option will be saved in the client's
 environment before the up script is called, under
 the name "foreign_option_{n}".
+
+.B TFTP addr --
+Set TFTP server address (Trivial File Transer Protocol).
+This option sets both the RFC2132 DHCP option (66) and the Cisco option 
(150).
+
+.B WPAD url --
+Set the WPAD url (Windows Proxy Auto Detection) for proxy autodetection.
+The URL should be of the format "http://example.org/wpad.dat".
 .\"*********************************************************
 .TP
 .B \-\-tap\-sleep n



