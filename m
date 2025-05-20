From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 20 May 2025 12:08:32 +0000
In-Reply-To: <gerrit.1741315174000.I4919af2b845a47787c08f454b108ef376ea5c0f6@...2715...>
References: <gerrit.1741315174000.I4919af2b845a47787c08f454b108ef376ea5c0f6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <fa26d880e85a6a9e2ea587b6672b1d9a1434262f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J3taaioQLgc="; charset=UTF-8
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
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--J3taaioQLgc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#21) to the change originally created b=
y d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/905?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/905/21

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
Gerrit-MessageType: newpatchset

--J3taaioQLgc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #21</strong> to the change originally c=
reated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/905=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">win: match search domains when creating exclude rule=
s<br><br>Compare local domains for exclude rules to search domains and skip=
<br>matching ones. This prevents the creation of exclude rules when the<br>=
server indicates that the domain should be resolved via the VPN, by<br>push=
ing the search domain.<br><br>Change-Id: I4919af2b845a47787c08f454b108ef376=
ea5c0f6<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: =
Lev Stipakov &lt;lstipakov@...277...&gt;<br>Message-Id: &lt;20250520105119.=
10431-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg31731.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file cha=
nged, 86 insertions(+), 24 deletions(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/05/905/21</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>index=
 5f842bd..a1581a6 100644</span><br><span>--- a/src/openvpnserv/interactive.=
c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -2=
126,18 +2126,52 @@</span><br><span> }</span><br><span> </span><br><span> /*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check if a doma=
in is contained in a comma separated list of domains</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param list      Comma separated list of domains</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param domain    Domain=
 string to search for</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param len       Length of the domain string, excluding the &#39;\0&#3=
9;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @return TRUE when the domain wa=
s found in the list, FALSE otherwise.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ListCo=
ntainsDomain(PCWSTR list, PCWSTR domain, size_t len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    PCWSTR match =3D list;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    while (TRUE)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        match =3D wcsstr(match, domain);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (!match)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            /* Domain has not matched */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if ((match =3D=3D list || *(match - 1) =
=3D=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &amp;&amp; (*(match + len) =3D=3D &#39;,&#39; || *(match + len)=
 =3D=3D &#39;\0&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     /* Domain has matched fully */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return TRUE;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        match +=3D len;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Return interfa=
ce specific domain suffix(es)</span><br><span>  *</span><br><span>  * The \=
p domains paramter will be set to a MULTI_SZ domains string.</span><br><spa=
n>  * In case of an error or if no domains are found for the interface</spa=
n><br><span>  * \p size is set to 0 and the contents of \p domains are inva=
lid.</span><br><span>  * Note that the domains could have been set by DHCP =
or manually.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Note=
 that domains are ignored if they match a pushed search domain.</span><br><=
span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  it=
f        HKEY of the interface to read from</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @param  domains    PWSTR buffer to return the doma=
in(s) in</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  si=
ze       pointer to size of the domains buffer in bytes. Will be</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *                    set to the=
 size of the string returned, including</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *                    the terminating zeros or 0.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  itf             =
HKEY of the interface to read from</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param  search_domains  optional list of search domains</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  domains   =
      PWSTR buffer to return the domain(s) in</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param  size            pointer to size of the=
 domains buffer in bytes. Will be</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *                         set to the size of the string retu=
rned, including</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
                       the terminating zeros or 0.</span><br><span>  *</spa=
n><br><span>  * @return LSTATUS NO_ERROR if the domain suffix(es) were read=
 successfully,</span><br><span>  *         ERROR_FILE_NOT_FOUND if no domai=
n was found for the interface,</span><br><span>@@ -2145,7 +2179,7 @@</span>=
<br><span>  *         any other error indicates an error while reading from=
 the registry.</span><br><span>  */</span><br><span> static LSTATUS</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-GetItfDnsDomains(HKEY itf, PW=
STR domains, PDWORD size)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+GetItfDnsDomains(HKEY itf, PCWSTR search_domains, PWSTR domains, PDWO=
RD size)</span><br><span> {</span><br><span>     if (domains =3D=3D NULL ||=
 size =3D=3D 0)</span><br><span>     {</span><br><span>@@ -2179,9 +2213,27 =
@@</span><br><span>                     *comma =3D &#39;\0&#39;;</span><br>=
<span>                 }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                /* Ignore itf domains which match a =
pushed search domain */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                size_t domain_len =3D wcslen(pos);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                if (ListContainsDomain(s=
earch_domains, pos, domain_len))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    if (comma)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        pos =3D comma + 1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        cont=
inue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   /* This was the last domain */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        *pos =3D &#39;\0&#39;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      *size +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_=
FOUND;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>                 /* Check for enough space to convert this domain */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                domain=
_len +=3D 1; /* leading dot */</span><br><span>                 size_t conv=
erted_size =3D pos - domains;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                size_t domain_len =3D wcslen(pos) + 1;</span><br><s=
pan>                 size_t domain_size =3D domain_len * one_glyph;</span><=
br><span>                 size_t extra_size =3D 2 * one_glyph;</span><br><s=
pan>                 if (converted_size + domain_size + extra_size &gt; buf=
_size)</span><br><span>@@ -2265,11 +2317,12 @@</span><br><span>  * needed s=
o that local DNS keeps working even when a catch all NRPT rule is</span><br=
><span>  * installed by a VPN connection.</span><br><span>  *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * @param  data       pointer to th=
e data structures the values are returned in</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * @param  data_size  number of exclude data structu=
res pointed to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram  search_domains  optional list of search domains</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param  data            pointer to the=
 data structures the values are returned in</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param  data_size       number of exclude data s=
tructures pointed to</span><br><span>  */</span><br><span> static void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-GetNrptExcludeData(nrpt_ex=
clude_data_t *data, size_t data_size)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+GetNrptExcludeData(PCWSTR search_domains, nrpt_exclude_da=
ta_t *data, size_t data_size)</span><br><span> {</span><br><span>     HKEY =
v4_itfs =3D INVALID_HANDLE_VALUE;</span><br><span>     HKEY v6_itfs =3D INV=
ALID_HANDLE_VALUE;</span><br><span>@@ -2313,7 +2366,7 @@</span><br><span>  =
       /* Get the DNS domain(s) for exclude routing */</span><br><span>    =
     data[i].domains_size =3D sizeof(data[0].domains);</span><br><span>    =
     memset(data[i].domains, 0, data[i].domains_size);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        err =3D GetItfDnsDomains(v4_itf, d=
ata[i].domains, &amp;data[i].domains_size);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        err =3D GetItfDnsDomains(v4_itf, search_dom=
ains, data[i].domains, &amp;data[i].domains_size);</span><br><span>        =
 if (err)</span><br><span>         {</span><br><span>             if (err !=
=3D ERROR_FILE_NOT_FOUND)</span><br><span>@@ -2471,15 +2524,16 @@</span><br=
><span>  * local resolution of names is not interfered with in case the VPN=
 resolves</span><br><span>  * all names.</span><br><span>  *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param  nrpt_key   the registry k=
ey to set the rules under</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @param  ovpn_pid   the PID of the openvpn process</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param  nrpt_key        the registr=
y key to set the rules under</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param  ovpn_pid        the PID of the openvpn process</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  search_domains  o=
ptional list of search domains</span><br><span>  */</span><br><span> static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SetNrptExcludeRu=
les(HKEY nrpt_key, DWORD ovpn_pid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+SetNrptExcludeRules(HKEY nrpt_key, DWORD ovpn_pid, PCWSTR se=
arch_domains)</span><br><span> {</span><br><span>     nrpt_exclude_data_t d=
ata[8]; /* data from up to 8 interfaces */</span><br><span>     memset(data=
, 0, sizeof(data));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  GetNrptExcludeData(data, _countof(data));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    GetNrptExcludeData(search_domains, data, _count=
of(data));</span><br><span> </span><br><span>     unsigned n =3D 0;</span><=
br><span>     for (int i =3D 0; i &lt; _countof(data); ++i)</span><br><span=
>@@ -2504,17 +2558,18 @@</span><br><span> /**</span><br><span>  * Set NRPT =
rules for a openvpn process</span><br><span>  *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * @param  nrpt_key   the registry key to set the=
 rules under</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param=
  addresses  name server addresses</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @param  domains    optional list of split routing domains</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  dnssec     b=
oolean whether DNSSEC is to be used</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * @param  ovpn_pid   the PID of the openvpn process</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  nrpt_key         =
 the registry key to set the rules under</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param  addresses         name server addresses</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  domains     =
      optional list of split routing domains</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param  search_domains    optional list of sear=
ch domains</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
  dnssec            boolean whether DNSSEC is to be used</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param  ovpn_pid          the PID o=
f the openvpn process</span><br><span>  *</span><br><span>  * @return NO_ER=
ROR on success, or a Windows error code</span><br><span>  */</span><br><spa=
n> static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SetNrp=
tRules(HKEY nrpt_key, const nrpt_address_t *addresses,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-             const char *domains, BOOL dns=
sec, DWORD ovpn_pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses, const char *d=
omains,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
 const char *search_domains, BOOL dnssec, DWORD ovpn_pid)</span><br><span> =
{</span><br><span>     DWORD err =3D NO_ERROR;</span><br><span>     PWSTR w=
ide_domains =3D L&quot;.\0&quot;; /* DNS route everything by default */</sp=
an><br><span>@@ -2543,7 +2598,14 @@</span><br><span>     }</span><br><span>=
     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        SetNrptExcludeRules(nrpt_key, ovpn_pid);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        PWSTR wide_search_domains;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wide_search_=
domains =3D utf8to16(search_domains);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!wide_search_domains)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return ERROR_OUTOFMEMORY;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        SetNrptExcludeRules(nrpt_key, ovp=
n_pid, wide_search_domains);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        free(wide_search_domains);</span><br><span>     }</span><b=
r><span> </span><br><span>     /* Create address string list */</span><br><=
span>@@ -2803,7 +2865,7 @@</span><br><span> </span><br><span>     /* Set NR=
PT rules */</span><br><span>     BOOL dnssec =3D (msg-&gt;flags &amp; nrpt_=
dnssec) !=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    er=
r =3D SetNrptRules(key, msg-&gt;addresses, msg-&gt;resolve_domains, dnssec,=
 ovpn_pid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =
=3D SetNrptRules(key, msg-&gt;addresses, msg-&gt;resolve_domains, msg-&gt;s=
earch_domains, dnssec, ovpn_pid);</span><br><span>     if (err)</span><br><=
span>     {</span><br><span>         goto out;</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/905=
?usp=3Demail">change 905</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/905?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--J3taaioQLgc=--

