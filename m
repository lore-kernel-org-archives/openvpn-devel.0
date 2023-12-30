From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 30 Dec 2023 15:03:43 +0000
In-Reply-To: <gerrit.1700582804000.Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8@...2715...>
References: <gerrit.1700582804000.Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8299961179fe22a388dd7020a95bbe000bb31897-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hrs6lZqZeSM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Hrs6lZqZeSM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/454?usp=3Demail )

Change subject: Fix unaligned access in macOS, FreeBSD, Solaris hwaddr
......................................................................


Patch Set 2: Code-Review-1

(5 comments)

Patchset:

PS2:
The ifr memcpy() is well understood and necessary.  The sockaddr_dl memcpy(=
) needs at least some better comments, but maybe it's not necessary at all.


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/454/comment/b7cb53d2_d5e9c975 :
PS2, Line 3677:              * requires */
"need to memcpy() to a strict ifr to force 8-byte alignment required for me=
mber access"


http://gerrit.openvpn.net/c/openvpn/+/454/comment/3ec0b40a_9dd8ee38 :
PS2, Line 3691:                      * struct sockaddr_dl is 20 bytes in si=
ze and has
On FreeBSD 13 this is

```
struct sockaddr_dl {
        u_char  sdl_len;        /* Total length of sockaddr */
        u_char  sdl_family;     /* AF_LINK */
        u_short sdl_index;      /* if !=3D 0, system given index for interf=
ace */
        u_char  sdl_type;       /* interface type */
        u_char  sdl_nlen;       /* interface name length, no trailing 0 req=
d. */
        u_char  sdl_alen;       /* link level address length */
        u_char  sdl_slen;       /* link layer selector length */
        char    sdl_data[46];   /* minimum work area, can be larger;
                                   contains both if name and ll address */
};
```

so the "20 bytes" comment should be qualified "on some of the BSDs" or so (=
NetBSD indeed has only 20 bytes).  OpenBSD has

```
        char      sdl_data[24]; /* minimum work area, can be larger;
                                   contains both if name and ll address;
                                   big enough for IFNAMSIZ plus 8byte ll ad=
dr */
```


http://gerrit.openvpn.net/c/openvpn/+/454/comment/5b60619c_c908b9eb :
PS2, Line 3693:                      * and Ethernet interface name (max 16 =
bytes)
the wording here confused me ("if it's hw address and interface name, in th=
is order, why would we care about size of interface name?") - I'd swap the =
order around ("..for interface name (max 16 bytes) and hw address (max 6 by=
tes").


http://gerrit.openvpn.net/c/openvpn/+/454/comment/e6546e64_f9ad06e2 :
PS2, Line 3703:                      * Since we only copied 32 bytes from c=
p to ifr but sdl
If ifr_addr.sa_len is >16 (because "long address") the max() above will mak=
e us copy more than 32 bytes.  So maybe we already have everything we need =
here, and can spare ourselves the double twist?

OTOH, the code below does max(sizeof(), sa_len) - so if sa_len is shorter, =
we might copy too much with the second copy?



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
Gerrit-Comment-Date: Sat, 30 Dec 2023 15:03:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Hrs6lZqZeSM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/454?usp=3Demail">Vi=
ew Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/454?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">The ifr memcpy() is well understood and neces=
sary.  The sockaddr_dl memcpy() needs at least some better comments, but ma=
ybe it&#39;s not necessary at all.</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/route.c:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/454/co=
mment/b7cb53d2_d5e9c975">Patch Set #2, Line 3677:</a> <code style=3D"font-f=
amily:monospace,monospace">             * requires */</code></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">&quot;need to memcpy() to a=
 strict ifr to force 8-byte alignment required for member access&quot;</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/454/comment/3ec0b4=
0a_9dd8ee38">Patch Set #2, Line 3691:</a> <code style=3D"font-family:monosp=
ace,monospace">                     * struct sockaddr_dl is 20 bytes in siz=
e and has</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">On FreeBSD 13 this is</p><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">```<br>struct sockaddr_dl {<br>        u_char  sd=
l_len;        /* Total length of sockaddr */<br>        u_char  sdl_family;=
     /* AF_LINK */<br>        u_short sdl_index;      /* if !=3D 0, system =
given index for interface */<br>        u_char  sdl_type;       /* interfac=
e type */<br>        u_char  sdl_nlen;       /* interface name length, no t=
railing 0 reqd. */<br>        u_char  sdl_alen;       /* link level address=
 length */<br>        u_char  sdl_slen;       /* link layer selector length=
 */<br>        char    sdl_data[46];   /* minimum work area, can be larger;=
<br>                                   contains both if name and ll address=
 */   <br>};<br>```</pre><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">so the &quot;20 bytes&quot; comment should be qualified &quot;on s=
ome of the BSDs&quot; or so (NetBSD indeed has only 20 bytes).  OpenBSD has=
</p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>```<br>        char      sdl_data[24]; /* minimum work area, can be larger=
;<br>                                   contains both if name and ll addres=
s;<br>                                   big enough for IFNAMSIZ plus 8byte=
 ll addr */<br>```</pre></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/454/comment/5b60619c_c908b9eb">Patch Set #2, Line 3693:</a> <code st=
yle=3D"font-family:monospace,monospace">                     * and Ethernet=
 interface name (max 16 bytes)</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">the wording here confused me (&quot;if it&#39;s hw=
 address and interface name, in this order, why would we care about size of=
 interface name?&quot;) - I&#39;d swap the order around (&quot;..for interf=
ace name (max 16 bytes) and hw address (max 6 bytes&quot;).</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/454/comment/e6546e64_f9ad06e2=
">Patch Set #2, Line 3703:</a> <code style=3D"font-family:monospace,monospa=
ce">                     * Since we only copied 32 bytes from cp to ifr but=
 sdl</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I=
f ifr_addr.sa_len is &gt;16 (because &quot;long address&quot;) the max() ab=
ove will make us copy more than 32 bytes.  So maybe we already have everyth=
ing we need here, and can spare ourselves the double twist?</p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">OTOH, the code below does ma=
x(sizeof(), sa_len) - so if sa_len is shorter, we might copy too much with =
the second copy?</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/454?usp=3Demail">change 454</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/454?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 30 Dec 2023 15:03:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Hrs6lZqZeSM=--

