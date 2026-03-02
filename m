From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 2 Mar 2026 14:19:58 +0000
In-Reply-To: <gerrit.1771607942000.I53d47e4a0d33c380ee95e0e33aecad3db3197940@...2715...>
References: <gerrit.1771607942000.I53d47e4a0d33c380ee95e0e33aecad3db3197940@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 steffan@...1856..., max@...2606..., gert@...1296...
Message-ID: <851a23cd02073eb54062e69539b871f2447afc9a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xdk0ly7PGSQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Avoid unbounded
 allocations in pkcs11_mbedtls.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: syzzer <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Xdk0ly7PGSQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, syzzer.

plaisthos has posted comments on this change by MaxF. ( http://gerrit.openv=
pn.net/c/openvpn/+/1549?usp=3Demail )

Change subject: Avoid unbounded allocations in pkcs11_mbedtls.c
......................................................................


Patch Set 1: Code-Review+2


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1549?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53d47e4a0d33c380ee95e0e33aecad3db3197940
Gerrit-Change-Number: 1549
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: syzzer <steffan@...1856...>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Mon, 02 Mar 2026 14:19:58 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--Xdk0ly7PGSQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, syzzer. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1549?usp=3Demail">V=
iew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1549?usp=3Demail=
">change 1549</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1549?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53d47e4a0d33c380ee95e0e33ae=
cad3db3197940 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1549 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: syzzer &lt;steffan@...1856...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Mar 2026 14:19:58=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--Xdk0ly7PGSQ=--

