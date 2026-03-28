From: "Bluca (Code Review)" <gerrit@...515...>
Date: Sat, 28 Mar 2026 16:32:15 +0000
In-Reply-To: <gerrit.1774477871000.Ib99f171fb69d51f2260b44edf8ebe21ac958f233@...2715...>
References: <gerrit.1774477871000.Ib99f171fb69d51f2260b44edf8ebe21ac958f233@...2715...>
Reply-To: luca.boccassi@...277..., arne-openvpn@...1227...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <5141de16c063714da3bafaa84eb36c4db840ca6e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E6O319JrOTk="; charset=UTF-8
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
Cc: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--E6O319JrOTk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, selvanair.

Bluca has posted comments on this change by Bluca. ( http://gerrit.openvpn.=
net/c/openvpn/+/1593?usp=3Demail )

Change subject: management: add base64 multi-line input for passwords
......................................................................


Patch Set 2:

(6 comments)

Patchset:

PS2:
Applied as suggested and re-tested, thank you


File doc/management-notes.txt:

http://gerrit.openvpn.net/c/openvpn/+/1593/comment/b759445b_0d2c0f53?usp=3D=
email :
PS1, Line 329:   commands.
> Update MANAGEMENT_VERSION to 6 and document that multi-line password supp=
ort requires daemon version [=E2=80=A6]
Acknowledged


File src/openvpn/manage.c:

http://gerrit.openvpn.net/c/openvpn/+/1593/comment/637bc2bb_b3e0712d?usp=3D=
email :
PS1, Line 1029:  * @param type          The type of password being entered =
(e.g. "Auth", "TLS-Auth", etc)
> Nitpick: "TLS-Auth" is not a valid type -- "Private Key" ?
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/1593/comment/7a862134_202d00db?usp=3D=
email :
PS1, Line 1102:                     msg(M_CLIENT, "ERROR: could not base64-=
decode password");
> This could lead to an unhelpful decode error or silent truncation which i=
s hard to debug. [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/1593/comment/ba43603c_1204f5ea?usp=3D=
email :
PS1, Line 1110:             secure_memzero(decoded, sizeof(decoded));
> Also needs a buf_clear() somewhere as buf contains sensitive data.
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/1593/comment/ef07d82c_af4a08f9?usp=3D=
email :
PS1, Line 1664:     else if (streq(p[0], "password-base64"))
> As Gert suggested, we could use "password 'Type'" with no argument and in=
terpret it differently base [=E2=80=A6]
Acknowledged



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib99f171fb69d51f2260b44edf8ebe21ac958f233
Gerrit-Change-Number: 1593
Gerrit-PatchSet: 2
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Sat, 28 Mar 2026 16:32:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: selvanair <selva.nair@...277...>

--E6O319JrOTk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail">View =
Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1593?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Applied as sug=
gested and re-tested, thank you</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File doc/management-notes.txt:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1593=
/comment/b759445b_0d2c0f53?usp=3Demail">Patch Set #1, Line 329:</a> <code s=
tyle=3D"font-family:monospace,monospace">  commands.</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Update MANAGEMENT_VERSION to 6 and document that multi-line password suppor=
t requires daemon version [=E2=80=A6]</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage.=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1593/comment/637bc2bb_b3e0712d?usp=3Demail">Pat=
ch Set #1, Line 1029:</a> <code style=3D"font-family:monospace,monospace"> =
* @param type          The type of password being entered (e.g. &quot;Auth&=
quot;, &quot;TLS-Auth&quot;, etc)</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Nitpick: &quot;TLS-=
Auth&quot; is not a valid type -- &quot;Private Key&quot; ?</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1593/comment/7a862134_202d00db?usp=3Demail">Patch Set #1, Line 1102:</a> <=
code style=3D"font-family:monospace,monospace">                    msg(M_CL=
IENT, &quot;ERROR: could not base64-decode password&quot;);</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">This could lead to an unhelpful decode error or silent truncation wh=
ich is hard to debug. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1593/comment/ba43603c_120=
4f5ea?usp=3Demail">Patch Set #1, Line 1110:</a> <code style=3D"font-family:=
monospace,monospace">            secure_memzero(decoded, sizeof(decoded));<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">Also needs a buf_clear() somewhere as buf contains se=
nsitive data.</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1593/comment/ef07d82c_af4a08f9?usp=3Demail">P=
atch Set #1, Line 1664:</a> <code style=3D"font-family:monospace,monospace"=
>    else if (streq(p[0], &quot;password-base64&quot;))</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">As Gert suggested, we could use &quot;password &#39;Type&#39;&quot; with=
 no argument and interpret it differently base [=E2=80=A6]</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Acknowledged</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1593?usp=3Demail">change 1593</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1593?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib99f171fb69d51f2260b44edf8e=
be21ac958f233 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1593 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Bluca &lt;luca.boccassi@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 28 Mar 2026 16:32:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>

</body></html>=

--E6O319JrOTk=--

