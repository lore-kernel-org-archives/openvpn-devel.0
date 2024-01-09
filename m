From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jan 2024 09:15:29 +0000
In-Reply-To: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
References: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <e58f778f5fbbb8e6f1e295960788f2447765193a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wd3T3nvubbc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Windows: enforce
 'block-local' with WFP filters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wd3T3nvubbc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/489?usp=3Demail )

Change subject: Windows: enforce 'block-local' with WFP filters
......................................................................


Patch Set 1: Code-Review-1

(9 comments)

File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/fae460bf_083f3462 :
PS1, Line 357:       Push this flag to defend against the TunnelCrack attac=
ks.
Should explain a bit more what this protects against. A reference to Tunnel=
Crack is fine but the documentation should be understandable without lookin=
g it up.


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/c60f4d43_2e7f9790 :
PS1, Line 1971:         /* Fortify 'redirect-gateway block-local' with fire=
wall rules? */
Since this hunk and the previous are completely identical I would move them=
 to a separate function. 12 lines are definitely worth it IMHO.


File src/openvpn/route.h:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/703fcdb5_6ee704b9 :
PS1, Line 248:  * is connected. This definatly returns false when not redir=
ecting the gateway
Typo "definatly"


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/39e95055_e284408d :
PS1, Line 612:     size_t i;
no reason to leave that on its own line


File src/openvpn/wfp_block.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/d821e3e7_d0986f52 :
PS1, Line 167:  * Block outgoing port 53 traffic except for
"port 53" needs to be changed to reflect the new functionality


http://gerrit.openvpn.net/c/openvpn/+/489/comment/81797d0e_701d2e70 :
PS1, Line 197:     FWPM_FILTER_CONDITION0 Condition[2];
Why remove the "=3D {0}" here?


http://gerrit.openvpn.net/c/openvpn/+/489/comment/d1a0883e_d9fb0c63 :
PS1, Line 294:     /* Third filter. Block IPv4 to port 53 or all besided lo=
opback. */
"besides"? Or maybe "except"?


http://gerrit.openvpn.net/c/openvpn/+/489/comment/919ec205_02180481 :
PS1, Line 303:     /* Forth filter. Block IPv6 to port 53 or all besides lo=
opback */
"Fourth"


File src/openvpn/win32.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/8c406c41_df81902d :
PS1, Line 1225:     if (ret =3D=3D false)
Simplify to "!win_get_exe_path(openvpnpath, _countof(openvpnpath))"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba
Gerrit-Change-Number: 489
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Tue, 09 Jan 2024 09:15:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--wd3T3nvubbc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">Vi=
ew Change</a></p><p>9 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/vpn-netwo=
rk-options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/fae460bf_083f3462">Pa=
tch Set #1, Line 357:</a> <code style=3D"font-family:monospace,monospace"> =
     Push this flag to defend against the TunnelCrack attacks.</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Should explain a b=
it more what this protects against. A reference to TunnelCrack is fine but =
the documentation should be understandable without looking it up.</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/489/comment/c60f4d43_2e7f9790">Patch Set #1, Line 1=
971:</a> <code style=3D"font-family:monospace,monospace">        /* Fortify=
 &#39;redirect-gateway block-local&#39; with firewall rules? */</code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Since this hunk a=
nd the previous are completely identical I would move them to a separate fu=
nction. 12 lines are definitely worth it IMHO.</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.h:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/489/comment/703fcdb5_6ee704b9">Patch Set #1, Line 248:</a> <code sty=
le=3D"font-family:monospace,monospace"> * is connected. This definatly retu=
rns false when not redirecting the gateway</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Typo &quot;definatly&quot;</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.c:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/489/comment/39e95055_e284408d">Patch Set #1, Line 61=
2:</a> <code style=3D"font-family:monospace,monospace">    size_t i;</code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">no reason to=
 leave that on its own line</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/wfp_block.c:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comme=
nt/d821e3e7_d0986f52">Patch Set #1, Line 167:</a> <code style=3D"font-famil=
y:monospace,monospace"> * Block outgoing port 53 traffic except for</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;port 53=
&quot; needs to be changed to reflect the new functionality</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/81797d0e_701d2e70=
">Patch Set #1, Line 197:</a> <code style=3D"font-family:monospace,monospac=
e">    FWPM_FILTER_CONDITION0 Condition[2];</code></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Why remove the &quot;=3D {0}&quot; he=
re?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/commen=
t/d1a0883e_d9fb0c63">Patch Set #1, Line 294:</a> <code style=3D"font-family=
:monospace,monospace">    /* Third filter. Block IPv4 to port 53 or all bes=
ided loopback. */</code></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">&quot;besides&quot;? Or maybe &quot;except&quot;?</p></li><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/919ec205_021804=
81">Patch Set #1, Line 303:</a> <code style=3D"font-family:monospace,monosp=
ace">    /* Forth filter. Block IPv6 to port 53 or all besides loopback */<=
/code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;=
Fourth&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/win32.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/8c406c41_df81902=
d">Patch Set #1, Line 1225:</a> <code style=3D"font-family:monospace,monosp=
ace">    if (ret =3D=3D false)</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Simplify to &quot;!win_get_exe_path(openvpnpath, _=
countof(openvpnpath))&quot;</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">change 489</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/489?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f=
071db3e4832ba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 489 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Jan 2024 09:15:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--wd3T3nvubbc=--

