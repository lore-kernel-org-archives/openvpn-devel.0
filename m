From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 24 Jan 2026 17:21:37 +0000
In-Reply-To: <gerrit.1767808679000.Ib517457015b754d59aeb70827c4795aa6154728c@...2715...>
References: <gerrit.1767808679000.Ib517457015b754d59aeb70827c4795aa6154728c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ad72c5ca4f695b2989edb4df137e0ff2754543ab-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h30v8yPlLGA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: Factor
 out the string conversion from GetItfDnsDomains
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--h30v8yPlLGA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
58?usp=3Demail )

Change subject: openvpnserv: Factor out the string conversion from GetItfDn=
sDomains
......................................................................

openvpnserv: Factor out the string conversion from GetItfDnsDomains

Mostly so that we can actually test it. Since that
code does some in-place conversions a test would be
good.

Change-Id: Ib517457015b754d59aeb70827c4795aa6154728c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Heiko Hund <heiko@...515...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1458
Message-Id: <20260119214927.27766-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
343.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 101 insertions(+), 72 deletions(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index b6ab2b8..ad19e2c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2143,6 +2143,106 @@
 }

 /**
+ * Convert interface specific domain suffix(es) from comma-separated
+ * string to MULTI_SZ string.
+ *
+ * The \p domains paramter will be set to a MULTI_SZ domains string.
+ * In case of an error \p size is set to 0 and the contents of \p domains
+ * are invalid.
+ * Note that domains are deleted from the string if they match a search do=
main.
+ *
+ * @param[in]     search_domains  optional list of search domains
+ * @param[in,out] domains         buffer that contains the input comma-sep=
arated
+ *                                string and will contain the MULTI_SZ out=
put string
+ * @param[in,out] size            pointer to size of the input string in b=
ytes. Will be
+ *                                set to the size of the string returned, =
including
+ *                                the terminating zeros or 0.
+ * @param[in]     buf_size        size of the \p domains buffer
+ *
+ * @return LSTATUS NO_ERROR if the domain suffix(es) were read successfull=
y,
+ *         ERROR_FILE_NOT_FOUND if no domain was found for the interface,
+ *         ERROR_MORE_DATA if the list did not fit into the buffer
+ */
+static LSTATUS
+ConvertItfDnsDomains(PCWSTR search_domains, PWSTR domains, PDWORD size, co=
nst DWORD buf_size)
+{
+    const DWORD glyph_size =3D sizeof(*domains);
+    const DWORD buf_len =3D buf_size / glyph_size;
+
+    /*
+     * Found domain(s), now convert them:
+     *   - prefix each domain with a dot
+     *   - convert comma separated list to MULTI_SZ
+     */
+    PWCHAR pos =3D domains;
+    while (TRUE)
+    {
+        /* Terminate the domain at the next comma */
+        PWCHAR comma =3D wcschr(pos, ',');
+        if (comma)
+        {
+            *comma =3D '\0';
+        }
+
+        DWORD domain_len =3D (DWORD)wcslen(pos);
+        DWORD domain_size =3D domain_len * glyph_size;
+        DWORD converted_size =3D (DWORD)(pos - domains) * glyph_size;
+
+        /* Ignore itf domains which match a pushed search domain */
+        if (ListContainsDomain(search_domains, pos, domain_len))
+        {
+            if (comma)
+            {
+                /* Overwrite the ignored domain with remaining one(s) */
+                memmove(pos, comma + 1, buf_size - converted_size);
+                *size -=3D domain_size + glyph_size;
+                continue;
+            }
+            else
+            {
+                /* This was the last domain */
+                *pos =3D '\0';
+                *size -=3D domain_size;
+                return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;
+            }
+        }
+
+        /* Add space for the leading dot */
+        domain_len +=3D 1;
+        domain_size +=3D glyph_size;
+
+        /* Space for the terminating zeros */
+        const DWORD extra_size =3D 2 * glyph_size;
+
+        /* Check for enough space to convert this domain */
+        if (converted_size + domain_size + extra_size > buf_size)
+        {
+            /* Domain doesn't fit, bad luck if it's the first one */
+            *pos =3D '\0';
+            *size =3D converted_size =3D=3D 0 ? 0 : converted_size + glyph=
_size;
+            return ERROR_MORE_DATA;
+        }
+
+        /* Prefix domain at pos with the dot */
+        memmove(pos + 1, pos, buf_size - converted_size - glyph_size);
+        domains[buf_len - 1] =3D '\0';
+        *pos =3D '.';
+        *size +=3D glyph_size;
+
+        if (!comma)
+        {
+            /* Conversion is done */
+            *(pos + domain_len) =3D '\0';
+            *size +=3D glyph_size;
+            return NO_ERROR;
+        }
+
+        /* Comma pos is now +1 after adding leading dot */
+        pos =3D comma + 2;
+    }
+}
+
+/**
  * Return interface specific domain suffix(es)
  *
  * The \p domains paramter will be set to a MULTI_SZ domains string.
@@ -2174,7 +2274,6 @@
     LSTATUS err =3D ERROR_FILE_NOT_FOUND;
     const DWORD buf_size =3D *size;
     const DWORD glyph_size =3D sizeof(*domains);
-    const DWORD buf_len =3D buf_size / glyph_size;
     PWSTR values[] =3D { L"SearchList", L"Domain", L"DhcpDomainSearchList"=
, L"DhcpDomain", NULL };

     for (int i =3D 0; values[i]; i++)
@@ -2183,77 +2282,7 @@
         err =3D RegGetValueW(itf, NULL, values[i], RRF_RT_REG_SZ, NULL, (P=
BYTE)domains, size);
         if (!err && *size > glyph_size && domains[(*size / glyph_size) - 1=
] =3D=3D '\0' && wcschr(domains, '.'))
         {
-            /*
-             * Found domain(s), now convert them:
-             *   - prefix each domain with a dot
-             *   - convert comma separated list to MULTI_SZ
-             */
-            PWCHAR pos =3D domains;
-            while (TRUE)
-            {
-                /* Terminate the domain at the next comma */
-                PWCHAR comma =3D wcschr(pos, ',');
-                if (comma)
-                {
-                    *comma =3D '\0';
-                }
-
-                DWORD domain_len =3D (DWORD)wcslen(pos);
-                DWORD domain_size =3D domain_len * glyph_size;
-                DWORD converted_size =3D (DWORD)(pos - domains) * glyph_si=
ze;
-
-                /* Ignore itf domains which match a pushed search domain */
-                if (ListContainsDomain(search_domains, pos, domain_len))
-                {
-                    if (comma)
-                    {
-                        /* Overwrite the ignored domain with remaining one=
(s) */
-                        memmove(pos, comma + 1, buf_size - converted_size);
-                        *size -=3D domain_size + glyph_size;
-                        continue;
-                    }
-                    else
-                    {
-                        /* This was the last domain */
-                        *pos =3D '\0';
-                        *size -=3D domain_size;
-                        return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT=
_FOUND;
-                    }
-                }
-
-                /* Add space for the leading dot */
-                domain_len +=3D 1;
-                domain_size +=3D glyph_size;
-
-                /* Space for the terminating zeros */
-                const DWORD extra_size =3D 2 * glyph_size;
-
-                /* Check for enough space to convert this domain */
-                if (converted_size + domain_size + extra_size > buf_size)
-                {
-                    /* Domain doesn't fit, bad luck if it's the first one =
*/
-                    *pos =3D '\0';
-                    *size =3D converted_size =3D=3D 0 ? 0 : converted_size=
 + glyph_size;
-                    return ERROR_MORE_DATA;
-                }
-
-                /* Prefix domain at pos with the dot */
-                memmove(pos + 1, pos, buf_size - converted_size - glyph_si=
ze);
-                domains[buf_len - 1] =3D '\0';
-                *pos =3D '.';
-                *size +=3D glyph_size;
-
-                if (!comma)
-                {
-                    /* Conversion is done */
-                    *(pos + domain_len) =3D '\0';
-                    *size +=3D glyph_size;
-                    return NO_ERROR;
-                }
-
-                /* Comma pos is now +1 after adding leading dot */
-                pos =3D comma + 2;
-            }
+            return ConvertItfDnsDomains(search_domains, domains, size, buf=
_size);
         }
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1458?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib517457015b754d59aeb70827c4795aa6154728c
Gerrit-Change-Number: 1458
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--h30v8yPlLGA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1458?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">openvpnserv: Factor out the string conversion fr=
om GetItfDnsDomains<br><br>Mostly so that we can actually test it. Since th=
at<br>code does some in-place conversions a test would be<br>good.<br><br>C=
hange-Id: Ib517457015b754d59aeb70827c4795aa6154728c<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Heiko Hund &lt;heiko@...493...=
515...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1458<br>Me=
ssage-Id: &lt;20260119214927.27766-1-gert@...1296...&gt;<br>URL: https://ww=
w.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35343.html<br>Sig=
ned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpnser=
v/interactive.c<br>1 file changed, 101 insertions(+), 72 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index b6ab2b8..ad19e2c 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -2143,6 +2143,106 @@</span><br><span> }</span><br><sp=
an> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Convert interface specific domain suffix(es) from comma-separated<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * string to MULTI_S=
Z string.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * The \p domains paramter =
will be set to a MULTI_SZ domains string.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * In case of an error \p size is set to 0 and the co=
ntents of \p domains</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * are invalid.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Note that domains are deleted from the string if they match a search domain=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param[in]     search_domains  o=
ptional list of search domains</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param[in,out] domains         buffer that contains the input=
 comma-separated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
                               string and will contain the MULTI_SZ output =
string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param[in,=
out] size            pointer to size of the input string in bytes. Will be<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                  =
              set to the size of the string returned, including</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *                             =
   the terminating zeros or 0.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param[in]     buf_size        size of the \p domains buffer<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @return LSTATUS NO_ERROR if the do=
main suffix(es) were read successfully,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *         ERROR_FILE_NOT_FOUND if no domain was found =
for the interface,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*         ERROR_MORE_DATA if the list did not fit into the buffer</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static LSTATUS</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ConvertItfDnsDomains(PCWSTR search_domains, PWSTR =
domains, PDWORD size, const DWORD buf_size)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const DWORD glyph_size =3D sizeof(*domains);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const DWORD buf_len =3D buf_size / g=
lyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * Found domain(s), now convert them:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *   - prefix e=
ach domain with a dot</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     *   - convert comma separated list to MULTI_SZ</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    PWCHAR pos =3D domains;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    while (TRUE)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        /* Terminate the domain at the next comma */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        PWCHAR comma =3D wcsc=
hr(pos, &#39;,&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (comma)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   *comma =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD domain_=
len =3D (DWORD)wcslen(pos);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        DWORD domain_size =3D domain_len * glyph_size;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        DWORD converted_size =3D=
 (DWORD)(pos - domains) * glyph_size;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* Ignore itf domains which match a pushed search domain */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (ListContainsDoma=
in(search_domains, pos, domain_len))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (comma)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                /* Overwrite the ignored domain with remaining one(s) *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                me=
mmove(pos, comma + 1, buf_size - converted_size);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                *size -=3D domain_size + glyp=
h_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* Th=
is was the last domain */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                *pos =3D &#39;\0&#39;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                *size -=3D domain_size;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                return wcslen(=
domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
Add space for the leading dot */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        domain_len +=3D 1;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        domain_size +=3D glyph_size;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* Space for the terminating zeros */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        const DWORD extra_size =
=3D 2 * glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Check fo=
r enough space to convert this domain */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (converted_size + domain_size + extra_size =
&gt; buf_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* =
Domain doesn&#39;t fit, bad luck if it&#39;s the first one */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            *pos =3D &#39;\0&#39;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *size =
=3D converted_size =3D=3D 0 ? 0 : converted_size + glyph_size;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return ERROR_MORE_DA=
TA;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* Prefix domain at pos with the dot =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        memmove(p=
os + 1, pos, buf_size - converted_size - glyph_size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        domains[buf_len - 1] =3D &#39;\0&=
#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *pos =
=3D &#39;.&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     *size +=3D glyph_size;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!comma)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Conver=
sion is done */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        *(pos + domain_len) =3D &#39;\0&#39;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            *size +=3D glyph_size;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return NO_ERROR;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* Comma pos is now +1 after adding leading do=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pos =3D=
 comma + 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span>  * Return interface specific domain su=
ffix(es)</span><br><span>  *</span><br><span>  * The \p domains paramter wi=
ll be set to a MULTI_SZ domains string.</span><br><span>@@ -2174,7 +2274,6 =
@@</span><br><span>     LSTATUS err =3D ERROR_FILE_NOT_FOUND;</span><br><sp=
an>     const DWORD buf_size =3D *size;</span><br><span>     const DWORD gl=
yph_size =3D sizeof(*domains);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const DWORD buf_len =3D buf_size / glyph_size;</span><br><span=
>     PWSTR values[] =3D { L&quot;SearchList&quot;, L&quot;Domain&quot;, L&=
quot;DhcpDomainSearchList&quot;, L&quot;DhcpDomain&quot;, NULL };</span><br=
><span> </span><br><span>     for (int i =3D 0; values[i]; i++)</span><br><=
span>@@ -2183,77 +2282,7 @@</span><br><span>         err =3D RegGetValueW(i=
tf, NULL, values[i], RRF_RT_REG_SZ, NULL, (PBYTE)domains, size);</span><br>=
<span>         if (!err &amp;&amp; *size &gt; glyph_size &amp;&amp; domains=
[(*size / glyph_size) - 1] =3D=3D &#39;\0&#39; &amp;&amp; wcschr(domains, &=
#39;.&#39;))</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            /*</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-             * Found domain(s), now convert them:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-             *   - prefix each domai=
n with a dot</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
    *   - convert comma separated list to MULTI_SZ</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-             */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            PWCHAR pos =3D domains;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            while (TRUE)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                /* Terminate the domain at =
the next comma */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            PWCHAR comma =3D wcschr(pos, &#39;,&#39;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                if (comma)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    *comma =3D &#39;\0&#3=
9;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                DWORD domain_len =3D (DWORD=
)wcslen(pos);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        DWORD domain_size =3D domain_len * glyph_size;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                DWORD converted_size =3D (=
DWORD)(pos - domains) * glyph_size;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         /* Ignore itf domains which match a pushed search domain */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                if (ListCont=
ainsDomain(search_domains, pos, domain_len))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    if (comma)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        /* Overwrite the ignore=
d domain with remaining one(s) */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        memmove(pos, comma + 1, buf_size - conv=
erted_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
               *size -=3D domain_size + glyph_size;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        continue;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        /* T=
his was the last domain */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        *pos =3D &#39;\0&#39;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        *size -=3D domain_s=
ize;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                /* Add space for the leading dot */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                domain_len =
+=3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  domain_size +=3D glyph_size;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    /* Space for the terminating zeros */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                const DWORD extra_size =3D 2 * glyph_si=
ze;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                /* Check for enough spa=
ce to convert this domain */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                if (converted_size + domain_size + extra_size &gt; b=
uf_size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   /* Domain doesn&#39;t fit, bad luck if it&#39;s the first one */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    *pos =3D =
&#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            *size =3D converted_size =3D=3D 0 ? 0 : converted_size + glyph_=
size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    return ERROR_MORE_DATA;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* =
Prefix domain at pos with the dot */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                memmove(pos + 1, pos, buf_size - converted_s=
ize - glyph_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             domains[buf_len - 1] =3D &#39;\0&#39;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                *pos =3D &#39;.&#39;;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                *size +=3D =
glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                if (!comma)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    /* Conver=
sion is done */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              *(pos + domain_len) =3D &#39;\0&#39;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    *size +=3D glyph_size;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    re=
turn NO_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                /* Comma pos is =
now +1 after adding leading dot */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                pos =3D comma + 2;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return ConvertItfDnsDomains(search_domains,=
 domains, size, buf_size);</span><br><span>         }</span><br><span>     =
}</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1458?usp=3Demail">change 1458<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1458?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib517457015b754d59aeb70827c4=
795aa6154728c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1458 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--h30v8yPlLGA=--

