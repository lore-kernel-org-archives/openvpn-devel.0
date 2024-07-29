From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 29 Jul 2024 11:33:54 +0000
In-Reply-To: <gerrit.1717673612000.I6662605b60d4859949970cfe256c55cbcbd4a672@...2715...>
References: <gerrit.1717673612000.I6662605b60d4859949970cfe256c55cbcbd4a672@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a17e07ee313b4a7a3db16690b0735dca701f8f7b-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kGtMlUVmqbc="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Lay the foundation
 to support both old and new versions of DCO
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

--kGtMlUVmqbc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/662?usp=3Demail )

Change subject: Lay the foundation to support both old and new versions of =
DCO
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
Summing up the intermediate discussions on IRC

13:32 <@cron2> ordex, gianm: wrt https://gerrit.openvpn.net/c/openvpn/+/662=
 -
               do I remember correctly that we went for "we will at some po=
int
               do a cut-over, and who wants to use dco_v2 needs to use 2.6,=
 and
               master will only support dco_v3 / ovpn"?
13:32 <@ordex> Giaan: ^
13:33 <@ordex> cron2: correct
13:33 <@ordex> that's the final decision
13:33 <@cron2> in that case, I think 662 can be abandoned and we'll see a n=
ew
               patch that does the renaming + code change, but no if() and =
no
               function pointers :-)
13:33 <@ordex> so we don't need abstraction layers or function pointers any=
more
13:33 <@cron2> \o/
13:33 <@ordex> correct
13:33 <@ordex> Giaan will publish that patch later on, once v3 will be ready
               for dev use



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/662?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6662605b60d4859949970cfe256c55cbcbd4a672
Gerrit-Change-Number: 662
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 29 Jul 2024 11:33:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--kGtMlUVmqbc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/662?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/6=
62?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Summing up the intermediate discussions on IRC</p>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">13:=
32 &lt;@cron2&gt; ordex, gianm: wrt https://gerrit.openvpn.net/c/openvpn/+/=
662 - <br>               do I remember correctly that we went for &quot;we =
will at some point <br>               do a cut-over, and who wants to use d=
co_v2 needs to use 2.6, and <br>               master will only support dco=
_v3 / ovpn&quot;?<br>13:32 &lt;@ordex&gt; Giaan: ^<br>13:33 &lt;@ordex&gt; =
cron2: correct<br>13:33 &lt;@ordex&gt; that&#39;s the final decision<br>13:=
33 &lt;@cron2&gt; in that case, I think 662 can be abandoned and we&#39;ll =
see a new <br>               patch that does the renaming + code change, bu=
t no if() and no <br>               function pointers :-)<br>13:33 &lt;@ord=
ex&gt; so we don&#39;t need abstraction layers or function pointers anymore=
<br>13:33 &lt;@cron2&gt; \o/<br>13:33 &lt;@ordex&gt; correct<br>13:33 &lt;@=
ordex&gt; Giaan will publish that patch later on, once v3 will be ready <br=
>               for dev use</pre></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/662?usp=3Demail">change 662</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/662?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6662605b60d4859949970cfe256=
c55cbcbd4a672 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 662 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 29 Jul 2024 11:33:54=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--kGtMlUVmqbc=--

