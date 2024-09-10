From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 10 Sep 2024 09:17:44 +0000
In-Reply-To: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
References: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <4761d3328807b23d3b85ab0955dd6ef651537991-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dIQxsvFNsJc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco-win: factor out
 getting dco version info own function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dIQxsvFNsJc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/733?usp=3Demail )

Change subject: dco-win: factor out getting dco version info own function
......................................................................


Patch Set 2:

(4 comments)

File src/openvpn/dco_win.c:

http://gerrit.openvpn.net/c/openvpn/+/733/comment/8f07dbeb_507f5019 :
PS1, Line 102:     msg(D_DCO_DEBUG, "dco data_v3: %d", dco->supports_data_v=
3);
> I think keeping the "supports" here (=3D not changing the text) would eas=
e understanding of the logs.
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/733/comment/3508d8c9_0dd6626f :
PS1, Line 474:     ZeroMemory(&version, sizeof(version));
> `CLEAR(version)` exists (if you change this line anyway). [=E2=80=A6]
Agreed. Will use =3D {0} here and also CLEAN() within get_version() itself =
to make sure it zeroes fields and doesn't depend on the caller.


http://gerrit.openvpn.net/c/openvpn/+/733/comment/d5b2be96_d092b75d :
PS1, Line 481:     return BSTR(&out);
> technically this does something else if no DCO driver can be found - the =
old code returns "N/A", the [=E2=80=A6]
Good point, other platforms return "N/A", will bring it back.


http://gerrit.openvpn.net/c/openvpn/+/733/comment/e42a0200_3120a0fe :
PS1, Line 562:     dco_get_version(&version);
> see above wrt `CLEAR()` or `=3D {0}`
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7
Gerrit-Change-Number: 733
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 10 Sep 2024 09:17:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--dIQxsvFNsJc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_win.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/733/comment/8f07dbeb_507f5019">Patch Set #1, Line 102:</a=
> <code style=3D"font-family:monospace,monospace">    msg(D_DCO_DEBUG, &quo=
t;dco data_v3: %d&quot;, dco-&gt;supports_data_v3);</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I=
 think keeping the &quot;supports&quot; here (=3D not changing the text) wo=
uld ease understanding of the logs.</blockquote></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/733/comment/3508d8c9_0dd6626f">Patch Set=
 #1, Line 474:</a> <code style=3D"font-family:monospace,monospace">    Zero=
Memory(&amp;version, sizeof(version));</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`CLEAR(version=
)` exists (if you change this line anyway). [=E2=80=A6]</blockquote></p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Agreed. Will use =
=3D {0} here and also CLEAN() within get_version() itself to make sure it z=
eroes fields and doesn&#39;t depend on the caller.</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/733/comment/d5b2be96_d092b75d">Patch S=
et #1, Line 481:</a> <code style=3D"font-family:monospace,monospace">    re=
turn BSTR(&amp;out);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">technically this does something =
else if no DCO driver can be found - the old code returns &quot;N/A&quot;, =
the [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Good point, other platforms return &quot;N/A&quot;, will br=
ing it back.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
33/comment/e42a0200_3120a0fe">Patch Set #1, Line 562:</a> <code style=3D"fo=
nt-family:monospace,monospace">    dco_get_version(&amp;version);</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">see above wrt `CLEAR()` or `=3D {0}`</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/733?=
usp=3Demail">change 733</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/733?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e8ddd35bd3cc3334faf7f57118=
d1892512ae9f7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 733 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Sep 2024 09:17:44=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--dIQxsvFNsJc=--

