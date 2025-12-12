From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 12 Dec 2025 10:54:53 +0000
In-Reply-To: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
References: <gerrit.1765453028000.I72947bd4f0213fd118327f740daeb1d86ae166de@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <bcf67d678475dea48b4406588f310698260200bc-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/o4n4LNijhA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow test-crypto to
 work without the --secret argument
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/o4n4LNijhA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change by plaisthos. ( http://gerr=
it.openvpn.net/c/openvpn/+/1435?usp=3Demail )

Change subject: Allow test-crypto to work without the --secret argument
......................................................................


Patch Set 5:

(2 comments)

File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/1435/comment/08f7e7fe_7800d03f?usp=3D=
email :
PS3, Line 3528:     else if (c->options.test_crypto)
> So basically to currently still support the old mode that allows to use -=
-secret to manually specify [=E2=80=A6]
Acknowledged


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/1435/comment/c8f0900d_ef9eff0f?usp=3D=
email :
PS5, Line 2695:     if (options->tls_server + options->tls_client + (option=
s->shared_secret_file !=3D NULL) > 1)
Since test_crypto does not imply shared_secret_file anymore should we add a=
 check here that we do not combine `--test-crypto` with `--tls-*` ?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I72947bd4f0213fd118327f740daeb1d86ae166de
Gerrit-Change-Number: 1435
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Fri, 12 Dec 2025 10:54:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--/o4n4LNijhA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1435?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1435/comment/08f7e7fe_7800d03f?usp=3Demail">Patch Set #3, L=
ine 3528:</a> <code style=3D"font-family:monospace,monospace">    else if (=
c-&gt;options.test_crypto)</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">So basically to currently =
still support the old mode that allows to use --secret to manually specify =
[=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1435/comment/c8f0900d_ef9eff0f?usp=3Demail">Patch Set #5, Line 2695:</a>=
 <code style=3D"font-family:monospace,monospace">    if (options-&gt;tls_se=
rver + options-&gt;tls_client + (options-&gt;shared_secret_file !=3D NULL) =
&gt; 1)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Since test_crypto does not imply shared_secret_file anym=
ore should we add a check here that we do not combine `--test-crypto` with =
`--tls-*` ?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1435?usp=3Demail">change 1435</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1435?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I72947bd4f0213fd118327f740da=
eb1d86ae166de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1435 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 12 Dec 2025 10:54:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--/o4n4LNijhA=--

