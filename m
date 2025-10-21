From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 21 Oct 2025 07:00:17 +0000
In-Reply-To: <gerrit.1760942237000.Ifb1c49fce75e671f699f5db5f6da7246f6e0b519@...2715...>
References: <gerrit.1760942237000.Ifb1c49fce75e671f699f5db5f6da7246f6e0b519@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726..., frank@...2641...
Message-ID: <a9ee8e8b448504b8831ef615778bccfd08f6b0fe-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OlbaOrsVF2k="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: management: ensure
 consistent BYTECOUNT timing on server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OlbaOrsVF2k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici.

stipa has posted comments on this change by ralf_lici. ( http://gerrit.open=
vpn.net/c/openvpn/+/1285?usp=3Demail )

Change subject: management: ensure consistent BYTECOUNT timing on server
......................................................................


Patch Set 2: Code-Review+2

(1 comment)

Patchset:

PS2:
LGTM. The previous implementation triggered BYTECOUNT callback at most ever=
y 10 seconds, even with a smaller interval - this is due to instance reaper=
 timeout being set to 10 secs, and we haven't checked BYTECOUNT timeout aga=
inst any timeval instance.

This checks BYTECOUNT timeout expiration against multi->top.c2.timeval, the=
 one used by multi_io_wait, which means that any interval will now work.

Tested on Windows server setup.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1285?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifb1c49fce75e671f699f5db5f6da7246f6e0b519
Gerrit-Change-Number: 1285
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Tue, 21 Oct 2025 07:00:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--OlbaOrsVF2k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1285?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1285?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">LGTM. The p=
revious implementation triggered BYTECOUNT callback at most every 10 second=
s, even with a smaller interval - this is due to instance reaper timeout be=
ing set to 10 secs, and we haven&#39;t checked BYTECOUNT timeout against an=
y timeval instance.</p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">This checks BYTECOUNT timeout expiration against mu=
lti-&gt;top.c2.timeval, the one used by multi_io_wait, which means that any=
 interval will now work.</p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Tested on Windows server setup.</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1285?usp=3Demail">change 1285</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/12=
85?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifb1c49fce75e671f699f5db5f6d=
a7246f6e0b519 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1285 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 21 Oct 2025 07:00:17=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--OlbaOrsVF2k=--

