From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 1 Jun 2025 15:41:32 +0000
In-Reply-To: <gerrit.1747746380000.If5e832866b312a2f8a1ce6b4e00d40e3dcf63681@...2715...>
References: <gerrit.1747746380000.If5e832866b312a2f8a1ce6b4e00d40e3dcf63681@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606..., gert@...1296...
Message-ID: <4b213496740de069f9f1a702a5a6ed82b128affe-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DgYQ4Ul5ig4="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbedtls: Allow TLS
 1.3 if available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DgYQ4Ul5ig4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1042?usp=3Demail )

Change subject: mbedtls: Allow TLS 1.3 if available
......................................................................


Patch Set 3:

(1 comment)

File README.mbedtls:

http://gerrit.openvpn.net/c/openvpn/+/1042/comment/bf3c99be_a1c3ac1a :
PS3, Line 32: (mbedtls-3.6 or development branch).
> this 3.6 here does not look right.  FreeBSD ships 3.6. [=E2=80=A6]
It is not released yet. You need the mbed TLS 3.6 development branch or the=
 master developmenet branch. I used the 3.6 development branch since master=
 breaks for different reasons



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1042?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If5e832866b312a2f8a1ce6b4e00d40e3dcf63681
Gerrit-Change-Number: 1042
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Sun, 01 Jun 2025 15:41:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--DgYQ4Ul5ig4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, cron2. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1042?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File README.mbedtls:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1042/comment/bf3c99be_a1c3ac1a">Patch Set #3, Line 32:</a> <co=
de style=3D"font-family:monospace,monospace">(mbedtls-3.6 or development br=
anch).</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">this 3.6 here does not look right.  FreeBSD sh=
ips 3.6. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">It is not released yet. You need the mbed TLS 3.6 deve=
lopment branch or the master developmenet branch. I used the 3.6 developmen=
t branch since master breaks for different reasons</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1042?usp=
=3Demail">change 1042</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1042?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If5e832866b312a2f8a1ce6b4e00=
d40e3dcf63681 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1042 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 01 Jun 2025 15:41:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--DgYQ4Ul5ig4=--

