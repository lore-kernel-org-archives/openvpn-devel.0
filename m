From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Dec 2024 19:04:42 +0000
In-Reply-To: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
References: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <e4256d9fc61fa9035e78fbeeb8178d89b443c5d2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IN3HbXzW5YA="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IN3HbXzW5YA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/436?usp=3Demail )

Change subject: allow user to specify 'local' multiple times in config files
......................................................................


Patch Set 10: Code-Review-1

(4 comments)

Patchset:

PS10:
This works, but I find the `local_list` structure in need of improvement.


File src/openvpn/options.h:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/b51da7c8_0ec98e70 :
PS10, Line 105:     struct local_list *local_list;
I do not like this data structure - having an extra indirection seems to se=
rve no good purpose (like, it's not actually a "list").

All the other new multisocket code just has a local array, and I think we s=
hould do the same thing here - that is:

`struct connection_entry
{
    struct local_entry *local_list;
    int local_list_len;
    ...
`

most of the remaining code will simplify itself (`ce->local_list->array[i]`=
 to `ce->local_list[i]` etc.) or will not care at all (if dealing with a `l=
e`).


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/b6ab664e_ab058053 :
PS10, Line 2476:             msg(M_USAGE, "--remote and a --local addresses=
 are the same");
`a local address`, singular :-) (or `one of the --local addresses`)

Dunno.  Something grammarly correct :-)


File src/openvpn/socket.c:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/fc6cd992_13935a2b :
PS10, Line 421:         for (int j =3D 0; j < ce->local_list->len; j++)
is this save against "no `--local` specified at all, list not initialized"?=
  The old code had an `if (ce->bind_local)` check here, for which I'm missi=
ng the equivalent



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Gerrit-Change-Number: 436
Gerrit-PatchSet: 10
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Mon, 30 Dec 2024 19:04:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--IN3HbXzW5YA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>Patch set 10:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/436?tab=3Dcomments">Patch Set #10:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">This works, but I find the `local_list` str=
ucture in need of improvement.</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/options.h:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436/comm=
ent/b51da7c8_0ec98e70">Patch Set #10, Line 105:</a> <code style=3D"font-fam=
ily:monospace,monospace">    struct local_list *local_list;</code></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">I do not like this da=
ta structure - having an extra indirection seems to serve no good purpose (=
like, it&#39;s not actually a &quot;list&quot;).</p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">All the other new multisocket code just=
 has a local array, and I think we should do the same thing here - that is:=
</p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>`struct connection_entry<br>{<br>    struct local_entry *local_list;<br>  =
  int local_list_len;<br>    ...<br>`</pre><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">most of the remaining code will simplify itself =
(`ce-&gt;local_list-&gt;array[i]` to `ce-&gt;local_list[i]` etc.) or will n=
ot care at all (if dealing with a `le`).</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/436/comment/b6ab664e_ab058053">Patch Set #10, Line 2476:</a> <code style=
=3D"font-family:monospace,monospace">            msg(M_USAGE, &quot;--remot=
e and a --local addresses are the same&quot;);</code></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">`a local address`, singular :-) (o=
r `one of the --local addresses`)</p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Dunno.  Something grammarly correct :-)</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/436/comment/fc6cd992_13935a2b">Patch Set #10, Line 421=
:</a> <code style=3D"font-family:monospace,monospace">        for (int j =
=3D 0; j &lt; ce-&gt;local_list-&gt;len; j++)</code></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">is this save against &quot;no `--lo=
cal` specified at all, list not initialized&quot;?  The old code had an `if=
 (ce-&gt;bind_local)` check here, for which I&#39;m missing the equivalent<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/436?usp=3Demail">change 436</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/43=
6?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20a=
dde09529e2764 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 436 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@...1664...=
26...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 30 Dec 2024 19:04:42=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--IN3HbXzW5YA=--

