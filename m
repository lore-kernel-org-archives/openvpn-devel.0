References: <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
 <20200706161532.GH1431@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <e5be8b49-0689-eb96-b294-f5b50388a67b@...1147...>
Date: Tue, 7 Jul 2020 18:14:25 +0200
MIME-Version: 1.0
In-Reply-To: <20200706161532.GH1431@...1296...>
Content-Type: multipart/mixed; boundary="------------899741CFEC983A26DEA0BD51"
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
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
--------------899741CFEC983A26DEA0BD51
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 06/07/20 18:15, Gert Doering wrote:
> Hi,
>
> On Tue, Jun 30, 2020 at 04:15:58PM +0200, Jan Just Keijser wrote:
>> On 30/06/20 16:11, Gert Doering wrote:
>>> On Tue, Jun 30, 2020 at 04:07:52PM +0200, Jan Just Keijser wrote:
>>>> @@ -5697,6 +5740,11 @@ build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
>>>>        write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error);
>>>>        write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &error);
>>>>    
>>>> +    for (int i=0; i < o->domain_search_list_len; i++)
>>>> +    {
>>>> +        write_dhcp_search_str(buf, 119, o->domain_search_list[i], &error);
>>>> +    }
>>> I assume that this won't work.  In the DHCP answer, it must be a single
>>> option with the concatenated list, not multiple answers with a single
>>> domain name each.
>> see https://tools.ietf.org/html/rfc3397
>>
>> "
>>
>>      In the above diagram, Searchstring is a string specifying the
>>      searchlist.  If the length of the searchlist exceeds the maximum
>>      permissible within a single option (255 octets), then multiple
>>      options MAY be used, as described in "Encoding Long Options in the
>>      Dynamic Host Configuration Protocol (DHCPv4)" [RFC3396 <https://tools.ietf.org/html/rfc3396>].
>>
>> "
>> so you MAY use this option multiple times - and wireshark groks it fine. I don't have a Windows 10
>> client to test it against, however, so I am hoping that someone (Selva?) can do that for me.
> I did test, and my initial suspicion was correct - Windows accepts the
> option, but only one of them.
>
> I am pushing
>
>    dhcp-option DOMAIN-SEARCH v6.de,dhcp-option DOMAIN-SEARCH leo.org,dhcp-option DOMAIN-SEARCH ov.greenie.net,dhcp-option DOMAIN-SEARCH nekosoft.de
>
> (because these are domains that have more interesting hostnames in than
> just "www" and "mail", so I can see if "v4only.v6.de" is found, or
> "dict.leo.org")
>
> and "ipconfig /all" only shows the "nekosoft.de" one.
>
> This one works(!), so generally, Win10 accepts this DHCP option - but
> it seems to want "all domains in one".
>
>
> Can you send a v3?
>
not sure if all went well , but here's V3.

cheers,

JJK


--------------899741CFEC983A26DEA0BD51
Content-Type: text/x-patch;
 name="0001-V3-Added-support-for-DHCP-option-119-dns-search-suff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-V3-Added-support-for-DHCP-option-119-dns-search-suff.pa";
 filename*1="tch"

From 2a7f199252ddaf1bccf1eb399d26adc0a5aca137 Mon Sep 17 00:00:00 2001
From: Jan Just Keijser <jan.just.keijser@...277...>
Date: Tue, 7 Jul 2020 18:10:15 +0200
Subject: [PATCH] [V3] Added support for DHCP option 119 (dns search suffix
 list) for Windows. As of Windows 10 1809 Windows finally supports this so it
 makes sense to add support to OpenVPN as well.

Signed-off-by: Jan Just Keijser <jan.just.keijser@...277...>
---
 src/openvpn/options.c |  34 ++++++++++++++---
 src/openvpn/tun.c     | 101 ++++++++++++++++++++++++++++----------------------
 src/openvpn/tun.h     |   9 +++--
 3 files changed, 90 insertions(+), 54 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e59b22b..85f1d8a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -726,7 +726,7 @@ static const char usage_message[] =
     "                    which allow multiple addresses,\n"
     "                    --dhcp-option must be repeated.\n"
     "                    DOMAIN name : Set DNS suffix\n"
-    "                    SEARCH name : Set DNS domain search list\n"
+    "                    DOMAIN-SEARCH entry : Add entry to DNS domain search list\n"
     "                    DNS addr    : Set domain name server address(es) (IPv4 and IPv6)\n"
     "                    NTP         : Set NTP server address(es)\n"
     "                    NBDD        : Set NBDD server address(es)\n"
@@ -1150,6 +1150,20 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
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
+
+static void
 show_dhcp_option_addrs(const char *name, const in_addr_t *array, int len)
 {
     struct gc_arena gc = gc_new();
@@ -1176,7 +1190,6 @@ show_tuntap_options(const struct tuntap_options *o)
     SHOW_BOOL(dhcp_renew);
     SHOW_BOOL(dhcp_pre_release);
     SHOW_STR(domain);
-    SHOW_STR(domain_search_list);
     SHOW_STR(netbios_scope);
     SHOW_INT(netbios_node_type);
     SHOW_BOOL(disable_nbt);
@@ -1185,6 +1198,7 @@ show_tuntap_options(const struct tuntap_options *o)
     show_dhcp_option_addrs("WINS", o->wins, o->wins_len);
     show_dhcp_option_addrs("NTP", o->ntp, o->ntp_len);
     show_dhcp_option_addrs("NBDD", o->nbdd, o->nbdd_len);
+    show_dhcp_option_list("DOMAIN-SEARCH", o->domain_search_list, o->domain_search_list_len);
 }
 
 #endif /* ifndef ENABLE_SMALL */
@@ -7329,10 +7343,6 @@ add_option(struct options *options,
         {
             o->domain = p[2];
         }
-        else if (streq(p[1], "SEARCH") && p[2])
-        {
-            o->domain_search_list = p[2];
-        }
         else if (streq(p[1], "NBS") && p[2])
         {
             o->netbios_scope = p[2];
@@ -7373,6 +7383,18 @@ add_option(struct options *options,
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
index eed9ae6..60a149c 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5567,46 +5567,70 @@ write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *error)
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
 static void
-write_dhcp_search_str(struct buffer *buf, const int type, const char *str, bool *error)
+write_dhcp_search_str(struct buffer *buf, const int type, const char * const *str_array,
+                      int array_len, bool *error)
 {
-    const char  *ptr = str, *dotptr = str;
-    int          i, j;
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
 
-    const int len = strlen(str) + 2;
     if (!buf_safe(buf, 2 + len))
     {
         *error = true;
-        msg(M_WARN, "write_dhcp_str: buffer overflow building DHCP options");
+        msg(M_WARN, "write_search_dhcp_str: buffer overflow building DHCP options");
         return;
     }
-    if (len < 1 || len > 255)
+    if (len > 255)
     {
         *error = true;
-        msg(M_WARN, "write_dhcp_search_str: string '%s' must be > 0 bytes and <= 255 bytes", str);
+        msg(M_WARN, "write_dhcp_search_str: search domain string must be <= 255 bytes");
         return;
     }
 
     buf_write_u8(buf, type);
     buf_write_u8(buf, len);
-
-    /* Loop over all subdomains separated by a dot and replace the dot
-       with the length of the subdomain */
-    while ((dotptr = strchr(ptr, '.')) != NULL)
-    {   
-        i = dotptr - ptr;
-        buf_write_u8(buf, i);
-        for (j=0; j< i; j++) buf_write_u8(buf, ptr[j]);
-        ptr = dotptr + 1;
-    }   
-
-    /* Now do the remainder after the last dot */
-    i = strlen(ptr);
-    buf_write_u8(buf, i);
-    for (j=0; j< i; j++) buf_write_u8(buf, ptr[j]);
-  
-    /* And close off with an extra NUL char */
-    buf_write_u8(buf, 0);
+    for (i=0; i < len; i++) buf_write_u8(buf, tmp_buf[i]);
 }
 
 static bool
@@ -5618,26 +5642,6 @@ build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
         write_dhcp_str(buf, 15, o->domain, &error);
     }
 
-    if (o->domain_search_list)
-    {
-        /* multiple search domains are separated by semicolons; we make a copy
-           as we are chopping the string into pieces, which would cause problems
-           on a reconnection attempt */
-        char search_list[SEARCH_LIST_LEN];
-        char *sep, *ptr = search_list;
-    
-        strncpy(search_list, o->domain_search_list, SEARCH_LIST_LEN-1);
-    
-        while ( (sep = strchr(ptr, ';')) != NULL)
-        {
-            *sep = 0;
-            write_dhcp_search_str(buf, 119, ptr, &error);
-            ptr = ++sep;
-        }
-        /* print out the last/only one remaining */
-        write_dhcp_search_str(buf, 119, ptr, &error);
-    }
-
     if (o->netbios_scope)
     {
         write_dhcp_str(buf, 47, o->netbios_scope, &error);
@@ -5653,6 +5657,13 @@ build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
     write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error);
     write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &error);
 
+    if (o->domain_search_list_len > 0)
+    {
+        write_dhcp_search_str(buf, 119, o->domain_search_list, 
+                                        o->domain_search_list_len,
+                                       &error);
+    }
+
     /* the MS DHCP server option 'Disable Netbios-over-TCP/IP
      * is implemented as vendor option 001, value 002.
      * A value of 001 means 'leave NBT alone' which is the default */
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 571b694..6a87387 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -89,9 +89,6 @@ struct tuntap_options {
 
     const char *domain;      /* DOMAIN (15) */
 
-#define SEARCH_LIST_LEN 256
-    const char *domain_search_list;      /* SEARCH (119), MacOS, Linux Win10 1809+ */
-
     const char *netbios_scope; /* NBS (47) */
 
     int netbios_node_type;   /* NBT 1,2,4,8 (46) */
@@ -115,6 +112,12 @@ struct tuntap_options {
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


--------------899741CFEC983A26DEA0BD51--

