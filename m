From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 11:34:07 +0000
In-Reply-To: <gerrit.1765030148000.I99a6604fdfc682f9609bfe7672aa78285084dcb9@...2715...>
References: <gerrit.1765030148000.I99a6604fdfc682f9609bfe7672aa78285084dcb9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, kn@...2273...
Message-ID: <0d66ca0ffe78009eb41fa3fb9b83c26ab9f3c18d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vi25bxC7ZGo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Prevent crash on
 invalid server-ipv6 argument
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Vi25bxC7ZGo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
18?usp=3Demail )

Change subject: Prevent crash on invalid server-ipv6 argument
......................................................................

Prevent crash on invalid server-ipv6 argument

`get_addr_generic()` expects `openvpn_getaddrinfo()` to return a newly
allocated struct, but getaddrinfo(3) failure leaves `*ai =3D NULL` as-is.

On OpenBSD, unlike free(3), freegetaddrinfo(3) requires a valid struct,
thus callers must check the argument to avoid NULL-deref or double-free:

```
$ openvpn --server-ipv6 ''
2025-12-06 11:59:18 RESOLVE: Cannot resolve host address: :[AF_INET6] (no a=
ddress associated with name)
Segmentation fault (core dumped)
```

Guard against empty `ai`, i.e. failure, like similar code already does:

```
$ ./openvpn --server-ipv6 ''
2025-12-06 12:05:11 RESOLVE: Cannot resolve host address: :[AF_INET6] (no a=
ddress associated with name)
Options error: error parsing --server-ipv6 parameter
Use --help for more information.
```

Spotted through a configuration typo "server-ipv6 fd00:/64" with 2.6.17,
reproduced with and tested against 2.7rc3 on OpenBSD/amd64 7.8-current.

NB: Standards are unclear wrt. freeaddrinfo(3)'s NULL handling;
    Linux, FreeBSD and illumos do check it and thus not crash.

Github: fixes OpenVPN/openvpn#930

Change-Id: I99a6604fdfc682f9609bfe7672aa78285084dcb9
Signed-off-by: Klemens Nanni <kn@...2273...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1418
Message-Id: <20251207210529.9949-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
870.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 4 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 46bedf4..80c2895 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -189,7 +189,10 @@
         *sep =3D '/';
     }
 out:
-    freeaddrinfo(ai);
+    if (ai)
+    {
+        freeaddrinfo(ai);
+    }
     free(var_host);

     return ret;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1418?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I99a6604fdfc682f9609bfe7672aa78285084dcb9
Gerrit-Change-Number: 1418
Gerrit-PatchSet: 3
Gerrit-Owner: klemens <kn@...2273...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Vi25bxC7ZGo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1418?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Prevent crash on invalid server-ipv6 argument<br=
><br>`get_addr_generic()` expects `openvpn_getaddrinfo()` to return a newly=
<br>allocated struct, but getaddrinfo(3) failure leaves `*ai =3D NULL` as-i=
s.<br><br>On OpenBSD, unlike free(3), freegetaddrinfo(3) requires a valid s=
truct,<br>thus callers must check the argument to avoid NULL-deref or doubl=
e-free:<br><br>```<br>$ openvpn --server-ipv6 &#39;&#39;<br>2025-12-06 11:5=
9:18 RESOLVE: Cannot resolve host address: :[AF_INET6] (no address associat=
ed with name)<br>Segmentation fault (core dumped)<br>```<br><br>Guard again=
st empty `ai`, i.e. failure, like similar code already does:<br><br>```<br>=
$ ./openvpn --server-ipv6 &#39;&#39;<br>2025-12-06 12:05:11 RESOLVE: Cannot=
 resolve host address: :[AF_INET6] (no address associated with name)<br>Opt=
ions error: error parsing --server-ipv6 parameter<br>Use --help for more in=
formation.<br>```<br><br>Spotted through a configuration typo &quot;server-=
ipv6 fd00:/64&quot; with 2.6.17,<br>reproduced with and tested against 2.7r=
c3 on OpenBSD/amd64 7.8-current.<br><br>NB: Standards are unclear wrt. free=
addrinfo(3)&#39;s NULL handling;<br>    Linux, FreeBSD and illumos do check=
 it and thus not crash.<br><br>Github: fixes OpenVPN/openvpn#930<br><br>Cha=
nge-Id: I99a6604fdfc682f9609bfe7672aa78285084dcb9<br>Signed-off-by: Klemens=
 Nanni &lt;kn@...2273...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1418<br>Message-I=
d: &lt;20251207210529.9949-1-gert@...1296...&gt;<br>URL: https://www.mail-a=
rchive.com/openvpn-devel@lists.sourceforge.net/msg34870.html<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/socket.c<b=
r>1 file changed, 4 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span=
>index 46bedf4..80c2895 100644</span><br><span>--- a/src/openvpn/socket.c</=
span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -189,7 +189,10=
 @@</span><br><span>         *sep =3D &#39;/&#39;;</span><br><span>     }</=
span><br><span> out:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (ai)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        freeaddrinfo(=
ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span>     free(var_host);</span><br><span> </span><br><span>     return r=
et;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1418?usp=3Demail">change 1418</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1418?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I99a6604fdfc682f9609bfe7672a=
a78285084dcb9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1418 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: klemens &lt;kn@...2273...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Vi25bxC7ZGo=--

