From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 28 Mar 2025 21:34:30 +0000
In-Reply-To: <gerrit.1743175587000.I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf@...2715...>
References: <gerrit.1743175587000.I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1d7c5223805ac5d9c2e620ecced6d88181227f41-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RainoNgYXhk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix FreeBSD-DCO and
 Multisocket interaction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RainoNgYXhk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/925?usp=3Demail )

Change subject: Fix FreeBSD-DCO and Multisocket interaction
......................................................................


Patch Set 1:

(3 comments)

Patchset:

PS1:
questions...


File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/925/comment/9d655d2e_4fc29dc7 :
PS1, Line 263:     if (ce->local_list)
will this also catch clients that have no `--local` at all, just `--remote =
... tcp`?  FreeBSD DCO also needs to be disabled for TCP clients.


http://gerrit.openvpn.net/c/openvpn/+/925/comment/95331584_9525203f :
PS1, Line 277:     if (!proto_is_udp(ce->proto) && mode =3D=3D MODE_SERVER)
this looks as if we need the fix for windows too...  maybe keep & use the h=
as_tcp_in_local_list() for this?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/925?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9b6359076a61ae2bbb8e5cea00e33969cb5f92cf
Gerrit-Change-Number: 925
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Fri, 28 Mar 2025 21:34:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--RainoNgYXhk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/925?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
925?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">questions...</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File src/openvpn/dco.c:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/925/=
comment/9d655d2e_4fc29dc7">Patch Set #1, Line 263:</a> <code style=3D"font-=
family:monospace,monospace">    if (ce-&gt;local_list)</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">will this also catch cli=
ents that have no `--local` at all, just `--remote ... tcp`?  FreeBSD DCO a=
lso needs to be disabled for TCP clients.</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/925/comment/95331584_9525203f">Patch Set #1, Li=
ne 277:</a> <code style=3D"font-family:monospace,monospace">    if (!proto_=
is_udp(ce-&gt;proto) &amp;&amp; mode =3D=3D MODE_SERVER)</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">this looks as if we need=
 the fix for windows too...  maybe keep &amp; use the has_tcp_in_local_list=
() for this?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/925?usp=3Demail">change 925</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/925?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b6359076a61ae2bbb8e5cea00e=
33969cb5f92cf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 925 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 28 Mar 2025 21:34:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--RainoNgYXhk=--

