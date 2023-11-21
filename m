From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 21 Nov 2023 16:06:46 +0000
References: <gerrit.1700582804000.Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <83c5e06d672c765f7d6bd8646088869e8a4e04da-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hqqjuEOhvQU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix unaligned access
 in macOS/Solaris hwaddr
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hqqjuEOhvQU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/454?usp=3Demail

to review the following change.


Change subject: Fix unaligned access in macOS/Solaris hwaddr
......................................................................

Fix unaligned access in macOS/Solaris hwaddr

The undefined behaviour USAN clang checker found this.

This fix is a bit messy but so are the original structures.

Change-Id: Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8
---
M src/openvpn/route.c
1 file changed, 33 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/454/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ff64938..ab5bff7 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3643,7 +3643,6 @@
     if (rgi->flags & RGI_IFACE_DEFINED)
     {
         struct ifconf ifc;
-        struct ifreq *ifr;
         const int bufsize =3D 4096;
         char *buffer;

@@ -3668,22 +3667,48 @@

         for (cp =3D buffer; cp <=3D buffer + ifc.ifc_len - sizeof(struct i=
freq); )
         {
-            ifr =3D (struct ifreq *)cp;
+            struct ifreq ifr =3D { 0 };
+            /* this is not always using an 8 byte alignment that struct ifr
+             * requires */
+            memcpy(&ifr, cp, sizeof(struct ifreq));
 #if defined(TARGET_SOLARIS)
-            const size_t len =3D sizeof(ifr->ifr_name) + sizeof(ifr->ifr_a=
ddr);
+            const size_t len =3D sizeof(ifr.ifr_name) + sizeof(ifr.ifr_add=
r);
 #else
-            const size_t len =3D sizeof(ifr->ifr_name) + max(sizeof(ifr->i=
fr_addr), ifr->ifr_addr.sa_len);
+            const size_t len =3D sizeof(ifr.ifr_name) + max(sizeof(ifr.ifr=
_addr), ifr.ifr_addr.sa_len);
 #endif

-            if (!ifr->ifr_addr.sa_family)
+            if (!ifr.ifr_addr.sa_family)
             {
                 break;
             }
-            if (!strncmp(ifr->ifr_name, rgi->iface, IFNAMSIZ))
+            if (!strncmp(ifr.ifr_name, rgi->iface, IFNAMSIZ))
             {
-                if (ifr->ifr_addr.sa_family =3D=3D AF_LINK)
+                if (ifr.ifr_addr.sa_family =3D=3D AF_LINK)
                 {
-                    struct sockaddr_dl *sdl =3D (struct sockaddr_dl *)&ifr=
->ifr_addr;
+                    /* This is a confusing member access on multiple level=
s.
+                     *
+                     * struct sockaddr_dl is 20 bytes in size and has
+                     * 12 bytes space for the hw address (6 bytes)
+                     * and Ethernet interface name (max 16 bytes)
+                     *
+                     * So if the interface name is more than 6 byte, it
+                     * extends beyond the struct.
+                     *
+                     * This struct is embedded into ifreq that has
+                     * 16 bytes for a sockaddr and also expects this
+                     * struct to potentially extend beyond the bounds of
+                     * the struct.
+                     *
+                     * Since we only copied 32 bytes from cp to ifr but sdl
+                     * might extend after ifr's end, we  need to copy from
+                     * cp directly to avoid missing out on extra bytes
+                     * behind the struct
+                     */
+                    const size_t sock_dl_len =3D max_int((int) (sizeof(str=
uct sockaddr_dl)),
+                                                       (int) (ifr.ifr_addr=
.sa_len));
+
+                    struct sockaddr_dl *sdl =3D gc_malloc(sock_dl_len, tru=
e, &gc);
+                    memcpy(sdl, cp + offsetof(struct ifreq, ifr_addr), soc=
k_dl_len);
                     memcpy(rgi->hwaddr, LLADDR(sdl), 6);
                     rgi->flags |=3D RGI_HWADDR_DEFINED;
                 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/454?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8
Gerrit-Change-Number: 454
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--hqqjuEOhvQU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/454?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix unaligned access in macOS/Solaris hwaddr<br><br>The undef=
ined behaviour USAN clang checker found this.<br><br>This fix is a bit mess=
y but so are the original structures.<br><br>Change-Id: Ia797c8801fa9a9bc10=
b6674efde5fdbd7132e4a8<br>---<br>M src/openvpn/route.c<br>1 file changed, 3=
3 insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/54/454/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/route=
.c b/src/openvpn/route.c</span><br><span>index ff64938..ab5bff7 100644</spa=
n><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/rou=
te.c</span><br><span>@@ -3643,7 +3643,6 @@</span><br><span>     if (rgi-&gt=
;flags &amp; RGI_IFACE_DEFINED)</span><br><span>     {</span><br><span>    =
     struct ifconf ifc;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        struct ifreq *ifr;</span><br><span>         const int bufsize =3D=
 4096;</span><br><span>         char *buffer;</span><br><span> </span><br><=
span>@@ -3668,22 +3667,48 @@</span><br><span> </span><br><span>         for=
 (cp =3D buffer; cp &lt;=3D buffer + ifc.ifc_len - sizeof(struct ifreq); )<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            ifr =3D (struct ifreq *)cp;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            struct ifreq ifr =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            /* this is not alw=
ays using an 8 byte alignment that struct ifr</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             * requires */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;ifr, cp, sizeof(s=
truct ifreq));</span><br><span> #if defined(TARGET_SOLARIS)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            const size_t len =3D size=
of(ifr-&gt;ifr_name) + sizeof(ifr-&gt;ifr_addr);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            const size_t len =3D sizeof(ifr.if=
r_name) + sizeof(ifr.ifr_addr);</span><br><span> #else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            const size_t len =3D sizeof(if=
r-&gt;ifr_name) + max(sizeof(ifr-&gt;ifr_addr), ifr-&gt;ifr_addr.sa_len);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const siz=
e_t len =3D sizeof(ifr.ifr_name) + max(sizeof(ifr.ifr_addr), ifr.ifr_addr.s=
a_len);</span><br><span> #endif</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            if (!ifr-&gt;ifr_addr.sa_family)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!ifr.i=
fr_addr.sa_family)</span><br><span>             {</span><br><span>         =
        break;</span><br><span>             }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (!strncmp(ifr-&gt;ifr_name, rgi-&gt;=
iface, IFNAMSIZ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (!strncmp(ifr.ifr_name, rgi-&gt;iface, IFNAMSIZ))</span><br><s=
pan>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             if (ifr-&gt;ifr_addr.sa_family =3D=3D AF_LINK)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                if (ifr.ifr_addr.sa=
_family =3D=3D AF_LINK)</span><br><span>                 {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    struct sockaddr_dl=
 *sdl =3D (struct sockaddr_dl *)&amp;ifr-&gt;ifr_addr;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    /* This is a confusi=
ng member access on multiple levels.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                     *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                     * struct sockaddr_dl is 20 bytes i=
n size and has</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                * 12 bytes space for the hw address (6 bytes)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                     * and Ethern=
et interface name (max 16 bytes)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                     *</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                     * So if the interface name is more tha=
n 6 byte, it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              * extends beyond the struct.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                     *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     * This struct is embedded in=
to ifreq that has</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   * 16 bytes for a sockaddr and also expects this</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                     * struc=
t to potentially extend beyond the bounds of</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     * the struct.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                     * Since we =
only copied 32 bytes from cp to ifr but sdl</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                     * might extend after ifr&#39;s=
 end, we  need to copy from</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                     * cp directly to avoid missing out on extra by=
tes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
     * behind the struct</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                     */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    const size_t sock_dl_len =3D max_int((int) (si=
zeof(struct sockaddr_dl)),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                                       (int) (ifr.if=
r_addr.sa_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    st=
ruct sockaddr_dl *sdl =3D gc_malloc(sock_dl_len, true, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    memcpy(sdl=
, cp + offsetof(struct ifreq, ifr_addr), sock_dl_len);</span><br><span>    =
                 memcpy(rgi-&gt;hwaddr, LLADDR(sdl), 6);</span><br><span>  =
                   rgi-&gt;flags |=3D RGI_HWADDR_DEFINED;</span><br><span> =
                }</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/454?usp=3Demail">change 454</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/454?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia797c8801fa9a9bc10b6674efde=
5fdbd7132e4a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 454 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--hqqjuEOhvQU=--

