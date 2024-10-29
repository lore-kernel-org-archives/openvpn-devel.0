From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 29 Oct 2024 13:44:07 +0000
References: <gerrit.1730209445000.I9306a590a10a7d5cba32abe06d269494fec41ba6@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cbec232dce34db72a82f8ed000070d07ebb56f8a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PpC9mlSwuRo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: sitnl: replace
 NLMSG_TAIL macro with nlmsg_tail() function
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

--PpC9mlSwuRo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/788?usp=3Demail

to review the following change.


Change subject: sitnl: replace NLMSG_TAIL macro with nlmsg_tail() function
......................................................................

sitnl: replace NLMSG_TAIL macro with nlmsg_tail() function

The NLMSG_TAIL macro never had any reason to exist, because libnl
already provides a function doing exactly the same: nlmsg_tail().

Moreover, this macro was found to confuse gcc when compiling with -O3,
which would result in subsequent warnings like:

networking_sitnl.c:143:9: warning: writing 4 bytes into a region of size 0 =
[-Wstringop-overflow=3D]
  143 |         memcpy(RTA_DATA(rta), data, alen);
      |         ^
networking_sitnl.c:101:21: note: at offset [72, 88] into destination object=
 =E2=80=98n=E2=80=99 of size 16
  101 |     struct nlmsghdr n;
      |                     ^

(Above warnings are critical on Fedora 40 as they are turned into errors)

Delete the macro, replace it with nlmsg_tail() and get rid of the
warnings.

Change-Id: I9306a590a10a7d5cba32abe06d269494fec41ba6
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/networking_sitnl.c
1 file changed, 4 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/788/1

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index f53f5ee..8eeab72 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -40,6 +40,7 @@
 #include <sys/socket.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
+#include <netlink/msg.h>

 #define SNDBUF_SIZE (1024 * 2)
 #define RCVBUF_SIZE (1024 * 4)
@@ -52,19 +53,16 @@
         }                                                           \
     }

-#define NLMSG_TAIL(nmsg) \
-    ((struct rtattr *)(((uint8_t *)(nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len=
)))
-
 #define SITNL_NEST(_msg, _max_size, _attr)              \
     ({                                                  \
-        struct rtattr *_nest =3D NLMSG_TAIL(_msg);        \
+        struct rtattr *_nest =3D nlmsg_tail(_msg);        \
         SITNL_ADDATTR(_msg, _max_size, _attr, NULL, 0); \
         _nest;                                          \
     })

 #define SITNL_NEST_END(_msg, _nest)                                 \
     {                                                               \
-        _nest->rta_len =3D (void *)NLMSG_TAIL(_msg) - (void *)_nest;  \
+        _nest->rta_len =3D (void *)nlmsg_tail(_msg) - (void *)_nest;  \
     }

 /**
@@ -130,7 +128,7 @@
         return -EMSGSIZE;
     }

-    rta =3D NLMSG_TAIL(n);
+    rta =3D nlmsg_tail(n);
     rta->rta_type =3D type;
     rta->rta_len =3D len;


--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/788?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9306a590a10a7d5cba32abe06d269494fec41ba6
Gerrit-Change-Number: 788
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--PpC9mlSwuRo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/788?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">sitnl: replace NLMSG_TAIL macro with nlmsg_tail() function<br=
><br>The NLMSG_TAIL macro never had any reason to exist, because libnl<br>a=
lready provides a function doing exactly the same: nlmsg_tail().<br><br>Mor=
eover, this macro was found to confuse gcc when compiling with -O3,<br>whic=
h would result in subsequent warnings like:<br><br>networking_sitnl.c:143:9=
: warning: writing 4 bytes into a region of size 0 [-Wstringop-overflow=3D]=
<br>  143 |         memcpy(RTA_DATA(rta), data, alen);<br>      |         ^=
<br>networking_sitnl.c:101:21: note: at offset [72, 88] into destination ob=
ject =E2=80=98n=E2=80=99 of size 16<br>  101 |     struct nlmsghdr n;<br>  =
    |                     ^<br><br>(Above warnings are critical on Fedora 4=
0 as they are turned into errors)<br><br>Delete the macro, replace it with =
nlmsg_tail() and get rid of the<br>warnings.<br><br>Change-Id: I9306a590a10=
a7d5cba32abe06d269494fec41ba6<br>Signed-off-by: Antonio Quartulli &lt;anton=
io@...2726...&gt;<br>---<br>M src/openvpn/networking_sitnl.c<br>1 file chan=
ged, 4 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/88/788/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
networking_sitnl.c b/src/openvpn/networking_sitnl.c</span><br><span>index f=
53f5ee..8eeab72 100644</span><br><span>--- a/src/openvpn/networking_sitnl.c=
</span><br><span>+++ b/src/openvpn/networking_sitnl.c</span><br><span>@@ -4=
0,6 +40,7 @@</span><br><span> #include &lt;sys/socket.h&gt;</span><br><span=
> #include &lt;linux/netlink.h&gt;</span><br><span> #include &lt;linux/rtne=
tlink.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;netlink/msg.h&gt;</span><br><span> </span><br><span> #define SNDBUF_SI=
ZE (1024 * 2)</span><br><span> #define RCVBUF_SIZE (1024 * 4)</span><br><sp=
an>@@ -52,19 +53,16 @@</span><br><span>         }                          =
                                 \</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define NLMSG_TAIL(nm=
sg) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ((struct rta=
ttr *)(((uint8_t *)(nmsg)) + NLMSG_ALIGN((nmsg)-&gt;nlmsg_len)))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define SITNL_=
NEST(_msg, _max_size, _attr)              \</span><br><span>     ({        =
                                          \</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        struct rtattr *_nest =3D NLMSG_TAIL(_msg);   =
     \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t rtattr *_nest =3D nlmsg_tail(_msg);        \</span><br><span>         SIT=
NL_ADDATTR(_msg, _max_size, _attr, NULL, 0); \</span><br><span>         _ne=
st;                                          \</span><br><span>     })</spa=
n><br><span> </span><br><span> #define SITNL_NEST_END(_msg, _nest)         =
                        \</span><br><span>     {                           =
                                    \</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        _nest-&gt;rta_len =3D (void *)NLMSG_TAIL(_msg) - (v=
oid *)_nest;  \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    _nest-&gt;rta_len =3D (void *)nlmsg_tail(_msg) - (void *)_nest;  \</spa=
n><br><span>     }</span><br><span> </span><br><span> /**</span><br><span>@=
@ -130,7 +128,7 @@</span><br><span>         return -EMSGSIZE;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    rta =3D NLMSG_TAIL(n);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    rta =3D nlmsg_tail(n);</span><br><span>     rta-&gt;rta_ty=
pe =3D type;</span><br><span>     rta-&gt;rta_len =3D len;</span><br><span>=
 </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/788?usp=3Demail">change 788</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/788?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9306a590a10a7d5cba32abe06d2=
69494fec41ba6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 788 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--PpC9mlSwuRo=--

