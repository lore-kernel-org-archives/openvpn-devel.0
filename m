From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 26 Jul 2024 13:27:26 +0000
In-Reply-To: <gerrit.1721982049000.I9766c68feaba71279f26c3310eee4b5ca215e6ac@...2715...>
References: <gerrit.1721982049000.I9766c68feaba71279f26c3310eee4b5ca215e6ac@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b0df44285c546ae376188aa9832200c1e37dc01d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g7GbJOBvs10="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for
 HAProxy's PROXY protocol
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--g7GbJOBvs10=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

ralf_lici has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/685?usp=3Demail )

Change subject: Add support for HAProxy's PROXY protocol
......................................................................


Patch Set 1:

(11 comments)

Patchset:

PS1:
> Only looked through it superficially. [=E2=80=A6]
Sure, I'm working on it


File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/685/comment/7290bcc7_a1b2bf59 :
PS1, Line 494:     src/openvpn/proxy_protocol.h
> haproxy_protocol.c/haproxy_protol.h [=E2=80=A6]
Acknowledged


File doc/proxy-protocol.txt:

http://gerrit.openvpn.net/c/openvpn/+/685/comment/98eb2e63_aa08eed1 :
PS1, Line 8: https://www.haproxy.org/download/2.4/doc/proxy-protocol.txt
> Is this just a copy and paste of the document or is this addition to that=
 document? It would be good [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/685/comment/7d238309_2cbc8ac3 :
PS1, Line 11: a binary version (v2).
> Is this protocol TCP only? I assume so, so would be good to mention this.
It also supports UDP but we only handle the TCP case so I will state it mor=
e clearly in the document.


http://gerrit.openvpn.net/c/openvpn/+/685/comment/83291020_4f4e27ad :
PS1, Line 26: ---------
> Why are supporting two new protocls? Is there a need to introduce an alre=
ady deprecated protocol to  [=E2=80=A6]
Actually, as far as I have seen, currently some proxies only support v1 (eg=
. stunnel) so I don't think this version can be considered deprecated yet.


http://gerrit.openvpn.net/c/openvpn/+/685/comment/e62ae60e_87dd1528 :
PS1, Line 97:   The v2 signature of the protocol: "\x0D\x0A\x0D\x0A\x00\x0D=
\x0A\x51\x55\x49\x54\x0A\x20".
> Really? The singnature is '\r\n\r\n\x00\r\nQUIT\n'?
Yes. Citing the specification (section 6):
This means that most protocols and implementations will not be confused by =
an incoming connection exhibiting the protocol signature, which avoids issu=
es when facing misconfigurations.


http://gerrit.openvpn.net/c/openvpn/+/685/comment/55c354bf_e38e4ac0 :
PS1, Line 108:
> What does this mean in the openvpn context?
Basically LOCAL commands are used when the proxy sends health-checks to the=
 server and therefore I guess these should never arrive to an openvpn serve=
r and should be ignored. I will add this info to the document


http://gerrit.openvpn.net/c/openvpn/+/685/comment/a24cdcda_47d21b79 :
PS1, Line 115:     DGRAM (0x2).
> if this is dgram, is the protocol still over tcp or does it use UDP then?
The PROXY protocol works both with TCP and with UDP but we support only TCP=
. I will write in the document that we support only TCP.


File src/openvpn/proxy_protocol.h:

http://gerrit.openvpn.net/c/openvpn/+/685/comment/9bd9130b_22b62cc0 :
PS1, Line 8:  *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
> Wrong copyright
Acknowledged


File src/openvpn/proxy_protocol.c:

http://gerrit.openvpn.net/c/openvpn/+/685/comment/af015d00_a4fef0e9 :
PS1, Line 8:  *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
> Wrong copyright
Acknowledged


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/685/comment/a5c360d3_bd5f87ca :
PS1, Line 2684:             /* check if it's a PROXY protocol header */
> I don't think this is the right place to add this. [=E2=80=A6]
It's true that it doesn't get executed only on the first packet. However, t=
here's a change in multi.c that checks if the header is present only once a=
t the beginning of a TCP connection and parses it. So, even if we were to d=
etect a proxy header later, we would not parse it. Additionally, we don't e=
xpect proxy headers after the connection has begun. Therefore, if we end up=
 in this "if" condition, it will probably be due to a malformed packet, and=
 the connection will be dropped.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9766c68feaba71279f26c3310eee4b5ca215e6ac
Gerrit-Change-Number: 685
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 26 Jul 2024 13:27:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--g7GbJOBvs10=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail">View C=
hange</a></p><p>11 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/685?tab=3Dcomments">Patch Set #1:</a> </p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Only looked through =
it superficially. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Sure, I&#39;m working on it</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File CMakeLists.txt:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/685/comment/7290bcc7_a1b2bf59">Patch Set #1, Line 494:</a> <co=
de style=3D"font-family:monospace,monospace">    src/openvpn/proxy_protocol=
.h</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">haproxy_protocol.c/haproxy_protol.h [=E2=80=A6]</b=
lockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ac=
knowledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File d=
oc/proxy-protocol.txt:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685/comment/98eb2e63_aa08ee=
d1">Patch Set #1, Line 8:</a> <code style=3D"font-family:monospace,monospac=
e">https://www.haproxy.org/download/2.4/doc/proxy-protocol.txt</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">Is this just a copy and paste of the document or is this addition=
 to that document? It would be good [=E2=80=A6]</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/685/comment/7d238309_2cbc8ac=
3">Patch Set #1, Line 11:</a> <code style=3D"font-family:monospace,monospac=
e">a binary version (v2).</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">Is this protocol TCP only? =
I assume so, so would be good to mention this.</blockquote></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">It also supports UDP but we =
only handle the TCP case so I will state it more clearly in the document.</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685/comment/832=
91020_4f4e27ad">Patch Set #1, Line 26:</a> <code style=3D"font-family:monos=
pace,monospace">---------</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">Why are supporting two new =
protocls? Is there a need to introduce an already deprecated protocol to  [=
=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Actually, as far as I have seen, currently some proxies only sup=
port v1 (eg. stunnel) so I don&#39;t think this version can be considered d=
eprecated yet.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/685/comment/e62ae60e_87dd1528">Patch Set #1, Line 97:</a> <code style=3D"f=
ont-family:monospace,monospace">  The v2 signature of the protocol: &quot;\=
x0D\x0A\x0D\x0A\x00\x0D\x0A\x51\x55\x49\x54\x0A\x20&quot;.</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">Really? The singnature is &#39;\r\n\r\n\x00\r\nQUIT\n&#39;?</blockquo=
te></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes. Citi=
ng the specification (section 6):<br>This means that most protocols and imp=
lementations will not be confused by an incoming connection exhibiting the =
protocol signature, which avoids issues when facing misconfigurations.</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685/comment/55c354=
bf_e38e4ac0">Patch Set #1, Line 108:</a> <code style=3D"font-family:monospa=
ce,monospace"></code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">What does this mean in the openvpn con=
text?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Basically LOCAL commands are used when the proxy sends health-checks =
to the server and therefore I guess these should never arrive to an openvpn=
 server and should be ignored. I will add this info to the document</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685/comment/a24cdcda_=
47d21b79">Patch Set #1, Line 115:</a> <code style=3D"font-family:monospace,=
monospace">    DGRAM (0x2).</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">if this is dgram, is the =
protocol still over tcp or does it use UDP then?</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">The PROXY protocol works=
 both with TCP and with UDP but we support only TCP. I will write in the do=
cument that we support only TCP.</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/proxy_protocol.h:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/685/comment/9bd9130b_22b62cc0">Patch Set #1, Line 8:</a> <code style=3D"fo=
nt-family:monospace,monospace"> *  Copyright (C) 2002-2024 OpenVPN Inc &lt;=
sales@...515...&gt;</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">Wrong copyright</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/prox=
y_protocol.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/685/comment/af015d00_a4fef0e9">Patch=
 Set #1, Line 8:</a> <code style=3D"font-family:monospace,monospace"> *  Co=
pyright (C) 2002-2024 OpenVPN Inc &lt;sales@...515...&gt;</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Wrong copyright</blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/socket.c:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685/co=
mment/a5c360d3_bd5f87ca">Patch Set #1, Line 2684:</a> <code style=3D"font-f=
amily:monospace,monospace">            /* check if it&#39;s a PROXY protoco=
l header */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">I don&#39;t think this is the right place=
 to add this. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">It&#39;s true that it doesn&#39;t get executed on=
ly on the first packet. However, there&#39;s a change in multi.c that check=
s if the header is present only once at the beginning of a TCP connection a=
nd parses it. So, even if we were to detect a proxy header later, we would =
not parse it. Additionally, we don&#39;t expect proxy headers after the con=
nection has begun. Therefore, if we end up in this &quot;if&quot; condition=
, it will probably be due to a malformed packet, and the connection will be=
 dropped.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/685?usp=3Demail">change 685</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/685?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9766c68feaba71279f26c3310ee=
e4b5ca215e6ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 685 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 26 Jul 2024 13:27:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--g7GbJOBvs10=--

