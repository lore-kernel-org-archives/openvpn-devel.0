From: "klemens (Code Review)" <gerrit@...515...>
Date: Sat, 6 Dec 2025 14:09:11 +0000
References: <gerrit.1765030148000.I99a6604fdfc682f9609bfe7672aa78285084dcb9@...2715...>
Reply-To: kn@...2273..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1f710956d50b1334b12149158a463399f86dd84f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9EeqCARiaig="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9EeqCARiaig=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1418?usp=3Demail

to review the following change.


Change subject: Prevent crash on invalid server-ipv6 argument
......................................................................

Prevent crash on invalid server-ipv6 argument

`get_addr_generic()` expects `openvpn_getaddrinfo()` to return a newly
allocated struct, but getaddrinfo(3) failure leaves `*ai =3D NULL` as-is.

Unlike free(3), freegetaddrinfo(3) requires a valid struct, thus the
following is enough to trigger a NULL pointer dereference in libc:

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

Change-Id: I99a6604fdfc682f9609bfe7672aa78285084dcb9
Signed-off-by: Klemens Nanni <kn@...2273...>
---
M src/openvpn/socket.c
1 file changed, 4 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1418/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I99a6604fdfc682f9609bfe7672aa78285084dcb9
Gerrit-Change-Number: 1418
Gerrit-PatchSet: 1
Gerrit-Owner: klemens <kn@...2273...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--9EeqCARiaig=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>klemens would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1418?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Prevent crash on invalid server-ipv6 argume=
nt<br><br>`get_addr_generic()` expects `openvpn_getaddrinfo()` to return a =
newly<br>allocated struct, but getaddrinfo(3) failure leaves `*ai =3D NULL`=
 as-is.<br><br>Unlike free(3), freegetaddrinfo(3) requires a valid struct, =
thus the<br>following is enough to trigger a NULL pointer dereference in li=
bc:<br><br>```<br>$ openvpn --server-ipv6 &#39;&#39;<br>2025-12-06 11:59:18=
 RESOLVE: Cannot resolve host address: :[AF_INET6] (no address associated w=
ith name)<br>Segmentation fault (core dumped)<br>```<br><br>Guard against e=
mpty `ai`, i.e. failure, like similar code already does:<br><br>```<br>$ ./=
openvpn --server-ipv6 &#39;&#39;<br>2025-12-06 12:05:11 RESOLVE: Cannot res=
olve host address: :[AF_INET6] (no address associated with name)<br>Options=
 error: error parsing --server-ipv6 parameter<br>Use --help for more inform=
ation.<br>```<br><br>Spotted through a configuration typo &quot;server-ipv6=
 fd00:/64&quot; with 2.6.17,<br>reproduced with and tested against 2.7rc3 o=
n OpenBSD/amd64 7.8-current.<br><br>Change-Id: I99a6604fdfc682f9609bfe7672a=
a78285084dcb9<br>Signed-off-by: Klemens Nanni &lt;kn@...2273...&gt;<br>---<=
br>M src/openvpn/socket.c<br>1 file changed, 4 insertions(+), 1 deletion(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/18/1418/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/ope=
nvpn/socket.c</span><br><span>index 46bedf4..80c2895 100644</span><br><span=
>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</spa=
n><br><span>@@ -189,7 +189,10 @@</span><br><span>         *sep =3D &#39;/&#=
39;;</span><br><span>     }</span><br><span> out:</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    freeaddrinfo(ai);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (ai)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span>     free(var_host);</span><br><span> <=
/span><br><span>     return ret;</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1418?usp=3Demail"=
>change 1418</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1418?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I99a6604fdfc682f9609bfe7672a=
a78285084dcb9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1418 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: klemens &lt;kn@...2273...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--9EeqCARiaig=--

