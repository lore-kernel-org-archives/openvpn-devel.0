From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 8 Jul 2024 19:27:55 +0000
In-Reply-To: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
References: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <de828dfd46d56b68208fafe749f6ff67711b2a9c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RQbELwJ65lg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Allow trailing \r
 and \n in control channel message
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

--RQbELwJ65lg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/672?usp=3Demail )

Change subject: Allow trailing \r and \n in control channel message
......................................................................


Patch Set 2: Code-Review-1

(3 comments)

Patchset:

PS2:
getting close


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/672/comment/fbe5364d_eb37f3f4 :
PS2, Line 302:                 int buflen =3D (int)strlen(BSTR(&buf)) + 1;
While this is besser than the original, I find it still confusing to call `=
strlen()` twice on the very same string, in direct sequence.  What's wrong =
with `int buflen =3D cmdlen +1;`...?


http://gerrit.openvpn.net/c/openvpn/+/672/comment/46ed5072_d7aeafa2 :
PS2, Line 318:                         format_hex(BPTR(&buf), BLEN(&cmdbuf)=
, 256, &gc));
> While it is not actually wrong to use BPTR(&buf) here, I would recommend =
BPTR(&cmdbuf). [=E2=80=A6]
It is "not wrong today", but this sort of booby trap will come back and bit=
e us later - so this should both be `&cmdbuf` if that's the buffer we have =
looked at (especially with new code in the pipeline that might handle multi=
ple commands in a single TLS record etc)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e
Gerrit-Change-Number: 672
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 08 Jul 2024 19:27:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--RQbELwJ65lg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/672?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">getting close</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/672/comment/fbe5364d_eb37f3f4">Patch Set #2, Line 302:</a> <code style=
=3D"font-family:monospace,monospace">                int buflen =3D (int)st=
rlen(BSTR(&amp;buf)) + 1;</code></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">While this is besser than the original, I find it still=
 confusing to call `strlen()` twice on the very same string, in direct sequ=
ence.  What&#39;s wrong with `int buflen =3D cmdlen +1;`...?</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/672/comment/46ed5072_d7aeafa=
2">Patch Set #2, Line 318:</a> <code style=3D"font-family:monospace,monospa=
ce">                        format_hex(BPTR(&amp;buf), BLEN(&amp;cmdbuf), 2=
56, &amp;gc));</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">While it is not actually wrong to use =
BPTR(&amp;buf) here, I would recommend BPTR(&amp;cmdbuf). [=E2=80=A6]</bloc=
kquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">It is=
 &quot;not wrong today&quot;, but this sort of booby trap will come back an=
d bite us later - so this should both be `&amp;cmdbuf` if that&#39;s the bu=
ffer we have looked at (especially with new code in the pipeline that might=
 handle multiple commands in a single TLS record etc)</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?us=
p=3Demail">change 672</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/672?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47c992b6b73b1475cbff8a28f72=
0cf50dc1fbe3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 672 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Jul 2024 19:27:55=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--RQbELwJ65lg=--

