From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 20 May 2025 08:42:48 +0000
In-Reply-To: <gerrit.1747725275000.Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1@...2715...>
References: <gerrit.1747725275000.Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f6e92076fa3a222656fc70db1cb0095b1976c1b9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mu3E87/RIh0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win: fix collecting
 DNS exclude data
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

--mu3E87/RIh0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1028?usp=3Demail

to look at the new patch set (#3).


Change subject: win: fix collecting DNS exclude data
......................................................................

win: fix collecting DNS exclude data

The size of the returned MULTI_SZ wide domains string was calculated
wrongly. Instead of adding the size of a WCHAR, only the size of a char
was used. As a result, the domains string was stored too short and was
missing the final string terminator.

DHCP assigned DNS server addresses are separated by space, not comma.
These spaces were not replaced by semicolon, as the spec requires.

Fixes: OpenVPN/openvpn#747
Change-Id: Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/interactive.c
1 file changed, 5 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/1028/3

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a1581a6..bea8277 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2226,7 +2226,7 @@
                     {
                         /* This was the last domain */
                         *pos =3D '\0';
-                        *size +=3D 1;
+                        *size +=3D one_glyph;
                         return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT=
_FOUND;
                     }
                 }
@@ -2248,13 +2248,13 @@
                 memmove(pos + 1, pos, buf_size - converted_size - one_glyp=
h);
                 domains[buf_len - 1] =3D '\0';
                 *pos =3D '.';
-                *size +=3D 1;
+                *size +=3D one_glyph;

                 if (!comma)
                 {
                     /* Conversion is done */
                     *(pos + domain_len) =3D '\0';
-                    *size +=3D 1;
+                    *size +=3D one_glyph;
                     return NO_ERROR;
                 }

@@ -2409,10 +2409,10 @@

         if (v4_addrs_size || v6_addrs_size)
         {
-            /* Replace comma-delimters with semicolons, as required by NRP=
T */
+            /* Replace delimters with semicolons, as required by NRPT */
             for (int j =3D 0; j < sizeof(data[0].addresses) && data[i].add=
resses[j]; j++)
             {
-                if (data[i].addresses[j] =3D=3D ',')
+                if (data[i].addresses[j] =3D=3D ',' || data[i].addresses[j=
] =3D=3D ' ')
                 {
                     data[i].addresses[j] =3D ';';
                 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1028?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1
Gerrit-Change-Number: 1028
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--mu3E87/RIh0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1028?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">win: fix collecting DNS exclude data<br><br>The size of the returned MUL=
TI_SZ wide domains string was calculated<br>wrongly. Instead of adding the =
size of a WCHAR, only the size of a char<br>was used. As a result, the doma=
ins string was stored too short and was<br>missing the final string termina=
tor.<br><br>DHCP assigned DNS server addresses are separated by space, not =
comma.<br>These spaces were not replaced by semicolon, as the spec requires=
.<br><br>Fixes: OpenVPN/openvpn#747<br>Change-Id: Ie3fcd845344fd0c3ce9a2f99=
612fb19fe5ebb2f1<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>-=
--<br>M src/openvpnserv/interactive.c<br>1 file changed, 5 insertions(+), 5=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/28/1028/3</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/sr=
c/openvpnserv/interactive.c</span><br><span>index a1581a6..bea8277 100644</=
span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/sr=
c/openvpnserv/interactive.c</span><br><span>@@ -2226,7 +2226,7 @@</span><br=
><span>                     {</span><br><span>                         /* T=
his was the last domain */</span><br><span>                         *pos =
=3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    *size +=3D 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        *size +=3D one_glyph;</span><br><span=
>                         return wcslen(domains) ? NO_ERROR : ERROR_FILE_NO=
T_FOUND;</span><br><span>                     }</span><br><span>           =
      }</span><br><span>@@ -2248,13 +2248,13 @@</span><br><span>           =
      memmove(pos + 1, pos, buf_size - converted_size - one_glyph);</span><=
br><span>                 domains[buf_len - 1] =3D &#39;\0&#39;;</span><br>=
<span>                 *pos =3D &#39;.&#39;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                *size +=3D 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                *size +=3D one_glyph;</sp=
an><br><span> </span><br><span>                 if (!comma)</span><br><span=
>                 {</span><br><span>                     /* Conversion is d=
one */</span><br><span>                     *(pos + domain_len) =3D &#39;\0=
&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     *size +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   *size +=3D one_glyph;</span><br><span>                  =
   return NO_ERROR;</span><br><span>                 }</span><br><span> </s=
pan><br><span>@@ -2409,10 +2409,10 @@</span><br><span> </span><br><span>   =
      if (v4_addrs_size || v6_addrs_size)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Replace comma=
-delimters with semicolons, as required by NRPT */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            /* Replace delimters with semico=
lons, as required by NRPT */</span><br><span>             for (int j =3D 0;=
 j &lt; sizeof(data[0].addresses) &amp;&amp; data[i].addresses[j]; j++)</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                if (data[i].addresses[j] =3D=3D &#39;,&#39;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                if (data[i].=
addresses[j] =3D=3D &#39;,&#39; || data[i].addresses[j] =3D=3D &#39; &#39;)=
</span><br><span>                 {</span><br><span>                     da=
ta[i].addresses[j] =3D &#39;;&#39;;</span><br><span>                 }</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1028?usp=3Demail">change 1028</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1028?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie3fcd845344fd0c3ce9a2f99612=
fb19fe5ebb2f1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1028 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--mu3E87/RIh0=--

