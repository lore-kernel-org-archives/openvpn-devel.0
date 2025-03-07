From: "d12fk (Code Review)" <gerrit@...515...>
Date: Fri, 7 Mar 2025 02:39:42 +0000
References: <gerrit.1741315174000.I4919af2b845a47787c08f454b108ef376ea5c0f6@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2609ea882d125e4e86450ea68da0edcaa7823587-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tgoUKK0UmC0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tgoUKK0UmC0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/905?usp=3Demail

to review the following change.


Change subject: win: match search domains when creating exclude rules
......................................................................

win: match search domains when creating exclude rules

Compare local domains for exclude rules to search domains and skip
matching ones. This prevents the creation of exclude rules when the
server indicates that the domain should be resolved via the VPN, by
pushing the search domain.

Change-Id: I4919af2b845a47787c08f454b108ef376ea5c0f6
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 56 insertions(+), 24 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/905/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 6097cd0..f725199 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2163,12 +2163,14 @@
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
@@ -2176,7 +2178,7 @@
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
@@ -2209,9 +2211,29 @@
                     *comma =3D '\0';
                 }

+                /* Ignore itf domains which match pushed search domains */
+                size_t domain_len =3D wcslen(pos);
+                PCWSTR match =3D wcsstr(search_domains, pos);
+                if (match && (match =3D=3D search_domains || *(match - 1) =
=3D=3D ',')
+                    && (*(match + domain_len) =3D=3D ',' || *(match + doma=
in_len) =3D=3D '\0'))
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
@@ -2292,11 +2314,12 @@
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
@@ -2342,7 +2365,7 @@
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
@@ -2504,15 +2527,16 @@
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
@@ -2534,17 +2558,18 @@
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
@@ -2573,7 +2598,14 @@
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
@@ -2833,7 +2865,7 @@

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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--tgoUKK0UmC0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/905?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">win: match search domains when creating exclude rules<br><br>=
Compare local domains for exclude rules to search domains and skip<br>match=
ing ones. This prevents the creation of exclude rules when the<br>server in=
dicates that the domain should be resolved via the VPN, by<br>pushing the s=
earch domain.<br><br>Change-Id: I4919af2b845a47787c08f454b108ef376ea5c0f6<b=
r>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvp=
nserv/interactive.c<br>1 file changed, 56 insertions(+), 24 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/905=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/int=
eractive.c</span><br><span>index 6097cd0..f725199 100644</span><br><span>--=
- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/int=
eractive.c</span><br><span>@@ -2163,12 +2163,14 @@</span><br><span>  * In c=
ase of an error or if no domains are found for the interface</span><br><spa=
n>  * \p size is set to 0 and the contents of \p domains are invalid.</span=
><br><span>  * Note that the domains could have been set by DHCP or manuall=
y.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Note that doma=
ins are ignored if they match a pushed search domain.</span><br><span>  *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  itf        H=
KEY of the interface to read from</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * @param  domains    PWSTR buffer to return the domain(s) in</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  size       p=
ointer to size of the domains buffer in bytes. Will be</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *                    set to the size of t=
he string returned, including</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *                    the terminating zeros or 0.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param  itf             HKEY of th=
e interface to read from</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param  search_domains  optional list of search domains</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param  domains         PWST=
R buffer to return the domain(s) in</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param  size            pointer to size of the domains b=
uffer in bytes. Will be</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *                         set to the size of the string returned, incl=
uding</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
             the terminating zeros or 0.</span><br><span>  *</span><br><spa=
n>  * @return LSTATUS NO_ERROR if the domain suffix(es) were read successfu=
lly,</span><br><span>  *         ERROR_FILE_NOT_FOUND if no domain was foun=
d for the interface,</span><br><span>@@ -2176,7 +2178,7 @@</span><br><span>=
  *         any other error indicates an error while reading from the regis=
try.</span><br><span>  */</span><br><span> static LSTATUS</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-GetItfDnsDomains(HKEY itf, PWSTR domain=
s, PDWORD size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+GetI=
tfDnsDomains(HKEY itf, PCWSTR search_domains, PWSTR domains, PDWORD size)</=
span><br><span> {</span><br><span>     if (domains =3D=3D NULL || size =3D=
=3D 0)</span><br><span>     {</span><br><span>@@ -2209,9 +2211,29 @@</span>=
<br><span>                     *comma =3D &#39;\0&#39;;</span><br><span>   =
              }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                /* Ignore itf domains which match pushed sear=
ch domains */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          size_t domain_len =3D wcslen(pos);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                PCWSTR match =3D wcsstr(search_dom=
ains, pos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        if (match &amp;&amp; (match =3D=3D search_domains || *(match - 1) =
=3D=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    &amp;&amp; (*(match + domain_len) =3D=3D &#39;,&#39; ||=
 *(match + domain_len) =3D=3D &#39;\0&#39;))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    if (comma)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        pos =3D comma +=
 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        /* This was the last domain */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        *pos =3D =
&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  *size +=3D 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        return wcslen(domains) ? NO_ERROR : ERR=
OR_FILE_NOT_FOUND;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>                 /* Check for enough space to convert this =
domain */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      domain_len +=3D 1; /* leading dot */</span><br><span>                =
 size_t converted_size =3D pos - domains;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                size_t domain_len =3D wcslen(pos) + 1;<=
/span><br><span>                 size_t domain_size =3D domain_len * one_gl=
yph;</span><br><span>                 size_t extra_size =3D 2 * one_glyph;<=
/span><br><span>                 if (converted_size + domain_size + extra_s=
ize &gt; buf_size)</span><br><span>@@ -2292,11 +2314,12 @@</span><br><span>=
  * needed so that local DNS keeps working even when a catch all NRPT rule =
is</span><br><span>  * installed by a VPN connection.</span><br><span>  *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  data       p=
ointer to the data structures the values are returned in</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @param  data_size  number of exclude =
data structures pointed to</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param  search_domains  optional list of search domains</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  data            po=
inter to the data structures the values are returned in</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param  data_size       number of ex=
clude data structures pointed to</span><br><span>  */</span><br><span> stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-GetNrptExclude=
Data(nrpt_exclude_data_t *data, size_t data_size)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+GetNrptExcludeData(PCWSTR search_domains, nrp=
t_exclude_data_t *data, size_t data_size)</span><br><span> {</span><br><spa=
n>     HKEY v4_itfs =3D INVALID_HANDLE_VALUE;</span><br><span>     HKEY v6_=
itfs =3D INVALID_HANDLE_VALUE;</span><br><span>@@ -2342,7 +2365,7 @@</span>=
<br><span>         /* Get the DNS domain(s) for exclude routing */</span><b=
r><span>         data[i].domains_size =3D sizeof(data[0].domains);</span><b=
r><span>         memset(data[i].domains, 0, data[i].domains_size);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D GetItfDnsDomai=
ns(v4_itf, data[i].domains, &amp;data[i].domains_size);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        err =3D GetItfDnsDomains(v4_itf=
, search_domains, data[i].domains, &amp;data[i].domains_size);</span><br><s=
pan>         if (err)</span><br><span>         {</span><br><span>          =
   if (err !=3D ERROR_FILE_NOT_FOUND)</span><br><span>@@ -2504,15 +2527,16 =
@@</span><br><span>  * local resolution of names is not interfered with in =
case the VPN resolves</span><br><span>  * all names.</span><br><span>  *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  nrpt_key   th=
e registry key to set the rules under</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @param  ovpn_pid   the PID of the openvpn process</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  nrpt_key       =
 the registry key to set the rules under</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param  ovpn_pid        the PID of the openvpn proc=
ess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  searc=
h_domains  optional list of search domains</span><br><span>  */</span><br><=
span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SetN=
rptExcludeRules(HKEY nrpt_key, DWORD ovpn_pid)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+SetNrptExcludeRules(HKEY nrpt_key, DWORD ovpn_pi=
d, PCWSTR search_domains)</span><br><span> {</span><br><span>     nrpt_excl=
ude_data_t data[8]; /* data from up to 8 interfaces */</span><br><span>    =
 memset(data, 0, sizeof(data));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    GetNrptExcludeData(data, _countof(data));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    GetNrptExcludeData(search_domains, =
data, _countof(data));</span><br><span> </span><br><span>     unsigned n =
=3D 0;</span><br><span>     for (int i =3D 0; i &lt; _countof(data); ++i)</=
span><br><span>@@ -2534,17 +2558,18 @@</span><br><span> /**</span><br><span=
>  * Set NRPT rules for a openvpn process</span><br><span>  *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * @param  nrpt_key   the registry =
key to set the rules under</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * @param  addresses  name server addresses</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * @param  domains    optional list of split rou=
ting domains</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param=
  dnssec     boolean whether DNSSEC is to be used</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @param  ovpn_pid   the PID of the openvpn pr=
ocess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  nrp=
t_key          the registry key to set the rules under</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param  addresses         name server=
 addresses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
  domains           optional list of split routing domains</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param  search_domains    optiona=
l list of search domains</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param  dnssec            boolean whether DNSSEC is to be used</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  ovpn_pid     =
     the PID of the openvpn process</span><br><span>  *</span><br><span>  *=
 @return NO_ERROR on success, or a Windows error code</span><br><span>  */<=
/span><br><span> static DWORD</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             const char *dom=
ains, BOOL dnssec, DWORD ovpn_pid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses,=
 const char *domains,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+             const char *search_domains, BOOL dnssec, DWORD ovpn_pid)</sp=
an><br><span> {</span><br><span>     DWORD err =3D NO_ERROR;</span><br><spa=
n>     PWSTR wide_domains =3D L&quot;.\0&quot;; /* DNS route everything by =
default */</span><br><span>@@ -2573,7 +2598,14 @@</span><br><span>     }</s=
pan><br><span>     else</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        SetNrptExcludeRules(nrpt_key, ovpn_pid);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PWSTR wide_se=
arch_domains;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  wide_search_domains =3D utf8to16(search_domains);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!wide_search_domains)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return ERROR_OUTOFMEMORY;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        SetNrptExcludeRules(n=
rpt_key, ovpn_pid, wide_search_domains);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        free(wide_search_domains);</span><br><span>   =
  }</span><br><span> </span><br><span>     /* Create address string list */=
</span><br><span>@@ -2833,7 +2865,7 @@</span><br><span> </span><br><span>  =
   /* Set NRPT rules */</span><br><span>     BOOL dnssec =3D (msg-&gt;flags=
 &amp; nrpt_dnssec) !=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    err =3D SetNrptRules(key, msg-&gt;addresses, msg-&gt;resolve_doma=
ins, dnssec, ovpn_pid);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    err =3D SetNrptRules(key, msg-&gt;addresses, msg-&gt;resolve_domain=
s, msg-&gt;search_domains, dnssec, ovpn_pid);</span><br><span>     if (err)=
</span><br><span>     {</span><br><span>         goto out;</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/905?usp=3Demail">change 905</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/905?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4919af2b845a47787c08f454b10=
8ef376ea5c0f6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 905 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--tgoUKK0UmC0=--

