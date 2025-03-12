From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 12 Mar 2025 04:05:06 +0000
In-Reply-To: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
References: <gerrit.1733316222000.Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., gert@...1296...
Message-ID: <bd071a01ed0cadc7c04f5df5d9f844eddc857f58-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jciD9TuUjgc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: support
 multiple domains without DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jciD9TuUjgc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/824?usp=3Demail )

Change subject: dns: support multiple domains without DHCP
......................................................................


Patch Set 12:

(7 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/824/comment/7e7bfac6_b367e51d :
PS12, Line 23:
> please reference the github issue about WMIC no longer working on Win11 [=
=E2=80=A6]
Done


File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/824/comment/70916549_d4e0161f :
PS12, Line 1171: ApplyGpolSettings32()
> `(void)`
Done


http://gerrit.openvpn.net/c/openvpn/+/824/comment/2b36d095_cbfd9faa :
PS12, Line 1211: ApplyGpolSettings64()
> `(void)`
Done


http://gerrit.openvpn.net/c/openvpn/+/824/comment/12b0644b_5e2f5cad :
PS12, Line 1248: ApplyGpolSettings()
> `(void)`
Done


http://gerrit.openvpn.net/c/openvpn/+/824/comment/2dd35100_49932acc :
PS12, Line 1609:  * If it doesn't exists, resets to empty, effectively disa=
bling it.
> typo here ("exists")
Done


http://gerrit.openvpn.net/c/openvpn/+/824/comment/ea2a7802_1d8a8a94 :
PS12, Line 1631:         goto out;
> my understanding of the code flow is that the `goto out` should be inside=
 the `if (err !=3D ERROR_FILE [=E2=80=A6]
Yeah that is intentional. If there was no SearchList, there will be no Inin=
italSearchList created in the first place.


http://gerrit.openvpn.net/c/openvpn/+/824/comment/6b364f9b_c7efb34c :
PS12, Line 1698:         }
> in this case ("no InitialSearchList can be found") this whole function wo=
uld then fail to do anythin [=E2=80=A6]
When we get there something is inconsistent in the registry. The SearchList=
 is not empty, but we do not have a InitialSearchList to compare to. Storin=
g the shorter, but non-empty list is as wrong as leaving it in its current =
state, as it is not empty, not can it be reset to the original list.

If you rather have the `return` removed and the next branch turned into an =
`else if` I can do it, but the SearchList will still be in an undefined sta=
te after the modification.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537cb74b15f4fed96
Gerrit-Change-Number: 824
Gerrit-PatchSet: 12
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 12 Mar 2025 04:05:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--jciD9TuUjgc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail">View C=
hange</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/824/comment/7e7bfac6_b367e51d">Patch Set #12, Line 23:</a> <code styl=
e=3D"font-family:monospace,monospace"></code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">please referen=
ce the github issue about WMIC no longer working on Win11 [=E2=80=A6]</bloc=
kquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpns=
erv/interactive.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/70916549_d4e0161f">=
Patch Set #12, Line 1171:</a> <code style=3D"font-family:monospace,monospac=
e">ApplyGpolSettings32()</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">`(void)`</blockquote></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/2b36d095_cbfd9fa=
a">Patch Set #12, Line 1211:</a> <code style=3D"font-family:monospace,monos=
pace">ApplyGpolSettings64()</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">`(void)`</blockquote></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/12b0644b_5e2f=
5cad">Patch Set #12, Line 1248:</a> <code style=3D"font-family:monospace,mo=
nospace">ApplyGpolSettings()</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`(void)`</blockquote></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/2dd35100_499=
32acc">Patch Set #12, Line 1609:</a> <code style=3D"font-family:monospace,m=
onospace"> * If it doesn&#39;t exists, resets to empty, effectively disabli=
ng it.</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">typo here (&quot;exists&quot;)</blockquote></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/ea2a7802_1d8=
a8a94">Patch Set #12, Line 1631:</a> <code style=3D"font-family:monospace,m=
onospace">        goto out;</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">my understanding of the c=
ode flow is that the `goto out` should be inside the `if (err !=3D ERROR_FI=
LE [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Yeah that is intentional. If there was no SearchList, there =
will be no IninitalSearchList created in the first place.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/824/comment/6b364f9b_c7efb34c">=
Patch Set #12, Line 1698:</a> <code style=3D"font-family:monospace,monospac=
e">        }</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">in this case (&quot;no InitialSearchList=
 can be found&quot;) this whole function would then fail to do anythin [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">When we get there something is inconsistent in the registry. The Se=
archList is not empty, but we do not have a InitialSearchList to compare to=
. Storing the shorter, but non-empty list is as wrong as leaving it in its =
current state, as it is not empty, not can it be reset to the original list=
.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">If you rath=
er have the `return` removed and the next branch turned into an `else if` I=
 can do it, but the SearchList will still be in an undefined state after th=
e modification.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/824?usp=3Demail">change 824</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/824?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaffbfa6b2e8efa2bd24a05537c=
b74b15f4fed96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 824 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 12 Mar 2025 04:05:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--jciD9TuUjgc=--

