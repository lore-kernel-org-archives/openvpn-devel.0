From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 24 Jan 2026 16:02:13 +0000
In-Reply-To: <gerrit.1767808679000.I864cd4a718886f437b72e93d0286f90fcb73592b@...2715...>
References: <gerrit.1767808679000.I864cd4a718886f437b72e93d0286f90fcb73592b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ba7cbd797fa6b13caa9ffc3f890a5cd3a0d75e83-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IzgFAVR4n8I="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: Fix
 conversion warnings in interactive.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, d12fk <heiko@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IzgFAVR4n8I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1457?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by d12fk


Change subject: openvpnserv: Fix conversion warnings in interactive.c
......................................................................

openvpnserv: Fix conversion warnings in interactive.c

Mostly DWORD vs. size_t conversions where we have no
choice but to cast.

Change-Id: I864cd4a718886f437b72e93d0286f90fcb73592b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Heiko Hund <heiko@...515...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1457
Message-Id: <20260120155547.116088-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
356.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 32 insertions(+), 26 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/1457/6

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index aa7da00..b6ab2b8 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1383,10 +1383,20 @@
     return TRUE;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
+/**
+ * Return correct size for registry value to set for string
+ *
+ */
+static DWORD
+RegWStringSize(PCWSTR string)
+{
+    size_t length =3D (wcslen(string) + 1) * sizeof(wchar_t);
+    if (length > UINT_MAX)
+    {
+        length =3D UINT_MAX;
+    }
+    return (DWORD)length;
+}

 /**
  * Prepare DNS domain "SearchList" registry value, so additional
@@ -1413,7 +1423,7 @@
         return TRUE;
     }

-    DWORD size =3D (wcslen(list) + 1) * sizeof(*list);
+    DWORD size =3D RegWStringSize(list);
     LSTATUS err =3D RegSetValueExW(key, L"InitialSearchList", 0, REG_SZ, (=
PBYTE)list, size);
     if (err)
     {
@@ -1474,7 +1484,7 @@
         wcsncpy(list, domains, wcslen(domains) + 1);
     }

-    size =3D (wcslen(list) + 1) * sizeof(list[0]);
+    size =3D RegWStringSize(list);
     err =3D RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, siz=
e);
     if (err)
     {
@@ -1515,7 +1525,7 @@
         goto out;
     }

-    size =3D (wcslen(list) + 1) * sizeof(list[0]);
+    size =3D RegWStringSize(list);
     err =3D RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, siz=
e);
     if (err)
     {
@@ -1579,14 +1589,14 @@
         }

         /* If the search list is back to its initial state reset it */
-        if (wcsncmp(list, initial, wcslen(list)) =3D=3D 0)
+        if (wcsncmp(list, initial, list_len) =3D=3D 0)
         {
             ResetDnsSearchDomains(key);
             return;
         }
     }
=20
-    size =3D (list_len + 1) * sizeof(list[0]);
+    size =3D RegWStringSize(list);
     err =3D RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, siz=
e);
     if (err)
     {
@@ -1751,7 +1761,7 @@
         goto out;
     }

-    err =3D RegSetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, str=
len(value) + 1);
+    err =3D RegSetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, (DW=
ORD)strlen(value) + 1);
     if (err)
     {
         MsgToEventLog(M_SYSERR, L"%S: could not set name servers '%S' for =
%s family %d (%lu)",
@@ -1807,7 +1817,7 @@
     int addr_len =3D msg->addr_len;

     /* sanity check */
-    const size_t max_addrs =3D _countof(msg->addr);
+    const int max_addrs =3D _countof(msg->addr);
     if (addr_len > max_addrs)
     {
         addr_len =3D max_addrs;
@@ -1949,7 +1959,7 @@
         short family =3D families[i];

         /* Create a comma sparated list of addresses of this family */
-        int offset =3D 0;
+        size_t offset =3D 0;
         char addr_list[NRPT_ADDR_SIZE * NRPT_ADDR_NUM];
         for (int j =3D 0; j < NRPT_ADDR_NUM && addresses[j][0]; j++)
         {
@@ -2085,9 +2095,9 @@

             size_t addr_len =3D strlen(pos);
             pos +=3D addr_len;
-            s -=3D addr_len;
+            s -=3D (DWORD)addr_len;
         }
-        s =3D strlen(addrs) + 1;
+        s =3D (DWORD)strlen(addrs) + 1;
     }

     if (strchr(addrs, ':'))
@@ -2163,7 +2173,8 @@

     LSTATUS err =3D ERROR_FILE_NOT_FOUND;
     const DWORD buf_size =3D *size;
-    const size_t glyph_size =3D sizeof(*domains);
+    const DWORD glyph_size =3D sizeof(*domains);
+    const DWORD buf_len =3D buf_size / glyph_size;
     PWSTR values[] =3D { L"SearchList", L"Domain", L"DhcpDomainSearchList"=
, L"DhcpDomain", NULL };

     for (int i =3D 0; values[i]; i++)
@@ -2178,7 +2189,6 @@
              *   - convert comma separated list to MULTI_SZ
              */
             PWCHAR pos =3D domains;
-            const DWORD buf_len =3D buf_size / glyph_size;
             while (TRUE)
             {
                 /* Terminate the domain at the next comma */
@@ -2188,9 +2198,9 @@
                     *comma =3D '\0';
                 }

-                size_t domain_len =3D wcslen(pos);
-                size_t domain_size =3D domain_len * glyph_size;
-                size_t converted_size =3D (pos - domains) * glyph_size;
+                DWORD domain_len =3D (DWORD)wcslen(pos);
+                DWORD domain_size =3D domain_len * glyph_size;
+                DWORD converted_size =3D (DWORD)(pos - domains) * glyph_si=
ze;

                 /* Ignore itf domains which match a pushed search domain */
                 if (ListContainsDomain(search_domains, pos, domain_len))
@@ -2216,7 +2226,7 @@
                 domain_size +=3D glyph_size;

                 /* Space for the terminating zeros */
-                size_t extra_size =3D 2 * glyph_size;
+                const DWORD extra_size =3D 2 * glyph_size;

                 /* Check for enough space to convert this domain */
                 if (converted_size + domain_size + extra_size > buf_size)
@@ -2450,7 +2460,7 @@

     /* Set DNS Server address */
     err =3D RegSetValueExA(rule_key, "GenericDNSServers", 0, REG_SZ, (PBYT=
E)address,
-                         strlen(address) + 1);
+                         (DWORD)strlen(address) + 1);
     if (err)
     {
         goto out;
@@ -2571,7 +2581,7 @@
     if (domains[0])
     {
         size_t domains_len =3D strlen(domains);
-        dom_size =3D domains_len + 2; /* len + the trailing NULs */
+        dom_size =3D (DWORD)domains_len + 2; /* len + the trailing NULs */

         wide_domains =3D utf8to16_size(domains, dom_size);
         dom_size *=3D sizeof(*wide_domains);
@@ -2628,10 +2638,6 @@
     return err;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * Return the registry key where NRPT rules are stored
  *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1457?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I864cd4a718886f437b72e93d0286f90fcb73592b
Gerrit-Change-Number: 1457
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IzgFAVR4n8I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1457?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by d12fk</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">openvpnserv: Fix conversion warning=
s in interactive.c<br><br>Mostly DWORD vs. size_t conversions where we have=
 no<br>choice but to cast.<br><br>Change-Id: I864cd4a718886f437b72e93d0286f=
90fcb73592b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>Acked-by: Heiko Hund &lt;heiko@...515...&gt;<br>Gerrit URL: https://gerrit=
.openvpn.net/c/openvpn/+/1457<br>Message-Id: &lt;20260120155547.116088-1-fr=
ank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg35356.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 32 =
insertions(+), 26 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/57/1457/6</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><sp=
an>index aa7da00..b6ab2b8 100644</span><br><span>--- a/src/openvpnserv/inte=
ractive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><sp=
an>@@ -1383,10 +1383,20 @@</span><br><span>     return TRUE;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconvers=
ion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Return correct size for registry value=
 to set for string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static DWORD</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+RegWStringSize(PCWSTR string)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    size_t length =3D (wcslen(string) + 1) * size=
of(wchar_t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(length &gt; UINT_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        len=
gth =3D UINT_MAX;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (DWOR=
D)length;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span> </span><br><span> /**</span><br><span>  * Prepare DNS domain &quot=
;SearchList&quot; registry value, so additional</span><br><span>@@ -1413,7 =
+1423,7 @@</span><br><span>         return TRUE;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWO=
RD size =3D (wcslen(list) + 1) * sizeof(*list);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    DWORD size =3D RegWStringSize(list);</span>=
<br><span>     LSTATUS err =3D RegSetValueExW(key, L&quot;InitialSearchList=
&quot;, 0, REG_SZ, (PBYTE)list, size);</span><br><span>     if (err)</span>=
<br><span>     {</span><br><span>@@ -1474,7 +1484,7 @@</span><br><span>    =
     wcsncpy(list, domains, wcslen(domains) + 1);</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    si=
ze =3D (wcslen(list) + 1) * sizeof(list[0]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    size =3D RegWStringSize(list);</span><br><span=
>     err =3D RegSetValueExW(key, L&quot;SearchList&quot;, 0, REG_SZ, (PBYT=
E)list, size);</span><br><span>     if (err)</span><br><span>     {</span><=
br><span>@@ -1515,7 +1525,7 @@</span><br><span>         goto out;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    size =3D (wcslen(list) + 1) * sizeof(list[0]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    size =3D RegWStringSize(list);=
</span><br><span>     err =3D RegSetValueExW(key, L&quot;SearchList&quot;, =
0, REG_SZ, (PBYTE)list, size);</span><br><span>     if (err)</span><br><spa=
n>     {</span><br><span>@@ -1579,14 +1589,14 @@</span><br><span>         }=
</span><br><span> </span><br><span>         /* If the search list is back t=
o its initial state reset it */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (wcsncmp(list, initial, wcslen(list)) =3D=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (wcsncmp(list, =
initial, list_len) =3D=3D 0)</span><br><span>         {</span><br><span>   =
          ResetDnsSearchDomains(key);</span><br><span>             return;<=
/span><br><span>         }</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D (list_len + 1) *=
 sizeof(list[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  size =3D RegWStringSize(list);</span><br><span>     err =3D RegSetValueEx=
W(key, L&quot;SearchList&quot;, 0, REG_SZ, (PBYTE)list, size);</span><br><s=
pan>     if (err)</span><br><span>     {</span><br><span>@@ -1751,7 +1761,7=
 @@</span><br><span>         goto out;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D RegSe=
tValueExA(itf, &quot;NameServer&quot;, 0, REG_SZ, (PBYTE)value, strlen(valu=
e) + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D=
 RegSetValueExA(itf, &quot;NameServer&quot;, 0, REG_SZ, (PBYTE)value, (DWOR=
D)strlen(value) + 1);</span><br><span>     if (err)</span><br><span>     {<=
/span><br><span>         MsgToEventLog(M_SYSERR, L&quot;%S: could not set n=
ame servers &#39;%S&#39; for %s family %d (%lu)&quot;,</span><br><span>@@ -=
1807,7 +1817,7 @@</span><br><span>     int addr_len =3D msg-&gt;addr_len;</=
span><br><span> </span><br><span>     /* sanity check */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    const size_t max_addrs =3D _countof(=
msg-&gt;addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst int max_addrs =3D _countof(msg-&gt;addr);</span><br><span>     if (add=
r_len &gt; max_addrs)</span><br><span>     {</span><br><span>         addr_=
len =3D max_addrs;</span><br><span>@@ -1949,7 +1959,7 @@</span><br><span>  =
       short family =3D families[i];</span><br><span> </span><br><span>    =
     /* Create a comma sparated list of addresses of this family */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        int offset =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t offset =
=3D 0;</span><br><span>         char addr_list[NRPT_ADDR_SIZE * NRPT_ADDR_N=
UM];</span><br><span>         for (int j =3D 0; j &lt; NRPT_ADDR_NUM &amp;&=
amp; addresses[j][0]; j++)</span><br><span>         {</span><br><span>@@ -2=
085,9 +2095,9 @@</span><br><span> </span><br><span>             size_t addr=
_len =3D strlen(pos);</span><br><span>             pos +=3D addr_len;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            s -=3D addr_len=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s -=3D=
 (DWORD)addr_len;</span><br><span>         }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        s =3D strlen(addrs) + 1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        s =3D (DWORD)strlen(addrs) + 1;=
</span><br><span>     }</span><br><span> </span><br><span>     if (strchr(a=
ddrs, &#39;:&#39;))</span><br><span>@@ -2163,7 +2173,8 @@</span><br><span> =
</span><br><span>     LSTATUS err =3D ERROR_FILE_NOT_FOUND;</span><br><span=
>     const DWORD buf_size =3D *size;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    const size_t glyph_size =3D sizeof(*domains);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const DWORD glyph_size =
=3D sizeof(*domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const DWORD buf_len =3D buf_size / glyph_size;</span><br><span>     P=
WSTR values[] =3D { L&quot;SearchList&quot;, L&quot;Domain&quot;, L&quot;Dh=
cpDomainSearchList&quot;, L&quot;DhcpDomain&quot;, NULL };</span><br><span>=
 </span><br><span>     for (int i =3D 0; values[i]; i++)</span><br><span>@@=
 -2178,7 +2189,6 @@</span><br><span>              *   - convert comma separ=
ated list to MULTI_SZ</span><br><span>              */</span><br><span>    =
         PWCHAR pos =3D domains;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            const DWORD buf_len =3D buf_size / glyph_size;</span=
><br><span>             while (TRUE)</span><br><span>             {</span><=
br><span>                 /* Terminate the domain at the next comma */</spa=
n><br><span>@@ -2188,9 +2198,9 @@</span><br><span>                     *com=
ma =3D &#39;\0&#39;;</span><br><span>                 }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                size_t =
domain_len =3D wcslen(pos);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                size_t domain_size =3D domain_len * glyph_size;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                size_t conv=
erted_size =3D (pos - domains) * glyph_size;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                DWORD domain_len =3D (DWORD)wcslen=
(pos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   DWORD domain_size =3D domain_len * glyph_size;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                DWORD converted_size =3D (DWO=
RD)(pos - domains) * glyph_size;</span><br><span> </span><br><span>        =
         /* Ignore itf domains which match a pushed search domain */</span>=
<br><span>                 if (ListContainsDomain(search_domains, pos, doma=
in_len))</span><br><span>@@ -2216,7 +2226,7 @@</span><br><span>            =
     domain_size +=3D glyph_size;</span><br><span> </span><br><span>       =
          /* Space for the terminating zeros */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                size_t extra_size =3D 2 * glyph_s=
ize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 const DWORD extra_size =3D 2 * glyph_size;</span><br><span> </span><br><sp=
an>                 /* Check for enough space to convert this domain */</sp=
an><br><span>                 if (converted_size + domain_size + extra_size=
 &gt; buf_size)</span><br><span>@@ -2450,7 +2460,7 @@</span><br><span> </sp=
an><br><span>     /* Set DNS Server address */</span><br><span>     err =3D=
 RegSetValueExA(rule_key, &quot;GenericDNSServers&quot;, 0, REG_SZ, (PBYTE)=
address,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
            strlen(address) + 1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                         (DWORD)strlen(address) + 1);</span><=
br><span>     if (err)</span><br><span>     {</span><br><span>         goto=
 out;</span><br><span>@@ -2571,7 +2581,7 @@</span><br><span>     if (domain=
s[0])</span><br><span>     {</span><br><span>         size_t domains_len =
=3D strlen(domains);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       dom_size =3D domains_len + 2; /* len + the trailing NULs */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        dom_size =3D (DWORD)=
domains_len + 2; /* len + the trailing NULs */</span><br><span> </span><br>=
<span>         wide_domains =3D utf8to16_size(domains, dom_size);</span><br=
><span>         dom_size *=3D sizeof(*wide_domains);</span><br><span>@@ -26=
28,10 +2638,6 @@</span><br><span>     return err;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> /**</span><br><span>  * Return the registry key where N=
RPT rules are stored</span><br><span>  *</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1457?usp=
=3Demail">change 1457</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1457?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I864cd4a718886f437b72e93d028=
6f90fcb73592b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1457 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--IzgFAVR4n8I=--

