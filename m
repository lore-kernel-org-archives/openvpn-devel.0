From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 May 2026 11:27:30 +0000
References: <gerrit.1778239616000.Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <85f2f6614582d4930cb583639cfdde09d3d0036f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GY+xGiZJW6c="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Address
 some uninitVariable warnings from cppcheck
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

--GY+xGiZJW6c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1674?usp=3Demail

to review the following change.


Change subject: openvpnserv: Address some uninitVariable warnings from cppc=
heck
......................................................................

openvpnserv: Address some uninitVariable warnings from cppcheck

In the first case this is about helping cppcheck
remember that msg->addr_len and addr_len are the same
thing, but we use them in confusing ways.

In the second case there is indeed a theoretical
code path where we use an uninitialized buffer. So
make the code safer.

Change-Id: Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnserv/interactive.c
1 file changed, 19 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1674/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index bd310e4..781391c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1876,7 +1876,7 @@
         return err; /* job done */
     }

-    if (msg->addr_len > 0)
+    if (addr_len > 0)
     {
         /* prepare the comma separated address list */
         /* cannot use max_addrs here as that is not considered compile
@@ -2647,25 +2647,28 @@
         free(wide_search_domains);
     }

-    /* Create address string list */
-    CHAR addr_list[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];
-    PSTR pos =3D addr_list;
-    for (int i =3D 0; i < NRPT_ADDR_NUM && addresses[i][0]; ++i)
+    if (addresses[0][0])
     {
-        if (i !=3D 0)
+        /* Create address string list */
+        CHAR addr_list[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];
+        PSTR pos =3D addr_list;
+        for (int i =3D 0; i < NRPT_ADDR_NUM && addresses[i][0]; ++i)
         {
-            *pos++ =3D ';';
+            if (i !=3D 0)
+            {
+                *pos++ =3D ';';
+            }
+            strcpy(pos, addresses[i]);
+            pos +=3D strlen(pos);
         }
-        strcpy(pos, addresses[i]);
-        pos +=3D strlen(pos);
-    }

-    WCHAR subkey[MAX_PATH];
-    swprintf(subkey, _countof(subkey), L"OpenVPNDNSRouting-%lu", ovpn_pid);
-    err =3D SetNrptRule(nrpt_key, subkey, addr_list, wide_domains, dom_siz=
e, dnssec);
-    if (err)
-    {
-        MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%lu)", __func__,=
 subkey, err);
+        WCHAR subkey[MAX_PATH];
+        swprintf(subkey, _countof(subkey), L"OpenVPNDNSRouting-%lu", ovpn_=
pid);
+        err =3D SetNrptRule(nrpt_key, subkey, addr_list, wide_domains, dom=
_size, dnssec);
+        if (err)
+        {
+            MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%lu)", __fun=
c__, subkey, err);
+        }
     }

     if (domains[0])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1674?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f
Gerrit-Change-Number: 1674
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--GY+xGiZJW6c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1674?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openvpnserv: Address some uninitVariable wa=
rnings from cppcheck<br><br>In the first case this is about helping cppchec=
k<br>remember that msg-&gt;addr_len and addr_len are the same<br>thing, but=
 we use them in confusing ways.<br><br>In the second case there is indeed a=
 theoretical<br>code path where we use an uninitialized buffer. So<br>make =
the code safer.<br><br>Change-Id: Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M s=
rc/openvpnserv/interactive.c<br>1 file changed, 19 insertions(+), 16 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/74/1674/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interact=
ive.c b/src/openvpnserv/interactive.c</span><br><span>index bd310e4..781391=
c 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><spa=
n>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -1876,7 +1876,7 @@=
</span><br><span>         return err; /* job done */</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (msg-&gt;addr_len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (addr_len &gt; 0)</span><br><span>     {</span><br><span> =
        /* prepare the comma separated address list */</span><br><span>    =
     /* cannot use max_addrs here as that is not considered compile</span><=
br><span>@@ -2647,25 +2647,28 @@</span><br><span>         free(wide_search_=
domains);</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* Create address string list */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    CHAR addr_list[NRPT_ADDR_NU=
M * NRPT_ADDR_SIZE];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   PSTR pos =3D addr_list;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    for (int i =3D 0; i &lt; NRPT_ADDR_NUM &amp;&amp; addresses[i][0];=
 ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (addres=
ses[0][0])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (i !=3D 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* Create address string list */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        CHAR addr_list[NRPT_ADDR_NUM * N=
RPT_ADDR_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    PSTR pos =3D addr_list;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        for (int i =3D 0; i &lt; NRPT_ADDR_NUM &amp;&amp; addresses=
[i][0]; ++i)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            *pos++ =3D &#39;;&#39;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (i !=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                *pos++ =3D &#39;;&#39;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            strcpy(pos, add=
resses[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    pos +=3D strlen(pos);</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        strcpy(pos, addresses[i]);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        pos +=3D strlen(pos);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    WCHAR subkey[MAX=
_PATH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(s=
ubkey, _countof(subkey), L&quot;OpenVPNDNSRouting-%lu&quot;, ovpn_pid);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    err =3D SetNrptRule(n=
rpt_key, subkey, addr_list, wide_domains, dom_size, dnssec);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (err)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        MsgToEventLog(M_ERR, L&quot;%S: failed to set rule =
%s (%lu)&quot;, __func__, subkey, err);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        WCHAR subkey[MAX_PATH];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        swprintf(subkey, _countof(subkey)=
, L&quot;OpenVPNDNSRouting-%lu&quot;, ovpn_pid);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        err =3D SetNrptRule(nrpt_key, subkey, =
addr_list, wide_domains, dom_size, dnssec);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (err)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            MsgToEventLog(M_ERR, L&quot;%S: failed to set rule %=
s (%lu)&quot;, __func__, subkey, err);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </span=
><br><span>     if (domains[0])</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1674?usp=3Demail">=
change 1674</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1674?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ida6d4fa8c5c5ffbd7909d6afd51=
b1b6f32ca2d9f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1674 </div>
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

--GY+xGiZJW6c=--

