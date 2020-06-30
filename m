References: <523527018.2514117.1583041035054.ref@...2084...>
 <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
 <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
 <20200621111403.GP1431@...1296...>
 <CAKuzo_h2oTaNK7A3+3MJ6GSfApr9L9vXYFtzELH8SaaNzqFWuQ@...278...>
 <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
Date: Tue, 30 Jun 2020 16:07:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200624102804.GM1431@...1296...>
Content-Type: multipart/mixed; boundary="------------DAA57B7A228A5C42C3AEB36F"
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
--------------DAA57B7A228A5C42C3AEB36F
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/06/20 12:28, Gert Doering wrote:
> Hi,
>
> On Tue, Jun 23, 2020 at 03:53:52PM -0400, Selva Nair wrote:
>>> So what option do we want?
>>>
>>> --dhcp-option SEARCH
>>> --dhcp-option DOMAIN-SEARCH
>>> --dhcp-option SEARCH-DOMAIN
>> RFC 3397 calls it "Domain Search" so it has to be DOMAIN-SEARCH, in my
>> view.  Platform scripts accepting other forms in foreign_option is up
>> to them. We don't have to officially support that.
> I like that argument.
>
> (I do not care too much which string it is, in the end, but if we have
> an RFC which has a name for it, and that name maps directly to one of
> the candidates, this is a strong argument :-) )
>
>
> On the "shall it be a single occurrance with multiple domains in it" or
> "shall it be multiple occurances that are concatenated into a single DHCP
> option which then has multiple domains in it", I do not have a truly
> strong opinion.  So I'd go with "what Tunnelblick has", which is
> "multiple occurances, a single string each".
>
> He who goes first wins :-)
here's V2:
-=A0 allow a user to specify
 =A0 dhcp-option DOMAIN-SEARCH
 =A0multiple times
- only a single FQDN per entry

cheers,

JJK


--------------DAA57B7A228A5C42C3AEB36F
Content-Type: text/x-patch;
 name="0001-Added-support-for-DHCP-option-119-dns-search-suffix-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Added-support-for-DHCP-option-119-dns-search-suffix-.pa";
 filename*1="tch"

From a82036c3f81d31af223a574f75de48797ba76698 Mon Sep 17 00:00:00 2001
From: Jan Just Keijser <jan.just.keijser@...277...>
Date: Tue, 30 Jun 2020 15:52:58 +0200
Subject: [PATCH] Added support for DHCP option 119 (dns search suffix list)
 for Windows. As of Windows 10 1809 Windows finally supports this so it makes
 sense to add support to OpenVPN as well.

Signed-off-by: Jan Just Keijser <jan.just.keijser@...277...>
---
 src/openvpn/options.c | 13 +++++++++++++
 src/openvpn/tun.c     | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/tun.h     |  6 ++++++
 3 files changed, 67 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2073b4a..376b8e7 100644
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
@@ -7460,6 +7461,18 @@ add_option(struct options *options,
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
index 5567c44..843c6b2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5673,6 +5673,49 @@ write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *error)
     buf_write(buf, str, len);
 }
 
+
+static void
+write_dhcp_search_str(struct buffer *buf, const int type, const char *str, bool *error)
+{
+    const char  *ptr = str, *dotptr = str;
+    int          i, j;
+
+    const int len = strlen(str) + 2;
+    if (!buf_safe(buf, 2 + len))
+    {
+        *error = true;
+        msg(M_WARN, "write_dhcp_str: buffer overflow building DHCP options");
+        return;
+    }
+    if (len < 1 || len > 255)
+    {
+        *error = true;
+        msg(M_WARN, "write_dhcp_search_str: string '%s' must be > 0 bytes and <= 255 bytes", str);
+        return;
+    }
+
+    buf_write_u8(buf, type);
+    buf_write_u8(buf, len);
+
+    /* Loop over all subdomains separated by a dot and replace the dot
+       with the length of the subdomain */
+    while ((dotptr = strchr(ptr, '.')) != NULL)
+    {
+        i = dotptr - ptr;
+        buf_write_u8(buf, i);
+        for (j=0; j< i; j++) buf_write_u8(buf, ptr[j]);
+        ptr = dotptr + 1;
+    }
+
+    /* Now do the remainder after the last dot */
+    i = strlen(ptr);
+    buf_write_u8(buf, i);
+    for (j=0; j< i; j++) buf_write_u8(buf, ptr[j]);
+
+    /* And close off with an extra NUL char */
+    buf_write_u8(buf, 0);
+}
+
 static bool
 build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
 {
@@ -5697,6 +5740,11 @@ build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
     write_dhcp_u32_array(buf, 42, (uint32_t *)o->ntp, o->ntp_len, &error);
     write_dhcp_u32_array(buf, 45, (uint32_t *)o->nbdd, o->nbdd_len, &error);
 
+    for (int i=0; i < o->domain_search_list_len; i++)
+    {
+        write_dhcp_search_str(buf, 119, o->domain_search_list[i], &error);
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


--------------DAA57B7A228A5C42C3AEB36F--

