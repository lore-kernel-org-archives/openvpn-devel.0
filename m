From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 22 Nov 2023 13:08:59 +0000
In-Reply-To: <gerrit.1700582804000.Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8@...2715...>
References: <gerrit.1700582804000.Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <430a734e15d164a4e98b0849d40330116b802646-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G6JadVbR+9A="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix unaligned access
 in macOS, FreeBSD, Solaris hwaddr
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--G6JadVbR+9A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/454?usp=3Demail

to look at the new patch set (#2).


Change subject: Fix unaligned access in macOS, FreeBSD, Solaris hwaddr
......................................................................

Fix unaligned access in macOS, FreeBSD, Solaris hwaddr

The undefined behaviour USAN clang checker found this.

This fix is a bit messy but so are the original structures.

Since the API on Solaris/Illuminos does not return the AF_LINK
sockaddr type we are interested in, there is little value in
fixing the code on that platform to iterate through a list
that does not contain the element we are looking for.

Change-Id: Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/route.c
1 file changed, 38 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/454/2

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ff64938..f8cfa53 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3639,11 +3639,15 @@
         rgi->flags |=3D RGI_NETMASK_DEFINED;
     }

+#if !defined(TARGET_SOLARIS)
+    /* Illumos/Solaris does not provide AF_LINK entries when calling the
+     * SIOCGIFCONF API, so there is little sense to trying to figure out a
+     * MAC address from an API that does not provide that information */
+
     /* try to read MAC addr associated with interface that owns default ga=
teway */
     if (rgi->flags & RGI_IFACE_DEFINED)
     {
         struct ifconf ifc;
-        struct ifreq *ifr;
         const int bufsize =3D 4096;
         char *buffer;

@@ -3668,22 +3672,44 @@

         for (cp =3D buffer; cp <=3D buffer + ifc.ifc_len - sizeof(struct i=
freq); )
         {
-            ifr =3D (struct ifreq *)cp;
-#if defined(TARGET_SOLARIS)
-            const size_t len =3D sizeof(ifr->ifr_name) + sizeof(ifr->ifr_a=
ddr);
-#else
-            const size_t len =3D sizeof(ifr->ifr_name) + max(sizeof(ifr->i=
fr_addr), ifr->ifr_addr.sa_len);
-#endif
+            struct ifreq ifr =3D { 0 };
+            /* this is not always using an 8 byte alignment that struct ifr
+             * requires */
+            memcpy(&ifr, cp, sizeof(struct ifreq));
+            const size_t len =3D sizeof(ifr.ifr_name) + max(sizeof(ifr.ifr=
_addr), ifr.ifr_addr.sa_len);

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
@@ -3691,6 +3717,7 @@
             cp +=3D len;
         }
     }
+#endif /* if !defined(TARGET_SOLARIS) */

 done:
     if (sockfd >=3D 0)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/454?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8
Gerrit-Change-Number: 454
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--G6JadVbR+9A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/454?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Fix unaligned access in macOS, FreeBSD, Solaris hwaddr<br><br>The und=
efined behaviour USAN clang checker found this.<br><br>This fix is a bit me=
ssy but so are the original structures.<br><br>Since the API on Solaris/Ill=
uminos does not return the AF_LINK<br>sockaddr type we are interested in, t=
here is little value in<br>fixing the code on that platform to iterate thro=
ugh a list<br>that does not contain the element we are looking for.<br><br>=
Change-Id: Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8<br>Signed-off-by: Arne=
 Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/route.c<br>1 file =
changed, 38 insertions(+), 11 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/54/454/2</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/route.c b/src/openvpn/route.c</span><br><span>index ff64938..f8cfa53 =
100644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/=
openvpn/route.c</span><br><span>@@ -3639,11 +3639,15 @@</span><br><span>   =
      rgi-&gt;flags |=3D RGI_NETMASK_DEFINED;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !def=
ined(TARGET_SOLARIS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Illumos/Solaris does not provide AF_LINK entries when calling the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * SIOCGIFCONF AP=
I, so there is little sense to trying to figure out a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * MAC address from an API that does =
not provide that information */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     /* try to read MAC addr associated with i=
nterface that owns default gateway */</span><br><span>     if (rgi-&gt;flag=
s &amp; RGI_IFACE_DEFINED)</span><br><span>     {</span><br><span>         =
struct ifconf ifc;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     struct ifreq *ifr;</span><br><span>         const int bufsize =3D 4096=
;</span><br><span>         char *buffer;</span><br><span> </span><br><span>=
@@ -3668,22 +3672,44 @@</span><br><span> </span><br><span>         for (cp =
=3D buffer; cp &lt;=3D buffer + ifc.ifc_len - sizeof(struct ifreq); )</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            ifr =3D (struct ifreq *)cp;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(TARGET_SOLARIS)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            const size_t len =3D sizeof(ifr-&gt;ifr=
_name) + sizeof(ifr-&gt;ifr_addr);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         const size_t len =3D sizeof(ifr-&gt;ifr_name) + max(sizeof(ifr-&gt=
;ifr_addr), ifr-&gt;ifr_addr.sa_len);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            struct ifreq ifr =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            /* this is not always using an 8 byte al=
ignment that struct ifr</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+             * requires */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            memcpy(&amp;ifr, cp, sizeof(struct ifreq));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            const size_t len=
 =3D sizeof(ifr.ifr_name) + max(sizeof(ifr.ifr_addr), ifr.ifr_addr.sa_len);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if (!ifr-&gt;ifr_addr.sa_family)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if (!ifr.ifr_addr.sa_family)</span><br><s=
pan>             {</span><br><span>                 break;</span><br><span>=
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (!strncmp(ifr-&gt;ifr_name, rgi-&gt;iface, IFNAMSIZ))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (!strncmp(ifr.ifr_=
name, rgi-&gt;iface, IFNAMSIZ))</span><br><span>             {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                if (ifr-&gt;ifr_ad=
dr.sa_family =3D=3D AF_LINK)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                if (ifr.ifr_addr.sa_family =3D=3D AF_LINK)</span><=
br><span>                 {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    struct sockaddr_dl *sdl =3D (struct sockaddr_dl *=
)&amp;ifr-&gt;ifr_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    /* This is a confusing member access on multiple le=
vels.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
       *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
          * struct sockaddr_dl is 20 bytes in size and has</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                     * 12 bytes spac=
e for the hw address (6 bytes)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                     * and Ethernet interface name (max 16 bytes=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
   *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
      * So if the interface name is more than 6 byte, it</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                     * extends beyond =
the struct.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
             *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                * This struct is embedded into ifreq that has</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                     * 16 bytes f=
or a sockaddr and also expects this</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                     * struct to potentially extend beyond =
the bounds of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
               * the struct.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                     *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     * Since we only copied 32 bytes from cp to=
 ifr but sdl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              * might extend after ifr&#39;s end, we  need to copy from</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                     * =
cp directly to avoid missing out on extra bytes</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                     * behind the struct</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                     */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    co=
nst size_t sock_dl_len =3D max_int((int) (sizeof(struct sockaddr_dl)),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                               (int) (ifr.ifr_addr.sa_len));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    struct sockaddr_dl *sdl =3D gc_ma=
lloc(sock_dl_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    memcpy(sdl, cp + offsetof(struct ifreq, i=
fr_addr), sock_dl_len);</span><br><span>                     memcpy(rgi-&gt=
;hwaddr, LLADDR(sdl), 6);</span><br><span>                     rgi-&gt;flag=
s |=3D RGI_HWADDR_DEFINED;</span><br><span>                 }</span><br><sp=
an>@@ -3691,6 +3717,7 @@</span><br><span>             cp +=3D len;</span><b=
r><span>         }</span><br><span>     }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif /* if !defined(TARGET_SOLARIS) */</span><br><s=
pan> </span><br><span> done:</span><br><span>     if (sockfd &gt;=3D 0)</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/454?usp=3Demail">change 454</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/454?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia797c8801fa9a9bc10b6674efde=
5fdbd7132e4a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 454 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--G6JadVbR+9A=--

