From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 6 Dec 2025 20:57:16 +0000
In-Reply-To: <gerrit.1765030148000.I99a6604fdfc682f9609bfe7672aa78285084dcb9@...2715...>
References: <gerrit.1765030148000.I99a6604fdfc682f9609bfe7672aa78285084dcb9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, kn@...2273...
Message-ID: <cc8b4c5b43f7cc215208d07b92617f2395cd57b7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="21dFIEaFEj4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Prevent crash on
 invalid server-ipv6 argument
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--21dFIEaFEj4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: klemens, plaisthos.

cron2 has posted comments on this change by klemens. ( http://gerrit.openvp=
n.net/c/openvpn/+/1418?usp=3Demail )

Change subject: Prevent crash on invalid server-ipv6 argument
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
On FreeBSD and Linux, freeaddrinfo(NULL) seems to be safe, but the comment =
inside FreeBSD's lib sources hint at "this is not clearly defined in the st=
andard" and it seems OpenBSD prefes to make that point very clear.

We do actually check getaddrinfo() return everywhere else and only do `free=
addrinfo(ai)` in the success branch, or after testing for `not NULL`, so th=
is is a very reasonable change.

(I might add some wording about this to the commit message)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1418?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I99a6604fdfc682f9609bfe7672aa78285084dcb9
Gerrit-Change-Number: 1418
Gerrit-PatchSet: 1
Gerrit-Owner: klemens <kn@...2273...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: klemens <kn@...2273...>
Gerrit-Comment-Date: Sat, 06 Dec 2025 20:57:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--21dFIEaFEj4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: klemens, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1418?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1418?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">On FreeBSD and =
Linux, freeaddrinfo(NULL) seems to be safe, but the comment inside FreeBSD&=
#39;s lib sources hint at &quot;this is not clearly defined in the standard=
&quot; and it seems OpenBSD prefes to make that point very clear.</p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">We do=
 actually check getaddrinfo() return everywhere else and only do `freeaddri=
nfo(ai)` in the success branch, or after testing for `not NULL`, so this is=
 a very reasonable change.</p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">(I might add some wording about this to the =
commit message)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1418?usp=3Demail">change 1418</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1418?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I99a6604fdfc682f9609bfe7672a=
a78285084dcb9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1418 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: klemens &lt;kn@...2273...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: klemens &lt;kn@...2273...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 06 Dec 2025 20:57:16=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--21dFIEaFEj4=--

