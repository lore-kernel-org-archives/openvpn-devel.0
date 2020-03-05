References: <523527018.2514117.1583041035054.ref@...2084...>
 <523527018.2514117.1583041035054@...2084...>
 <20200301071521.GI1431@...1296...>
 <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <f4b83fe0-cbe1-eed3-ff9b-4aaaea5a12b1@...1147...>
Date: Thu, 5 Mar 2020 13:53:12 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_j=P8vZvkOL4Rgh1icLJiu0a-r4yQGrD1GSACrn14G9QQ@...278...>
Content-Type: multipart/mixed; boundary="------------C6A165D5E38EFAB4CE6649A8"
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
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------C6A165D5E38EFAB4CE6649A8
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi,

On 01/03/20 16:29, Selva Nair wrote:
> On Sun, Mar 1, 2020 at 2:17 AM Gert Doering <gert@...1296...> wrote:
>>
>> On Sun, Mar 01, 2020 at 05:37:15AM +0000, Leroy Tennison via Openvpn-users wrote:
>>> Admittedly, and older server version (2.3) but is there a way to specify multiple DNS search suffixes for a Windows (10 if that makes a difference) client.  The clients are part of a domain but I have no control over them via that avenue.  I've tried multiple dhcp-option DOMAiN entries and the last one applies, I don't see another dhcp-option such as DOMAIN-SEARCH.  Any options would be much appreciated.  Thanks.
>>
>> OpenVPN never had functionality to set the DHCP SEARCH LIST option
>> on Windows.
>>
>> So while you could always specify the option multiple times, it would
>> only use one of them and put it into the DHCP DOMAIN option.
>>
>> It's not very much missing code, but someone would have to do it (and
>> the "core team" is very busy with other aspects right now).
> IIRC, windows clients never queried DHCP option 119 (domain search).
> It seems that has changed since Windows 10, or has it?
>
>
I had to dig through my archives for this one - I found an OpenVPN 
2.0.9  (!) source tree to which I had added rudimentary support for DHCP 
domain search, but that was *before* I found out that Windows did not 
support that...
And yes, according to the comment section of 
https://www.normanbauer.com/2018/04/18/configuring-dhcp-option-119-domain-search-list-on-a-windows-dhcp-server/, 
Windows 10 1809+ finally has support for DHCP domain searches.

So, for what it's worth, I've dusted off the patch again and rebased it 
to the current openvpn master tree. See attached. Note that I did only 
rudimentary testing, as I don't use Windows 10 a lot and I was testing 
using a mingw cross-compile only. In wireshark I *do* see that the 
correct DHCP offer is sent to the tap-win adapter.

Also note that I implemented multiple search domains by separating them 
using semi-colons, e.g.

    --dhcp-option SEARCH example.com;example.org;example.nl;example.de

etc as that was easier to implement
Also note that I did not fully implement the RFC3397 encoding of the 
search list, as that requires one to merge domain names that occur more 
than once - that would have made the code far more complicated.


share and enjoy,

JJK


--------------C6A165D5E38EFAB4CE6649A8
Content-Type: text/x-patch;
 name="dhcp-option-119.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dhcp-option-119.patch"

From a969947cd86292c881f7cc1c704ac992e8f6f0d6 Mon Sep 17 00:00:00 2001
From: Jan Just Keijser <janjust@...1147...>
Date: Thu, 5 Mar 2020 13:41:00 +0100
Subject: [PATCH] Added support for DHCP option 119 (dns search suffix list)
 for Windows. As of Windows 10 1809 Windows finally supports this so it makes
 sense to add support to OpenVPN as well.

---
 src/openvpn/options.c |  6 +++++
 src/openvpn/tun.c     | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/tun.h     |  3 +++
 3 files changed, 71 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6c0e52e..e59b22b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -726,6 +726,7 @@ static const char usage_message[] =
     "                    which allow multiple addresses,\n"
     "                    --dhcp-option must be repeated.\n"
     "                    DOMAIN name : Set DNS suffix\n"
+    "                    SEARCH name : Set DNS domain search list\n"
     "                    DNS addr    : Set domain name server address(es) (IPv4 and IPv6)\n"
     "                    NTP         : Set NTP server address(es)\n"
     "                    NBDD        : Set NBDD server address(es)\n"
@@ -1175,6 +1176,7 @@ show_tuntap_options(const struct tuntap_options *o)
     SHOW_BOOL(dhcp_renew);
     SHOW_BOOL(dhcp_pre_release);
     SHOW_STR(domain);
+    SHOW_STR(domain_search_list);
     SHOW_STR(netbios_scope);
     SHOW_INT(netbios_node_type);
     SHOW_BOOL(disable_nbt);
@@ -7327,6 +7329,10 @@ add_option(struct options *options,
         {
             o->domain = p[2];
         }
+        else if (streq(p[1], "SEARCH") && p[2])
+        {
+            o->domain_search_list = p[2];
+        }
         else if (streq(p[1], "NBS") && p[2])
         {
             o->netbios_scope = p[2];
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index aa131b2..eed9ae6 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5567,6 +5567,48 @@ write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *error)
     buf_write(buf, str, len);
 }
 
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
@@ -5576,6 +5618,26 @@ build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
         write_dhcp_str(buf, 15, o->domain, &error);
     }
 
+    if (o->domain_search_list)
+    {
+        /* multiple search domains are separated by semicolons; we make a copy
+           as we are chopping the string into pieces, which would cause problems
+           on a reconnection attempt */
+        char search_list[SEARCH_LIST_LEN];
+        char *sep, *ptr = search_list;
+    
+        strncpy(search_list, o->domain_search_list, SEARCH_LIST_LEN-1);
+    
+        while ( (sep = strchr(ptr, ';')) != NULL)
+        {
+            *sep = 0;
+            write_dhcp_search_str(buf, 119, ptr, &error);
+            ptr = ++sep;
+        }
+        /* print out the last/only one remaining */
+        write_dhcp_search_str(buf, 119, ptr, &error);
+    }
+
     if (o->netbios_scope)
     {
         write_dhcp_str(buf, 47, o->netbios_scope, &error);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 327d792..571b694 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -89,6 +89,9 @@ struct tuntap_options {
 
     const char *domain;      /* DOMAIN (15) */
 
+#define SEARCH_LIST_LEN 256
+    const char *domain_search_list;      /* SEARCH (119), MacOS, Linux Win10 1809+ */
+
     const char *netbios_scope; /* NBS (47) */
 
     int netbios_node_type;   /* NBT 1,2,4,8 (46) */
-- 
1.8.3.1


--------------C6A165D5E38EFAB4CE6649A8--

