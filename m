From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 5 Aug 2025 16:00:20 +0000
In-Reply-To: <gerrit.1753360288000.I6a0d352a039a0936cb9bbedf6168cd6eecd053ea@...2715...>
References: <gerrit.1753360288000.I6a0d352a039a0936cb9bbedf6168cd6eecd053ea@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <69e24494708bc2a845aebc32dbac77c961afcacf-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IaKxTE9nUeo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: comp: Make sure comp
 flags are treated as unsigned
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

--IaKxTE9nUeo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1102?usp=3Demail

to look at the new patch set (#4).


Change subject: comp: Make sure comp flags are treated as unsigned
......................................................................

comp: Make sure comp flags are treated as unsigned

compress_options.flags is already unsigned. Make sure
the individual flags are as well to avoid spurious
conversion warnings.

Change-Id: I6a0d352a039a0936cb9bbedf6168cd6eecd053ea
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/comp.h
1 file changed, 8 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1102/4

diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 265e15d..0354896 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -32,23 +32,23 @@

 /* Compression flags */
 /* Removed
- #define COMP_F_ADAPTIVE             (1<<0) / * COMP_ALG_LZO only * /
- #define COMP_F_ALLOW_COMPRESS       (1<<1) / * not only incoming is compr=
essed but also outgoing *
+ #define COMP_F_ADAPTIVE             (1u<<0) / * COMP_ALG_LZO only * /
+ #define COMP_F_ALLOW_COMPRESS       (1u<<1) / * not only incoming is comp=
ressed but also outgoing *
  /
  */
 /** initial command byte is swapped with last byte in buffer to preserve p=
ayload alignment */
-#define COMP_F_SWAP                 (1 << 2)
+#define COMP_F_SWAP                 (1u << 2)
 /** tell server that we only support compression stubs */
-#define COMP_F_ADVERTISE_STUBS_ONLY (1 << 3)
+#define COMP_F_ADVERTISE_STUBS_ONLY (1u << 3)
 /** Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
  * we still accept other compressions to be pushed */
-#define COMP_F_ALLOW_STUB_ONLY      (1 << 4)
+#define COMP_F_ALLOW_STUB_ONLY      (1u << 4)
 /** push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ =
*/
-#define COMP_F_MIGRATE              (1 << 5)
+#define COMP_F_MIGRATE              (1u << 5)
 /** Compression was explicitly set to allow asymetric compression */
-#define COMP_F_ALLOW_ASYM           (1 << 6)
+#define COMP_F_ALLOW_ASYM           (1u << 6)
 /** Do not allow compression framing (breaks DCO) */
-#define COMP_F_ALLOW_NOCOMP_ONLY    (1 << 7)
+#define COMP_F_ALLOW_NOCOMP_ONLY    (1u << 7)

 /* algorithms */
 #define COMP_ALG_UNDEF  0

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1102?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6a0d352a039a0936cb9bbedf6168cd6eecd053ea
Gerrit-Change-Number: 1102
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--IaKxTE9nUeo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1102?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">comp: Make sure comp flags are treated as unsigned<br><br>compres=
s_options.flags is already unsigned. Make sure<br>the individual flags are =
as well to avoid spurious<br>conversion warnings.<br><br>Change-Id: I6a0d35=
2a039a0936cb9bbedf6168cd6eecd053ea<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>---<br>M src/openvpn/comp.h<br>1 file changed, 8 in=
sertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/02/1102/4</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/comp.h b=
/src/openvpn/comp.h</span><br><span>index 265e15d..0354896 100644</span><br=
><span>--- a/src/openvpn/comp.h</span><br><span>+++ b/src/openvpn/comp.h</s=
pan><br><span>@@ -32,23 +32,23 @@</span><br><span> </span><br><span> /* Com=
pression flags */</span><br><span> /* Removed</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- #define COMP_F_ADAPTIVE             (1&lt;&lt;0) /=
 * COMP_ALG_LZO only * /</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- #define COMP_F_ALLOW_COMPRESS       (1&lt;&lt;1) / * not only incoming =
is compressed but also outgoing *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ #define COMP_F_ADAPTIVE             (1u&lt;&lt;0) / * COMP_A=
LG_LZO only * /</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ #de=
fine COMP_F_ALLOW_COMPRESS       (1u&lt;&lt;1) / * not only incoming is com=
pressed but also outgoing *</span><br><span>  /</span><br><span>  */</span>=
<br><span> /** initial command byte is swapped with last byte in buffer to =
preserve payload alignment */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define COMP_F_SWAP                 (1 &lt;&lt; 2)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define COMP_F_SWAP                 =
(1u &lt;&lt; 2)</span><br><span> /** tell server that we only support compr=
ession stubs */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e COMP_F_ADVERTISE_STUBS_ONLY (1 &lt;&lt; 3)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define COMP_F_ADVERTISE_STUBS_ONLY (1u &lt;&lt; 3=
)</span><br><span> /** Only accept stub compression, even with COMP_F_ADVER=
TISE_STUBS_ONLY</span><br><span>  * we still accept other compressions to b=
e pushed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CO=
MP_F_ALLOW_STUB_ONLY      (1 &lt;&lt; 4)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define COMP_F_ALLOW_STUB_ONLY      (1u &lt;&lt; 4)</s=
pan><br><span> /** push stub-v2 or comp-lzo no when we see a client with co=
mp-lzo in occ */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne COMP_F_MIGRATE              (1 &lt;&lt; 5)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define COMP_F_MIGRATE              (1u &lt;&lt; =
5)</span><br><span> /** Compression was explicitly set to allow asymetric c=
ompression */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
COMP_F_ALLOW_ASYM           (1 &lt;&lt; 6)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define COMP_F_ALLOW_ASYM           (1u &lt;&lt; 6)<=
/span><br><span> /** Do not allow compression framing (breaks DCO) */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_ALLOW_NOCOMP=
_ONLY    (1 &lt;&lt; 7)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define COMP_F_ALLOW_NOCOMP_ONLY    (1u &lt;&lt; 7)</span><br><span> </=
span><br><span> /* algorithms */</span><br><span> #define COMP_ALG_UNDEF  0=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1102?usp=3Demail">change 1102</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1102?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a0d352a039a0936cb9bbedf616=
8cd6eecd053ea </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1102 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--IaKxTE9nUeo=--

