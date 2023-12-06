From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 Dec 2023 17:30:24 +0000
In-Reply-To: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
References: <gerrit.1701865618000.Ia9b3f1813d2d0d492d17c87348b4cebd0bf19ce2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <cc25eb22762b0e2b8c47a5b95a37810310f6e0c7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QrN1PPELMlU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QrN1PPELMlU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/466?usp=3Demail )

Change subject: Implement the --tls-export-cert feature
......................................................................


Patch Set 2: Code-Review-1

(6 comments)

File doc/man-sections/script-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/738f9728_f9eb156f :
PS2, Line 427:   Adds a an environment variables ``peer_cert_{x}`` (and an =
alias
Remove "a"


File src/openvpn/ssl_verify.c:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/dd7a5b9a_bf660274 :
PS2, Line 466:     /* export the certificate itself as pem when the enabled=
 */
missing words?


http://gerrit.openvpn.net/c/openvpn/+/466/comment/f487e7c8_793bcb7e :
PS2, Line 477:     bool ret =3D true;
Can combine with the next line.


http://gerrit.openvpn.net/c/openvpn/+/466/comment/2e703085_bdc2ffba :
PS2, Line 602:      * these variables defined */
can replace repetition of "these variables" with "them"


File src/openvpn/ssl_verify_mbedtls.c:

http://gerrit.openvpn.net/c/openvpn/+/466/comment/74783133_a96d6da5 :
PS2, Line 225:      * The only way to is directly access the DER encoded ra=
w certificate
"to is" -> "is to"


http://gerrit.openvpn.net/c/openvpn/+/466/comment/b48e3170_e0e585b4 :
PS2, Line 230:      * using needing 3 times the space for the base64 and 10=
0 bytes for the
drop one of "using needing"



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Wed, 06 Dec 2023 17:30:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--QrN1PPELMlU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail">Vi=
ew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/script-op=
tions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/466/comment/738f9728_f9eb156f">Patch Se=
t #2, Line 427:</a> <code style=3D"font-family:monospace,monospace">  Adds =
a an environment variables ``peer_cert_{x}`` (and an alias</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Remove &quot;a&quot;</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/s=
sl_verify.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/466/comment/dd7a5b9a_bf660274">Patch =
Set #2, Line 466:</a> <code style=3D"font-family:monospace,monospace">    /=
* export the certificate itself as pem when the enabled */</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">missing words?</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466/comment/f487e7c8_=
793bcb7e">Patch Set #2, Line 477:</a> <code style=3D"font-family:monospace,=
monospace">    bool ret =3D true;</code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Can combine with the next line.</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/466/comment/2e703085_bdc2ffba=
">Patch Set #2, Line 602:</a> <code style=3D"font-family:monospace,monospac=
e">     * these variables defined */</code></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">can replace repetition of &quot;these variab=
les&quot; with &quot;them&quot;</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/ssl_verify_mbedtls.c:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/466/comment/74783133_a96d6da5">Patch Set #2, Line 225:</a> <code style=
=3D"font-family:monospace,monospace">     * The only way to is directly acc=
ess the DER encoded raw certificate</code></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">&quot;to is&quot; -&gt; &quot;is to&quot;</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466/comment/b48e3=
170_e0e585b4">Patch Set #2, Line 230:</a> <code style=3D"font-family:monosp=
ace,monospace">     * using needing 3 times the space for the base64 and 10=
0 bytes for the</code></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">drop one of &quot;using needing&quot;</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Dem=
ail">change 466</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/466?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 06 Dec 2023 17:30:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--QrN1PPELMlU=--

