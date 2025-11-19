MIME-Version: 1.0
From: Jon Chiappetta <root@...2904...>
Date: Wed, 19 Nov 2025 09:19:35 -0500
Message-ID: <CAOh3LPOnR5qbF-8xRuJFfZhWW25wNXBK3cUwC710cK4kRcSVpA@...278...>
Content-Type: multipart/alternative; boundary="000000000000c35d8d0643f345d6"
References: <CAOh3LPOnR5qbF-8xRuJFfZhWW25wNXBK3cUwC710cK4kRcSVpA.ref@...278...>
Subject: [Openvpn-devel] Old/New IP - Logic Redo
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000c35d8d0643f345d6
Content-Type: text/plain; charset="UTF-8"

Hi all,

This is something I noticed recently with potential connection
interruptions which could occur which the original older code checked for!

https://github.com/OpenVPN/openvpn/pull/910

There was an update pushed earlier this year which undid some important
logic in terms of learning/unlearning the ifconfig IP address. The older
original code would check that the new/old IPs don't match first before
performing that logic. I believe this was important and correct because it
could cause connection interruptions during the learn/unlearn process if
the IP address has stayed the same!

```
commit 5e4c9a69eaf9d32e85613bd71ed219fdbb062d34
Author: Marco Baffo <marco@...2726...>
Date:   Fri Oct 17 22:19:12 2025 +0200
...
-update_vhash(struct multi_context *m, struct multi_instance *mi, const
char *old_ip, const char *old_ipv6)
+update_vhash(struct multi_context *m, struct multi_instance *mi, const
char *new_ip, const char *new_ipv6)
 {
-    struct in_addr addr;
-    struct in6_addr new_ipv6;
-
-    if ((mi->context.options.ifconfig_local && (!old_ip || strcmp(old_ip,
mi->context.options.ifconfig_local)))
-        && inet_pton(AF_INET, mi->context.options.ifconfig_local, &addr)
== 1)
+    if (new_ip)
     {
```

Thanks,
Jon C

--000000000000c35d8d0643f345d6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>This is something I noticed rec=
ently with potential connection interruptions which could occur which the o=
riginal older code checked for!</div><div><br></div><div><a href=3D"https:/=
/github.com/OpenVPN/openvpn/pull/910">https://github.com/OpenVPN/openvpn/pu=
ll/910</a><br></div><div><br></div><div>There was an update pushed earlier =
this year which undid some important logic in terms of learning/unlearning =
the ifconfig IP address. The older original code would check that the new/o=
ld IPs don&#39;t match first before performing that logic. I believe this w=
as important and correct because it could cause connection interruptions du=
ring the learn/unlearn process if the IP address has stayed the same!<br><b=
r>```<br>commit 5e4c9a69eaf9d32e85613bd71ed219fdbb062d34<br>Author: Marco B=
affo &lt;<a href=3D"mailto:marco@...2726...">marco@...2726...</a>&gt;<br>Da=
te: =C2=A0 Fri Oct 17 22:19:12 2025 +0200<br>...<br>-update_vhash(struct mu=
lti_context *m, struct multi_instance *mi, const char *old_ip, const char *=
old_ipv6)<br>+update_vhash(struct multi_context *m, struct multi_instance *=
mi, const char *new_ip, const char *new_ipv6)<br>=C2=A0{<br>- =C2=A0 =C2=A0=
struct in_addr addr;<br>- =C2=A0 =C2=A0struct in6_addr new_ipv6;<br>-<br>- =
=C2=A0 =C2=A0if ((mi-&gt;context.options.ifconfig_local &amp;&amp; (!old_ip=
 || strcmp(old_ip, mi-&gt;context.options.ifconfig_local)))<br>- =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;&amp; inet_pton(AF_INET, mi-&gt;context.options.ifcon=
fig_local, &amp;addr) =3D=3D 1)<br>+ =C2=A0 =C2=A0if (new_ip)<br>=C2=A0 =C2=
=A0 =C2=A0{<br>```<br></div><div><br></div><div>Thanks,</div><div>Jon C</di=
v><div><br></div></div>

--000000000000c35d8d0643f345d6--

