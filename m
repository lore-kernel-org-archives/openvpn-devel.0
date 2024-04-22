From: "reynir (Code Review)" <gerrit@...515...>
Date: Mon, 22 Apr 2024 11:19:41 +0000
In-Reply-To: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
References: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
Reply-To: reynir@...2756..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <93a6b5fdf4825172950f79c3dc1b20397b207175-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LIgbzZ1QQQs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Only
 schedule_exit() once
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LIgbzZ1QQQs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

reynir has posted comments on this change. ( http://gerrit.openvpn.net/c/op=
envpn/+/555?usp=3Demail )

Change subject: Only schedule_exit() once
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/555/comment/3395ca91_15f2e5ca :
PS1, Line 523:      * only ever seems to be SIGTERM anyway. */
I also considered dropping the `signal` argument as it is currently always =
`SIGTERM` at all call sites.


http://gerrit.openvpn.net/c/openvpn/+/555/comment/f2f84020_796d7125 :
PS1, Line 530:     event_timeout_init(&c->c2.scheduled_exit, n_seconds, now=
);
I have only now thought of it: what if the new `n_seconds` is sooner than t=
he already scheduled exit?! I suspect `n_seconds` is always 5, though.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9457f005f4ba970502e6b667d9dc4299a588d661
Gerrit-Change-Number: 555
Gerrit-PatchSet: 1
Gerrit-Owner: reynir <reynir@...2756...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: reynir <reynir@...2756...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 22 Apr 2024 11:19:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--LIgbzZ1QQQs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/555/comment/3395ca91_15f2e5ca">Patch Set #1, Line 523=
:</a> <code style=3D"font-family:monospace,monospace">     * only ever seem=
s to be SIGTERM anyway. */</code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">I also considered dropping the `signal` argument as it=
 is currently always `SIGTERM` at all call sites.</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/555/comment/f2f84020_796d7125">Patch Se=
t #1, Line 530:</a> <code style=3D"font-family:monospace,monospace">    eve=
nt_timeout_init(&amp;c-&gt;c2.scheduled_exit, n_seconds, now);</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">I have only now th=
ought of it: what if the new `n_seconds` is sooner than the already schedul=
ed exit?! I suspect `n_seconds` is always 5, though.</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/555?usp=
=3Demail">change 555</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9457f005f4ba970502e6b667d9d=
c4299a588d661 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 555 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: reynir &lt;reynir@...2756...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: reynir &lt;reynir@...2756...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 22 Apr 2024 11:19:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--LIgbzZ1QQQs=--

