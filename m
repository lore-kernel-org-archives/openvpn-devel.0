From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 24 Apr 2025 06:58:36 +0000
In-Reply-To: <gerrit.1744973073000.I621d44ec6b0facc524875c15ddfd11ec47b06c15@...2715...>
References: <gerrit.1744973073000.I621d44ec6b0facc524875c15ddfd11ec47b06c15@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d95c90e1cda092167552e3041caf11fa9eb76762-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qvvOjR6MZRE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win: create adapter
 on demand
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qvvOjR6MZRE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, selvanair.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/943?usp=3Demail )

Change subject: win: create adapter on demand
......................................................................


Patch Set 2:

(3 comments)

File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/943/comment/e2801d99_1753f1ba :
PS2, Line 3781: static struct device_instance_id_interface *
> This change is not required nor advisable. Same with panel_reg and tap_re=
g below. [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/943/comment/78901121_07cb7bb3 :
PS2, Line 6656:     struct device_instance_id_interface *device_instance_id=
_interface =3D get_device_instance_id_interface(gc);
> Define these three as "const struct ...". One can still re-assign them as=
 required below.
right, the data is const, but not the pointer.


http://gerrit.openvpn.net/c/openvpn/+/943/comment/36c92149_f13d12e9 :
PS2, Line 6731:             if (tun_try_open_device(tt, *device_guid, devic=
e_instance_id_interface))
> I think we should not limit this using the adapter_created flag here. [=
=E2=80=A6]
Acknowledged



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/943?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I621d44ec6b0facc524875c15ddfd11ec47b06c15
Gerrit-Change-Number: 943
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Thu, 24 Apr 2025 06:58:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: selvanair <selva.nair@...277...>
Gerrit-MessageType: comment

--qvvOjR6MZRE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, selvanai=
r. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/943?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/943/comment/e2801d99_1753f1ba">Patch Set #2, Line 3781:</a> <=
code style=3D"font-family:monospace,monospace">static struct device_instanc=
e_id_interface *</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">This change is not required nor advi=
sable. Same with panel_reg and tap_reg below. [=E2=80=A6]</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/943/comment/789011=
21_07cb7bb3">Patch Set #2, Line 6656:</a> <code style=3D"font-family:monosp=
ace,monospace">    struct device_instance_id_interface *device_instance_id_=
interface =3D get_device_instance_id_interface(gc);</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">D=
efine these three as &quot;const struct ...&quot;. One can still re-assign =
them as required below.</blockquote></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">right, the data is const, but not the pointer.</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/943/comment/36c921=
49_f13d12e9">Patch Set #2, Line 6731:</a> <code style=3D"font-family:monosp=
ace,monospace">            if (tun_try_open_device(tt, *device_guid, device=
_instance_id_interface))</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">I think we should not limit =
this using the adapter_created flag here. [=E2=80=A6]</blockquote></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/943?usp=3Demail">change 943</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/943?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I621d44ec6b0facc524875c15ddf=
d11ec47b06c15 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 943 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 24 Apr 2025 06:58:36=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--qvvOjR6MZRE=--

