From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 8 Mar 2025 11:32:46 +0000
In-Reply-To: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
References: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., a@...2181...
Message-ID: <8d4c9ca0b24f473f427c0da64873e37be8913695-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xYliaafqx2o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement
 override-username
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: d12fk <heiko@...515...>, stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xYliaafqx2o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/872?usp=3Demail )

Change subject: Implement override-username
......................................................................


Patch Set 8:

(4 comments)

Patchset:

PS8:
one minor nit (manpage), one major nit (*boom*).


File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/69b22c75_363de9cc :
PS8, Line 421: --override-username
this is missing the "username" argument


http://gerrit.openvpn.net/c/openvpn/+/872/comment/e1365250_cc8b4a6a :
PS8, Line 428:   Also ``username-as-common-name`` will use the client provi=
ded username
`--` missing before `username-as-common-name`, while all other opions refer=
enced have it


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/872/comment/d4cf5d2c_a9aa9911 :
PS8, Line 2692:         && strcmp(multi->locked_username, options->override=
_username) !=3D 0)
I managed to SIGSEGV this on client connect...

```
#0  0x00007ffff7913ceb in ?? () from /lib64/libc.so.6
#1  0x0000555555594699 in override_locked_username (mi=3Dmi@...1851...=3D0x=
555555709dc0)
    at multi.c:2698
#2  0x00005555555983d2 in multi_connection_established (m=3D0x7fffffffc490,
...
(gdb) print multi->locked_original_username
$1 =3D 0x0
(gdb) print multi->locked_username
$2 =3D 0x0
(gdb) print options->override_username
$3 =3D 0x55555570f658 "MyUsernameFromCCD"
```

the config is set up for testing - it has `auth-gen-token` in the main conf=
ig, and `override-username mumble` in the client's CCD/.  It does not have =
`auth-user-pass-verify` or `auth-user-pass-*` in the config.

(The original config had `auth-user-pass-optional` + an `auth-user-pass-ver=
ify script`, but for the test I did not want the script, and openvpn disall=
owed having "just auth-user-pass[-optional] without a verify method"... so =
I removed the other one too)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7a159d79ba6b6f
Gerrit-Change-Number: 872
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Sat, 08 Mar 2025 11:32:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--xYliaafqx2o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos, s=
tipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
872?tab=3Dcomments">Patch Set #8:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">one minor nit (manpage), one major nit (*boom*).<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sect=
ions/server-options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/69b22c75_363d=
e9cc">Patch Set #8, Line 421:</a> <code style=3D"font-family:monospace,mono=
space">--override-username</code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">this is missing the &quot;username&quot; argument</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/e13652=
50_cc8b4a6a">Patch Set #8, Line 428:</a> <code style=3D"font-family:monospa=
ce,monospace">  Also ``username-as-common-name`` will use the client provid=
ed username</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">`--` missing before `username-as-common-name`, while all other opions=
 referenced have it</p></li></ul></li><li style=3D"margin: 0; padding: 0;">=
<p>File src/openvpn/multi.c:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872/comment/d4cf5d2c_=
a9aa9911">Patch Set #8, Line 2692:</a> <code style=3D"font-family:monospace=
,monospace">        &amp;&amp; strcmp(multi-&gt;locked_username, options-&g=
t;override_username) !=3D 0)</code></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">I managed to SIGSEGV this on client connect...</p><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<b=
r>#0  0x00007ffff7913ceb in ?? () from /lib64/libc.so.6<br>#1  0x0000555555=
594699 in override_locked_username (mi=3Dmi@...1851...=3D0x555555709dc0)<br=
>    at multi.c:2698<br>#2  0x00005555555983d2 in multi_connection_establis=
hed (m=3D0x7fffffffc490, <br>...<br>(gdb) print multi-&gt;locked_original_u=
sername<br>$1 =3D 0x0<br>(gdb) print multi-&gt;locked_username<br>$2 =3D 0x=
0<br>(gdb) print options-&gt;override_username<br>$3 =3D 0x55555570f658 &qu=
ot;MyUsernameFromCCD&quot;<br>```</pre><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">the config is set up for testing - it has `auth-gen-=
token` in the main config, and `override-username mumble` in the client&#39=
;s CCD/.  It does not have `auth-user-pass-verify` or `auth-user-pass-*` in=
 the config.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
(The original config had `auth-user-pass-optional` + an `auth-user-pass-ver=
ify script`, but for the test I did not want the script, and openvpn disall=
owed having &quot;just auth-user-pass[-optional] without a verify method&qu=
ot;... so I removed the other one too)</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail">chan=
ge 872</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/872?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4095518d5e4447992a2974e0d7=
a159d79ba6b6f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 872 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 08 Mar 2025 11:32:46=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--xYliaafqx2o=--

