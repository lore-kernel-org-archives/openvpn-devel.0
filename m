From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 22 Apr 2024 11:46:20 +0000
In-Reply-To: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
References: <gerrit.1713783920000.I9457f005f4ba970502e6b667d9dc4299a588d661@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, reynir@...2756...
Message-ID: <ab4432fecbed78638083532e3ff9b10f9a0a39d4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ceCjRPcfAiU="; charset=UTF-8
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
To: reynir <reynir@...2756...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ceCjRPcfAiU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, reynir.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/555?usp=3Demail )

Change subject: Only schedule_exit() once
......................................................................


Patch Set 1:

(2 comments)

File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/555/comment/832e9f3f_055cb4bc :
PS1, Line 525:         return;
You might want to consider changing the function to return a boolean to ind=
icate whether it did anything. `send_auth_failure` already does the same ch=
eck and could just use this one instead. And the other callers might also b=
enefit from not doing other actions if exit is already scheduled.


http://gerrit.openvpn.net/c/openvpn/+/555/comment/73f172e8_be13b424 :
PS1, Line 530:     event_timeout_init(&c->c2.scheduled_exit, n_seconds, now=
);
> I have only now thought of it: what if the new `n_seconds` is sooner than=
 the already scheduled exit [=E2=80=A6]
It is always `c->options.scheduled_exit_interval` which is always 5 at the =
moment.



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
Gerrit-Attention: reynir <reynir@...2756...>
Gerrit-Comment-Date: Mon, 22 Apr 2024 11:46:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: reynir <reynir@...2756...>
Gerrit-MessageType: comment

--ceCjRPcfAiU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, reynir. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/555/comment/832e9f3f_055cb4bc">Patch Set #1, Line 525:</a=
> <code style=3D"font-family:monospace,monospace">        return;</code></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">You might want =
to consider changing the function to return a boolean to indicate whether i=
t did anything. `send_auth_failure` already does the same check and could j=
ust use this one instead. And the other callers might also benefit from not=
 doing other actions if exit is already scheduled.</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/555/comment/73f172e8_be13b424">Patch S=
et #1, Line 530:</a> <code style=3D"font-family:monospace,monospace">    ev=
ent_timeout_init(&amp;c-&gt;c2.scheduled_exit, n_seconds, now);</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">I have only now thought of it: what if the new `n_seconds` is so=
oner than the already scheduled exit [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">It is always `c-&gt;opti=
ons.scheduled_exit_interval` which is always 5 at the moment.</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/555?usp=3Demail">change 555</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/555?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: reynir &lt;reynir@...2756...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 22 Apr 2024 11:46:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: reynir &lt;reynir@...2800...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ceCjRPcfAiU=--

