From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 11:41:14 +0000
References: <gerrit.1761565272000.I329b407693b97dd048bd3788ecad345d6e25dab2@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <828b963e737c9262baa272e357d5822cbc39adcc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yjJuF6TStV4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: iservice: use
 interface index with netsh
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

--yjJuF6TStV4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail

to review the following change.


Change subject: iservice: use interface index with netsh
......................................................................

iservice: use interface index with netsh

We use the interface index with netsh everywhere else, so convert this
invocation of netsh to index use as well.

Change-Id: I329b407693b97dd048bd3788ecad345d6e25dab2
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 25 insertions(+), 37 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1308/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ce0d4dd..029c1d7 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -995,16 +995,16 @@
 }

 /**
- * Run the command: netsh interface ip $action wins $if_name [static] $addr
+ * Run the command: netsh interface ip $action wins $if_index [static] $ad=
dr
  * @param  action      "delete", "add" or "set"
- * @param  if_name     "name_of_interface"
+ * @param  if_index    index of the interface to modify WINS for
  * @param  addr        IPv4 address as a string
  *
  * If addr is null and action =3D "delete" all addresses are deleted.
  * if action =3D "set" then "static" is added before $addr
  */
 static DWORD
-netsh_wins_cmd(const wchar_t *action, const wchar_t *if_name, const wchar_=
t *addr)
+netsh_wins_cmd(const wchar_t *action, int if_index, const wchar_t *addr)
 {
     DWORD err =3D 0;
     int timeout =3D 30000; /* in msec */
@@ -1030,10 +1030,10 @@
     /* cmd template:
      * netsh interface ip $action wins $if_name $static $addr
      */
-    const wchar_t *fmt =3D L"netsh interface ip %ls wins \"%ls\" %ls %ls";
+    const wchar_t *fmt =3D L"netsh interface ip %ls wins %d %ls %ls";

     /* max cmdline length in wchars -- include room for worst case and som=
e */
-    size_t ncmdline =3D wcslen(fmt) + wcslen(if_name) + wcslen(action) + w=
cslen(addr)
+    size_t ncmdline =3D wcslen(fmt) + 11 /*if_index*/ + wcslen(action) + w=
cslen(addr)
                       + wcslen(addr_static) + 32 + 1;
     cmdline =3D malloc(ncmdline * sizeof(wchar_t));
     if (!cmdline)
@@ -1042,7 +1042,7 @@
         goto out;
     }

-    swprintf(cmdline, ncmdline, fmt, action, if_name, addr_static, addr);
+    swprintf(cmdline, ncmdline, fmt, action, if_index, addr_static, addr);

     err =3D ExecCommand(argv0, cmdline, timeout);

@@ -2882,7 +2882,7 @@
 static DWORD
 HandleWINSConfigMessage(const wins_cfg_message_t *msg, undo_lists_t *lists)
 {
-    DWORD err =3D 0;
+    DWORD err =3D NO_ERROR;
     wchar_t addr[16]; /* large enough to hold string representation of an =
ipv4 */
     int addr_len =3D msg->addr_len;

@@ -2892,38 +2892,25 @@
         addr_len =3D _countof(msg->addr);
     }

-    if (!msg->iface.name[0]) /* interface name is required */
+    if (!msg->iface.index) /* interface index is required */
     {
         return ERROR_MESSAGE_DATA;
     }

-    /* use a non-const reference with limited scope to enforce null-termin=
ation of strings from
-     * client */
-    {
-        wins_cfg_message_t *msgptr =3D (wins_cfg_message_t *)msg;
-        msgptr->iface.name[_countof(msg->iface.name) - 1] =3D '\0';
-    }
-
-    wchar_t *wide_name =3D utf8to16(msg->iface.name); /* utf8 to wide-char=
 */
-    if (!wide_name)
-    {
-        return ERROR_OUTOFMEMORY;
-    }
-
     /* We delete all current addresses before adding any
      * OR if the message type is del_wins_cfg
      */
     if (addr_len > 0 || msg->header.type =3D=3D msg_del_wins_cfg)
     {
-        err =3D netsh_wins_cmd(L"delete", wide_name, NULL);
+        err =3D netsh_wins_cmd(L"delete", msg->iface.index, NULL);
         if (err)
         {
             goto out;
         }
-        free(RemoveListItem(&(*lists)[undo_wins], CmpWString, wide_name));
+        free(RemoveListItem(&(*lists)[undo_wins], CmpAny, NULL));
     }

-    if (msg->header.type =3D=3D msg_del_wins_cfg)
+    if (addr_len =3D=3D 0 || msg->header.type =3D=3D msg_del_wins_cfg)
     {
         goto out; /* job done */
     }
@@ -2931,7 +2918,7 @@
     for (int i =3D 0; i < addr_len; ++i)
     {
         RtlIpv4AddressToStringW(&msg->addr[i].ipv4, addr);
-        err =3D netsh_wins_cmd(i =3D=3D 0 ? L"set" : L"add", wide_name, ad=
dr);
+        err =3D netsh_wins_cmd(i =3D=3D 0 ? L"set" : L"add", msg->iface.in=
dex, addr);
         if (i =3D=3D 0 && err)
         {
             goto out;
@@ -2941,22 +2928,23 @@
          */
     }

-    err =3D 0;
-
-    if (addr_len > 0)
+    int *if_index =3D malloc(sizeof(msg->iface.index));
+    if (if_index)
     {
-        wchar_t *tmp_name =3D _wcsdup(wide_name);
-        if (!tmp_name || AddListItem(&(*lists)[undo_wins], tmp_name))
-        {
-            free(tmp_name);
-            netsh_wins_cmd(L"delete", wide_name, NULL);
-            err =3D ERROR_OUTOFMEMORY;
-            goto out;
-        }
+        *if_index =3D msg->iface.index;
     }

+    if (!if_index || AddListItem(&(*lists)[undo_wins], if_index))
+    {
+        free(if_index);
+        netsh_wins_cmd(L"delete", msg->iface.index, NULL);
+        err =3D ERROR_OUTOFMEMORY;
+        goto out;
+    }
+
+    err =3D 0;
+
 out:
-    free(wide_name);
     return err;
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I329b407693b97dd048bd3788ecad345d6e25dab2
Gerrit-Change-Number: 1308
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--yjJuF6TStV4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">iservice: use interface index with netsh<br=
><br>We use the interface index with netsh everywhere else, so convert this=
<br>invocation of netsh to index use as well.<br><br>Change-Id: I329b407693=
b97dd048bd3788ecad345d6e25dab2<br>Signed-off-by: Heiko Hund &lt;heiko@...2375...=
62...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 25 i=
nsertions(+), 37 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/08/1308/1</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/s=
rc/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><spa=
n>index ce0d4dd..029c1d7 100644</span><br><span>--- a/src/openvpnserv/inter=
active.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><spa=
n>@@ -995,16 +995,16 @@</span><br><span> }</span><br><span> </span><br><spa=
n> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Run the comm=
and: netsh interface ip $action wins $if_name [static] $addr</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Run the command: netsh interfac=
e ip $action wins $if_index [static] $addr</span><br><span>  * @param  acti=
on      &quot;delete&quot;, &quot;add&quot; or &quot;set&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param  if_name     &quot;name_=
of_interface&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param  if_index    index of the interface to modify WINS for</span><br><=
span>  * @param  addr        IPv4 address as a string</span><br><span>  *</=
span><br><span>  * If addr is null and action =3D &quot;delete&quot; all ad=
dresses are deleted.</span><br><span>  * if action =3D &quot;set&quot; then=
 &quot;static&quot; is added before $addr</span><br><span>  */</span><br><s=
pan> static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nets=
h_wins_cmd(const wchar_t *action, const wchar_t *if_name, const wchar_t *ad=
dr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+netsh_wins_cmd(c=
onst wchar_t *action, int if_index, const wchar_t *addr)</span><br><span> {=
</span><br><span>     DWORD err =3D 0;</span><br><span>     int timeout =3D=
 30000; /* in msec */</span><br><span>@@ -1030,10 +1030,10 @@</span><br><sp=
an>     /* cmd template:</span><br><span>      * netsh interface ip $action=
 wins $if_name $static $addr</span><br><span>      */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const wchar_t *fmt =3D L&quot;netsh int=
erface ip %ls wins \&quot;%ls\&quot; %ls %ls&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const wchar_t *fmt =3D L&quot;netsh i=
nterface ip %ls wins %d %ls %ls&quot;;</span><br><span> </span><br><span>  =
   /* max cmdline length in wchars -- include room for worst case and some =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t ncmdline=
 =3D wcslen(fmt) + wcslen(if_name) + wcslen(action) + wcslen(addr)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    size_t ncmdline =3D wcsl=
en(fmt) + 11 /*if_index*/ + wcslen(action) + wcslen(addr)</span><br><span> =
                      + wcslen(addr_static) + 32 + 1;</span><br><span>     =
cmdline =3D malloc(ncmdline * sizeof(wchar_t));</span><br><span>     if (!c=
mdline)</span><br><span>@@ -1042,7 +1042,7 @@</span><br><span>         goto=
 out;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    swprintf(cmdline, ncmdline, fmt, action, if_na=
me, addr_static, addr);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    swprintf(cmdline, ncmdline, fmt, action, if_index, addr_static, add=
r);</span><br><span> </span><br><span>     err =3D ExecCommand(argv0, cmdli=
ne, timeout);</span><br><span> </span><br><span>@@ -2882,7 +2882,7 @@</span=
><br><span> static DWORD</span><br><span> HandleWINSConfigMessage(const win=
s_cfg_message_t *msg, undo_lists_t *lists)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    DWORD err =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    DWORD err =3D NO_ERROR;</span>=
<br><span>     wchar_t addr[16]; /* large enough to hold string representat=
ion of an ipv4 */</span><br><span>     int addr_len =3D msg-&gt;addr_len;</=
span><br><span> </span><br><span>@@ -2892,38 +2892,25 @@</span><br><span>  =
       addr_len =3D _countof(msg-&gt;addr);</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!msg=
-&gt;iface.name[0]) /* interface name is required */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!msg-&gt;iface.index) /* interfac=
e index is required */</span><br><span>     {</span><br><span>         retu=
rn ERROR_MESSAGE_DATA;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* use a non-const reference =
with limited scope to enforce null-termination of strings from</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * client */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        wins_cfg_message_t *msgptr =3D (wins_cfg_messag=
e_t *)msg;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
ptr-&gt;iface.name[_countof(msg-&gt;iface.name) - 1] =3D &#39;\0&#39;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    wchar_t *wide_name =3D utf8to16(msg-&gt;iface.name); /* utf=
8 to wide-char */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!wide_name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return ERROR_O=
UTOFMEMORY;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* W=
e delete all current addresses before adding any</span><br><span>      * OR=
 if the message type is del_wins_cfg</span><br><span>      */</span><br><sp=
an>     if (addr_len &gt; 0 || msg-&gt;header.type =3D=3D msg_del_wins_cfg)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        err =3D netsh_wins_cmd(L&quot;delete&quot;, wide_name, NULL);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D netsh_w=
ins_cmd(L&quot;delete&quot;, msg-&gt;iface.index, NULL);</span><br><span>  =
       if (err)</span><br><span>         {</span><br><span>             got=
o out;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        free(RemoveListItem(&amp;(*lists)[undo_wins], CmpWStrin=
g, wide_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    free(RemoveListItem(&amp;(*lists)[undo_wins], CmpAny, NULL));</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (msg-&gt;header.type =3D=3D msg_del_wins_cfg)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (addr_len =3D=3D 0 || msg=
-&gt;header.type =3D=3D msg_del_wins_cfg)</span><br><span>     {</span><br>=
<span>         goto out; /* job done */</span><br><span>     }</span><br><s=
pan>@@ -2931,7 +2918,7 @@</span><br><span>     for (int i =3D 0; i &lt; add=
r_len; ++i)</span><br><span>     {</span><br><span>         RtlIpv4AddressT=
oStringW(&amp;msg-&gt;addr[i].ipv4, addr);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        err =3D netsh_wins_cmd(i =3D=3D 0 ? L&quot;set=
&quot; : L&quot;add&quot;, wide_name, addr);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        err =3D netsh_wins_cmd(i =3D=3D 0 ? L&quot=
;set&quot; : L&quot;add&quot;, msg-&gt;iface.index, addr);</span><br><span>=
         if (i =3D=3D 0 &amp;&amp; err)</span><br><span>         {</span><b=
r><span>             goto out;</span><br><span>@@ -2941,22 +2928,23 @@</spa=
n><br><span>          */</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (addr_len &gt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int *if_index =3D malloc(sizeof(msg-&gt;iface.inde=
x));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (if_inde=
x)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        wchar_t *tmp_name =3D _wcsdup(wide_name);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!tmp_name || AddListItem(&amp;(=
*lists)[undo_wins], tmp_name))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         free(tmp_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            netsh_wins_cmd(L&quot;delete&quot;, wide_name, NULL);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            err =3D ERROR_OU=
TOFMEMORY;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 goto out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *if_index =3D=
 msg-&gt;iface.index;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!if_index || AddListItem=
(&amp;(*lists)[undo_wins], if_index))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        free(if_index);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        netsh_wins_cmd(L&quot;delete&quot;, msg-&gt;iface.index, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D=
 ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    err =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> out:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    free(wide_name);</span><br><span>  =
   return err;</span><br><span> }</span><br><span> </span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1308?usp=3Demail">change 1308</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
308?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I329b407693b97dd048bd3788eca=
d345d6e25dab2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1308 </div>
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

</body></html>=

--yjJuF6TStV4=--

