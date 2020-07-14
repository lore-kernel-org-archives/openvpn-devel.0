References: <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
 <20200706161532.GH1431@...1296...>
 <e5be8b49-0689-eb96-b294-f5b50388a67b@...1147...>
 <20200708082428.GT1431@...1296...>
 <198ea3c8-a306-6a52-eaf6-e88aca10812b@...1147...>
 <20200711104448.GH1431@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <c404dd17-e0db-ce61-0d79-864a5736f2d0@...1147...>
Date: Tue, 14 Jul 2020 11:41:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200711104448.GH1431@...1296...>
Content-Type: multipart/mixed; boundary="------------2E3D18A4AB6A07AD4D568FA0"
Content-Language: nl-NL
Subject: [Openvpn-devel] [PATCH] [V5] Added support for DHCP option 119 (dns
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
--------------2E3D18A4AB6A07AD4D568FA0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/07/20 12:44, Gert Doering wrote:
> On Fri, Jul 10, 2020 at 06:42:18PM +0200, Jan Just Keijser wrote:
>> On 08/07/20 10:24, Gert Doering wrote:
>>> Can I have a v4, please? :-)
>> V4:
> Okay, here we go...
thanks for the review, I incorporated your suggestions and comments 
almost verbatim ;)
See attached V5.

cheers,

JJK


>
> Generally speaking, it works now :-)
>
> In the "ipconfig /all" output, I can now see a long list of DNS suffixes.
>
> Together with a DNS search list on the LAN *and* block-outside-dns, this
> seems to have interesting effects on Win10 - namely, it tries all the
> search domains it has (on all interfaces), but it will try the "LAN"
> search domains only via the "LAN" nameservers - and these are blocked,
> so there might be interesting side effects if both are used togehter -
> *or* it might be a way to get Win10 DNS to behave better even without
> block-outside-DNS (by configuring a search domain on the TAP side).
>
>
> Codewise, a few remarks...
>
>
>> @@ -1145,6 +1146,19 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
>>   #ifndef ENABLE_SMALL
>>   
>>   static void
>> +show_dhcp_option_list(const char *name, const char * const*array, int len)
>> +{
>> +    int i;
>> +    for (i = 0; i < len; ++i)
>> +    {
>> +        msg(D_SHOW_PARMS, "  %s[%d] = %s",
>> +            name,
>> +            i,
>> +            array[i] );
>> +    }
>> +}
> This is not "forbidden" by the style guide, but I think a more compact
> form would increase readability - the old openvpn style of having
> individual function calls spread over 10+ lines because each parameter
> is getting its own line is not really something we do anymore.  So:
>
>> +        msg(D_SHOW_PARMS, "  %s[%d] = %s", name, i, array[i] );
> ... which is well below the 80 character limit and which I find more
> readable, tbh.
>
>
>> +/*
>> + * RFC3397 states that multiple searchdomains are encoded as follows:
>> + *  - at start the length of the entire option is given
>> + *  - each subdomain is preceded by its length
>> + *  - each searchdomain is separated by a NUL character
>> + * e.g. if you want "openvpn.net" and "duckduckgo.com" then you end up with
>> + *  0x13  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
> While at it, 0x1D :-)
>
>> + */
>> +static void
>> +write_dhcp_search_str(struct buffer *buf, const int type, const char * const *str_array,
>> +                      int array_len, bool *error)
>> +{
>> +    char         tmp_buf[256];
>> +    int          i;
>> +    int          len = 0;
>> +
>> +    for (i=0; i < array_len; i++)
>> +    {
>> +        const char  *ptr = str_array[i], *dotptr = str_array[i];
>> +        int          j, k;
>> +
>> +        msg(M_INFO, "Processing '%s'", ptr);
> This line should not stay as it is - if you see it in the log, it's
> mostly unclear "it's processing 'domain' - what for?", and M_INFO is
> too high for unspecific info.
>
> Most other DHCP activities do not log anything (unless error), so for
> consistency I would just remove it.  But if we keep it, it needs to
> be more clear, like
>
>> +        msg(D_DHCP_OPT, "dhcp search domain '%s'", ptr);
> or something like that.
>
>
>> +        if (strlen(ptr) + len + 1 > sizeof(tmp_buf))
>> +        {
>> +            *error = true;
>> +            msg(M_WARN, "write_dhcp_search_str: temp buffer overflow building DHCP options");
>> +            return;
>> +        }
>> +        /* Loop over all subdomains separated by a dot and replace the dot
>> +           with the length of the subdomain */
>> +        while ((dotptr = strchr(ptr, '.')) != NULL)
>> +        {
>> +            j = dotptr - ptr;
>> +            tmp_buf[len++] = j;
>> +            for (k=0; k < j; k++) tmp_buf[len++] = ptr[k];
> Side note: this violate coding style - for(), as if(), mandates brackets.
>
>> +            for (k=0; k < j; k++)
>                 {
> 	           tmp_buf[len++] = ptr[k];
>                 }
>
>> +            ptr = dotptr + 1;
>> +        }
>> +
>> +        /* Now do the remainder after the last dot */
>> +        j = strlen(ptr);
>> +        tmp_buf[len++] = j;
>> +        for (k=0; k < j; k++) tmp_buf[len++] = ptr[k];
> same here.
>
>> +
>> +        /* And close off with an extra NUL char */
>> +        tmp_buf[len++] = 0;
>> +    }
>
> With these required brackets, the nested loops get long - and I do not
> find them overly elegant anyway (one could do a memcpy(), which would
> make more clear what is done, but it's still double-looping).
>
> For this, I had the idea to code it as follows (mentioned yesterday, but
> now actually written down) - single pass, no nested loops:
>
>      /* Loop over all subdomains separated by a dot and replace the dot
>         with the length of the subdomain */
>
>      /* label_length_pos points to the byte to be replaced by the length
>       * of the following domain label */
>      int label_length_pos = len++;
>
>      while(true)
>      {
>          if (*ptr == '.' || *ptr == '\0' )
> 	{
> 	    tmp_buf[label_length_pos] = (len-label_length_pos)-1;
> 	    label_length_pos = len;
> 	    if (*ptr == '\0')
> 	    {
> 		break;
> 	    }
> 	}
> 	tmp_buf[len++] = *ptr++;
>      }
>      /* And close off with an extra NUL char */
>      tmp_buf[len++] = '\0';
>
>
> (I've actually tested this and it works :-) - wireshark and Win10 confirms
> that the result is good - so if you want it, just use it for v5, if not,
> leave it)
>
>> +
>> +    if (!buf_safe(buf, 2 + len))
>> +    {
>> +        *error = true;
>> +        msg(M_WARN, "write_search_dhcp_str: buffer overflow building DHCP options");
>> +        return;
>> +    }
>> +    if (len > 255)
>> +    {
>> +        *error = true;
>> +        msg(M_WARN, "write_dhcp_search_str: search domain string must be <= 255 bytes");
>> +        return;
>> +    }
>> +
>> +    buf_write_u8(buf, type);
>> +    buf_write_u8(buf, len);
>> +    for (i=0; i < len; i++) buf_write_u8(buf, tmp_buf[i]);
>> +}
>
> There's another set of brackets needed here... { buf_write_u8() }
>
> But why use buf_write_u8() and another for() loop at all?
>
>     buf_write(buf, tmp_buf, len);
>
> should do the job just fine...
>
>
> So - getting close.  Technological issues solved, now style issues
> (which are much harder at times :-) ).
>
> gert


--------------2E3D18A4AB6A07AD4D568FA0
Content-Type: text/x-patch;
 name="0001-Added-support-for-DHCP-option-119-dns-search-suffix-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Added-support-for-DHCP-option-119-dns-search-suffix-.pa";
 filename*1="tch"

From db6491450361aede405510edf412bc276cce6536 Mon Sep 17 00:00:00 2001
From: Jan Just Keijser <jan.just.keijser@...277...>
Date: Tue, 14 Jul 2020 11:39:10 +0200
Subject: [PATCH] Added support for DHCP option 119 (dns search suffix list)
 for Windows. As of Windows 10 1809 Windows finally supports this so it makes
 sense to add support to OpenVPN as well.

Signed-off-by: Jan Just Keijser <jan.just.keijser@...277...>
---
 src/openvpn/options.c | 24 ++++++++++++++++
 src/openvpn/tun.c     | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/tun.h     |  6 ++++
 3 files changed, 106 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bf2760e..66c72f1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -729,6 +729,7 @@ static const char usage_message[] =
     "                    which allow multiple addresses,\n"
     "                    --dhcp-option must be repeated.\n"
     "                    DOMAIN name : Set DNS suffix\n"
+    "                    DOMAIN-SEARCH entry : Add entry to DNS domain search list\n"
     "                    DNS addr    : Set domain name server address(es) (IPv4 and IPv6)\n"
     "                    NTP         : Set NTP server address(es)\n"
     "                    NBDD        : Set NBDD server address(es)\n"
@@ -1144,6 +1145,16 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
 
 #ifndef ENABLE_SMALL
 
+static void 
+show_dhcp_option_list(const char *name, const char * const*array, int len) 
+{
+    int i;
+    for (i = 0; i < len; ++i) 
+    {    
+        msg(D_SHOW_PARMS, "  %s[%d] = %s", name, i, array[i] );
+    }    
+}
+
 static void
 show_dhcp_option_addrs(const char *name, const in_addr_t *array, int len)
 {
@@ -1179,6 +1190,7 @@ show_tuntap_options(const struct tuntap_options *o)
     show_dhcp_option_addrs("WINS", o->wins, o->wins_len);
     show_dhcp_option_addrs("NTP", o->ntp, o->ntp_len);
     show_dhcp_option_addrs("NBDD", o->nbdd, o->nbdd_len);
+    show_dhcp_option_list("DOMAIN-SEARCH", o->domain_search_list, o->domain_search_list_len);
 }
 
 #endif /* ifndef ENABLE_SMALL */
@@ -7460,6 +7472,18 @@ add_option(struct options *options,
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
index 2a2df27..4b772dd 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5673,6 +5673,75 @@ write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *error)
     buf_write(buf, str, len);
 }
 
+/*
+ * RFC3397 states that multiple searchdomains are encoded as follows:
+ *  - at start the length of the entire option is given
+ *  - each subdomain is preceded by its length
+ *  - each searchdomain is separated by a NUL character
+ * e.g. if you want "openvpn.net" and "duckduckgo.com" then you end up with
+ *  0x1D  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
+ */
+static void
+write_dhcp_search_str(struct buffer *buf, const int type, const char * const *str_array,
+                      int array_len, bool *error)
+{
+    char         tmp_buf[256];
+    int          i;
+    int          len = 0;
+    int          label_length_pos;
+
+    for (i=0; i < array_len; i++)
+    {
+        const char  *ptr = str_array[i];
+
+        if (strlen(ptr) + len + 1 > sizeof(tmp_buf))
+        {
+            *error = true;
+            msg(M_WARN, "write_dhcp_search_str: temp buffer overflow building DHCP options");
+            return;
+        }
+        /* Loop over all subdomains separated by a dot and replace the dot
+           with the length of the subdomain */
+
+        /* label_length_pos points to the byte to be replaced by the length 
+         * of the following domain label */
+        label_length_pos = len++;
+
+        while (true)
+        {
+            if (*ptr == '.' || *ptr == '\0' )
+            {
+                tmp_buf[label_length_pos] = (len-label_length_pos)-1;
+                label_length_pos = len;
+                if (*ptr == '\0')
+                {
+                    break;
+                }
+            }
+            tmp_buf[len++] = *ptr++;
+        }
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
+    buf_write(buf, tmp_buf, len);
+}
+
 static bool
 build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
 {
@@ -5697,6 +5766,13 @@ build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
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


--------------2E3D18A4AB6A07AD4D568FA0--

