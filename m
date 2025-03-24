From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 24 Mar 2025 21:15:37 +0000
In-Reply-To: <gerrit.1742829972000.I1976307a7643c82f31d55ca32c79cbe64b6fffc6@...2715...>
References: <gerrit.1742829972000.I1976307a7643c82f31d55ca32c79cbe64b6fffc6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <b2415b0dae1162dc7414fc7c49a068439efd22ca-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0JuYsBQLWz4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make 'lport 0' no
 longer sufficient to do '--bind'.
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

--0JuYsBQLWz4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/916?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Make 'lport 0' no longer sufficient to do '--bind'.
......................................................................

Make 'lport 0' no longer sufficient to do '--bind'.

'lport <anything>' used to trigger 'do socket bind', which is not
useful in itself for the 'lport 0' case (port 0 -> OS assigns a
random port, as it is done for unbound sockets) unless also binding
to a particular local IP address ('--local 192.0.2.1').

The trigger for 'lport has been used, do socket bind' is
ce.local_port_defined -> change the code to test for "0", and
only set this for non-0 ports (NOTE: this is a string match,
so if you really really want the old "lport 0" behaviour, using
"lport 00" still does that...).

The ce.local_port value is still set, so '--lport 0' together
with '--local 192.0.2.1' will give you a random port number
bound to that IP address - without 'lport 0' it would default
to 1194 or the value of '--port' (if not using '--rport').

Summary:  socket bind is now only done if one of these is set
  - --lport <port> with <port> not "0"
  - --bind  (default on the client is "--nobind")
  - --local <address>

Github: schwabe/ics-openvpn#1794

Change-Id: I1976307a7643c82f31d55ca32c79cbe64b6fffc6
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250324182735.12657-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
222.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/link-options.rst
M src/openvpn/options.c
2 files changed, 9 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/16/916/2

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index d48021e..287473e 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -122,7 +122,9 @@

 --lport port
   Set default TCP/UDP port number. Cannot be used together with
-  ``--nobind`` option.
+  ``--nobind`` option.  A port number of ``0`` is only honoured to
+  achieve "bind() to a random assigned port number" if a bind-to IP
+  address is specified with ``--local``.

 --mark value
   Mark encrypted packets being sent with ``value``. The mark value can be
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ab56609..99dd60a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6710,7 +6710,12 @@
     else if (streq(p[0], "lport") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->ce.local_port_defined =3D true;
+
+        /* only trigger bind() if port is not 0 (or --local is used) */
+        if (!streq(p[1], "0"))
+        {
+            options->ce.local_port_defined =3D true;
+        }
         options->ce.local_port =3D p[1];
     }
     else if (streq(p[0], "rport") && p[1] && !p[2])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/916?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1976307a7643c82f31d55ca32c79cbe64b6fffc6
Gerrit-Change-Number: 916
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-MessageType: newpatchset

--0JuYsBQLWz4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/916?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Make &#39;lport 0&#39; no longer sufficient to d=
o &#39;--bind&#39;.<br><br>&#39;lport &lt;anything&gt;&#39; used to trigger=
 &#39;do socket bind&#39;, which is not<br>useful in itself for the &#39;lp=
ort 0&#39; case (port 0 -&gt; OS assigns a<br>random port, as it is done fo=
r unbound sockets) unless also binding<br>to a particular local IP address =
(&#39;--local 192.0.2.1&#39;).<br><br>The trigger for &#39;lport has been u=
sed, do socket bind&#39; is<br>ce.local_port_defined -&gt; change the code =
to test for &quot;0&quot;, and<br>only set this for non-0 ports (NOTE: this=
 is a string match,<br>so if you really really want the old &quot;lport 0&q=
uot; behaviour, using<br>&quot;lport 00&quot; still does that...).<br><br>T=
he ce.local_port value is still set, so &#39;--lport 0&#39; together<br>wit=
h &#39;--local 192.0.2.1&#39; will give you a random port number<br>bound t=
o that IP address - without &#39;lport 0&#39; it would default<br>to 1194 o=
r the value of &#39;--port&#39; (if not using &#39;--rport&#39;).<br><br>Su=
mmary:  socket bind is now only done if one of these is set<br>  - --lport =
&lt;port&gt; with &lt;port&gt; not &quot;0&quot;<br>  - --bind  (default on=
 the client is &quot;--nobind&quot;)<br>  - --local &lt;address&gt;<br><br>=
Github: schwabe/ics-openvpn#1794<br><br>Change-Id: I1976307a7643c82f31d55ca=
32c79cbe64b6fffc6<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;=
20250324182735.12657-1-gert@...1296...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg31222.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections/link-option=
s.rst<br>M src/openvpn/options.c<br>2 files changed, 9 insertions(+), 2 del=
etions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/16/916/2</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/doc/man-sections/link-options.rst b/doc=
/man-sections/link-options.rst</span><br><span>index d48021e..287473e 10064=
4</span><br><span>--- a/doc/man-sections/link-options.rst</span><br><span>+=
++ b/doc/man-sections/link-options.rst</span><br><span>@@ -122,7 +122,9 @@<=
/span><br><span> </span><br><span> --lport port</span><br><span>   Set defa=
ult TCP/UDP port number. Cannot be used together with</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  ``--nobind`` option.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  ``--nobind`` option.  A port number of=
 ``0`` is only honoured to</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  achieve &quot;bind() to a random assigned port number&quot; if a b=
ind-to IP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  address =
is specified with ``--local``.</span><br><span> </span><br><span> --mark va=
lue</span><br><span>   Mark encrypted packets being sent with ``value``. Th=
e mark value can be</span><br><span>diff --git a/src/openvpn/options.c b/sr=
c/openvpn/options.c</span><br><span>index ab56609..99dd60a 100644</span><br=
><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/option=
s.c</span><br><span>@@ -6710,7 +6710,12 @@</span><br><span>     else if (st=
req(p[0], &quot;lport&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><s=
pan>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_C=
ONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        op=
tions-&gt;ce.local_port_defined =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* only trigger bind() if port is not 0 (or --local is used) */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!streq(p=
[1], &quot;0&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   options-&gt;ce.local_port_defined =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span>         options-&gt;c=
e.local_port =3D p[1];</span><br><span>     }</span><br><span>     else if =
(streq(p[0], &quot;rport&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/916?usp=3Demail">change 916</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/9=
16?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1976307a7643c82f31d55ca32c7=
9cbe64b6fffc6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 916 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--0JuYsBQLWz4=--

