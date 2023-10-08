From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 8 Oct 2023 10:44:02 +0000
In-Reply-To: <gerrit.1683717398000.Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26@...2715...>
References: <gerrit.1683717398000.Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <009f59f26a01cb99650a08199e7ea7daab549fbb-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gPmkDjmJzRM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Change type of
 frame.mss_fix to uint16_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, plaisthos <arne-openvpn@...1227...>

--gPmkDjmJzRM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/268?usp=3Demail )

Change subject: Change type of frame.mss_fix to uint16_t
......................................................................


Patch Set 4:

(2 comments)

File src/openvpn/mss.c:

http://gerrit.openvpn.net/c/openvpn/+/268/comment/e08cbc9f_bc6cb983 :
PS3, Line 195:                 mssval +=3D opt[3];
> why is this change needed?
This fixes a conversion warning:
../../../src/openvpn/mss.c:196:26: warning:
conversion from =E2=80=98int=E2=80=99 to =E2=80=98uint16_t=E2=80=99 {aka =
=E2=80=98short unsigned int=E2=80=99} may change value [-Wconversion]
  196 |                 mssval =3D (opt[2] << 8) + opt[3];
      |                          ^

So basically the compiler goes up to int and then realizes it needs
to go back down to uint16_t. By splitting the statement this is avoided.

One could also fix that with casts, but that would be much uglier, IMHO.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/268/comment/d77550a7_9c8eca27 :
PS3, Line 7257:             if (mssfix > UINT16_MAX)
> If we introduce a check here, we should also ensure a minimum value - we =
assign `ce. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/268?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26
Gerrit-Change-Number: 268
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Sun, 08 Oct 2023 10:44:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--gPmkDjmJzRM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/268?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mss.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/268/comment/e08cbc9f_bc6cb983">Patch Set #3, Line 195:</a> <c=
ode style=3D"font-family:monospace,monospace">                mssval +=3D o=
pt[3];</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">why is this change needed?</blockquote></p><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">This f=
ixes a conversion warning:<br>../../../src/openvpn/mss.c:196:26: warning:<b=
r>conversion from =E2=80=98int=E2=80=99 to =E2=80=98uint16_t=E2=80=99 {aka =
=E2=80=98short unsigned int=E2=80=99} may change value [-Wconversion]<br>  =
196 |                 mssval =3D (opt[2] &lt;&lt; 8) + opt[3];<br>      |  =
                        ^</pre><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">So basically the compiler goes up to int and then realizes i=
t needs<br>to go back down to uint16_t. By splitting the statement this is =
avoided.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">One =
could also fix that with casts, but that would be much uglier, IMHO.</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/option=
s.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/268/comment/d77550a7_9c8eca27">Patch Set #3, =
Line 7257:</a> <code style=3D"font-family:monospace,monospace">            =
if (mssfix &gt; UINT16_MAX)</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">If we introduce a check h=
ere, we should also ensure a minimum value - we assign `ce. [=E2=80=A6]</bl=
ockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/268?usp=3Demail">change 268</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
268?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id8321dfbb8ad8d79f4bb2a9da61=
f8cd6b6c6ee26 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 268 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 08 Oct 2023 10:44:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--gPmkDjmJzRM=--

