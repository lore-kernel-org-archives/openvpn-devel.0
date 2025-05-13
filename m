From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 13 May 2025 13:40:38 +0000
In-Reply-To: <gerrit.1747046041000.I43ec390040bffeec05270271ea7fb54fb219c536@...2715...>
References: <gerrit.1747046041000.I43ec390040bffeec05270271ea7fb54fb219c536@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <1e0050535368c3c48702f09a240f94f67fa2df61-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gBui9t+PP+g="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: win: remove Wintun
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gBui9t+PP+g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1021?usp=3Demail )

Change subject: win: remove Wintun support
......................................................................


Patch Set 2: Code-Review+1

(4 comments)

Patchset:

PS2:
I like this - so much code and special cases going out :-) - one comment, t=
wo questions remain


File include/openvpn-msg.h:

http://gerrit.openvpn.net/c/openvpn/+/1021/comment/6f74688f_234eb585 :
PS2, Line 47:     msg_register_ring_buffers,
I am a bit worried about taking out message number enums, leading to testin=
g challenges when having openvpn.exe talking to an iservice that is from a =
different build version (this might not affect anyone but me, but I usually=
 just build an openvpn.exe and use "the rest" from a regular .msi install)


File src/openvpn/forward.h:

http://gerrit.openvpn.net/c/openvpn/+/1021/comment/1d13e680_6724da03 :
PS2, Line 406:         }
is that related to wintun? ("it does not say so, and I'm not aware of the o=
rigins of this code")


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/1021/comment/bd5e03db_47c6ab5d :
PS2, Line 2230:         }
this is similar to the thing in `forward.h` - is this related to wintun par=
ticulars, or "windows read/write" in general?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1021?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I43ec390040bffeec05270271ea7fb54fb219c536
Gerrit-Change-Number: 1021
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Tue, 13 May 2025 13:40:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--gBui9t+PP+g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1021?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1021?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">I like this - so much code and special case=
s going out :-) - one comment, two questions remain</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File include/openvpn-msg.h:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1021/comment/6f74688f_234eb585">Patch Set #2, Line 47:</a> <co=
de style=3D"font-family:monospace,monospace">    msg_register_ring_buffers,=
</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I am =
a bit worried about taking out message number enums, leading to testing cha=
llenges when having openvpn.exe talking to an iservice that is from a diffe=
rent build version (this might not affect anyone but me, but I usually just=
 build an openvpn.exe and use &quot;the rest&quot; from a regular .msi inst=
all)</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/forward.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1021/comment/1d13e680_6724da03">P=
atch Set #2, Line 406:</a> <code style=3D"font-family:monospace,monospace">=
        }</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">is that related to wintun? (&quot;it does not say so, and I&#39;m not a=
ware of the origins of this code&quot;)</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1021/comment/bd5e03db_47c6ab5d">Patch Set #2, Line 2230:</a> <code style=
=3D"font-family:monospace,monospace">        }</code></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">this is similar to the thing in `f=
orward.h` - is this related to wintun particulars, or &quot;windows read/wr=
ite&quot; in general?</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1021?usp=3Demail">change 1021</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1021?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43ec390040bffeec05270271ea7=
fb54fb219c536 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1021 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 13 May 2025 13:40:38=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--gBui9t+PP+g=--

