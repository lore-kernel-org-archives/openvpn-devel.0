From: "mattock (Code Review)" <gerrit@...515...>
Date: Wed, 26 Mar 2025 12:24:10 +0000
In-Reply-To: <gerrit.1735303463000.I47d95eee8a00b9878331fd6cd6a7db12665f5537@...2715...>
References: <gerrit.1735303463000.I47d95eee8a00b9878331fd6cd6a7db12665f5537@...2715...>
Reply-To: sasepp@...2783..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <050873f8bc9fb3881181a123c8c731ade95d06bb-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bQXV5h9fcLo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]:
 t_server_null_default.rc: Add some tests with --data-ciphers
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

--bQXV5h9fcLo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

mattock has posted comments on this change. ( http://gerrit.openvpn.net/c/o=
penvpn/+/847?usp=3Demail )

Change subject: t_server_null_default.rc: Add some tests with --data-ciphers
......................................................................


Patch Set 2:

(3 comments)

Patchset:

PS2:
I believe this works as intended. I added a comment about the inconsistency=
 in order of the ciphers (see below), but I think that does not cause any p=
roblems in practice


File tests/t_server_null_default.rc:

http://gerrit.openvpn.net/c/openvpn/+/847/comment/fd61574c_bf9c83bc :
PS2, Line 109: CLIENT_CONF_4a=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 119=
4 udp --proto udp --cipher AES-128-CBC --data-ciphers AES-192-CBC:DEFAULT"
The inconsistency in --data-ciphers between server (DEFAULT:AES-192-CBC) an=
d this client (AES-192-CBC:DEFAULT) looked off, so I checked the implicatio=
ns just in case.

The --data-ciphers setting is expanded as AES-256-GCM:AES-128-GCM:AES-192-C=
BC (server) and AES-192-CBC:AES-256-GCM:AES-128-GCM (client).

The man page tells this:

"For servers, the first cipher from cipher-list that is also supported by t=
he client will be pushed to clients that support cipher negotiation."

Also, in OpenVPN 2.6.0 and later (as in here), the --cipher setting is igno=
red in TLS mode. As --cipher is different for the server and this client, t=
his seems to test the "does --cipher get ignored" part. If I'm reading this=
 right, the server tries to push AES-256-GCM first and as the client also h=
as AES-256-GCM, that cipher is chosen. AES-192-CBC, despite being in both l=
ists, is not chosen.


http://gerrit.openvpn.net/c/openvpn/+/847/comment/346e5108_279f06cb :
PS2, Line 123: CLIENT_CONF_4c=3D"${CLIENT_CONF_BASE} --remote 127.0.0.1 119=
6 udp --proto udp --cipher AES-192-CBC --data-ciphers AES-128-CBC"
This seems to fail correctly, as server does not have AES-128-CBC enabled.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/847?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I47d95eee8a00b9878331fd6cd6a7db12665f5537
Gerrit-Change-Number: 847
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mattock <sasepp@...2783...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 26 Mar 2025 12:24:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--bQXV5h9fcLo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/847?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
847?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">I believe this works as intended. I added a comme=
nt about the inconsistency in order of the ciphers (see below), but I think=
 that does not cause any problems in practice</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File tests/t_server_null_default.rc:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/847/comment/fd61574c_bf9c83bc">Patch Set #2, Line 109:</a=
> <code style=3D"font-family:monospace,monospace">CLIENT_CONF_4a=3D&quot;${=
CLIENT_CONF_BASE} --remote 127.0.0.1 1194 udp --proto udp --cipher AES-128-=
CBC --data-ciphers AES-192-CBC:DEFAULT&quot;</code></p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">The inconsistency in --data-ciphers =
between server (DEFAULT:AES-192-CBC) and this client (AES-192-CBC:DEFAULT) =
looked off, so I checked the implications just in case.</p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">The --data-ciphers setting is ex=
panded as AES-256-GCM:AES-128-GCM:AES-192-CBC (server) and AES-192-CBC:AES-=
256-GCM:AES-128-GCM (client).</p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">The man page tells this:</p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">&quot;For servers, the first cipher from ciphe=
r-list that is also supported by the client will be pushed to clients that =
support cipher negotiation.&quot;</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Also, in OpenVPN 2.6.0 and later (as in here), the --c=
ipher setting is ignored in TLS mode. As --cipher is different for the serv=
er and this client, this seems to test the &quot;does --cipher get ignored&=
quot; part. If I&#39;m reading this right, the server tries to push AES-256=
-GCM first and as the client also has AES-256-GCM, that cipher is chosen. A=
ES-192-CBC, despite being in both lists, is not chosen.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/847/comment/346e5108_279f06cb">=
Patch Set #2, Line 123:</a> <code style=3D"font-family:monospace,monospace"=
>CLIENT_CONF_4c=3D&quot;${CLIENT_CONF_BASE} --remote 127.0.0.1 1196 udp --p=
roto udp --cipher AES-192-CBC --data-ciphers AES-128-CBC&quot;</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">This seems to fail=
 correctly, as server does not have AES-128-CBC enabled.</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/847=
?usp=3Demail">change 847</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/847?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47d95eee8a00b9878331fd6cd6a=
7db12665f5537 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 847 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mattock &lt;sasepp@...2783...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Mar 2025 12:24:10=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--bQXV5h9fcLo=--

