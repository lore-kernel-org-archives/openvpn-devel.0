Message-ID: <55953B78.8090904@...1147...>
Date: Thu, 02 Jul 2015 15:24:08 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <55950ACC.1000909@...1147...> <20150702123852.GS382@...1296...>
In-Reply-To: <20150702123852.GS382@...1296...>
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Gert Doering wrote:
> Hi,
>
> On Thu, Jul 02, 2015 at 11:56:28AM +0200, Jan Just Keijser wrote:
>   
>> +    write_dhcp_str (buf, 66, o->tftp, &error);
>> +    write_dhcp_str (buf, 150, o->tftp, &error);
>>     
>
> This does not look safe to me (or I'm overlooking something) - if 
> o->tftp is not set, it will do "strlen(o->tftp)" inside write_dhcp_str()...
>
> (And we generally shouldn't set options that we do not have anything 
> to say for :) ).
>
>   
I fully agree. Here's v2 with Jonathan's remarks addressed as well.

--- openvpn-2.3.7/src/openvpn/options.c 2015-06-02 10:01:24.000000000 +0200
+++ /tmp/build-x86_64/openvpn-2.3.7/src/openvpn/options.c       
2015-07-02 11:47:24.291216980 +0200
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
@@ -6153,6 +6157,14 @@
        {
          o->disable_nbt = 1;
        }
+         else if (streq (p[1], "TFTP") && p[2])
+       {
+         o->tftp = p[2];
+       }
+         else if (streq (p[1], "WPAD") && p[2])
+       {
+         o->wpad_url = p[2];
+       }
       else
        {
          msg (msglevel, "--dhcp-option: unknown option type '%s' or 
missing parameter", p[1]);
--- openvpn-2.3.7/src/openvpn/tun.c     2015-06-08 08:16:35.000000000 +0200
+++ /tmp/build-x86_64/openvpn-2.3.7/src/openvpn/tun.c   2015-07-02 
15:16:58.041328818 +0200
@@ -4692,6 +4692,27 @@
     buf_write_u8 (buf,  4);  /* length of the vendor specified field */
     buf_write_u32 (buf, 0x002);
   }
+
+  /* Set both the RFC2132 and Cisco DHCP options for a TFTP server */
+  if (o->tftp)
+  {
+    write_dhcp_str (buf, 66, o->tftp, &error);
+    write_dhcp_str (buf, 150, o->tftp, &error);
+  }
+
+  /* IE6 seems to requires an extra character at the end of the URL */
+if (o->wpad_url)
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
   return !error;
 }
 
--- openvpn-2.3.7/src/openvpn/tun.h     2015-06-02 10:01:24.000000000 +0200
+++ /tmp/build-x86_64/openvpn-2.3.7/src/openvpn/tun.h   2015-07-02 
11:29:36.770462209 +0200
@@ -98,6 +98,12 @@
   /* DISABLE_NBT (43, Vendor option 001) */
   bool disable_nbt;
 
+  /* TFTP (66&150), see RFC2132: NOT an in_addr_t */
+  const char *tftp;
+
+  /* WPAD automatic proxy URL (252) */
+  const char *wpad_url;
+
   bool dhcp_renew;
   bool dhcp_pre_release;
   bool dhcp_release;
--- openvpn-2.3.7/doc/openvpn.8 2015-06-02 10:01:34.000000000 +0200
+++ /tmp/build-x86_64/openvpn-2.3.7/doc/openvpn.8       2015-07-02 
15:17:03.191987399 +0200
@@ -5413,6 +5413,14 @@
 to a non-windows client, the option will be saved in the client's
 environment before the up script is called, under
 the name "foreign_option_{n}".
+
+.B TFTP hostname|address --
+Set TFTP server hostname or address (Trivial File Transer Protocol).
+This option sets both the RFC2132 DHCP option (66) and the Cisco option 
(150).
+
+.B WPAD url --
+Set the WPAD url (Windows Proxy Auto Detection) for proxy autodetection.
+The URL should be of the format "http://example.org/wpad.dat".
 .\"*********************************************************
 .TP
 .B \-\-tap\-sleep n



