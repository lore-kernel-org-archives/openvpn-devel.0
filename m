From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 8 Dec 2025 16:13:29 +0000
In-Reply-To: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
References: <gerrit.1764812658000.I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <5ab844e0ddc3ff1d4869817836952c863d5dceff-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r+fnvxuz47o="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: pull-filter:
 improve documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--r+fnvxuz47o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

selvanair has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1415?usp=3Demail )

Change subject: pull-filter: improve documentation
......................................................................


Patch Set 1:

(1 comment)

File doc/man-sections/client-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1415/comment/cb5ea473_694dd9d3?usp=3D=
email :
PS1, Line 349:   protect against offending options pushed by a server. For =
example, the
> Well, I see your point, but then I find your wording a bit hard to unders=
tand - "it can not be relie [=E2=80=A6]
This is what I wanted to say: Pull filter was not designed as a security me=
asure, so do not use it for security, its easy to be defeated. That said, t=
here is some care one could take while writing the filter commands to guard=
 against formatting mismatches. I do not want to give an impression that it=
s "secure" once ordered as an "allow-list". May be it is, I do not know.

I just paraphrased the above into a more formal form --- "in such situation=
s" was meant to refer to spaces/formatting mismatches, not security; "prefe=
rred" is meant to indicate that its a suggestion, not a fool-proof work-aro=
und. I see its a bit nuanced. If the intended meaning is not coming through=
 I'll rewrite it:

Option 1 -- use a less nuanced language:

Warning: The pull-filter mechanism must not be regarded as a security measu=
re for blocking undesired server-pushed options. It can be circumvented thr=
ough formatting variations (e.g., added whitespace). To improve robustness =
against such formatting discrepancies, an "allow-list" configuration using =
specific `pull-filter accept` directives followed by a general `pull-filter=
 ignore` is preferred to a "deny-list" approach. This recommendation does n=
ot imply that pull-filter provides any security guarantees.

Option 2 -- Just add an extra line:
"This approach improves robustness but does not guarantee security."



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2c8d40038e52fbdff1c56f93db1e6a2f9255c59a
Gerrit-Change-Number: 1415
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Mon, 08 Dec 2025 16:13:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: selvanair <selva.nair@...277...>

--r+fnvxuz47o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/client-option=
s.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1415/comment/cb5ea473_694dd9d3?usp=3Demail"=
>Patch Set #1, Line 349:</a> <code style=3D"font-family:monospace,monospace=
">  protect against offending options pushed by a server. For example, the<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">Well, I see your point, but then I find your wording =
a bit hard to understand - &quot;it can not be relie [=E2=80=A6]</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">This is what I wanted to say: Pull filter was not designed as a secu=
rity measure, so do not use it for security, its easy to be defeated. That =
said, there is some care one could take while writing the filter commands t=
o guard against formatting mismatches. I do not want to give an impression =
that its &quot;secure&quot; once ordered as an &quot;allow-list&quot;. May =
be it is, I do not know.</p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">I just paraphrased the above into a more forma=
l form --- &quot;in such situations&quot; was meant to refer to spaces/form=
atting mismatches, not security; &quot;preferred&quot; is meant to indicate=
 that its a suggestion, not a fool-proof work-around. I see its a bit nuanc=
ed. If the intended meaning is not coming through I&#39;ll rewrite it:</p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Option 1 -- use a less nuanced language:</p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Warning: The pull-filter mecha=
nism must not be regarded as a security measure for blocking undesired serv=
er-pushed options. It can be circumvented through formatting variations (e.=
g., added whitespace). To improve robustness against such formatting discre=
pancies, an &quot;allow-list&quot; configuration using specific `pull-filte=
r accept` directives followed by a general `pull-filter ignore` is preferre=
d to a &quot;deny-list&quot; approach. This recommendation does not imply t=
hat pull-filter provides any security guarantees.</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Option 2 -- Just add =
an extra line:<br>&quot;This approach improves robustness but does not guar=
antee security.&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail">change 1415</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1415?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2c8d40038e52fbdff1c56f93db1=
e6a2f9255c59a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1415 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 08 Dec 2025 16:13:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>

</body></html>=

--r+fnvxuz47o=--

