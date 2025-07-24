From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 24 Jul 2025 12:31:39 +0000
References: <gerrit.1753360288000.I6a0d352a039a0936cb9bbedf6168cd6eecd053ea@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <43969cfc1ad480fa9bd6dbafece9356d76f78928-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="foRV6Jq79F4="; charset=UTF-8
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

--foRV6Jq79F4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1102?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1102/1

diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 0bb0d32..ee9c16a 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -33,22 +33,22 @@

 /* Compression flags */
 /* Removed
- #define COMP_F_ADAPTIVE             (1<<0) / * COMP_ALG_LZO only * /
- #define COMP_F_ALLOW_COMPRESS       (1<<1) / * not only incoming is compr=
essed but also outgoing * /
+ #define COMP_F_ADAPTIVE             (1u<<0) / * COMP_ALG_LZO only * /
+ #define COMP_F_ALLOW_COMPRESS       (1u<<1) / * not only incoming is comp=
ressed but also outgoing * /
  */
 /** initial command byte is swapped with last byte in buffer to preserve p=
ayload alignment */
-#define COMP_F_SWAP                 (1<<2)
+#define COMP_F_SWAP                 (1u<<2)
 /** tell server that we only support compression stubs */
-#define COMP_F_ADVERTISE_STUBS_ONLY (1<<3)
+#define COMP_F_ADVERTISE_STUBS_ONLY (1u<<3)
 /** Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
  * we still accept other compressions to be pushed */
-#define COMP_F_ALLOW_STUB_ONLY      (1<<4)
+#define COMP_F_ALLOW_STUB_ONLY      (1u<<4)
 /** push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ =
*/
-#define COMP_F_MIGRATE              (1<<5)
+#define COMP_F_MIGRATE              (1u<<5)
 /** Compression was explicitly set to allow asymetric compression */
-#define COMP_F_ALLOW_ASYM           (1<<6)
+#define COMP_F_ALLOW_ASYM           (1u<<6)
 /** Do not allow compression framing (breaks DCO) */
-#define COMP_F_ALLOW_NOCOMP_ONLY    (1<<7)
+#define COMP_F_ALLOW_NOCOMP_ONLY    (1u<<7)

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--foRV6Jq79F4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1102?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">comp: Make sure comp flags are treated as unsigned<br><br>co=
mpress_options.flags is already unsigned. Make sure<br>the individual flags=
 are as well to avoid spurious<br>conversion warnings.<br><br>Change-Id: I6=
a0d352a039a0936cb9bbedf6168cd6eecd053ea<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/comp.h<br>1 file changed,=
 8 insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/02/1102/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/com=
p.h b/src/openvpn/comp.h</span><br><span>index 0bb0d32..ee9c16a 100644</spa=
n><br><span>--- a/src/openvpn/comp.h</span><br><span>+++ b/src/openvpn/comp=
.h</span><br><span>@@ -33,22 +33,22 @@</span><br><span> </span><br><span> /=
* Compression flags */</span><br><span> /* Removed</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- #define COMP_F_ADAPTIVE             (1&lt;&lt=
;0) / * COMP_ALG_LZO only * /</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- #define COMP_F_ALLOW_COMPRESS       (1&lt;&lt;1) / * not only inco=
ming is compressed but also outgoing * /</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ #define COMP_F_ADAPTIVE             (1u&lt;&lt;0) / *=
 COMP_ALG_LZO only * /</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ #define COMP_F_ALLOW_COMPRESS       (1u&lt;&lt;1) / * not only incoming=
 is compressed but also outgoing * /</span><br><span>  */</span><br><span> =
/** initial command byte is swapped with last byte in buffer to preserve pa=
yload alignment */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine COMP_F_SWAP                 (1&lt;&lt;2)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define COMP_F_SWAP                 (1u&lt;&lt;2)=
</span><br><span> /** tell server that we only support compression stubs */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_ADVERT=
ISE_STUBS_ONLY (1&lt;&lt;3)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define COMP_F_ADVERTISE_STUBS_ONLY (1u&lt;&lt;3)</span><br><span> =
/** Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY</sp=
an><br><span>  * we still accept other compressions to be pushed */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_ALLOW_STUB_ONL=
Y      (1&lt;&lt;4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define COMP_F_ALLOW_STUB_ONLY      (1u&lt;&lt;4)</span><br><span> /** push=
 stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_MIGRATE      =
        (1&lt;&lt;5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define COMP_F_MIGRATE              (1u&lt;&lt;5)</span><br><span> /** Com=
pression was explicitly set to allow asymetric compression */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_ALLOW_ASYM          =
 (1&lt;&lt;6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e COMP_F_ALLOW_ASYM           (1u&lt;&lt;6)</span><br><span> /** Do not all=
ow compression framing (breaks DCO) */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define COMP_F_ALLOW_NOCOMP_ONLY    (1&lt;&lt;7)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define COMP_F_ALLOW_NOCOMP_O=
NLY    (1u&lt;&lt;7)</span><br><span> </span><br><span> /* algorithms */</s=
pan><br><span> #define COMP_ALG_UNDEF  0</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1102?usp=
=3Demail">change 1102</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1102?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a0d352a039a0936cb9bbedf616=
8cd6eecd053ea </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1102 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--foRV6Jq79F4=--

