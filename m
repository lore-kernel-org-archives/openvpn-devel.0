From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 23 Jan 2025 15:22:20 +0000
In-Reply-To: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
References: <gerrit.1700055887000.I4d1c96662c5a8c750d883e3b20adde09529e2764@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <005a503db71e8dfa16b758e92c019c9c4e9990ab-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YqZslSHi58w="; charset=UTF-8
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

--YqZslSHi58w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/436?usp=3Demail )

Change subject: allow user to specify 'local' multiple times in config files
......................................................................


Patch Set 11:

(4 comments)

Patchset:

PS11:
A few comments to look at, but at this point I'd say "fix the manpage and s=
hip" ;-)


File doc/man-sections/link-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/5e7f4c84_d49c3a9f :
PS11, Line 124:   open a socket.
As discussed on IRC, this is still a bit unclear / a leftover from earlier =
versions.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/436/comment/87b58fcf_5e96bec6 :
PS11, Line 2485:         if (le->local && !ce->bind_local)
I do wonder if we really need to check this for every entry in the local_li=
st, or checking it once (`if ( ce->local_list && !ce->bind_local )`) would =
be sufficient...  but this is not really important.


http://gerrit.openvpn.net/c/openvpn/+/436/comment/9744ee88_ecea7af7 :
PS11, Line 3780:             options_postprocess_mutate_le(o->ce, o->ce.loc=
al_list->array[i]);
I guess that this is preparations for one of the later patches?  For the si=
mple case having an extra function 420 lines further up in the code seems m=
ore complicated then necessary.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20adde09529e2764
Gerrit-Change-Number: 436
Gerrit-PatchSet: 11
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
Gerrit-Comment-Date: Thu, 23 Jan 2025 15:22:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--YqZslSHi58w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
436?tab=3Dcomments">Patch Set #11:</a> </p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">A few comments to look at, but at this point I&#=
39;d say &quot;fix the manpage and ship&quot; ;-)</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File doc/man-sections/link-options.rst:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/436/comment/5e7f4c84_d49c3a9f">Patch Set #11, Line 1=
24:</a> <code style=3D"font-family:monospace,monospace">  open a socket.</c=
ode></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">As discu=
ssed on IRC, this is still a bit unclear / a leftover from earlier versions=
.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvp=
n/options.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/436/comment/87b58fcf_5e96bec6">Patch =
Set #11, Line 2485:</a> <code style=3D"font-family:monospace,monospace">   =
     if (le-&gt;local &amp;&amp; !ce-&gt;bind_local)</code></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">I do wonder if we really nee=
d to check this for every entry in the local_list, or checking it once (`if=
 ( ce-&gt;local_list &amp;&amp; !ce-&gt;bind_local )`) would be sufficient.=
..  but this is not really important.</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/436/comment/9744ee88_ecea7af7">Patch Set #11, Line =
3780:</a> <code style=3D"font-family:monospace,monospace">            optio=
ns_postprocess_mutate_le(o-&gt;ce, o-&gt;ce.local_list-&gt;array[i]);</code=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I guess tha=
t this is preparations for one of the later patches?  For the simple case h=
aving an extra function 420 lines further up in the code seems more complic=
ated then necessary.</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/436?usp=3Demail">change 436</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/436?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d1c96662c5a8c750d883e3b20a=
dde09529e2764 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 436 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 23 Jan 2025 15:22:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--YqZslSHi58w=--

