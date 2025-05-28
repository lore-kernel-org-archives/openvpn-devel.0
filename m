From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 28 May 2025 01:02:06 +0000
In-Reply-To: <gerrit.1748268615000.I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91@...2715...>
References: <gerrit.1748268615000.I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., gert@...1296...
Message-ID: <7f2fd98f5d2b0cf65c104b51cd97cadd518c4fe5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s3gpMzT93gk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Changes.rst: Collect, fix,
 and improve entries for 2.7 release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--s3gpMzT93gk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

selvanair has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1032?usp=3Demail )

Change subject: Changes.rst: Collect, fix, and improve entries for 2.7 rele=
ase
......................................................................


Patch Set 4:

(3 comments)

File Changes.rst:

http://gerrit.openvpn.net/c/openvpn/+/1032/comment/4b70288b_e5365aa6 :
PS4, Line 187:
New option --providers to load optional OpenSSL3 providers


http://gerrit.openvpn.net/c/openvpn/+/1032/comment/7f3955a7_08db94c6 :
PS4, Line 189:   which is the case for many OpenSSL 3 providers.
Technically its not really depend on SSL library (OpenSSL 3 required) but o=
n providers which can be loaded by the user.
A more correct wording would be
"--key`` and ``--cert`` now accept URIs implemented in OpenSSL 3 as well as
optional OpenSSL 3 providers loaded using --providers option."


http://gerrit.openvpn.net/c/openvpn/+/1032/comment/65bba08f_975e28d1 :
PS4, Line 190:
--cryptopapicert now supports issuer name as well as Windows CA template na=
me or OID as selector string.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I80a14b77fcc2fabf51af9f2d5ea0c36362cccb91
Gerrit-Change-Number: 1032
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Wed, 28 May 2025 01:02:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--s3gpMzT93gk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File Changes.rst:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1032/comment/4b70288b_e5365aa6">Patch Set #4, Line 187:</a> <code =
style=3D"font-family:monospace,monospace"></code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">New option --providers to load optiona=
l OpenSSL3 providers</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1032/comment/7f3955a7_08db94c6">Patch Set #4, Line 189:</a> <code st=
yle=3D"font-family:monospace,monospace">  which is the case for many OpenSS=
L 3 providers.</code></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Technically its not really depend on SSL library (OpenSSL 3 requir=
ed) but on providers which can be loaded by the user.<br>A more correct wor=
ding would be<br>&quot;--key`` and ``--cert`` now accept URIs implemented i=
n OpenSSL 3 as well as<br>optional OpenSSL 3 providers loaded using --provi=
ders option.&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1032/comment/65bba08f_975e28d1">Patch Set #4, Line 190:</a> <code styl=
e=3D"font-family:monospace,monospace"></code></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">--cryptopapicert now supports issuer name =
as well as Windows CA template name or OID as selector string.</p></li></ul=
></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1032?usp=3Demail">change 1032</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1032?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80a14b77fcc2fabf51af9f2d5ea=
0c36362cccb91 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1032 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva.nair@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 28 May 2025 01:02:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--s3gpMzT93gk=--

