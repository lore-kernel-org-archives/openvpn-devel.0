From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 16 Sep 2025 07:10:24 +0000
In-Reply-To: <gerrit.1757943505000.I423c9880def0eb479abb72bef2e8034a73cf5905@...2715...>
References: <gerrit.1757943505000.I423c9880def0eb479abb72bef2e8034a73cf5905@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5d005d88119c7783b5c212976089f6a4fd3ea0ec-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jxuU+IDA++k="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: Fix
 writing messages to the event log
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jxuU+IDA++k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, selvanair.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1188?usp=3Demail )

Change subject: openvpnserv: Fix writing messages to the event log
......................................................................


Patch Set 2:

(2 comments)

File src/openvpnserv/common.c:

http://gerrit.openvpn.net/c/openvpn/+/1188/comment/faf6c002_b6bdf61f :
PS1, Line 209:                         NULL, error, MAKELANGID(LANG_NEUTRAL=
, SUBLANG_DEFAULT), (LPTSTR)&tmp, 0, NULL);
> Explict use of the unicode version "FormatMessageW" preferred.
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/1188/comment/33eaf24d_50732a8f :
PS1, Line 228:     buf[_countof(buf) - 1] =3D L'\0';
> Previously we removed openvp_swprintf etc. [=E2=80=A6]
JFTR: only MSFT version of swprintf guarantees NULL termination. Other vers=
ions won't write anything (and won't terminate) if the string doesn't fit. =
OTOH, we build releases with MSVC and in any case we nowadays use MSFT impl=
ementation (ucrtbase.dll) from OS.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1188?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I423c9880def0eb479abb72bef2e8034a73cf5905
Gerrit-Change-Number: 1188
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Tue, 16 Sep 2025 07:10:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: selvanair <selva.nair@...277...>
Gerrit-MessageType: comment

--jxuU+IDA++k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, selvanai=
r. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1188?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/common.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1188/comment/faf6c002_b6bdf61f">Patch Set #1, Line 20=
9:</a> <code style=3D"font-family:monospace,monospace">                    =
    NULL, error, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR)&amp;tm=
p, 0, NULL);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">Explict use of the unicode version &quot=
;FormatMessageW&quot; preferred.</blockquote></p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1188/comment/33eaf24d_50732a8f">Patch Set #=
1, Line 228:</a> <code style=3D"font-family:monospace,monospace">    buf[_c=
ountof(buf) - 1] =3D L&#39;\0&#39;;</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Previously we rem=
oved openvp_swprintf etc. [=E2=80=A6]</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">JFTR: only MSFT version of swprintf g=
uarantees NULL termination. Other versions won&#39;t write anything (and wo=
n&#39;t terminate) if the string doesn&#39;t fit. OTOH, we build releases w=
ith MSVC and in any case we nowadays use MSFT implementation (ucrtbase.dll)=
 from OS.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1188?usp=3Demail">change 1188</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1188?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I423c9880def0eb479abb72bef2e=
8034a73cf5905 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1188 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva.nair@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 16 Sep 2025 07:10:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--jxuU+IDA++k=--

