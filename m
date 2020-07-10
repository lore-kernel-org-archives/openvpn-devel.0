References: <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
 <20200706161532.GH1431@...1296...>
 <e5be8b49-0689-eb96-b294-f5b50388a67b@...1147...>
 <20200708082428.GT1431@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <198ea3c8-a306-6a52-eaf6-e88aca10812b@...1147...>
Date: Fri, 10 Jul 2020 18:42:18 +0200
MIME-Version: 1.0
In-Reply-To: <20200708082428.GT1431@...1296...>
Content-Type: multipart/mixed; boundary="------------477330B34A4A891E0F4B0E48"
Content-Language: nl-NL
Subject: [Openvpn-devel] [PATCH] [V4] Added support for DHCP option 119 (dns
 search suffix,
 list) for Windows. As of Windows 10 1809 Windows finally supports this so it,
 makes sense to add support to OpenVPN as well.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------477330B34A4A891E0F4B0E48
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/20 10:24, Gert Doering wrote:
> Can I have a v4, please? :-)

V4:



--------------477330B34A4A891E0F4B0E48
Content-Type: text/x-patch;
 name="0001-Added-support-for-DHCP-option-119-dns-search-suffix-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Added-support-for-DHCP-option-119-dns-search-suffix-.pa";
 filename*1="tch"

From fe0592df3235f3eb9bc9820586651ba8fc8bade0 Mon Sep 17 00:00:00 2001
From: Jan Just Keijser <jan.just.keijser@...277...>
Date: Fri, 10 Jul 2020 18:40:43 +0200
Subject: [PATCH] Added support for DHCP option 119 (dns search suffix list)
 for Windows. As of Windows 10 1809 Windows finally supports this so it makes
 sense to add support to OpenVPN as well.

Signed-off-by: Jan Just Keijser <jan.just.keijser@...277...>
---
 src/openvpn/options.c | 27 +++++++++++++++++++
 src/openvpn/tun.c     | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/tun.h     |  6 +++++
 3 files changed, 107 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b93fd4f..ff3a116 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -732,6 +732,7 @@ static const char usage_message[] =
     "                    DNS addr    : Set domain name server address(es) (IPv4 and IPv6)\n"
     "                    NTP         : Set NTP server address(es)\n"
     "                    NBDD        : Set NBDD server address(es)\n"
+    "                    DOMAIN-SEARCH entry : Add entry to DNS domain search list\n"
     "                    WINS addr   : Set WINS server address(es)\n"
     "                    NBT type    : Set NetBIOS over TCP/IP Node type\n"
     "                                  1: B, 2: P, 4: M, 8: H\n"
@@ -1145,6 +1146,19 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
 #ifndef ENABLE_SMALL
 
 static void
+show_dhcp_option_list(const char *name, const char * const*array, int len)
+{
+    int i;
+    for (i = 0; i < len; ++i)
+    {
+        msg(D_SHOW_PARMS, "  %s[%d] = %s",
+            name,
+            i,
+            array[i] );
+    }
+}
+
+static void
 show_dhcp_option_addrs(const char *name, const in_addr_t *array, int len)
 {
     struct gc_arena gc = gc_new();
@@ -1179,6 +1193,7 @@ show_tuntap_options(const struct tuntap_options *o)
     show_dhcp_option_addrs("WINS", o->wins, o->wins_len);
     show_dhcp_option_addrs("NTP", o->ntp, o->ntp_len);
     show_dhcp_option_addrs("NBDD", o->nbdd, o->nbdd_len);
+    show_dhcp_option_list("DOMAIN-SEARCH", o->domain_search_list, o->domain_search_list_len);
 }
 
 #endif /* ifndef ENABLE_SMALL */
@@ -7460,6 +7475,18 @@ add_option(struct options *options,
         {
             dhcp_option_address_parse("NBDD", p[2], o->nbdd, &o->nbdd_len, msglevel);
         }
+        else if (streq(p[1], "DOMAIN-SEARCH") && p[2])
+        {
+            if (o->domain_search_list_len < N_SEARCH_LIST_LEN)
+            {
+                o->domain_search_list[o->domain_search_list_len++] = p[2];
+            }
+            else
+            {
+                msg(msglevel, "--dhcp-option %s: maximum of %d search entries can be specified",
+                    p[1], N_SEARCH_LIST_LEN);
+            }
+        }
         else if (streq(p[1], "DISABLE-NBT") && !p[2])
         {
             o->disable_nbt = 1;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 2a2df27..75d5b04 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5673,6 +5673,72 @@ write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *error)
     buf_write(buf, str, len);
 }
 
+/*
+ * RFC3397 states that multiple searchdomains are encoded as follows:
+ *  - at start the length of the entire option is given
+ *  - each subdomain is preceded by its length
+ *  - each searchdomain is separated by a NUL character
+ * e.g. if you want "openvpn.net" and "duckduckgo.com" then you end up with
+ *  0x13  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
+ */
+static void
+write_dhcp_search_str(struct buffer *buf, const int type, const char * const *str_array,
+                      int array_len, bool *error)
+{
+    char         tmp_buf[256];
+    int          i;
+    int          len = 0;
+
+    for (i=0; i < array_len; i++)
+    {
+        const char  *ptr = str_array[i], *dotptr = str_array[i];
+        int          j, k;
+
+        msg(M_INFO, "Processing '%s'", ptr);
+
+        if (strlen(ptr) + len + 1 > sizeof(tmp_buf))
+        {
+            *error = true;
+            msg(M_WARN, "write_dhcp_search_str: temp buffer overflow building DHCP options");
+            return;
+        }
+        /* Loop over all subdomains separated by a dot and replace the dot
+           with the length of the subdomain */
+        while ((dotptr = strchr(ptr, '.')) != NULL)
+        {   
+            j = dotptr - ptr;
+            tmp_buf[len++] = j;
+            for (k=0; k < j; k++) tmp_buf[len++] = ptr[k];
+            ptr = dotptr + 1;
+        }   
+
+        /* Now do the remainder after the last dot */
+        j = strlen(ptr);
+        tmp_buf[len++] = j;
+        for (k=0; k < j; k++) tmp_buf[len++] = ptr[k];
+  
+        /* And close off with an extra NUL char */
+        tmp_buf[len++] = 0;
+    }
+
+    if (!buf_safe(buf, 2 + len))
+    {
+        *error = true;
+        msg(M_WARN, "write_search_dhcp_str: buffer overflow building DHCP options");
+        return;
+    }
+    if (len > 255)
+    {
+        *error = true;
+        msg(M_WARN, "write_dhcp_search_str: search domain string must be <= 255 bytes");
+        return;
+    }
+
+    buf_write_u8(buf, type);
+    buf_write_u8(buf, len);
+    for (i=0; i < len; i++) buf_write_u8(buf, tmp_buf[i]);
+}
+
 static bool
 build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
 {
@@ -5697,6 +5763,14 @@ build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
     write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error);
     write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &error);
 
+    if (o->domain_search_list_len > 0)
+    {
+        write_dhcp_search_str(buf, 119, o->domain_search_list, 
+                                        o->domain_search_list_len,
+                                       &error);
+    }
+
+
     /* the MS DHCP server option 'Disable Netbios-over-TCP/IP
      * is implemented as vendor option 001, value 002.
      * A value of 001 means 'leave NBT alone' which is the default */
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index b38e7e9..99826cf 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -112,6 +112,12 @@ struct tuntap_options {
     in_addr_t nbdd[N_DHCP_ADDR];
     int nbdd_len;
 
+#define N_SEARCH_LIST_LEN 10 /* Max # of entries in domin-search list */
+
+    /* SEARCH (119), MacOS, Linux, Win10 1809+ */
+    const char *domain_search_list[N_SEARCH_LIST_LEN];
+    int domain_search_list_len;
+
     /* DISABLE_NBT (43, Vendor option 001) */
     bool disable_nbt;
 
-- 
1.8.3.1


--------------477330B34A4A891E0F4B0E48--

