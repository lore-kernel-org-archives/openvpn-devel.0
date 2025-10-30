From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 16:37:35 +0000
In-Reply-To: <gerrit.1761565272000.I329b407693b97dd048bd3788ecad345d6e25dab2@...2715...>
References: <gerrit.1761565272000.I329b407693b97dd048bd3788ecad345d6e25dab2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <4a06f987dd9ca65acb4a51694787b78ac426b9b9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JPRA97XZAQA="; charset=UTF-8
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
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JPRA97XZAQA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


Change subject: iservice: use interface index with netsh
......................................................................

iservice: use interface index with netsh

We use the interface index with netsh everywhere else, so convert this
invocation of netsh to index use as well.

Remove CmpWString() as it is no longer used anywhere.

Change-Id: I329b407693b97dd048bd3788ecad345d6e25dab2
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1308
Message-Id: <20251030150214.4161-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
037.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 26 insertions(+), 44 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1308/4

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index cb31267..577d89c 100644
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

@@ -1051,12 +1051,6 @@
     return err;
 }
=20
-static BOOL
-CmpWString(LPVOID item, LPVOID str)
-{
-    return (wcscmp(item, str) =3D=3D 0) ? TRUE : FALSE;
-}
-
 /**
  * Signal the DNS resolver (and others potentially) to reload the
  * group policy (DNS) settings on 32 bit Windows systems
@@ -2882,7 +2876,7 @@
 static DWORD
 HandleWINSConfigMessage(const wins_cfg_message_t *msg, undo_lists_t *lists)
 {
-    DWORD err =3D 0;
+    DWORD err =3D NO_ERROR;
     wchar_t addr[16]; /* large enough to hold string representation of an =
ipv4 */
     int addr_len =3D msg->addr_len;

@@ -2892,38 +2886,25 @@
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
@@ -2931,7 +2912,7 @@
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
@@ -2941,22 +2922,23 @@
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

@@ -3206,7 +3188,7 @@
                     break;

                 case undo_wins:
-                    netsh_wins_cmd(L"delete", item->data, NULL);
+                    netsh_wins_cmd(L"delete", *(int *)item->data, NULL);
                     break;

                 case wfp_block:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I329b407693b97dd048bd3788ecad345d6e25dab2
Gerrit-Change-Number: 1308
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JPRA97XZAQA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by stipa</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">iservice: use interface index with =
netsh<br><br>We use the interface index with netsh everywhere else, so conv=
ert this<br>invocation of netsh to index use as well.<br><br>Remove CmpWStr=
ing() as it is no longer used anywhere.<br><br>Change-Id: I329b407693b97dd0=
48bd3788ecad345d6e25dab2<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&=
gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Gerrit URL: ht=
tps://gerrit.openvpn.net/c/openvpn/+/1308<br>Message-Id: &lt;20251030150214=
.4161-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg34037.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file cha=
nged, 26 insertions(+), 44 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1308/4</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</spa=
n><br><span>index cb31267..577d89c 100644</span><br><span>--- a/src/openvpn=
serv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</spa=
n><br><span>@@ -995,16 +995,16 @@</span><br><span> }</span><br><span> </spa=
n><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Ru=
n the command: netsh interface ip $action wins $if_name [static] $addr</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Run the command: nets=
h interface ip $action wins $if_index [static] $addr</span><br><span>  * @p=
aram  action      &quot;delete&quot;, &quot;add&quot; or &quot;set&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param  if_name     &=
quot;name_of_interface&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param  if_index    index of the interface to modify WINS for</=
span><br><span>  * @param  addr        IPv4 address as a string</span><br><=
span>  *</span><br><span>  * If addr is null and action =3D &quot;delete&qu=
ot; all addresses are deleted.</span><br><span>  * if action =3D &quot;set&=
quot; then &quot;static&quot; is added before $addr</span><br><span>  */</s=
pan><br><span> static DWORD</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-netsh_wins_cmd(const wchar_t *action, const wchar_t *if_name, const w=
char_t *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+netsh_=
wins_cmd(const wchar_t *action, int if_index, const wchar_t *addr)</span><b=
r><span> {</span><br><span>     DWORD err =3D 0;</span><br><span>     int t=
imeout =3D 30000; /* in msec */</span><br><span>@@ -1030,10 +1030,10 @@</sp=
an><br><span>     /* cmd template:</span><br><span>      * netsh interface =
ip $action wins $if_name $static $addr</span><br><span>      */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    const wchar_t *fmt =3D L&quot=
;netsh interface ip %ls wins \&quot;%ls\&quot; %ls %ls&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const wchar_t *fmt =3D L&quot=
;netsh interface ip %ls wins %d %ls %ls&quot;;</span><br><span> </span><br>=
<span>     /* max cmdline length in wchars -- include room for worst case a=
nd some */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t =
ncmdline =3D wcslen(fmt) + wcslen(if_name) + wcslen(action) + wcslen(addr)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t ncmdline =
=3D wcslen(fmt) + 11 /*if_index*/ + wcslen(action) + wcslen(addr)</span><br=
><span>                       + wcslen(addr_static) + 32 + 1;</span><br><sp=
an>     cmdline =3D malloc(ncmdline * sizeof(wchar_t));</span><br><span>   =
  if (!cmdline)</span><br><span>@@ -1042,7 +1042,7 @@</span><br><span>     =
    goto out;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    swprintf(cmdline, ncmdline, fmt, actio=
n, if_name, addr_static, addr);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    swprintf(cmdline, ncmdline, fmt, action, if_index, addr_sta=
tic, addr);</span><br><span> </span><br><span>     err =3D ExecCommand(argv=
0, cmdline, timeout);</span><br><span> </span><br><span>@@ -1051,12 +1051,6=
 @@</span><br><span>     return err;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static BOOL</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-CmpWString(LPVOID item, LPVOID st=
r)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return (wcscmp(item, str) =3D=3D 0)=
 ? TRUE : FALSE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</sp=
an><br><span>  * Signal the DNS resolver (and others potentially) to reload=
 the</span><br><span>  * group policy (DNS) settings on 32 bit Windows syst=
ems</span><br><span>@@ -2882,7 +2876,7 @@</span><br><span> static DWORD</sp=
an><br><span> HandleWINSConfigMessage(const wins_cfg_message_t *msg, undo_l=
ists_t *lists)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    DWORD err =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    DWORD err =3D NO_ERROR;</span><br><span>     wchar_t addr[=
16]; /* large enough to hold string representation of an ipv4 */</span><br>=
<span>     int addr_len =3D msg-&gt;addr_len;</span><br><span> </span><br><=
span>@@ -2892,38 +2886,25 @@</span><br><span>         addr_len =3D _countof=
(msg-&gt;addr);</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!msg-&gt;iface.name[0]) /* inter=
face name is required */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!msg-&gt;iface.index) /* interface index is required */</span>=
<br><span>     {</span><br><span>         return ERROR_MESSAGE_DATA;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* use a non-const reference with limited scope to enforce=
 null-termination of strings from</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * client */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        w=
ins_cfg_message_t *msgptr =3D (wins_cfg_message_t *)msg;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msgptr-&gt;iface.name[_countof(m=
sg-&gt;iface.name) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wchar_t *wide=
_name =3D utf8to16(msg-&gt;iface.name); /* utf8 to wide-char */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!wide_name)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return ERROR_OUTOFMEMORY;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span>     /* We delete all current addresse=
s before adding any</span><br><span>      * OR if the message type is del_w=
ins_cfg</span><br><span>      */</span><br><span>     if (addr_len &gt; 0 |=
| msg-&gt;header.type =3D=3D msg_del_wins_cfg)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D netsh_wins_=
cmd(L&quot;delete&quot;, wide_name, NULL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        err =3D netsh_wins_cmd(L&quot;delete&quot;, =
msg-&gt;iface.index, NULL);</span><br><span>         if (err)</span><br><sp=
an>         {</span><br><span>             goto out;</span><br><span>      =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(Remo=
veListItem(&amp;(*lists)[undo_wins], CmpWString, wide_name));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        free(RemoveListItem(&amp;=
(*lists)[undo_wins], CmpAny, NULL));</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (msg-&gt;hea=
der.type =3D=3D msg_del_wins_cfg)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (addr_len =3D=3D 0 || msg-&gt;header.type =3D=3D msg_d=
el_wins_cfg)</span><br><span>     {</span><br><span>         goto out; /* j=
ob done */</span><br><span>     }</span><br><span>@@ -2931,7 +2912,7 @@</sp=
an><br><span>     for (int i =3D 0; i &lt; addr_len; ++i)</span><br><span> =
    {</span><br><span>         RtlIpv4AddressToStringW(&amp;msg-&gt;addr[i]=
.ipv4, addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
err =3D netsh_wins_cmd(i =3D=3D 0 ? L&quot;set&quot; : L&quot;add&quot;, wi=
de_name, addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    err =3D netsh_wins_cmd(i =3D=3D 0 ? L&quot;set&quot; : L&quot;add&quot;=
, msg-&gt;iface.index, addr);</span><br><span>         if (i =3D=3D 0 &amp;=
&amp; err)</span><br><span>         {</span><br><span>             goto out=
;</span><br><span>@@ -2941,22 +2922,23 @@</span><br><span>          */</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (addr_=
len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
*if_index =3D malloc(sizeof(msg-&gt;iface.index));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (if_index)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        wchar_t *tmp_name=
 =3D _wcsdup(wide_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (!tmp_name || AddListItem(&amp;(*lists)[undo_wins], tmp_name)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            free(tmp_name);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            netsh_wins_cmd=
(L&quot;delete&quot;, wide_name, NULL);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            err =3D ERROR_OUTOFMEMORY;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            goto out;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        *if_index =3D msg-&gt;iface.index;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!if_index || AddListItem(&amp;(*lists)[undo_wins], if=
_index))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(if_index);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        netsh_wins_cm=
d(L&quot;delete&quot;, msg-&gt;iface.index, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        err =3D ERROR_OUTOFMEMORY;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    err =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> out:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    free(wide_name);</span><br><span>     return err;</span><br><spa=
n> }</span><br><span> </span><br><span>@@ -3206,7 +3188,7 @@</span><br><spa=
n>                     break;</span><br><span> </span><br><span>           =
      case undo_wins:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    netsh_wins_cmd(L&quot;delete&quot;, item-&gt;data, NULL=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   netsh_wins_cmd(L&quot;delete&quot;, *(int *)item-&gt;data, NULL);</span>=
<br><span>                     break;</span><br><span> </span><br><span>   =
              case wfp_block:</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail">ch=
ange 1308</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I329b407693b97dd048bd3788eca=
d345d6e25dab2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1308 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--JPRA97XZAQA=--

