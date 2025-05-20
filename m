From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 20 May 2025 12:08:34 +0000
In-Reply-To: <gerrit.1741315174000.I4919af2b845a47787c08f454b108ef376ea5c0f6@...2715...>
References: <gerrit.1741315174000.I4919af2b845a47787c08f454b108ef376ea5c0f6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <fa26d880e85a6a9e2ea587b6672b1d9a1434262f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7xS1h0txkZU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win: match search
 domains when creating exclude rules
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7xS1h0txkZU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/90=
5?usp=3Demail )

Change subject: win: match search domains when creating exclude rules
......................................................................

win: match search domains when creating exclude rules

Compare local domains for exclude rules to search domains and skip
matching ones. This prevents the creation of exclude rules when the
server indicates that the domain should be resolved via the VPN, by
pushing the search domain.

Change-Id: I4919af2b845a47787c08f454b108ef376ea5c0f6
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20250520105119.10431-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
731.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 86 insertions(+), 24 deletions(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 5f842bd..a1581a6 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2126,18 +2126,52 @@
 }

 /**
+ * Check if a domain is contained in a comma separated list of domains
+ *
+ * @param list      Comma separated list of domains
+ * @param domain    Domain string to search for
+ * @param len       Length of the domain string, excluding the '\0'
+ *
+ * @return TRUE when the domain was found in the list, FALSE otherwise.
+ */
+static BOOL
+ListContainsDomain(PCWSTR list, PCWSTR domain, size_t len)
+{
+    PCWSTR match =3D list;
+    while (TRUE)
+    {
+        match =3D wcsstr(match, domain);
+        if (!match)
+        {
+            /* Domain has not matched */
+            break;
+        }
+        if ((match =3D=3D list || *(match - 1) =3D=3D ',')
+            && (*(match + len) =3D=3D ',' || *(match + len) =3D=3D '\0'))
+        {
+            /* Domain has matched fully */
+            return TRUE;
+        }
+        match +=3D len;
+    }
+    return FALSE;
+}
+
+/**
  * Return interface specific domain suffix(es)
  *
  * The \p domains paramter will be set to a MULTI_SZ domains string.
  * In case of an error or if no domains are found for the interface
  * \p size is set to 0 and the contents of \p domains are invalid.
  * Note that the domains could have been set by DHCP or manually.
+ * Note that domains are ignored if they match a pushed search domain.
  *
- * @param  itf        HKEY of the interface to read from
- * @param  domains    PWSTR buffer to return the domain(s) in
- * @param  size       pointer to size of the domains buffer in bytes. Will=
 be
- *                    set to the size of the string returned, including
- *                    the terminating zeros or 0.
+ * @param  itf             HKEY of the interface to read from
+ * @param  search_domains  optional list of search domains
+ * @param  domains         PWSTR buffer to return the domain(s) in
+ * @param  size            pointer to size of the domains buffer in bytes.=
 Will be
+ *                         set to the size of the string returned, includi=
ng
+ *                         the terminating zeros or 0.
  *
  * @return LSTATUS NO_ERROR if the domain suffix(es) were read successfull=
y,
  *         ERROR_FILE_NOT_FOUND if no domain was found for the interface,
@@ -2145,7 +2179,7 @@
  *         any other error indicates an error while reading from the regis=
try.
  */
 static LSTATUS
-GetItfDnsDomains(HKEY itf, PWSTR domains, PDWORD size)
+GetItfDnsDomains(HKEY itf, PCWSTR search_domains, PWSTR domains, PDWORD si=
ze)
 {
     if (domains =3D=3D NULL || size =3D=3D 0)
     {
@@ -2179,9 +2213,27 @@
                     *comma =3D '\0';
                 }

+                /* Ignore itf domains which match a pushed search domain */
+                size_t domain_len =3D wcslen(pos);
+                if (ListContainsDomain(search_domains, pos, domain_len))
+                {
+                    if (comma)
+                    {
+                        pos =3D comma + 1;
+                        continue;
+                    }
+                    else
+                    {
+                        /* This was the last domain */
+                        *pos =3D '\0';
+                        *size +=3D 1;
+                        return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT=
_FOUND;
+                    }
+                }
+
                 /* Check for enough space to convert this domain */
+                domain_len +=3D 1; /* leading dot */
                 size_t converted_size =3D pos - domains;
-                size_t domain_len =3D wcslen(pos) + 1;
                 size_t domain_size =3D domain_len * one_glyph;
                 size_t extra_size =3D 2 * one_glyph;
                 if (converted_size + domain_size + extra_size > buf_size)
@@ -2265,11 +2317,12 @@
  * needed so that local DNS keeps working even when a catch all NRPT rule =
is
  * installed by a VPN connection.
  *
- * @param  data       pointer to the data structures the values are return=
ed in
- * @param  data_size  number of exclude data structures pointed to
+ * @param  search_domains  optional list of search domains
+ * @param  data            pointer to the data structures the values are r=
eturned in
+ * @param  data_size       number of exclude data structures pointed to
  */
 static void
-GetNrptExcludeData(nrpt_exclude_data_t *data, size_t data_size)
+GetNrptExcludeData(PCWSTR search_domains, nrpt_exclude_data_t *data, size_=
t data_size)
 {
     HKEY v4_itfs =3D INVALID_HANDLE_VALUE;
     HKEY v6_itfs =3D INVALID_HANDLE_VALUE;
@@ -2313,7 +2366,7 @@
         /* Get the DNS domain(s) for exclude routing */
         data[i].domains_size =3D sizeof(data[0].domains);
         memset(data[i].domains, 0, data[i].domains_size);
-        err =3D GetItfDnsDomains(v4_itf, data[i].domains, &data[i].domains=
_size);
+        err =3D GetItfDnsDomains(v4_itf, search_domains, data[i].domains, =
&data[i].domains_size);
         if (err)
         {
             if (err !=3D ERROR_FILE_NOT_FOUND)
@@ -2471,15 +2524,16 @@
  * local resolution of names is not interfered with in case the VPN resolv=
es
  * all names.
  *
- * @param  nrpt_key   the registry key to set the rules under
- * @param  ovpn_pid   the PID of the openvpn process
+ * @param  nrpt_key        the registry key to set the rules under
+ * @param  ovpn_pid        the PID of the openvpn process
+ * @param  search_domains  optional list of search domains
  */
 static void
-SetNrptExcludeRules(HKEY nrpt_key, DWORD ovpn_pid)
+SetNrptExcludeRules(HKEY nrpt_key, DWORD ovpn_pid, PCWSTR search_domains)
 {
     nrpt_exclude_data_t data[8]; /* data from up to 8 interfaces */
     memset(data, 0, sizeof(data));
-    GetNrptExcludeData(data, _countof(data));
+    GetNrptExcludeData(search_domains, data, _countof(data));

     unsigned n =3D 0;
     for (int i =3D 0; i < _countof(data); ++i)
@@ -2504,17 +2558,18 @@
 /**
  * Set NRPT rules for a openvpn process
  *
- * @param  nrpt_key   the registry key to set the rules under
- * @param  addresses  name server addresses
- * @param  domains    optional list of split routing domains
- * @param  dnssec     boolean whether DNSSEC is to be used
- * @param  ovpn_pid   the PID of the openvpn process
+ * @param  nrpt_key          the registry key to set the rules under
+ * @param  addresses         name server addresses
+ * @param  domains           optional list of split routing domains
+ * @param  search_domains    optional list of search domains
+ * @param  dnssec            boolean whether DNSSEC is to be used
+ * @param  ovpn_pid          the PID of the openvpn process
  *
  * @return NO_ERROR on success, or a Windows error code
  */
 static DWORD
-SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses,
-             const char *domains, BOOL dnssec, DWORD ovpn_pid)
+SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses, const char *d=
omains,
+             const char *search_domains, BOOL dnssec, DWORD ovpn_pid)
 {
     DWORD err =3D NO_ERROR;
     PWSTR wide_domains =3D L".\0"; /* DNS route everything by default */
@@ -2543,7 +2598,14 @@
     }
     else
     {
-        SetNrptExcludeRules(nrpt_key, ovpn_pid);
+        PWSTR wide_search_domains;
+        wide_search_domains =3D utf8to16(search_domains);
+        if (!wide_search_domains)
+        {
+            return ERROR_OUTOFMEMORY;
+        }
+        SetNrptExcludeRules(nrpt_key, ovpn_pid, wide_search_domains);
+        free(wide_search_domains);
     }

     /* Create address string list */
@@ -2803,7 +2865,7 @@

     /* Set NRPT rules */
     BOOL dnssec =3D (msg->flags & nrpt_dnssec) !=3D 0;
-    err =3D SetNrptRules(key, msg->addresses, msg->resolve_domains, dnssec=
, ovpn_pid);
+    err =3D SetNrptRules(key, msg->addresses, msg->resolve_domains, msg->s=
earch_domains, dnssec, ovpn_pid);
     if (err)
     {
         goto out;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/905?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4919af2b845a47787c08f454b108ef376ea5c0f6
Gerrit-Change-Number: 905
Gerrit-PatchSet: 21
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--7xS1h0txkZU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/905?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">win: match search domains when creating exclud=
e rules<br><br>Compare local domains for exclude rules to search domains an=
d skip<br>matching ones. This prevents the creation of exclude rules when t=
he<br>server indicates that the domain should be resolved via the VPN, by<b=
r>pushing the search domain.<br><br>Change-Id: I4919af2b845a47787c08f454b10=
8ef376ea5c0f6<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acke=
d-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Message-Id: &lt;202505201=
05119.10431-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg31731.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 fi=
le changed, 86 insertions(+), 24 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index 5f842bd..a1581a6 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -2126,18 +2126,52 @@</span><br><span> }</span><br><sp=
an> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Check if a domain is contained in a comma separated list of domain=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param list      Comma separated=
 list of domains</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param domain    Domain string to search for</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param len       Length of the domain string, e=
xcluding the &#39;\0&#39;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
TRUE when the domain was found in the list, FALSE otherwise.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ListContainsDomain(PCWSTR list, PCWSTR domain, size_t len)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    PCWSTR match =3D list;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    while (TRUE)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        match =3D wcsstr(match, domain);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!match)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            /* Domain has not matche=
d */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bre=
ak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((match =3D=3D =
list || *(match - 1) =3D=3D &#39;,&#39;)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &amp;&amp; (*(match + len) =3D=3D &#39;,&#=
39; || *(match + len) =3D=3D &#39;\0&#39;))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            /* Domain has matched fully */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return TRUE;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        match +=3D len;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return FALSE;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span>  * Return interface specific domain suffix(es)</span><br><span>  *</s=
pan><br><span>  * The \p domains paramter will be set to a MULTI_SZ domains=
 string.</span><br><span>  * In case of an error or if no domains are found=
 for the interface</span><br><span>  * \p size is set to 0 and the contents=
 of \p domains are invalid.</span><br><span>  * Note that the domains could=
 have been set by DHCP or manually.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * Note that domains are ignored if they match a pushed sea=
rch domain.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param  itf        HKEY of the interface to read from</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @param  domains    PWSTR bu=
ffer to return the domain(s) in</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param  size       pointer to size of the domains buffer in by=
tes. Will be</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *       =
             set to the size of the string returned, including</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *                    the terminat=
ing zeros or 0.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param  itf             HKEY of the interface to read from</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param  search_domains  optional l=
ist of search domains</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param  domains         PWSTR buffer to return the domain(s) in</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  size           =
 pointer to size of the domains buffer in bytes. Will be</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *                         set to the =
size of the string returned, including</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *                         the terminating zeros or 0.</=
span><br><span>  *</span><br><span>  * @return LSTATUS NO_ERROR if the doma=
in suffix(es) were read successfully,</span><br><span>  *         ERROR_FIL=
E_NOT_FOUND if no domain was found for the interface,</span><br><span>@@ -2=
145,7 +2179,7 @@</span><br><span>  *         any other error indicates an e=
rror while reading from the registry.</span><br><span>  */</span><br><span>=
 static LSTATUS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-GetItf=
DnsDomains(HKEY itf, PWSTR domains, PDWORD size)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+GetItfDnsDomains(HKEY itf, PCWSTR search_domai=
ns, PWSTR domains, PDWORD size)</span><br><span> {</span><br><span>     if =
(domains =3D=3D NULL || size =3D=3D 0)</span><br><span>     {</span><br><sp=
an>@@ -2179,9 +2213,27 @@</span><br><span>                     *comma =3D &=
#39;\0&#39;;</span><br><span>                 }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                /* Ignore itf=
 domains which match a pushed search domain */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                size_t domain_len =3D wcslen(pos=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                i=
f (ListContainsDomain(search_domains, pos, domain_len))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    if (comma)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        pos =
=3D comma + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   continue;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        /* This was the last domain */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  *pos =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        *size +=3D 1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        return wcslen(domains) ? NO_=
ERROR : ERROR_FILE_NOT_FOUND;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>                 /* Check for enough space to co=
nvert this domain */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                domain_len +=3D 1; /* leading dot */</span><br><span>     =
            size_t converted_size =3D pos - domains;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                size_t domain_len =3D wcsle=
n(pos) + 1;</span><br><span>                 size_t domain_size =3D domain_=
len * one_glyph;</span><br><span>                 size_t extra_size =3D 2 *=
 one_glyph;</span><br><span>                 if (converted_size + domain_si=
ze + extra_size &gt; buf_size)</span><br><span>@@ -2265,11 +2317,12 @@</spa=
n><br><span>  * needed so that local DNS keeps working even when a catch al=
l NRPT rule is</span><br><span>  * installed by a VPN connection.</span><br=
><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  =
data       pointer to the data structures the values are returned in</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  data_size  number=
 of exclude data structures pointed to</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param  search_domains  optional list of search domai=
ns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  data  =
          pointer to the data structures the values are returned in</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  data_size       =
number of exclude data structures pointed to</span><br><span>  */</span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-Ge=
tNrptExcludeData(nrpt_exclude_data_t *data, size_t data_size)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+GetNrptExcludeData(PCWSTR search_=
domains, nrpt_exclude_data_t *data, size_t data_size)</span><br><span> {</s=
pan><br><span>     HKEY v4_itfs =3D INVALID_HANDLE_VALUE;</span><br><span> =
    HKEY v6_itfs =3D INVALID_HANDLE_VALUE;</span><br><span>@@ -2313,7 +2366=
,7 @@</span><br><span>         /* Get the DNS domain(s) for exclude routing=
 */</span><br><span>         data[i].domains_size =3D sizeof(data[0].domain=
s);</span><br><span>         memset(data[i].domains, 0, data[i].domains_siz=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D Ge=
tItfDnsDomains(v4_itf, data[i].domains, &amp;data[i].domains_size);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D GetItfDnsDo=
mains(v4_itf, search_domains, data[i].domains, &amp;data[i].domains_size);<=
/span><br><span>         if (err)</span><br><span>         {</span><br><spa=
n>             if (err !=3D ERROR_FILE_NOT_FOUND)</span><br><span>@@ -2471,=
15 +2524,16 @@</span><br><span>  * local resolution of names is not interfe=
red with in case the VPN resolves</span><br><span>  * all names.</span><br>=
<span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  n=
rpt_key   the registry key to set the rules under</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @param  ovpn_pid   the PID of the openvpn pr=
ocess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  nrp=
t_key        the registry key to set the rules under</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param  ovpn_pid        the PID of the=
 openvpn process</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param  search_domains  optional list of search domains</span><br><span>  *=
/</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-SetNrptExcludeRules(HKEY nrpt_key, DWORD ovpn_pid)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+SetNrptExcludeRules(HKEY nrpt_key, =
DWORD ovpn_pid, PCWSTR search_domains)</span><br><span> {</span><br><span> =
    nrpt_exclude_data_t data[8]; /* data from up to 8 interfaces */</span><=
br><span>     memset(data, 0, sizeof(data));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    GetNrptExcludeData(data, _countof(data));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    GetNrptExcludeData(sea=
rch_domains, data, _countof(data));</span><br><span> </span><br><span>     =
unsigned n =3D 0;</span><br><span>     for (int i =3D 0; i &lt; _countof(da=
ta); ++i)</span><br><span>@@ -2504,17 +2558,18 @@</span><br><span> /**</spa=
n><br><span>  * Set NRPT rules for a openvpn process</span><br><span>  *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  nrpt_key   th=
e registry key to set the rules under</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @param  addresses  name server addresses</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * @param  domains    optional list o=
f split routing domains</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @param  dnssec     boolean whether DNSSEC is to be used</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param  ovpn_pid   the PID of the=
 openvpn process</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param  nrpt_key          the registry key to set the rules under</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  addresses         =
name server addresses</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param  domains           optional list of split routing domains</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  search_domains=
    optional list of search domains</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param  dnssec            boolean whether DNSSEC is to b=
e used</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  ov=
pn_pid          the PID of the openvpn process</span><br><span>  *</span><b=
r><span>  * @return NO_ERROR on success, or a Windows error code</span><br>=
<span>  */</span><br><span> static DWORD</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addres=
ses,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             cons=
t char *domains, BOOL dnssec, DWORD ovpn_pid)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+SetNrptRules(HKEY nrpt_key, const nrpt_address_t =
*addresses, const char *domains,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+             const char *search_domains, BOOL dnssec, DWORD ov=
pn_pid)</span><br><span> {</span><br><span>     DWORD err =3D NO_ERROR;</sp=
an><br><span>     PWSTR wide_domains =3D L&quot;.\0&quot;; /* DNS route eve=
rything by default */</span><br><span>@@ -2543,7 +2598,14 @@</span><br><spa=
n>     }</span><br><span>     else</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        SetNrptExcludeRules(nrpt_key, o=
vpn_pid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PW=
STR wide_search_domains;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        wide_search_domains =3D utf8to16(search_domains);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!wide_search_domains=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return ERROR_OUT=
OFMEMORY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SetNrptExclu=
deRules(nrpt_key, ovpn_pid, wide_search_domains);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        free(wide_search_domains);</span><br>=
<span>     }</span><br><span> </span><br><span>     /* Create address strin=
g list */</span><br><span>@@ -2803,7 +2865,7 @@</span><br><span> </span><br=
><span>     /* Set NRPT rules */</span><br><span>     BOOL dnssec =3D (msg-=
&gt;flags &amp; nrpt_dnssec) !=3D 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    err =3D SetNrptRules(key, msg-&gt;addresses, msg-&gt;res=
olve_domains, dnssec, ovpn_pid);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    err =3D SetNrptRules(key, msg-&gt;addresses, msg-&gt;resol=
ve_domains, msg-&gt;search_domains, dnssec, ovpn_pid);</span><br><span>    =
 if (err)</span><br><span>     {</span><br><span>         goto out;</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/905?usp=3Demail">change 905</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/905?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4919af2b845a47787c08f454b10=
8ef376ea5c0f6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 905 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--7xS1h0txkZU=--

