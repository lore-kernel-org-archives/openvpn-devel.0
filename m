From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 8 Jan 2026 13:36:56 +0000
In-Reply-To: <gerrit.1767808679000.Ib517457015b754d59aeb70827c4795aa6154728c@...2715...>
References: <gerrit.1767808679000.Ib517457015b754d59aeb70827c4795aa6154728c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <99612b2afb69a01f68badb8f279b3c7ab7afca1f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4Swf2QWic+Q="; charset=UTF-8
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

--4Swf2QWic+Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1458?usp=3Demail

to look at the new patch set (#4).


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
1 file changed, 101 insertions(+), 72 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/1458/4

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 8b817ed..00657b0 100644
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib517457015b754d59aeb70827c4795aa6154728c
Gerrit-Change-Number: 1458
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--4Swf2QWic+Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1458?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">openvpnserv: Factor out the string conversion fr=
om GetItfDnsDomains<br><br>Mostly so that we can actually test it. Since th=
at<br>code does some in-place conversions a test would be<br>good.<br><br>C=
hange-Id: Ib517457015b754d59aeb70827c4795aa6154728c<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpnserv/interacti=
ve.c<br>1 file changed, 101 insertions(+), 72 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/=
1458/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv=
/interactive.c</span><br><span>index 8b817ed..00657b0 100644</span><br><spa=
n>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv=
/interactive.c</span><br><span>@@ -2143,6 +2143,106 @@</span><br><span> }</=
span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Convert interface specific domain suffix(es) from comm=
a-separated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * strin=
g to MULTI_SZ string.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The \p domai=
ns paramter will be set to a MULTI_SZ domains string.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * In case of an error \p size is set to =
0 and the contents of \p domains</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * are invalid.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Note that domains are deleted from the string if they match a s=
earch domain.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param[in]     searc=
h_domains  optional list of search domains</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param[in,out] domains         buffer that contai=
ns the input comma-separated</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *                                string and will contain the MULT=
I_SZ output string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param[in,out] size            pointer to size of the input string in byt=
es. Will be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
                          set to the size of the string returned, including=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                 =
               the terminating zeros or 0.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param[in]     buf_size        size of the \p dom=
ains buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return LSTATUS NO_ERR=
OR if the domain suffix(es) were read successfully,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *         ERROR_FILE_NOT_FOUND if no dom=
ain was found for the interface,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *         ERROR_MORE_DATA if the list did not fit into the bu=
ffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static LSTATUS</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ConvertItfDnsDomains(PCWSTR search_d=
omains, PWSTR domains, PDWORD size, const DWORD buf_size)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const DWORD glyph_size =3D sizeof(*domains);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const DWORD buf_len =
=3D buf_size / glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Found domain(s), n=
ow convert them:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  *   - prefix each domain with a dot</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     *   - convert comma separated list to MULTI_SZ</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    PWCHAR pos =3D domains;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    while (TRUE)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* Terminate the domain at the next co=
mma */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PWCHA=
R comma =3D wcschr(pos, &#39;,&#39;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (comma)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            *comma =3D &#39;\0&#39;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   DWORD domain_len =3D (DWORD)wcslen(pos);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        DWORD domain_size =3D domain_len * glyph_si=
ze;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD co=
nverted_size =3D (DWORD)(pos - domains) * glyph_size;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* Ignore itf domains which match a pushed search do=
main */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
ListContainsDomain(search_domains, pos, domain_len))</span><br><span style=
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
@ -2174,7 +2274,6 @@</span><br><span>     LSTATUS err =3D ERROR_FILE_NOT_FO=
UND;</span><br><span>     const DWORD buf_size =3D *size;</span><br><span> =
    const DWORD glyph_size =3D sizeof(*domains);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const DWORD buf_len =3D buf_size / glyph_siz=
e;</span><br><span>     PWSTR values[] =3D { L&quot;SearchList&quot;, L&quo=
t;Domain&quot;, L&quot;DhcpDomainSearchList&quot;, L&quot;DhcpDomain&quot;,=
 NULL };</span><br><span> </span><br><span>     for (int i =3D 0; values[i]=
; i++)</span><br><span>@@ -2183,77 +2282,7 @@</span><br><span>         err =
=3D RegGetValueW(itf, NULL, values[i], RRF_RT_REG_SZ, NULL, (PBYTE)domains,=
 size);</span><br><span>         if (!err &amp;&amp; *size &gt; glyph_size =
&amp;&amp; domains[(*size / glyph_size) - 1] =3D=3D &#39;\0&#39; &amp;&amp;=
 wcschr(domains, &#39;.&#39;))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            /*</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-             * Found domain(s), now convert th=
em:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *   -=
 prefix each domain with a dot</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-             *   - convert comma separated list to MULTI_SZ</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            PWCHAR pos =3D domains=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            while (T=
RUE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* Termin=
ate the domain at the next comma */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                PWCHAR comma =3D wcschr(pos, &#39;,&#39;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (comm=
a)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    *co=
mma =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                DWORD dom=
ain_len =3D (DWORD)wcslen(pos);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                DWORD domain_size =3D domain_len * glyph_size;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                DWORD co=
nverted_size =3D (DWORD)(pos - domains) * glyph_size;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                /* Ignore itf domains which match a pushed searc=
h domain */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      if (ListContainsDomain(search_domains, pos, domain_len))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    if (comma)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        /* Ov=
erwrite the ignored domain with remaining one(s) */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        memmove(pos, comma =
+ 1, buf_size - converted_size);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        *size -=3D domain_size + glyph_size;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                        c=
ontinue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              /* This was the last domain */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        *pos =3D &#39;\0&#39;;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        *si=
ze -=3D domain_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_F=
OUND;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                /* Add space for the lead=
ing dot */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     domain_len +=3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                domain_size +=3D glyph_size;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                /* Space for the terminating zeros */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                const DWORD extra_size =
=3D 2 * glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* Chec=
k for enough space to convert this domain */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                if (converted_size + domain_size + e=
xtra_size &gt; buf_size)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   /* Domain doesn&#39;t fit, bad luck if it&#39;s the firs=
t one */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       *pos =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    *size =3D converted_size =3D=3D 0 ? 0 : convert=
ed_size + glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    return ERROR_MORE_DATA;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             /* Prefix domain at pos with the dot */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                memmove(pos + 1, pos, buf_s=
ize - converted_size - glyph_size);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                domains[buf_len - 1] =3D &#39;\0&#39;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                *pos =3D &#3=
9;.&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    *size +=3D glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
if (!comma)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      /* Conversion is done */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    *(pos + domain_len) =3D &#39;\0&#39;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    *size +=3D=
 glyph_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           return NO_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* =
Comma pos is now +1 after adding leading dot */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                pos =3D comma + 2;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return ConvertItfDnsDomains(s=
earch_domains, domains, size, buf_size);</span><br><span>         }</span><=
br><span>     }</span><br><span> </span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1458?usp=3Demail=
">change 1458</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1458?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib517457015b754d59aeb70827c4=
795aa6154728c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1458 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--4Swf2QWic+Q=--

