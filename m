From: "mattock (Code Review)" <gerrit@...515...>
Date: Thu, 9 Jan 2025 12:13:08 +0000
In-Reply-To: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
References: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
Reply-To: samuli@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3a506977cf55747526eb78301a41904d0b46513c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xUnS8yuXZ8M="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add lwip support to
 t_server_null
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xUnS8yuXZ8M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

mattock has posted comments on this change. ( http://gerrit.openvpn.net/c/o=
penvpn/+/811?usp=3Demail )

Change subject: Add lwip support to t_server_null
......................................................................


Patch Set 7:

(5 comments)

Patchset:

PS7:
I believe all the issues have now been fixed.


File doc/t_server_null.rst:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/2d1c9ea4_216d5c5f :
PS4, Line 129: Note that all ovpnlwip test names need to include a "_lwip" =
suffix: without if
> "without it"
Fixed.


File tests/lwip_client_up.sh:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/d09bbc1c_eac12c14 :
PS4, Line 4: if ! grep "$ifconfig_local" ./$test_name.ips; then
> Should use grep -q
Fixed.


File tests/t_server_null_client.sh:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/05185aa6_2c43584f :
PS4, Line 61:             echo "ERROR: pinging one or more openvpnlwip clie=
nt IP addresses failed!"
> This should use FAIL since it actually causes the test to fail. [=E2=80=
=A6]
Fixed.


File tests/t_server_null_default.rc:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/ab8689e8_99bd56fe :
PS4, Line 22: LWIPOVPN_PATH=3D"${LWIPOVPN_PATH:-lwipovpn}"
> This is extremely misleading. This seems to indicate that you can overrid=
e `LWIPOVPN_PATH`. [=E2=80=A6]
I actually mentioned this in my comment to patchset 2, quoted below in full:

---

It is now possible to do

LWIPOVPN_PATH=3D/some/path/to/lwipovpn make check

To use a custom location.

It would have been nicer to be able to override it it t_server_null.rc, but=
 that file gets loaded too late for it to have any practical effect on the =
actual client command-lines.

---

This override mechanism is already used in openvpn-buildbot, see

https://github.com/OpenVPN/openvpn-buildbot/blob/master/buildbot-host/build=
master/master.cfg#L506

I've added a comment to the file that explains how this works.

The details are already lost in the mists of time, but I remember not seein=
g an obvious alternative solution to this that would not have involved a fa=
ir amount of refactoring. Hence I opted for this simple solution which I ag=
ree was misleading, especially when not documented.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250
Gerrit-Change-Number: 811
Gerrit-PatchSet: 7
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 09 Jan 2025 12:13:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--xUnS8yuXZ8M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
811?tab=3Dcomments">Patch Set #7:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">I believe all the issues have now been fixed.</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/t_server_nu=
ll.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/811/comment/2d1c9ea4_216d5c5f">Patch Set #=
4, Line 129:</a> <code style=3D"font-family:monospace,monospace">Note that =
all ovpnlwip test names need to include a &quot;_lwip&quot; suffix: without=
 if</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">&quot;without it&quot;</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Fixed.</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File tests/lwip_client_up.sh:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/811/comment/d09bbc1c_eac12c14">Patch Set #4, Line 4:</=
a> <code style=3D"font-family:monospace,monospace">if ! grep &quot;$ifconfi=
g_local&quot; ./$test_name.ips; then</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should use grep =
-q</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Fixed.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File te=
sts/t_server_null_client.sh:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811/comment/05185aa6_=
2c43584f">Patch Set #4, Line 61:</a> <code style=3D"font-family:monospace,m=
onospace">            echo &quot;ERROR: pinging one or more openvpnlwip cli=
ent IP addresses failed!&quot;</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This should use FAIL s=
ince it actually causes the test to fail. [=E2=80=A6]</blockquote></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Fixed.</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File tests/t_server_null_defaul=
t.rc:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/811/comment/ab8689e8_99bd56fe">Patch Set #4,=
 Line 22:</a> <code style=3D"font-family:monospace,monospace">LWIPOVPN_PATH=
=3D&quot;${LWIPOVPN_PATH:-lwipovpn}&quot;</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This is ext=
remely misleading. This seems to indicate that you can override `LWIPOVPN_P=
ATH`. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I actually mentioned this in my comment to patchset 2, qu=
oted below in full:</p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">---</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">It=
 is now possible to do</p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">LWIPOVPN_PATH=3D/some/path/to/lwipovpn make check</p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">To use a custom location.</p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">It would have b=
een nicer to be able to override it it t_server_null.rc, but that file gets=
 loaded too late for it to have any practical effect on the actual client c=
ommand-lines.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>---</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">This ove=
rride mechanism is already used in openvpn-buildbot, see</p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">https://github.com/OpenVPN/open=
vpn-buildbot/blob/master/buildbot-host/buildmaster/master.cfg#L506</p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">I&#39;ve added a comm=
ent to the file that explains how this works.</p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">The details are already lost in the mists =
of time, but I remember not seeing an obvious alternative solution to this =
that would not have involved a fair amount of refactoring. Hence I opted fo=
r this simple solution which I agree was misleading, especially when not do=
cumented.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/811?usp=3Demail">change 811</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/811?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca=
6b8c029f0d250 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 811 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 09 Jan 2025 12:13:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--xUnS8yuXZ8M=--

