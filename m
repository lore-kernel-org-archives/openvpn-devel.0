From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sat, 21 Dec 2024 22:40:04 +0000
In-Reply-To: <gerrit.1733989644000.I6b4aa3d63c0b684bf95841271c04bc5d9c37793b@...2715...>
References: <gerrit.1733989644000.I6b4aa3d63c0b684bf95841271c04bc5d9c37793b@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <afc42545aa160c97c0b03e3518286f1077cfb7bd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZVCmCW6Mcos="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: service: add
 utf8to16 function that takes a size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZVCmCW6Mcos=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/836?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: service: add utf8to16 function that takes a size
......................................................................

service: add utf8to16 function that takes a size

utf8to16_size() takes the size of the to be converted string. This is
needed to convert MULTI_SZ strings, which contain inline NUL characters,
but can be useful in other cases as well.

Change-Id: I6b4aa3d63c0b684bf95841271c04bc5d9c37793b
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/common.c
M src/openvpnserv/service.h
2 files changed, 37 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/836/2

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 96bf800..61a7296 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -247,17 +247,16 @@
     return error;
 }

-/* Convert a utf8 string to utf16. Caller should free the result */
 wchar_t *
-utf8to16(const char *utf8)
+utf8to16_size(const char *utf8, int size)
 {
-    int n =3D MultiByteToWideChar(CP_UTF8, 0, utf8, -1, NULL, 0);
+    int n =3D MultiByteToWideChar(CP_UTF8, 0, utf8, size, NULL, 0);
     wchar_t *utf16 =3D malloc(n * sizeof(wchar_t));
     if (!utf16)
     {
         return NULL;
     }
-    MultiByteToWideChar(CP_UTF8, 0, utf8, -1, utf16, n);
+    MultiByteToWideChar(CP_UTF8, 0, utf8, size, utf16, n);
     return utf16;
 }

diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 6d0827d..6b559a5 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -89,8 +89,40 @@

 DWORD MsgToEventLog(DWORD flags, LPCTSTR lpszMsg, ...);

-/* Convert a utf8 string to utf16. Caller should free the result */
-wchar_t *utf8to16(const char *utf8);
+/**
+ * Convert a UTF-8 string to UTF-16
+ *
+ * The size parameter can be used to convert strings which contain inline =
NUL
+ * characters, like MULTI_SZ strings used as values in the registry do,
+ * or (sub)strings that are not zero terminated. If size is -1 the length
+ * of the string is determined automatically by the WIN32 API. Make sure
+ * you pass a terminated string or else bad things will happen. Note that
+ * the size you pass should always include the terminating zero as well.
+ *
+ * If the returned string is not NULL it must be freed by the caller.
+ *
+ * @param utf8  const string to be converted
+ * @param size  the size of the string
+ *
+ * @return wchar_t* heap allocated result string
+ */
+wchar_t *utf8to16_size(const char *utf8, int size);
+
+/**
+ * Convert a zero terminated UTF-8 string to UTF-16
+ *
+ * This is just a wrapper function that always passes -1 as string size
+ * to \ref utf8to16_size.
+ *
+ * @param utf8  const string to be converted
+ *
+ * @return wchar_t* heap allocated result string
+ */
+static inline wchar_t *
+utf8to16(const char *utf8)
+{
+    return utf8to16_size(utf8, -1);
+}

 /* return windows system directory as a pointer to a static string */
 const wchar_t *get_win_sys_path(void);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/836?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b4aa3d63c0b684bf95841271c04bc5d9c37793b
Gerrit-Change-Number: 836
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--ZVCmCW6Mcos=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p>d12fk <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/836?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">service: add utf8to16 function that takes a s=
ize<br><br>utf8to16_size() takes the size of the to be converted string. Th=
is is<br>needed to convert MULTI_SZ strings, which contain inline NUL chara=
cters,<br>but can be useful in other cases as well.<br><br>Change-Id: I6b4a=
a3d63c0b684bf95841271c04bc5d9c37793b<br>Signed-off-by: Heiko Hund &lt;heiko=
@...2662...&gt;<br>---<br>M src/openvpnserv/common.c<br>M src/openvpnserv/s=
ervice.h<br>2 files changed, 37 insertions(+), 6 deletions(-)<br><br></pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/836/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c</span><br>=
<span>index 96bf800..61a7296 100644</span><br><span>--- a/src/openvpnserv/c=
ommon.c</span><br><span>+++ b/src/openvpnserv/common.c</span><br><span>@@ -=
247,17 +247,16 @@</span><br><span>     return error;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Conv=
ert a utf8 string to utf16. Caller should free the result */</span><br><spa=
n> wchar_t *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-utf8to16(=
const char *utf8)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ut=
f8to16_size(const char *utf8, int size)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int n =3D MultiByteToWideChar(CP_U=
TF8, 0, utf8, -1, NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int n =3D MultiByteToWideChar(CP_UTF8, 0, utf8, size, NULL, 0);=
</span><br><span>     wchar_t *utf16 =3D malloc(n * sizeof(wchar_t));</span=
><br><span>     if (!utf16)</span><br><span>     {</span><br><span>        =
 return NULL;</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    MultiByteToWideChar(CP_UTF8, 0, utf8, -1, utf16, n);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    MultiByteToWideChar=
(CP_UTF8, 0, utf8, size, utf16, n);</span><br><span>     return utf16;</spa=
n><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpnse=
rv/service.h b/src/openvpnserv/service.h</span><br><span>index 6d0827d..6b5=
59a5 100644</span><br><span>--- a/src/openvpnserv/service.h</span><br><span=
>+++ b/src/openvpnserv/service.h</span><br><span>@@ -89,8 +89,40 @@</span><=
br><span> </span><br><span> DWORD MsgToEventLog(DWORD flags, LPCTSTR lpszMs=
g, ...);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/* Convert a utf8 string to utf16. Caller should free the result */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-wchar_t *utf8to16(const =
char *utf8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Convert a UTF-8 stri=
ng to UTF-16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The size parameter ca=
n be used to convert strings which contain inline NUL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * characters, like MULTI_SZ strings used=
 as values in the registry do,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * or (sub)strings that are not zero terminated. If size is -1 t=
he length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of the =
string is determined automatically by the WIN32 API. Make sure</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * you pass a terminated string =
or else bad things will happen. Note that</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * the size you pass should always include the termin=
ating zero as well.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If the returne=
d string is not NULL it must be freed by the caller.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param utf8  const string to be converted</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param size  the size of the s=
tring</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return wchar_t* heap alloca=
ted result string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wchar_t *utf8to16_=
size(const char *utf8, int size);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Convert a zero ter=
minated UTF-8 string to UTF-16</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Thi=
s is just a wrapper function that always passes -1 as string size</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * to \ref utf8to16_size.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param utf8  const string to be conve=
rted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return wchar_t* heap allocat=
ed result string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline wchar=
_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+utf8to16(const =
char *utf8)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return utf8to16_size(u=
tf8, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span> </span><br><span> /* return windows system directory as a pointer =
to a static string */</span><br><span> const wchar_t *get_win_sys_path(void=
);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/836?usp=3Demail">change 836</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/836?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b4aa3d63c0b684bf95841271c0=
4bc5d9c37793b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 836 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ZVCmCW6Mcos=--

