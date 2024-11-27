From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 27 Nov 2024 18:19:55 +0000
In-Reply-To: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
References: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <bbce814b21986fc9e2e41650941fd57d8bd16e38-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ycbWzoPaBiE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: allow user to
 specify 'local' multiple times in config files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ycbWzoPaBiE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/436?usp=3Demail )

Change subject: allow user to specify 'local' multiple times in config files
......................................................................


Patch Set 7: Code-Review-1

(9 comments)

Patchset:

PS7:
This is messier than it should be - having the `local` list in the CE struc=
ture, while it is only useful for servers (that do not use CE).  But maybe =
this cannot be fixed if we do want to permit a (single) `local` entry insid=
e a `<connection>` (which makes sense).

But besides this, there's questions...


File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/2ee16be6_972b5621 :
PS7, Line 114:   open a socket.
This text is not clear to me.  What does "*" do?  (This interacts with #761=
 on `::`).

Maybe:

```
On a client, or in point-to-point mode, this can only be specified once (1 =
socket).  On an OpenVPN setup running as `--server`, this can be specified =
multiple times to open multiple listening sockets on different addresses an=
d/or different ports.

In order to specify multiple listen ports without specifying an address, us=
e '*' to signal "use what the operating system gives you as default".  For =
"all IPv4 addresses" use '0.0.0.0', for "all IPv6 addresses" use '::'.

`--local` implies `--bind`.
```

(It's also slightly unclear how this interacts with `--proto`?  Maybe this =
is added in a later patch of the series?)


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/c96e1fb3_88b2e29c :
PS7, Line 133:     "                        a server listen on multiple soc=
kets at the same time.\n"
when there is agreement on the wording in the manpage, this needs to be add=
ressed as well


http://gerrit.openvpn.net/c/openvpn/+/436/comment/1ff60b54_20cb34b1 :
PS7, Line 998:     setenv_str_i(es, "local", e->local_list->array[0]->local=
, i);
will this crash if `--local` has not been used at all?


http://gerrit.openvpn.net/c/openvpn/+/436/comment/24119bb9_af8f4bf9 :
PS7, Line 2406:     }
I would not check on `ce->remote` but on `mode =3D=3D SERVER` here, and cha=
nge the wording to `multiple --local statements only allowed in --server mo=
de`.

Also, will this crash if no `--local` statement has been used (aka is the l=
ist always initialized?)


http://gerrit.openvpn.net/c/openvpn/+/436/comment/8fdc0098_59259f5f :
PS7, Line 3185:     bool need_bind =3D ce->local_port_defined || ce->bind_d=
efined;
this looks incomplete - shouldn't the existence of a `--local` entry also s=
et `need_bind =3D true`?


http://gerrit.openvpn.net/c/openvpn/+/436/comment/f467c398_a6c43f2d :
PS7, Line 3198:     if (o->client && !need_bind)
is this intentional or a rebase artefact?  This looks a bit unrelated


http://gerrit.openvpn.net/c/openvpn/+/436/comment/18bf97b8_6adc2bc6 :
PS7, Line 3827:     /* use the same listen list for every outgoing connecti=
on */
well... for outgoing connections we do not want to use a *list* at all, as =
we can only bind() once...?  (but I need to read up on o->ce vs. o->connect=
ion_list)


http://gerrit.openvpn.net/c/openvpn/+/436/comment/42fa7611_2d03d61e :
PS7, Line 6250:             e->bind_local =3D true;
I do not understand this `bind_local` variable.  Of course we bind(), other=
wise the whole setting of `local` does not make sense?   And even on "*" we=
 do want to `bind()`...?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Gerrit-Change-Number: 436
Gerrit-PatchSet: 7
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 27 Nov 2024 18:19:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--ycbWzoPaBiE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail">Vi=
ew Change</a></p><p>9 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/436?tab=3Dcomments">Patch Set #7:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">This is messier than it should be - having th=
e `local` list in the CE structure, while it is only useful for servers (th=
at do not use CE).  But maybe this cannot be fixed if we do want to permit =
a (single) `local` entry inside a `&lt;connection&gt;` (which makes sense).=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">But besides =
this, there&#39;s questions...</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File doc/man-sections/link-options.rst:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/436/comment/2ee16be6_972b5621">Patch Set #7, Line 114:</a> <code style=
=3D"font-family:monospace,monospace">  open a socket.</code></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">This text is not clear to m=
e.  What does &quot;*&quot; do?  (This interacts with #761 on `::`).</p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe:</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>On a client, or i=
n point-to-point mode, this can only be specified once (1 socket).  On an O=
penVPN setup running as `--server`, this can be specified multiple times to=
 open multiple listening sockets on different addresses and/or different po=
rts.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">In order=
 to specify multiple listen ports without specifying an address, use &#39;*=
&#39; to signal &quot;use what the operating system gives you as default&qu=
ot;.  For &quot;all IPv4 addresses&quot; use &#39;0.0.0.0&#39;, for &quot;a=
ll IPv6 addresses&quot; use &#39;::&#39;.</p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">`--local` implies `--bind`.<br>```</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">(It&#39;s also slightly =
unclear how this interacts with `--proto`?  Maybe this is added in a later =
patch of the series?)</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436/comment/c96e1=
fb3_88b2e29c">Patch Set #7, Line 133:</a> <code style=3D"font-family:monosp=
ace,monospace">    &quot;                        a server listen on multipl=
e sockets at the same time.\n&quot;</code></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">when there is agreement on the wording in the=
 manpage, this needs to be addressed as well</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/436/comment/1ff60b54_20cb34b1">Patch Set #7,=
 Line 998:</a> <code style=3D"font-family:monospace,monospace">    setenv_s=
tr_i(es, &quot;local&quot;, e-&gt;local_list-&gt;array[0]-&gt;local, i);</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">will thi=
s crash if `--local` has not been used at all?</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/436/comment/24119bb9_af8f4bf9">Patch Set #=
7, Line 2406:</a> <code style=3D"font-family:monospace,monospace">    }</co=
de></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I would n=
ot check on `ce-&gt;remote` but on `mode =3D=3D SERVER` here, and change th=
e wording to `multiple --local statements only allowed in --server mode`.</=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Also, will thi=
s crash if no `--local` statement has been used (aka is the list always ini=
tialized?)</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
36/comment/8fdc0098_59259f5f">Patch Set #7, Line 3185:</a> <code style=3D"f=
ont-family:monospace,monospace">    bool need_bind =3D ce-&gt;local_port_de=
fined || ce-&gt;bind_defined;</code></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">this looks incomplete - shouldn&#39;t the existence=
 of a `--local` entry also set `need_bind =3D true`?</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/436/comment/f467c398_a6c43f2d">Patch=
 Set #7, Line 3198:</a> <code style=3D"font-family:monospace,monospace">   =
 if (o-&gt;client &amp;&amp; !need_bind)</code></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">is this intentional or a rebase artefact=
?  This looks a bit unrelated</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/436/comment/18bf97b8_6adc2bc6">Patch Set #7, Line 3827:</a>=
 <code style=3D"font-family:monospace,monospace">    /* use the same listen=
 list for every outgoing connection */</code></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">well... for outgoing connections we do not=
 want to use a *list* at all, as we can only bind() once...?  (but I need t=
o read up on o-&gt;ce vs. o-&gt;connection_list)</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/436/comment/42fa7611_2d03d61e">Patch Set=
 #7, Line 6250:</a> <code style=3D"font-family:monospace,monospace">       =
     e-&gt;bind_local =3D true;</code></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">I do not understand this `bind_local` variable.  =
Of course we bind(), otherwise the whole setting of `local` does not make s=
ense?   And even on &quot;*&quot; we do want to `bind()`...?</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/436?usp=3Demail">change 436</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20a=
dde09529e2764 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 436 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@...1664...=
26...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 27 Nov 2024 18:19:55=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ycbWzoPaBiE=--

