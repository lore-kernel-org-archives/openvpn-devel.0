From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 26 Aug 2025 13:01:46 +0000
In-Reply-To: <gerrit.1755870317000.Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7@...2715...>
References: <gerrit.1755870317000.Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <6ca06e826f5fcf2fc0cb7ac415ac1027ff2c5859-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/saSNX7AQeQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Introduce
 atoi_constrained and review usages of atoi_warn
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

--/saSNX7AQeQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1150?usp=3Demail )

Change subject: options: Introduce atoi_constrained and review usages of at=
oi_warn
......................................................................


Patch Set 3: Code-Review-1

(2 comments)

Patchset:

PS3:
I am not sure that the 0 as INT_MAX is the best way to go here. See the com=
ment below.


File src/openvpn/options_util.h:

http://gerrit.openvpn.net/c/openvpn/+/1150/comment/8b3298f5_3710adb3 :
PS3, Line 51:  * If \p max is 0, \p INT_MAX is used instead.
Why not use INT_MAX for INT_MAX and instead use this both 0 and INT_MAX are=
 INT_MAX?

I think the code would be easier to parse from the calling functions if you=
 immediately see that it it is between whatever and INT_MAX.

I think

    atoi_constrained(p[1], &cf_max,  "connect-freq n", 1, INT_MAX, msglevel)

is intuatively more clear than

    atoi_constrained(p[1], &cf_max, "connect-freq n", 1, 0, msglevel)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1150?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7
Gerrit-Change-Number: 1150
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 26 Aug 2025 13:01:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--/saSNX7AQeQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1150?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1150?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">I am not sure that the 0 as INT_MAX is the =
best way to go here. See the comment below.</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/options_util.h:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1150/comment/8b3298f5_3710adb3">Patch Set #3, Line 51:</a> <code =
style=3D"font-family:monospace,monospace"> * If \p max is 0, \p INT_MAX is =
used instead.</code></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Why not use INT_MAX for INT_MAX and instead use this both 0 and INT=
_MAX are INT_MAX?</p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">I think the code would be easier to parse from the calling functions i=
f you immediately see that it it is between whatever and INT_MAX.</p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">I think </p><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">    atoi_cons=
trained(p[1], &amp;cf_max,  &quot;connect-freq n&quot;, 1, INT_MAX, msgleve=
l)</pre><p style=3D"white-space: pre-wrap; word-wrap: break-word;">is intua=
tively more clear than </p><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">    atoi_constrained(p[1], &amp;cf_max, &quot;conne=
ct-freq n&quot;, 1, 0, msglevel)</pre></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1150?usp=3Demail">change =
1150</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1150?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc7526d59c1de17a0f9d8ed88f7=
5c6f070ab11e7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1150 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 26 Aug 2025 13:01:46=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--/saSNX7AQeQ=--

