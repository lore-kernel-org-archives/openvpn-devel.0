From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 26 Jul 2024 11:45:33 +0000
In-Reply-To: <gerrit.1721982049000.I9766c68feaba71279f26c3310eee4b5ca215e6ac@...2715...>
References: <gerrit.1721982049000.I9766c68feaba71279f26c3310eee4b5ca215e6ac@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 ralf@...2726..., frank@...2641...
Message-ID: <287fc038a977d62a20fadc1ed08ee0acdca0d302-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mClWeMVQeaI="; charset=UTF-8
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
To: ralf_lici <ralf@...2726...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mClWeMVQeaI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/685?usp=3Demail )

Change subject: Add support for HAProxy's PROXY protocol
......................................................................


Patch Set 1: Code-Review-1

(9 comments)

Patchset:

PS1:
I think this needs more overhaul


File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/685/comment/59d24823_1499669a :
PS1, Line 494:     src/openvpn/proxy_protocol.h
haproxy_protocol.c/haproxy_protol.h

Currently it looks like they are related to the other proxy code which they=
 are not.


File doc/proxy-protocol.txt:

http://gerrit.openvpn.net/c/openvpn/+/685/comment/4932a48c_3085af39 :
PS1, Line 8: https://www.haproxy.org/download/2.4/doc/proxy-protocol.txt
Is this just a copy and paste of the document or is this addition to that d=
ocument? It would be good to clarify the relationship between these docuemn=
ts.


http://gerrit.openvpn.net/c/openvpn/+/685/comment/4a84e43a_90eb3cad :
PS1, Line 11: a binary version (v2).
Is this protocol TCP only? I assume so, so would be good to mention this.


http://gerrit.openvpn.net/c/openvpn/+/685/comment/1508ed20_2e564dcb :
PS1, Line 26: ---------
Why are supporting two new protocls? Is there a need to introduce an alread=
y deprecated protocol to OpenVPN?


http://gerrit.openvpn.net/c/openvpn/+/685/comment/f26ed461_54c16e70 :
PS1, Line 97:   The v2 signature of the protocol: "\x0D\x0A\x0D\x0A\x00\x0D=
\x0A\x51\x55\x49\x54\x0A\x20".
Really? The singnature is '\r\n\r\n\x00\r\nQUIT\n'?


http://gerrit.openvpn.net/c/openvpn/+/685/comment/28038db2_443fb0fb :
PS1, Line 108:
What does this mean in the openvpn context?


http://gerrit.openvpn.net/c/openvpn/+/685/comment/aff6de14_525b6ce9 :
PS1, Line 115:     DGRAM (0x2).
if this is dgram, is the protocol still over tcp or does it use UDP then?


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/685/comment/9d712c5d_d6c36d0f :
PS1, Line 2684:             /* check if it's a PROXY protocol header */
I don't think this is the right place to add this. This will be basically c=
alled on every link_socket_read_tcp and not just on the first packets. Also=
 it seems to be enabled always so this might have side effects on non-hapro=
xy operation.



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
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Fri, 26 Jul 2024 11:45:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--mClWeMVQeaI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: ralf_lici. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail">Vi=
ew Change</a></p><p>9 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/685?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">I think this needs more overhaul</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File CMakeLists.txt:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/685/comment/59d24823_1499669a">Patch Set #1, Line 494:</a>=
 <code style=3D"font-family:monospace,monospace">    src/openvpn/proxy_prot=
ocol.h</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>haproxy_protocol.c/haproxy_protol.h</p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Currently it looks like they are related to the oth=
er proxy code which they are not.</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File doc/proxy-protocol.txt:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685/=
comment/4932a48c_3085af39">Patch Set #1, Line 8:</a> <code style=3D"font-fa=
mily:monospace,monospace">https://www.haproxy.org/download/2.4/doc/proxy-pr=
otocol.txt</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Is this just a copy and paste of the document or is this addition to t=
hat document? It would be good to clarify the relationship between these do=
cuemnts.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685/c=
omment/4a84e43a_90eb3cad">Patch Set #1, Line 11:</a> <code style=3D"font-fa=
mily:monospace,monospace">a binary version (v2).</code></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Is this protocol TCP only? I ass=
ume so, so would be good to mention this.</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/685/comment/1508ed20_2e564dcb">Patch Set #1, Li=
ne 26:</a> <code style=3D"font-family:monospace,monospace">---------</code>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Why are supp=
orting two new protocls? Is there a need to introduce an already deprecated=
 protocol to OpenVPN?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/685/comment/f26ed461_54c16e70">Patch Set #1, Line 97:</a> <code sty=
le=3D"font-family:monospace,monospace">  The v2 signature of the protocol: =
&quot;\x0D\x0A\x0D\x0A\x00\x0D\x0A\x51\x55\x49\x54\x0A\x20&quot;.</code></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Really? The sin=
gnature is &#39;\r\n\r\n\x00\r\nQUIT\n&#39;?</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/685/comment/28038db2_443fb0fb">Patch Set #1,=
 Line 108:</a> <code style=3D"font-family:monospace,monospace"></code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">What does this me=
an in the openvpn context?</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/685/comment/aff6de14_525b6ce9">Patch Set #1, Line 115:</a> <co=
de style=3D"font-family:monospace,monospace">    DGRAM (0x2).</code></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">if this is dgram, i=
s the protocol still over tcp or does it use UDP then?</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/685/comment/9d712c5d_d6c36d0f">Patch Set #1, Line 2684:</a> =
<code style=3D"font-family:monospace,monospace">            /* check if it&=
#39;s a PROXY protocol header */</code></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">I don&#39;t think this is the right place to add=
 this. This will be basically called on every link_socket_read_tcp and not =
just on the first packets. Also it seems to be enabled always so this might=
 have side effects on non-haproxy operation.</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail=
">change 685</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 26 Jul 2024 11:45:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--mClWeMVQeaI=--

