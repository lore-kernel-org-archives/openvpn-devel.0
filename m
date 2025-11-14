From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 14 Nov 2025 18:39:24 +0000
In-Reply-To: <gerrit.1762271909000.Id0bb4c45d373437ab8dbaff7a311745f9b538cbf@...2715...>
References: <gerrit.1762271909000.Id0bb4c45d373437ab8dbaff7a311745f9b538cbf@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <9ed895c385f85296a839019d55496e9ddf0799cc-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="V/DHvTMfTbY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mudp: fix unaligned
 32-bit read when parsing peer ID
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--V/DHvTMfTbY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

cron2 has posted comments on this change by its_Giaan. ( http://gerrit.open=
vpn.net/c/openvpn/+/1348?usp=3Demail )

Change subject: mudp: fix unaligned 32-bit read when parsing peer ID
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/1348/comment/3f419bdf_37dbf5a2?usp=3D=
email :
PS1, Line 213:             memcpy(&tmp, ptr, sizeof(tmp));
> This reimplements the same logic as buf_read_u32() except that it doesn't=
 advance the buffer. [=E2=80=A6]
I am thinking of something more straightforward...

```
/* peer_id is a 24 byte integer in network byte order */
peer_id =3D (ptr[1]<<16) + (ptr[2]<<8) + ptr[3]
```

(or the other way round, didn't do the byte order calculations yet)...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1348?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id0bb4c45d373437ab8dbaff7a311745f9b538cbf
Gerrit-Change-Number: 1348
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Fri, 14 Nov 2025 18:39:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--V/DHvTMfTbY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1348?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1348/comment/3f419bdf_37dbf5a2?usp=3Demail">Patch Set #1, Li=
ne 213:</a> <code style=3D"font-family:monospace,monospace">            mem=
cpy(&amp;tmp, ptr, sizeof(tmp));</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This reimplements th=
e same logic as buf_read_u32() except that it doesn&#39;t advance the buffe=
r. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">I am thinking of something more straightfor=
ward...</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">```<br>/* peer_id is a 24 byte integer in network byte order */=
<br>peer_id =3D (ptr[1]&lt;&lt;16) + (ptr[2]&lt;&lt;8) + ptr[3]<br>```</p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
(or the other way round, didn&#39;t do the byte order calculations yet)...<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1348?usp=3Demail">change 1348</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1348?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id0bb4c45d373437ab8dbaff7a31=
1745f9b538cbf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1348 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Nov 2025 18:39:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--V/DHvTMfTbY=--

