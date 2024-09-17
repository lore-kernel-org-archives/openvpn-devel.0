From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 16:31:37 +0000
In-Reply-To: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
References: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <11ce3e8b6efb6e32145c2532926d0838e6742d74-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zl84TnmOPMs="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Introduce
 DRIVER_AFUNIX backend for use with lwipovpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zl84TnmOPMs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/747?usp=3Demail )

Change subject: Introduce DRIVER_AFUNIX backend for use with lwipovpn
......................................................................


Patch Set 6:

(11 comments)

File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/b63d509d_2a0f71c0 :
PS1, Line 19:     ``dev-node:/path/to/lwipovpn`` can emulate a full client =
that
> Shouldn't that be "unix:" ?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/747/comment/3afc6112_dfb74e8e :
PS1, Line 20:     can be pinged, can server a website and more without requ=
iring any
> "serve"
Acknowledged


File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/dbeb5e05_fce150de :
PS1, Line 123:   will pass the tun configuration as environment variables.
> ". [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/747/comment/b77c1645_98184cf9 :
PS1, Line 124:   The temporary unix will be be passed in the environment va=
riable
> "unix domain socket" ?
Acknowledged


File src/openvpn/run_command.h:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/25287472_63072ada :
PS1, Line 50: /** instead of waiting for child process exist status return =
the
> "exist" -> "exit"?
Acknowledged


File src/openvpn/run_command.c:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/ec7cc4f3_75a1d08b :
PS1, Line 196: openvpn_execve
> Aren't there changes missing to openvpn_execve in this patch?
Yes. They should be now there in the current. version


File src/openvpn/ssl.h:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/67544632_76ef8bbc :
PS1, Line 222: \
> Spurious change?
Acknowledged


File src/openvpn/tun.h:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/fcd22e1e_00ef5a87 :
PS1, Line 54:      *  this is always defined. We error out if a user tries =
to open this type
> ". [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/747/comment/76c790a0_ec4dad57 :
PS1, Line 55:      *  on unsupported platforms*/
> "platforms. [=E2=80=A6]
Acknowledged


File src/openvpn/tun_afunix.h:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/f537515b_57d9a083 :
PS1, Line 32:  * the user provided to that will take care of implementing t=
he actual tun
> Superfluous "to"?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/747/comment/1841cd16_fe4cde55 :
PS1, Line 33:  * device
> Missing full stop ". [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65099ef00822d08fd3f5480c80892f3bf86c56e7
Gerrit-Change-Number: 747
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 17 Sep 2024 16:31:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--zl84TnmOPMs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">View C=
hange</a></p><p>11 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File Changes.rst:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/747/comment/b63d509d_2a0f71c0">Patch Set #1, Line 19:</a> <code st=
yle=3D"font-family:monospace,monospace">    ``dev-node:/path/to/lwipovpn`` =
can emulate a full client that</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Shouldn&#39;t that be =
&quot;unix:&quot; ?</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/747/comment/3afc6112_dfb74e8e">Patch Set #1, Line 20:</a=
> <code style=3D"font-family:monospace,monospace">    can be pinged, can se=
rver a website and more without requiring any</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;s=
erve&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File doc/man-sections/vpn-network-options.rst:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/747/comment/dbeb5e05_fce150de">Patch Set #1, Line 123:</a> <code style=
=3D"font-family:monospace,monospace">  will pass the tun configuration as e=
nvironment variables.</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">&quot;. [=E2=80=A6]</blockquote=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledge=
d</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment/=
b77c1645_98184cf9">Patch Set #1, Line 124:</a> <code style=3D"font-family:m=
onospace,monospace">  The temporary unix will be be passed in the environme=
nt variable</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">&quot;unix domain socket&quot; ?</blockqu=
ote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowle=
dged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/run_command.h:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/747/comment/25287472_63072ada"=
>Patch Set #1, Line 50:</a> <code style=3D"font-family:monospace,monospace"=
>/** instead of waiting for child process exist status return the</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">&quot;exist&quot; -&gt; &quot;exit&quot;?</blockquote></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/run_com=
mand.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/747/comment/ec7cc4f3_75a1d08b">Patch Set #=
1, Line 196:</a> <code style=3D"font-family:monospace,monospace">openvpn_ex=
ecve</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">Aren&#39;t there changes missing to openvpn_exec=
ve in this patch?</blockquote></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Yes. They should be now there in the current. version</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=
.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/747/comment/67544632_76ef8bbc">Patch Set #1, L=
ine 222:</a> <code style=3D"font-family:monospace,monospace">\</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">Spurious change?</blockquote></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/tun.h:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
47/comment/fcd22e1e_00ef5a87">Patch Set #1, Line 54:</a> <code style=3D"fon=
t-family:monospace,monospace">     *  this is always defined. We error out =
if a user tries to open this type</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;. [=E2=80=A6]=
</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
747/comment/76c790a0_ec4dad57">Patch Set #1, Line 55:</a> <code style=3D"fo=
nt-family:monospace,monospace">     *  on unsupported platforms*/</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">&quot;platforms. [=E2=80=A6]</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun_afunix.h:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/747/comment/f537515b_57d9a083">Patch Set #1, Line 32:</a=
> <code style=3D"font-family:monospace,monospace"> * the user provided to t=
hat will take care of implementing the actual tun</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Sup=
erfluous &quot;to&quot;?</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/747/comment/1841cd16_fe4cde55">Patch Set #1, Line 3=
3:</a> <code style=3D"font-family:monospace,monospace"> * device</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">Missing full stop &quot;. [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?=
usp=3Demail">change 747</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65099ef00822d08fd3f5480c808=
92f3bf86c56e7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Sep 2024 16:31:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--zl84TnmOPMs=--

