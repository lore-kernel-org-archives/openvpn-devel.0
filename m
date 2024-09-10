From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 10 Sep 2024 10:56:14 +0000
In-Reply-To: <gerrit.1683717398000.I6818b153bdeb1eed65870af99b0531e95807fe0f@...2715...>
References: <gerrit.1683717398000.I6818b153bdeb1eed65870af99b0531e95807fe0f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e69e8afabe454345d7852355819c0005f3e92bea-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yTnKHM5hf+0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Various fixes for
 -Wconversion errors
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yTnKHM5hf+0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/267?usp=3Demail )

Change subject: Various fixes for -Wconversion errors
......................................................................


Patch Set 5:

(2 comments)

Patchset:

PS5:
I'll deal with it ASAP, but would ask you to look into link_socket_write*()=
 as discussed on IRC.  So yes it will make the patch larger, but if it make=
s things better aligned...


File src/openvpn/socket.h:

http://gerrit.openvpn.net/c/openvpn/+/267/comment/2bb2272e_c41da5d0 :
PS5, Line 1184: static inline size_t
this looks funny. `ssize_t` and keep the `-1`?

(it's a whole call chain of `link_socket_write_*()` things, but somewhere u=
nderneath is a `write()` or `sendto()`, which both use `ssize_t`)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/267?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6818b153bdeb1eed65870af99b0531e95807fe0f
Gerrit-Change-Number: 267
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 10 Sep 2024 10:56:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--yTnKHM5hf+0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/267?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
267?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">I&#39;ll deal with it ASAP, but would ask you to =
look into link_socket_write*() as discussed on IRC.  So yes it will make th=
e patch larger, but if it makes things better aligned...</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.h:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/267/comment/2bb2272e_c41da5d0">Patch Set #5, Line 1184:</a=
> <code style=3D"font-family:monospace,monospace">static inline size_t</cod=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">this looks=
 funny. `ssize_t` and keep the `-1`?</p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">(it&#39;s a whole call chain of `link_socket_write_=
*()` things, but somewhere underneath is a `write()` or `sendto()`, which b=
oth use `ssize_t`)</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/267?usp=3Demail">change 267</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/267?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6818b153bdeb1eed65870af99b0=
531e95807fe0f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 267 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Sep 2024 10:56:14=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--yTnKHM5hf+0=--

