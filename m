From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 29 Oct 2024 21:19:40 +0000
In-Reply-To: <gerrit.1730209445000.I9306a590a10a7d5cba32abe06d269494fec41ba6@...2715...>
References: <gerrit.1730209445000.I9306a590a10a7d5cba32abe06d269494fec41ba6@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3da8884870e48684ea30bafc50d0a0abb7d48a11-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="moNLTf7rDhY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: sitnl: replace
 NLMSG_TAIL macro with noinline function
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

--moNLTf7rDhY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/788?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: sitnl: replace NLMSG_TAIL macro with noinline function
......................................................................

sitnl: replace NLMSG_TAIL macro with noinline function

The NLMSG_TAIL macro is confusing gcc when compiling with -O3, leading
to warnings like:

networking_sitnl.c:143:9: warning: writing 4 bytes into a region of size 0 =
[-Wstringop-overflow=3D]
  143 |         memcpy(RTA_DATA(rta), data, alen);
      |         ^
networking_sitnl.c:101:21: note: at offset [72, 88] into destination object=
 =E2=80=98n=E2=80=99 of size 16
  101 |     struct nlmsghdr n;
      |                     ^

(Above warnings are critical on Fedora 40 as they are turned into errors)

Replacing the macro with a function is also not effective because gcc
will inline it and get confused again.

The only way out is to write a function that never gets inline'd and
replace the macro with it.

Tested on linux with gcc and clang.

Change-Id: I9306a590a10a7d5cba32abe06d269494fec41ba6
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/networking_sitnl.c
1 file changed, 11 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/788/3

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index f53f5ee..daa0999 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -52,21 +52,24 @@
         }                                                           \
     }

-#define NLMSG_TAIL(nmsg) \
-    ((struct rtattr *)(((uint8_t *)(nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len=
)))
-
 #define SITNL_NEST(_msg, _max_size, _attr)              \
     ({                                                  \
-        struct rtattr *_nest =3D NLMSG_TAIL(_msg);        \
+        struct rtattr *_nest =3D sitnl_nlmsg_tail(_msg);  \
         SITNL_ADDATTR(_msg, _max_size, _attr, NULL, 0); \
         _nest;                                          \
     })

-#define SITNL_NEST_END(_msg, _nest)                                 \
-    {                                                               \
-        _nest->rta_len =3D (void *)NLMSG_TAIL(_msg) - (void *)_nest;  \
+#define SITNL_NEST_END(_msg, _nest)                                     \
+    {                                                                   \
+        _nest->rta_len =3D (void *)sitnl_nlmsg_tail(_msg) - (void *)_nest;=
 \
     }

+static __attribute__ ((noinline)) void *
+sitnl_nlmsg_tail(const struct nlmsghdr *nlh)
+{
+    return (unsigned char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len);
+}
+
 /**
  * Generic address data structure used to pass addresses and prefixes as
  * argument to AF family agnostic functions
@@ -130,7 +133,7 @@
         return -EMSGSIZE;
     }

-    rta =3D NLMSG_TAIL(n);
+    rta =3D sitnl_nlmsg_tail(n);
     rta->rta_type =3D type;
     rta->rta_len =3D len;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/788?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9306a590a10a7d5cba32abe06d269494fec41ba6
Gerrit-Change-Number: 788
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--moNLTf7rDhY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>ordex <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/788?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">sitnl: replace NLMSG_TAIL macro with noinline=
 function<br><br>The NLMSG_TAIL macro is confusing gcc when compiling with =
-O3, leading<br>to warnings like:<br><br>networking_sitnl.c:143:9: warning:=
 writing 4 bytes into a region of size 0 [-Wstringop-overflow=3D]<br>  143 =
|         memcpy(RTA_DATA(rta), data, alen);<br>      |         ^<br>networ=
king_sitnl.c:101:21: note: at offset [72, 88] into destination object =E2=
=80=98n=E2=80=99 of size 16<br>  101 |     struct nlmsghdr n;<br>      |   =
                  ^<br><br>(Above warnings are critical on Fedora 40 as the=
y are turned into errors)<br><br>Replacing the macro with a function is als=
o not effective because gcc<br>will inline it and get confused again.<br><b=
r>The only way out is to write a function that never gets inline&#39;d and<=
br>replace the macro with it.<br><br>Tested on linux with gcc and clang.<br=
><br>Change-Id: I9306a590a10a7d5cba32abe06d269494fec41ba6<br>Signed-off-by:=
 Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/openvpn/netwo=
rking_sitnl.c<br>1 file changed, 11 insertions(+), 8 deletions(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/788/3</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_si=
tnl.c</span><br><span>index f53f5ee..daa0999 100644</span><br><span>--- a/s=
rc/openvpn/networking_sitnl.c</span><br><span>+++ b/src/openvpn/networking_=
sitnl.c</span><br><span>@@ -52,21 +52,24 @@</span><br><span>         }     =
                                                      \</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define NLMSG_TAIL(nmsg) \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    ((struct rtattr *)(((uint8_t *)(nmsg)) + NLMSG_ALIGN((nmsg)-&gt;nl=
msg_len)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> #define SITNL_NEST(_msg, _max_size, _attr)              \</span><br>=
<span>     ({                                                  \</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        struct rtattr *_nest =3D=
 NLMSG_TAIL(_msg);        \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct rtattr *_nest =3D sitnl_nlmsg_tail(_msg);  \</span><=
br><span>         SITNL_ADDATTR(_msg, _max_size, _attr, NULL, 0); \</span><=
br><span>         _nest;                                          \</span><=
br><span>     })</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define SITNL_NEST_END(_msg, _nest)                           =
      \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {         =
                                                      \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        _nest-&gt;rta_len =3D (void *)NLM=
SG_TAIL(_msg) - (void *)_nest;  \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define SITNL_NEST_END(_msg, _nest)                          =
           \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {  =
                                                                 \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        _nest-&gt;rta_len =
=3D (void *)sitnl_nlmsg_tail(_msg) - (void *)_nest; \</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static __attribute__ ((noinline)) void *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+sitnl_nlmsg_tail(const struct nlmsghdr *nlh)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return (unsigned char *)nlh + NLMSG_ALIGN(n=
lh-&gt;nlmsg_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /=
**</span><br><span>  * Generic address data structure used to pass addresse=
s and prefixes as</span><br><span>  * argument to AF family agnostic functi=
ons</span><br><span>@@ -130,7 +133,7 @@</span><br><span>         return -EM=
SGSIZE;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    rta =3D NLMSG_TAIL(n);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    rta =3D sitnl_nlmsg_tail(n);</span><b=
r><span>     rta-&gt;rta_type =3D type;</span><br><span>     rta-&gt;rta_le=
n =3D len;</span><br><span> </span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/788?usp=3Demail">chan=
ge 788</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/788?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9306a590a10a7d5cba32abe06d2=
69494fec41ba6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 788 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--moNLTf7rDhY=--

