From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 19 Jun 2024 10:17:14 +0000
In-Reply-To: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
References: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <08bb0b66d2adaa484806f3ea00bb45a936fcb6a2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0oz6EPCt7uk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Http-proxy: fix bug
 preventing proxy credentials caching
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0oz6EPCt7uk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/523?usp=3Demail )

Change subject: Http-proxy: fix bug preventing proxy credentials caching
......................................................................


Patch Set 8: Code-Review-1

(3 comments)

Patchset:

PS8:
Minor nitpick: function call and prototype having empty brackets `()` inste=
ad of proper `(void)`.  This needs to be fixed, and I can't do code changes=
 on merge.


File src/openvpn/ssl.h:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/5680c4c5_ce81e31d :
PS8, Line 402: bool ssl_get_auth_nocache();
this needs to have a `(void)` there.


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/523/comment/7c301b9f_a12ccb3f :
PS8, Line 341: ssl_get_auth_nocache()
this needs to have a `(void)` there.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a
Gerrit-Change-Number: 523
Gerrit-PatchSet: 8
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Wed, 19 Jun 2024 10:17:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--0oz6EPCt7uk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>Patch set 8:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/523?tab=3Dcomments">Patch Set #8:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Minor nitpick: function call and prototype ha=
ving empty brackets `()` instead of proper `(void)`.  This needs to be fixe=
d, and I can&#39;t do code changes on merge.</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/ssl.h:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/523/comment/5680c4c5_ce81e31d">Patch Set #8, Line 402:</a> <code style=3D=
"font-family:monospace,monospace">bool ssl_get_auth_nocache();</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">this needs to have=
 a `(void)` there.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523/comment/7c301b9f_a12=
ccb3f">Patch Set #8, Line 341:</a> <code style=3D"font-family:monospace,mon=
ospace">ssl_get_auth_nocache()</code></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">this needs to have a `(void)` there.</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/523?usp=3Demail">change 523</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3e06c0832c4ca0ab868c845279=
fb71c01a1a78a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 523 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Jun 2024 10:17:14=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--0oz6EPCt7uk=--

