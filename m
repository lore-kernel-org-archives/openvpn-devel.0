From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 2 Jun 2024 16:56:06 +0000
In-Reply-To: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
References: <gerrit.1713800630000.I1c038dc4ec80d3499582d81eee61fee74f26e693@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <df3263813f00670986cde21ab226a214e744abd5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GE4TUOFwazE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Try to
 detect LZO with pkg-config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GE4TUOFwazE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/556?usp=3Demail )

Change subject: configure: Try to detect LZO with pkg-config
......................................................................


Patch Set 6:

(1 comment)

Patchset:

PS6:
close...

fbsd14, master + this patch, "configure" with no further arguments

```
checking for lzo2... yes
checking for lzo/lzoutil.h... no
checking for lzoutil.h... no
configure: error: lzoutil.h is missing
$ locate lzoutil.h
/usr/local/include/lzo/lzoutil.h
```

and this might actually be a broken `.pc`, as the failure is

```
configure:18961: result: no
configure:18969: checking for lzoutil.h
configure:18969: cc -c -g -O2 -std=3Dc99 -I/usr/local/include/lzo  conftest=
.c >&5
In file included from conftest.c:162:
/usr/local/include/lzo/lzoutil.h:33:10: fatal error: 'lzo/lzoconf.h' file n=
ot fo
und
#include <lzo/lzoconf.h>
         ^~~~~~~~~~~~~~~
```

so we *should* `-I/usr/local/include`.

On the other side, `lzoutil.h` has this comment

```
/***********************************************************************
// LZO-v1 deprecated macros (which were used in the old example programs)
//
// THIS FILE IS DEPRECATED. DO NOT USE.
************************************************************************/
```

so maybe we shouldn't check for this one at all?  (we use `lzo_malloc()` an=
d `lzo_free()` though, but those are simple defines to plain malloc/free).

Mmmh.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee61fee74f26e693
Gerrit-Change-Number: 556
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sun, 02 Jun 2024 16:56:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--GE4TUOFwazE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
56?tab=3Dcomments">Patch Set #6:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">close...</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">fbsd14, master + this patch, &quot;configure&quot; wit=
h no further arguments</p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">```<br>checking for lzo2... yes<br>checking for lzo/lzoutil.h... =
no<br>checking for lzoutil.h... no<br>configure: error: lzoutil.h is missin=
g<br>$ locate lzoutil.h<br>/usr/local/include/lzo/lzoutil.h<br>```</p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">and this might actual=
ly be a broken `.pc`, as the failure is</p><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">```<br>configure:18961: result: no<=
br>configure:18969: checking for lzoutil.h<br>configure:18969: cc -c -g -O2=
 -std=3Dc99 -I/usr/local/include/lzo  conftest.c &gt;&amp;5<br>In file incl=
uded from conftest.c:162:<br>/usr/local/include/lzo/lzoutil.h:33:10: fatal =
error: &#39;lzo/lzoconf.h&#39; file not fo<br>und<br>#include &lt;lzo/lzoco=
nf.h&gt;<br>         ^~~~~~~~~~~~~~~<br>```</pre><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">so we *should* `-I/usr/local/include`.</p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">On the other sid=
e, `lzoutil.h` has this comment</p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">```<br>/************************************************=
***********************<br>// LZO-v1 deprecated macros (which were used in =
the old example programs)<br>//<br>// THIS FILE IS DEPRECATED. DO NOT USE.<=
br>************************************************************************=
/<br>```</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">so m=
aybe we shouldn&#39;t check for this one at all?  (we use `lzo_malloc()` an=
d `lzo_free()` though, but those are simple defines to plain malloc/free).<=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Mmmh.</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/556?usp=3Demail">change 556</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/556?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c038dc4ec80d3499582d81eee6=
1fee74f26e693 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 556 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 02 Jun 2024 16:56:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--GE4TUOFwazE=--

