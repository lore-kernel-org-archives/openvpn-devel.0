From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 16 Oct 2024 14:06:07 +0000
In-Reply-To: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
References: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net, a@...2181...
Message-ID: <7260010127fceb9d9977977bc88eebe3ebe5b0e5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6EFAd4d1Q2M="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: allow user to
 specify 'local' multiple times in config files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6EFAd4d1Q2M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, ordex, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/436?usp=3Demail )

Change subject: allow user to specify 'local' multiple times in config files
......................................................................


Patch Set 5: Code-Review-1

(7 comments)

File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/82b9206f_257c5965 :
PS5, Line 114:   0.0.0.0 or :: can be used to specifically open a socket.
Sentence does end in the middle?


http://gerrit.openvpn.net/c/openvpn/+/436/comment/729f1acd_879715ca :
PS5, Line 117: or name
Should probably say "default TCP/UDP port number" or something like that an=
d mention that this can be overridden by individual --local entries.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/e215e510_be593b03 :
PS5, Line 2400:      * Sanity check on daemon mode
Not sure what daemon is supposed to mean in this context?


http://gerrit.openvpn.net/c/openvpn/+/436/comment/7f064a0d_b60cd452 :
PS5, Line 3198:     if (ce->proto =3D=3D PROTO_UDP && ce->socks_proxy_serve=
r && !ce->local_list && !ce->local_port_defined && !ce->bind_defined)
Should use need_bind to simplify the condition.


http://gerrit.openvpn.net/c/openvpn/+/436/comment/09c9c53d_d50c5988 :
PS5, Line 3327: options_postprocess_mutate_le(struct options *o, struct loc=
al_entry *le)
should maybe take o->ce as input and not o, just to make clear that it does=
n't need the rest?


http://gerrit.openvpn.net/c/openvpn/+/436/comment/5052e26b_a665c5df :
PS5, Line 6247:         if (strcmp(p[1], "*") !=3D 0)
should we issue a warning if someone specifies "--local *" without port num=
ber that this is a NOOP?


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/c0b1d821_0f10076d :
PS5, Line 358: options
either this should use "l" or the definition of "l" should be removed compl=
etely.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Gerrit-Change-Number: 436
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: its_Giaan <gianmarco@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 16 Oct 2024 14:06:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--6EFAd4d1Q2M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, ordex, plaisthos. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail">Vi=
ew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/link-opti=
ons.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/436/comment/82b9206f_257c5965">Patch Set =
#5, Line 114:</a> <code style=3D"font-family:monospace,monospace">  0.0.0.0=
 or :: can be used to specifically open a socket.</code></p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Sentence does end in the middle=
?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436/comment/=
729f1acd_879715ca">Patch Set #5, Line 117:</a> <code style=3D"font-family:m=
onospace,monospace">or name</code></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Should probably say &quot;default TCP/UDP port number=
&quot; or something like that and mention that this can be overridden by in=
dividual --local entries.</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436/comment/e=
215e510_be593b03">Patch Set #5, Line 2400:</a> <code style=3D"font-family:m=
onospace,monospace">     * Sanity check on daemon mode</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Not sure what daemon is =
supposed to mean in this context?</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/436/comment/7f064a0d_b60cd452">Patch Set #5, Line 3198:=
</a> <code style=3D"font-family:monospace,monospace">    if (ce-&gt;proto =
=3D=3D PROTO_UDP &amp;&amp; ce-&gt;socks_proxy_server &amp;&amp; !ce-&gt;lo=
cal_list &amp;&amp; !ce-&gt;local_port_defined &amp;&amp; !ce-&gt;bind_defi=
ned)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">S=
hould use need_bind to simplify the condition.</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/436/comment/09c9c53d_d50c5988">Patch Set #=
5, Line 3327:</a> <code style=3D"font-family:monospace,monospace">options_p=
ostprocess_mutate_le(struct options *o, struct local_entry *le)</code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">should maybe take=
 o-&gt;ce as input and not o, just to make clear that it doesn&#39;t need t=
he rest?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436/c=
omment/5052e26b_a665c5df">Patch Set #5, Line 6247:</a> <code style=3D"font-=
family:monospace,monospace">        if (strcmp(p[1], &quot;*&quot;) !=3D 0)=
</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">shoul=
d we issue a warning if someone specifies &quot;--local *&quot; without por=
t number that this is a NOOP?</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/socket.c:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436/commen=
t/c0b1d821_0f10076d">Patch Set #5, Line 358:</a> <code style=3D"font-family=
:monospace,monospace">options</code></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">either this should use &quot;l&quot; or the definit=
ion of &quot;l&quot; should be removed completely.</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=
=3Demail">change 436</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20a=
dde09529e2764 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 436 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: its_Giaan &lt;gianmarco@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 16 Oct 2024 14:06:07=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--6EFAd4d1Q2M=--

