From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 30 Mar 2026 14:25:18 +0000
In-Reply-To: <gerrit.1774477871000.Ib99f171fb69d51f2260b44edf8ebe21ac958f233@...2715...>
References: <gerrit.1774477871000.Ib99f171fb69d51f2260b44edf8ebe21ac958f233@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 luca.boccassi@...277..., openvpn-devel@lists.sourceforge.net,
 gert@...1296...
Message-ID: <cd1568b37f8abe90f7aa58f195f35e101e7fea50-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s3oRhwXrowk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: management: add
 base64 multi-line input for passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Bluca <luca.boccassi@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--s3oRhwXrowk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Bluca, cron2, plaisthos.

selvanair has posted comments on this change by Bluca. ( http://gerrit.open=
vpn.net/c/openvpn/+/1593?usp=3Demail )

Change subject: management: add base64 multi-line input for passwords
......................................................................


Patch Set 8:

(2 comments)

Patchset:

PS8:
To me this looks safe for 2.7 as the changes are very isolated. As we can a=
lready set long passwords via stdin/console, one could argue this is not ev=
en a new feature. That said, limitations on password length that could fit =
in the TLS buffer still stands, so unclear of its immediate utility.


File doc/management-notes.txt:

http://gerrit.openvpn.net/c/openvpn/+/1593/comment/d8383e4f_fc3eda84?usp=3D=
email :
PS8, Line 531:     >PASSWORD:Need 'Auth' username -- version 4 or greater
Please add a line here to keep track of client versions. Usually client ver=
sion is updated only when new server->client commands are added -- this one=
 is a special case. So something like:
multiline password from client -- version 5 or greater ??



--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib99f171fb69d51f2260b44edf8ebe21ac958f233
Gerrit-Change-Number: 1593
Gerrit-PatchSet: 8
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: Bluca <luca.boccassi@...277...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Mon, 30 Mar 2026 14:25:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--s3oRhwXrowk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Bluca, cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1593?tab=3Dcomments&amp;usp=3Demail">Patch Set #8:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">To me this loo=
ks safe for 2.7 as the changes are very isolated. As we can already set lon=
g passwords via stdin/console, one could argue this is not even a new featu=
re. That said, limitations on password length that could fit in the TLS buf=
fer still stands, so unclear of its immediate utility.</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File doc/management-notes.txt:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1593/comment/d8383e4f_fc3eda84?usp=3Demail">Patch Set #8=
, Line 531:</a> <code style=3D"font-family:monospace,monospace">    &gt;PAS=
SWORD:Need &#39;Auth&#39; username -- version 4 or greater</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Pleas=
e add a line here to keep track of client versions. Usually client version =
is updated only when new server-&gt;client commands are added -- this one i=
s a special case. So something like:<br>multiline password from client -- v=
ersion 5 or greater ??</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail">change 1593</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib99f171fb69d51f2260b44edf8e=
be21ac958f233 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1593 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: Bluca &lt;luca.boccassi@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Bluca &lt;luca.boccassi@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 30 Mar 2026 14:25:18=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--s3oRhwXrowk=--

