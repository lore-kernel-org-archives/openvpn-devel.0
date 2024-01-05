From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 5 Jan 2024 14:19:56 +0000
In-Reply-To: <gerrit.1703674237000.Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71@...2715...>
References: <gerrit.1703674237000.Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <27d4d14af8e86dfd28735cd0b8424a2a013fbacd-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bfvxCFS1gL0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: increase
 verbosity for make check
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

--bfvxCFS1gL0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/485?usp=3Demail )

Change subject: GHA: increase verbosity for make check
......................................................................


Patch Set 1: Code-Review+2

(1 comment)

Patchset:

PS1:
> Retracting my previous ACK. I mixed up cmake VERBOSE=3D1 with the V=3D1 o=
f make.
I had still a backout of the serial test in my branch, so I did had the gen=
erated code for this in my tree:

tests/unit_tests/openvpn/Makefile:	  test x"$$VERBOSE" =3D x || cat $(TEST_=
SUITE_LOG);

So it actually works.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/485?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie44a4b750605c4cc3ac1f75e1fa5ab85804ffa71
Gerrit-Change-Number: 485
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 05 Jan 2024 14:19:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: comment

--bfvxCFS1gL0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/485?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/485?tab=3Dcomments">Patch Set #1:</a> </p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Retracting my prev=
ious ACK. I mixed up cmake VERBOSE=3D1 with the V=3D1 of make.</blockquote>=
</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I had still =
a backout of the serial test in my branch, so I did had the generated code =
for this in my tree:</p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">tests/unit_tests/openvpn/Makefile:	  test x&quot;$$VERBOSE&quot; =
=3D x || cat $(TEST_SUITE_LOG);</p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">So it actually works.</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/485?usp=3Demail">ch=
ange 485</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/485?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie44a4b750605c4cc3ac1f75e1fa=
5ab85804ffa71 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 485 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 05 Jan 2024 14:19:56=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--bfvxCFS1gL0=--

