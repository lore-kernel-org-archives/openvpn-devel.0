From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 24 Apr 2024 12:13:13 +0000
In-Reply-To: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
References: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, reynir@...2756...
Message-ID: <3350fb9669a06cf312c46d1af82530fefe308b72-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wM5Bg5lGcug="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Only schedule_exit()
 once
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: reynir <reynir@...2756...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wM5Bg5lGcug=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, reynir.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/555?usp=3Demail )

Change subject: Only schedule_exit() once
......................................................................


Patch Set 2: Code-Review+2

(3 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/555/comment/090e8b75_da780d6c :
PS1, Line 523:      * only ever seems to be SIGTERM anyway. */
> I also considered dropping the `signal` argument as it is currently alway=
s `SIGTERM` at all call sit [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/555/comment/01a64bab_9f4236b8 :
PS1, Line 525:         return;
> You might want to consider changing the function to return a boolean to i=
ndicate whether it did anyt [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/555/comment/123d7f7a_5b2bfd6a :
PS1, Line 530:     event_timeout_init(&c->c2.scheduled_exit, n_seconds, now=
);
> It is always `c->options.scheduled_exit_interval` which is always 5 at th=
e moment.
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9457f005f4ba970502e6b667d9dc4299a588d661
Gerrit-Change-Number: 555
Gerrit-PatchSet: 2
Gerrit-Owner: reynir <reynir@...2756...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: reynir <reynir@...2756...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: reynir <reynir@...2756...>
Gerrit-Comment-Date: Wed, 24 Apr 2024 12:13:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: reynir <reynir@...2756...>
Gerrit-MessageType: comment

--wM5Bg5lGcug=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, reynir. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/555/comment/090e8b75_da780d6c">Patch Set #1, Line 523=
:</a> <code style=3D"font-family:monospace,monospace">     * only ever seem=
s to be SIGTERM anyway. */</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">I also considered dropping=
 the `signal` argument as it is currently always `SIGTERM` at all call sit =
[=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/555/comment/01a64bab_9f4236b8">Patch Set #1, Line 525:</a> <code style=
=3D"font-family:monospace,monospace">        return;</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
You might want to consider changing the function to return a boolean to ind=
icate whether it did anyt [=E2=80=A6]</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/555/comment/123d7f7a_5b2bfd6a">Patch Set #1, L=
ine 530:</a> <code style=3D"font-family:monospace,monospace">    event_time=
out_init(&amp;c-&gt;c2.scheduled_exit, n_seconds, now);</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">It is always `c-&gt;options.scheduled_exit_interval` which is always 5 a=
t the moment.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail">change 555</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/555?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9457f005f4ba970502e6b667d9d=
c4299a588d661 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 555 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: reynir &lt;reynir@...2756...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 24 Apr 2024 12:13:13=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: reynir &lt;reynir@...2800...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--wM5Bg5lGcug=--

