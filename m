From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 28 Aug 2024 17:56:56 +0000
In-Reply-To: <gerrit.1723673969000.I82b32d5ab472926e7889a5f4a90caba14231879a@...2715...>
References: <gerrit.1723673969000.I82b32d5ab472926e7889a5f4a90caba14231879a@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <656103ad9ffc432e0074f099070149b3440c408a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0N8vwb6hIcE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Interpret --key and
 --cert option argument as URI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0N8vwb6hIcE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

selvanair has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/726?usp=3Demail )

Change subject: Interpret --key and --cert option argument as URI
......................................................................


Patch Set 2:

(1 comment)

Patchset:

PS2:
> So I actually tried to use this in a test scenario. [=E2=80=A6]
The way I tested this using a soft token is described in this gist: https:/=
/gist.github.com/selvanair/323ccadbef5ae16df2b7ffb80e2d038b

For softhsm2 token I had to set `pkcs11-module-quirks =3D no-operation-stat=
e` in provider config (see openssl.cnf in the above link). Without this I g=
ot an error:

```OpenSSL: error:40800054:pkcs11::reason(84):Error returned by C_GetOperat=
ionState```

which may be a softhsm2 quirk. Also, for this reason I opted to configure p=
roviders in openssl.cnf instead of using our `--providers` option which is =
limited in functionality.

With these settings both server and client worked using pkcs11 URI. As for =
hooks, I only tried a simple `tls-verify` script on server-side which does =
work for me. What kind of hooks caused openvpn to hang?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I82b32d5ab472926e7889a5f4a90caba14231879a
Gerrit-Change-Number: 726
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 28 Aug 2024 17:56:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--0N8vwb6hIcE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/726?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
26?tab=3Dcomments">Patch Set #2:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">So I actually tried to=
 use this in a test scenario. [=E2=80=A6]</blockquote></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">The way I tested this using a sof=
t token is described in this gist: https://gist.github.com/selvanair/323cca=
dbef5ae16df2b7ffb80e2d038b</p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">For softhsm2 token I had to set `pkcs11-module-quirks =3D no-=
operation-state` in provider config (see openssl.cnf in the above link). Wi=
thout this I got an error:</p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">```OpenSSL: error:40800054:pkcs11::reason(84):Error returned =
by C_GetOperationState```</p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">which may be a softhsm2 quirk. Also, for this reason I opted t=
o configure providers in openssl.cnf instead of using our `--providers` opt=
ion which is limited in functionality.</p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">With these settings both server and client worked=
 using pkcs11 URI. As for hooks, I only tried a simple `tls-verify` script =
on server-side which does work for me. What kind of hooks caused openvpn to=
 hang?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/726?usp=3Demail">change 726</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/726?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I82b32d5ab472926e7889a5f4a90=
caba14231879a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 726 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Aug 2024 17:56:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--0N8vwb6hIcE=--

