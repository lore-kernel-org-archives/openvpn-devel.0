From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 10 Jan 2025 09:49:02 +0000
In-Reply-To: <gerrit.1731290343000.I00751c42cb04e30205ba8e6584530831e0d143c5@...2715...>
References: <gerrit.1731290343000.I00751c42cb04e30205ba8e6584530831e0d143c5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <bc96346f78a7a3b10fe3c5f83f07368612321045-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NExYr4ZhWPw="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Implement epoch key
 data format
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NExYr4ZhWPw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/806?usp=3Demail )

Change subject: Implement epoch key data format
......................................................................


Patch Set 12:

(3 comments)

File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/806/comment/7cb2c8ce_a1734688 :
PS12, Line 38: Epoch data keys
> maybe make that header "epoch data keys & packet format" or so?  The text=
 describes keys and format. [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/806/comment/c262c810_6074d03e :
PS12, Line 40:     ciphers in TLS mode ciphers. This new data format has a =
number of=3D
> stray `=3D`
Acknowledged


File src/openvpn/crypto.c:

http://gerrit.openvpn.net/c/openvpn/+/806/comment/54b550d3_c3929922 :
PS12, Line 455:         goto error_exit;
> that `goto` should not be needed?  CRYPT_DROP() expands to CRYPT_ERROR_EX=
IT() which has the goto
Acknowledged



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00751c42cb04e30205ba8e6584530831e0d143c5
Gerrit-Change-Number: 806
Gerrit-PatchSet: 12
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 10 Jan 2025 09:49:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--NExYr4ZhWPw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File Changes.rst:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/806/comment/7cb2c8ce_a1734688">Patch Set #12, Line 38:</a> <code st=
yle=3D"font-family:monospace,monospace">Epoch data keys</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">maybe make that header &quot;epoch data keys &amp; packet format&quot; o=
r so?  The text describes keys and format. [=E2=80=A6]</blockquote></p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/806/comment/c262c810_=
6074d03e">Patch Set #12, Line 40:</a> <code style=3D"font-family:monospace,=
monospace">    ciphers in TLS mode ciphers. This new data format has a numb=
er of=3D</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">stray `=3D`</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/806/comment/54b550d3_c3929922">Patch Set #12, Line 455:</a>=
 <code style=3D"font-family:monospace,monospace">        goto error_exit;</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">that `goto` should not be needed?  CRYPT_DROP() expand=
s to CRYPT_ERROR_EXIT() which has the goto</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/806?=
usp=3Demail">change 806</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/806?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00751c42cb04e30205ba8e65845=
30831e0d143c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 806 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 10 Jan 2025 09:49:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--NExYr4ZhWPw=--

