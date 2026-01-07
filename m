From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 7 Jan 2026 17:58:06 +0000
References: <gerrit.1767808679000.Ib517457015b754d59aeb70827c4795aa6154728c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <49908b3b04cda3ea0a76c4724a4da914c19170b3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uARw2AlaRiA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uARw2AlaRiA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1458?usp=3Demail

to review the following change.


Change subject: openvpnserv: Factor out the string conversion from GetItfDn=
sDomains
......................................................................

openvpnserv: Factor out the string conversion from GetItfDnsDomains

Mostly so that we can actually test it. Since that
code does some in-place conversions a test would be
good.

Change-Id: Ib517457015b754d59aeb70827c4795aa6154728c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnserv/interactive.c
1 file changed, 101 insertions(+), 71 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/1458/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 8b418ce..f30394a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2143,6 +2143,106 @@
 }
=20
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
@@ -2183,77 +2283,7 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib517457015b754d59aeb70827c4795aa6154728c
Gerrit-Change-Number: 1458
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--uARw2AlaRiA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1458?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openvpnserv: Factor out the string conversi=
on from GetItfDnsDomains<br><br>Mostly so that we can actually test it. Sin=
ce that<br>code does some in-place conversions a test would be<br>good.<br>=
<br>Change-Id: Ib517457015b754d59aeb70827c4795aa6154728c<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpnserv/inte=
ractive.c<br>1 file changed, 101 insertions(+), 71 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/58/1458/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/openvp=
nserv/interactive.c</span><br><span>index 8b418ce..f30394a 100644</span><br=
><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvp=
nserv/interactive.c</span><br><span>@@ -2143,6 +2143,106 @@</span><br><span=
> }</span><br><span> </span><br><span> /**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Convert interface specific domain suffix(es) from=
 comma-separated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
string to MULTI_SZ string.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The \p =
domains paramter will be set to a MULTI_SZ domains string.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * In case of an error \p size is se=
t to 0 and the contents of \p domains</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * are invalid.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Note that domains are deleted from the string if they matc=
h a search domain.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param[in]     =
search_domains  optional list of search domains</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param[in,out] domains         buffer that c=
ontains the input comma-separated</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *                                string and will contain the=
 MULTI_SZ output string</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param[in,out] size            pointer to size of the input string i=
n bytes. Will be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
                               set to the size of the string returned, incl=
uding</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
                    the terminating zeros or 0.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param[in]     buf_size        size of the \=
p domains buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return LSTATUS N=
O_ERROR if the domain suffix(es) were read successfully,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *         ERROR_FILE_NOT_FOUND if no =
domain was found for the interface,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *         ERROR_MORE_DATA if the list did not fit into the=
 buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static LSTATUS</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ConvertItfDnsDomains(PCWSTR searc=
h_domains, PWSTR domains, PDWORD size, const DWORD buf_size)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const DWORD glyph_size =3D sizeof(*domains);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const DWORD buf_len=
 =3D buf_size / glyph_size;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Found domain(s), =
now convert them:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   *   - prefix each domain with a dot</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     *   - convert comma separated list to MULTI_SZ</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    PWCHAR pos =3D domains;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    while (TRUE)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* Terminate the domain at the next c=
omma */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PWCH=
AR comma =3D wcschr(pos, &#39;,&#39;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (comma)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            *comma =3D &#39;\0&#39;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    DWORD domain_len =3D (DWORD)wcslen(pos);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        DWORD domain_size =3D domain_len * glyph_s=
ize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD c=
onverted_size =3D (DWORD)(pos - domains) * glyph_size;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* Ignore itf domains which match a pushed search d=
omain */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(ListContainsDomain(search_domains, pos, domain_len))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (comma)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                /* Overwrite the ignored domain with r=
emaining one(s) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               memmove(pos, comma + 1, buf_size - converted_size);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                *size -=3D d=
omain_size + glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                continue;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            /* This was the last domain */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                *pos =3D &#39;\0&#39;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                *size -=3D domain=
_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* Add space for the leading dot */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        domain_len +=3D 1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        domain_size +=3D glyph_size;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* Space for the terminating zer=
os */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
DWORD extra_size =3D 2 * glyph_size;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* Check for enough space to convert this domain */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (converted_size + domain_s=
ize + extra_size &gt; buf_size)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /* Domain doesn&#39;t fit, bad luck if it&#39;s the first one=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *pos=
 =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           *size =3D converted_size =3D=3D 0 ? 0 : converted_size + glyph_s=
ize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret=
urn ERROR_MORE_DATA;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* Prefix domain at =
pos with the dot */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        memmove(pos + 1, pos, buf_size - converted_size - glyph_size);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        domains[buf_len =
- 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        *pos =3D &#39;.&#39;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        *size +=3D glyph_size;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (!comma)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* Conversion is done */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            *(pos + domain_len) =3D &#39;\0&#39;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            *size +=3D glyph_size=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 NO_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* Comma pos is now +1 after a=
dding leading dot */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        pos =3D comma + 2;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Return interface =
specific domain suffix(es)</span><br><span>  *</span><br><span>  * The \p d=
omains paramter will be set to a MULTI_SZ domains string.</span><br><span>@=
@ -2183,77 +2283,7 @@</span><br><span>         err =3D RegGetValueW(itf, NU=
LL, values[i], RRF_RT_REG_SZ, NULL, (PBYTE)domains, size);</span><br><span>=
         if (!err &amp;&amp; *size &gt; glyph_size &amp;&amp; domains[(*siz=
e / glyph_size) - 1] =3D=3D &#39;\0&#39; &amp;&amp; wcschr(domains, &#39;.&=
#39;))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            /*</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-             * Found domain(s), now convert them:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-             *   - prefix each domain with=
 a dot</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * =
  - convert comma separated list to MULTI_SZ</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-             */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            PWCHAR pos =3D domains;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            while (TRUE)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                /* Terminate the domain at the n=
ext comma */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       PWCHAR comma =3D wcschr(pos, &#39;,&#39;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                if (comma)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    *comma =3D &#39;\0&#39;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                DWORD domain_len =3D (DWORD)wcsl=
en(pos);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   DWORD domain_size =3D domain_len * glyph_size;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                DWORD converted_size =3D (DWORD=
)(pos - domains) * glyph_size;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    /* Ignore itf domains which match a pushed search domain */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                if (ListContainsD=
omain(search_domains, pos, domain_len))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    if (comma)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        /* Overwrite the ignored dom=
ain with remaining one(s) */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                        memmove(pos, comma + 1, buf_size - converted=
_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
          *size -=3D domain_size + glyph_size;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        continue;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        /* This was=
 the last domain */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                      *pos =3D &#39;\0&#39;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        *size -=3D domain_size;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        re=
turn wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                /* Add space for the leading dot */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                domain_len +=3D 1;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                domai=
n_size +=3D glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* =
Space for the terminating zeros */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                const DWORD extra_size =3D 2 * glyph_size;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                /* Check for enough space to c=
onvert this domain */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                if (converted_size + domain_size + extra_size &gt; buf_size=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    /* D=
omain doesn&#39;t fit, bad luck if it&#39;s the first one */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    *pos =3D &#39;\0=
&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     *size =3D converted_size =3D=3D 0 ? 0 : converted_size + glyph_size;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ret=
urn ERROR_MORE_DATA;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* Prefix =
domain at pos with the dot */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                memmove(pos + 1, pos, buf_size - converted_size - g=
lyph_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      domains[buf_len - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                *pos =3D &#39;.&#39;;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                *size +=3D glyph_siz=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                if (!comma)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    /* Conversion is d=
one */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     *(pos + domain_len) =3D &#39;\0&#39;;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    *size +=3D glyph_size;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    return NO_ERR=
OR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                /* Comma pos is now +1 afte=
r adding leading dot */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                pos =3D comma + 2;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return ConvertItfDnsDomains(search_domains, domains, s=
ize, buf_size);</span><br><span>         }</span><br><span>     }</span><br=
><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1458?usp=3Demail">change 1458</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1458?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib517457015b754d59aeb70827c4=
795aa6154728c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1458 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--uARw2AlaRiA=--

