From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 12 Feb 2026 14:02:59 +0000
In-Reply-To: <gerrit.1766158651000.I1f5724476862935284f620c54afa510eea03e3f9@...2715...>
References: <gerrit.1766158651000.I1f5724476862935284f620c54afa510eea03e3f9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...,
 gert@...1296...
Message-ID: <fdfc3c917ce505437dc0d508146c17592196a5d0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="soFwNEeZab4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove NTLM support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--soFwNEeZab4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos.

flichtenheld has posted comments on this change by flichtenheld. ( http://g=
errit.openvpn.net/c/openvpn/+/1453?usp=3Demail )

Change subject: Remove NTLM support
......................................................................


Patch Set 2:

(1 comment)

Patchset:

PS2:
> I love getting rid of this thing. However, shouldn't we warn user about t=
he option going away? I.e. [=E2=80=A6]
Currently we only have that in the release notes but the code does not issu=
e a warning.

Obviously that would need to go into a separate patch, but yes, if you want=
 that I can add it.

Curious to see whether we get any feedback on the NTLMv1 removal in 2.7. Mi=
crosoft is trying to get rid of it as well and with OpenSSL 3 you probably =
need to add --provider legacy to be able to use it. So it is not like this =
comes out of nowhere...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1453?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1f5724476862935284f620c54afa510eea03e3f9
Gerrit-Change-Number: 1453
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Thu, 12 Feb 2026 14:02:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@...2726...>

--soFwNEeZab4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, ordex, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1453?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1453?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I lo=
ve getting rid of this thing. However, shouldn&#39;t we warn user about the=
 option going away? I.e. [=E2=80=A6]</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Currently we only hav=
e that in the release notes but the code does not issue a warning.</p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Obvi=
ously that would need to go into a separate patch, but yes, if you want tha=
t I can add it.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Curious to see whether we get any feedback on the NTLMv=
1 removal in 2.7. Microsoft is trying to get rid of it as well and with Ope=
nSSL 3 you probably need to add --provider legacy to be able to use it. So =
it is not like this comes out of nowhere...</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1453?usp=3Demail=
">change 1453</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1453?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1f5724476862935284f620c54af=
a510eea03e3f9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1453 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Feb 2026 14:02:59=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>

</body></html>=

--soFwNEeZab4=--

