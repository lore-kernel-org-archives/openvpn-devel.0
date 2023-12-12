From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 12 Dec 2023 12:11:27 +0000
In-Reply-To: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
References: <gerrit.1700743197000.I04f8c7c413e7cb62c726262feee6ca89c7e86c70@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <9da6b25d4a6874f50c6cd682d2cc37ee19aede92-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nu2sxfu5PgA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Check PRF
 availability on initialisation and add --force-tls-key-mate...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nu2sxfu5PgA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/460?usp=3Demail )

Change subject: Check PRF availability on initialisation and add --force-tl=
s-key-material-export
......................................................................


Patch Set 6:

(2 comments)

File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/460/comment/09e5b596_0004b9ee :
PS5, Line 1841:         return false;
> there is whitespace missing at the first and second line wrap ("thisserve=
r" and "(RFC 5705)support"
Done


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/460/comment/4bde8b54_2a323d2b :
PS5, Line 3661:         }
> D'oh. Sorry for missing that.
whoops sorry for that. My bash history also shows that I still had the opti=
on on the command line, so I totally missed that. =F0=9F=98=9E



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04f8c7c413e7cb62c726262feee6ca89c7e86c70
Gerrit-Change-Number: 460
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 12 Dec 2023 12:11:27 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--nu2sxfu5PgA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/460/comment/09e5b596_0004b9ee">Patch Set #5, Line 1841:</a>=
 <code style=3D"font-family:monospace,monospace">        return false;</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">there is whitespace missing at the first and second line =
wrap (&quot;thisserver&quot; and &quot;(RFC 5705)support&quot;</blockquote>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=
.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/460/comment/4bde8b54_2a323d2b">Patch Set #5, L=
ine 3661:</a> <code style=3D"font-family:monospace,monospace">        }</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">D&#39;oh. Sorry for missing that.</blockquote></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">whoops sorry for that.=
 My bash history also shows that I still had the option on the command line=
, so I totally missed that. =F0=9F=98=9E</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail">ch=
ange 460</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/460?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04f8c7c413e7cb62c726262feee=
6ca89c7e86c70 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 460 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 12 Dec 2023 12:11:27=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--nu2sxfu5PgA=--

