From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 7 Dec 2023 11:27:23 +0000
In-Reply-To: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
References: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <eb178e043c90d76d29e17c974b83ad627d92e4ec-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w4lcfpQEceo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement the
 --tls-export-cert feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--w4lcfpQEceo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/466?usp=3Demail )

Change subject: Implement the --tls-export-cert feature
......................................................................


Patch Set 2:

(6 comments)

File doc/man-sections/script-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/dccfc964_cfd463f3 :
PS2, Line 427:   Adds a an environment variables ``peer_cert_{x}`` (and an =
alias
> Remove "a"
Done


File src/openvpn/ssl_verify.c:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/2e49f9a9_cc253bc2 :
PS2, Line 466:     /* export the certificate itself as pem when the enabled=
 */
> missing words?
Done


http://gerrit.openvpn.net/c/openvpn/+/466/comment/99393580_9e01f59d :
PS2, Line 477:     bool ret =3D true;
> Can combine with the next line.
Done


http://gerrit.openvpn.net/c/openvpn/+/466/comment/9626e926_96849b76 :
PS2, Line 602:      * these variables defined */
> can replace repetition of "these variables" with "them"
Done


File src/openvpn/ssl_verify_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/32a92534_6ee0a5db :
PS2, Line 225:      * The only way to is directly access the DER encoded ra=
w certificate
> "to is" -> "is to"
Done


http://gerrit.openvpn.net/c/openvpn/+/466/comment/85213291_05de576e :
PS2, Line 230:      * using needing 3 times the space for the base64 and 10=
0 bytes for the
> drop one of "using needing"
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2
Gerrit-Change-Number: 466
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 07 Dec 2023 11:27:23 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--w4lcfpQEceo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail">View C=
hange</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/script-option=
s.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/466/comment/dccfc964_cfd463f3">Patch Set #2=
, Line 427:</a> <code style=3D"font-family:monospace,monospace">  Adds a an=
 environment variables ``peer_cert_{x}`` (and an alias</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Remove &quot;a&quot;</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/ssl_verify.c:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466/comm=
ent/2e49f9a9_cc253bc2">Patch Set #2, Line 466:</a> <code style=3D"font-fami=
ly:monospace,monospace">    /* export the certificate itself as pem when th=
e enabled */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">missing words?</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/466/comment/99393580_9e01f59d">=
Patch Set #2, Line 477:</a> <code style=3D"font-family:monospace,monospace"=
>    bool ret =3D true;</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">Can combine with the next lin=
e.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466/co=
mment/9626e926_96849b76">Patch Set #2, Line 602:</a> <code style=3D"font-fa=
mily:monospace,monospace">     * these variables defined */</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">can replace repetition of &quot;these variables&quot; with &quot;the=
m&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/ssl_verify_mbedtls.c:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466/comment/32a=
92534_6ee0a5db">Patch Set #2, Line 225:</a> <code style=3D"font-family:mono=
space,monospace">     * The only way to is directly access the DER encoded =
raw certificate</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">&quot;to is&quot; -&gt; &quot;is to&q=
uot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466/=
comment/85213291_05de576e">Patch Set #2, Line 230:</a> <code style=3D"font-=
family:monospace,monospace">     * using needing 3 times the space for the =
base64 and 100 bytes for the</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">drop one of &quot;using =
needing&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail">change 466</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/466?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9b3f1813d2d0d492d17c87348b=
4cebd0bf19ce2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 466 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 07 Dec 2023 11:27:23=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--w4lcfpQEceo=--

