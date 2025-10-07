From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 08:28:07 +0000
In-Reply-To: <gerrit.1759751916000.I1aeed74dedf6dd5f559f4eb5cc84645f149ba788@...2715...>
References: <gerrit.1759751916000.I1aeed74dedf6dd5f559f4eb5cc84645f149ba788@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <69906ceacaf3789f792b0688d066d7822918fbf4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4e0/MFXhvC0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: COPYING: Remove
 licenses for software bundled in the Windows client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4e0/MFXhvC0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by flichtenheld. ( http://gerr=
it.openvpn.net/c/openvpn/+/1249?usp=3Demail )

Change subject: COPYING: Remove licenses for software bundled in the Window=
s client
......................................................................


Patch Set 1:

(1 comment)

File COPYING:

http://gerrit.openvpn.net/c/openvpn/+/1249/comment/0e1da529_7947c410?usp=3D=
email :
PS1, Line 88:   Markus F.X.J. Oberhumer
> The question is whether we need this in OpenVPN generally or whether this=
 is only relevant for the W [=E2=80=A6]
In general. Linking GPLv2 and old OpenSSL license or new OpenSSL license is=
 not allowed.

OpeNVPN has its own exception for allowing this linking and the author of L=
ZO grants us to do the same for his library. Technically *we* don't need th=
is exception on other platforms but anyone who builds/ships OpenVPN with LZ=
O needs it, so it is better to have it documented in a place where people c=
an point to.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1aeed74dedf6dd5f559f4eb5cc84645f149ba788
Gerrit-Change-Number: 1249
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 07 Oct 2025 08:28:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--4e0/MFXhvC0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File COPYING:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1249/comment/0e1da529_7947c410?usp=3Demail">Patch Set #1, Line 88:</a> =
<code style=3D"font-family:monospace,monospace">  Markus F.X.J. Oberhumer</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">The question is whether we need this in OpenVPN genera=
lly or whether this is only relevant for the W [=E2=80=A6]</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>In general. Linking GPLv2 and old OpenSSL license or new OpenSSL license i=
s not allowed. </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">OpeNVPN has its own exception for allowing this linking=
 and the author of LZO grants us to do the same for his library. Technicall=
y *we* don&#39;t need this exception on other platforms but anyone who buil=
ds/ships OpenVPN with LZO needs it, so it is better to have it documented i=
n a place where people can point to.</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demail">chang=
e 1249</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1249?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1aeed74dedf6dd5f559f4eb5cc8=
4645f149ba788 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1249 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 07 Oct 2025 08:28:07=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--4e0/MFXhvC0=--

