From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 17 Sep 2025 23:39:32 +0000
In-Reply-To: <gerrit.1757943505000.I423c9880def0eb479abb72bef2e8034a73cf5905@...2715...>
References: <gerrit.1757943505000.I423c9880def0eb479abb72bef2e8034a73cf5905@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., gert@...1296...
Message-ID: <9342ca215c1967a9b9c96ad04fa944799e579b06-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4ET4Wm5xhig="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4ET4Wm5xhig=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

selvanair has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1188?usp=3Demail )

Change subject: openvpnserv: Fix writing messages to the event log
......................................................................


Patch Set 3:

(1 comment)

Patchset:

PS2:
> FWIW, buildbot also has a mingw build and it shows it generates the file.=
 @selva.nair@...2916... [=E2=80=A6]
If that is so, all is good. Does the log just show building, or is the dll =
really generated as well? Also, is there a way to see buildbot logs -- for =
me the link always times out trying to connect to some AWS site.

Further, is --no-entry really a valid linker option? Googling brings it up =
but that could be an "AI hallucination" based on MSVC's /NOENTRY. Anyway, I=
 cant get that option to work. A way to make DLLs with no entry point using=
 gnu linker is probably to pass -nostartfiles option to gcc.

That said, I get no build errors -- just no dll to be found anyhere, nor th=
e command building it is in the verbose logs.(https://gist.github.com/selva=
nair/7145365eab2b38c2c961646efca692ea).



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1188?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I423c9880def0eb479abb72bef2e8034a73cf5905
Gerrit-Change-Number: 1188
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Comment-Date: Wed, 17 Sep 2025 23:39:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: selvanair <selva.nair@...277...>
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--4ET4Wm5xhig=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1188?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1188?tab=3Dcomments">Patch Set #2:</a> </p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">FWIW, buildbot also =
has a mingw build and it shows it generates the file. @selva.nair@...2917...=
. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">If that is so, all is good. Does the log just show building, =
or is the dll really generated as well? Also, is there a way to see buildbo=
t logs -- for me the link always times out trying to connect to some AWS si=
te. </p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Further,=
 is --no-entry really a valid linker option? Googling brings it up but that=
 could be an &quot;AI hallucination&quot; based on MSVC&#39;s /NOENTRY. Any=
way, I cant get that option to work. A way to make DLLs with no entry point=
 using gnu linker is probably to pass -nostartfiles option to gcc.</p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">That said, I get no b=
uild errors -- just no dll to be found anyhere, nor the command building it=
 is in the verbose logs.(https://gist.github.com/selvanair/7145365eab2b38c2=
c961646efca692ea).</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1188?usp=3Demail">change 1188</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1188?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I423c9880def0eb479abb72bef2e=
8034a73cf5905 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1188 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 17 Sep 2025 23:39:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: selvanair &lt;selva.nair@=
...277...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--4ET4Wm5xhig=--

