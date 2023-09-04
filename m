From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 4 Sep 2023 14:39:24 +0000
In-Reply-To: <gerrit.1693837331000.I2139b62117ba69d643b585d2610e8aef15f71d3e@...2715...>
References: <gerrit.1693837331000.I2139b62117ba69d643b585d2610e8aef15f71d3e@...2715...>
Reply-To: frank@...2641..., openvpn-devel@lists.sourceforge.net,
 lstipakov@...277...
Message-ID: <b1d5087ace26bcc7a32c0795867dcaaff6aaecac-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wYQI21UX9cM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: Support for
 long INFO/INFO_PRE messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wYQI21UX9cM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/327?usp=3Demail )

Change subject: Support for long INFO/INFO_PRE messages
......................................................................


Patch Set 1: Code-Review+1

(3 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/327/comment/90da86d9_5dc75b60 :
PS1, Line 10: the server (CloudConnexa) sends the longer string in some cas=
es.
"sends the longer string" -> "sends longer messages"


Patchset:

PS1:
looks technically okay


File src/openvpn/push.c:

http://gerrit.openvpn.net/c/openvpn/+/327/comment/cf2407e8_9d3632ee :
PS1, Line 246:         struct buffer out =3D alloc_buf_gc(1 + 7 + 1 + BLEN(=
&buf) + 1, &gc);
"1 + 7 + 1" -> strlen(">INFOMSG:")
might even move the ">INFOMSG:" into a preprocessor define and then reuse i=
t.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/327?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I2139b62117ba69d643b585d2610e8aef15f71d3e
Gerrit-Change-Number: 327
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Mon, 04 Sep 2023 14:39:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--wYQI21UX9cM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: stipa. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/327?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/327/comment/90da86d9_5dc75b60">Patch Set #1, Line 10:</a> <code s=
tyle=3D"font-family:monospace,monospace">the server (CloudConnexa) sends th=
e longer string in some cases.</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">&quot;sends the longer string&quot; -&gt; &quot;se=
nds longer messages&quot;</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/327?tab=3Dcomments">Patch Set #=
1:</a> </p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">looks=
 technically okay</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File src/openvpn/push.c:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/327/comment/cf2407e8_9d3=
632ee">Patch Set #1, Line 246:</a> <code style=3D"font-family:monospace,mon=
ospace">        struct buffer out =3D alloc_buf_gc(1 + 7 + 1 + BLEN(&amp;bu=
f) + 1, &amp;gc);</code></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">&quot;1 + 7 + 1&quot; -&gt; strlen(&quot;&gt;INFOMSG:&quot;)<br=
>might even move the &quot;&gt;INFOMSG:&quot; into a preprocessor define an=
d then reuse it.</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/327?usp=3Demail">change 327</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/327?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2139b62117ba69d643b585d2610=
e8aef15f71d3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 327 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 04 Sep 2023 14:39:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--wYQI21UX9cM=--

