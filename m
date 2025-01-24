From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 24 Jan 2025 08:00:10 +0000
In-Reply-To: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
References: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <bf316bd85a8fd81592fa9d8eda7462990c436f5d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ERSnRmIa2Jo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mroute: adapt to new
 protocol handling and hashing improvements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ERSnRmIa2Jo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/765?usp=3Demail )

Change subject: mroute: adapt to new protocol handling and hashing improvem=
ents
......................................................................


Patch Set 14: Code-Review-2

(8 comments)

Patchset:

PS14:
There is a couple of things that need looking at

- the forward.c hunk should go to a patch in the series that actually deals=
 with socket arrays, and also very very closely checked for correctness
- the `proto` initialization in the maddr could be done in a more elegant w=
ay
- `mroute_addr_hash_len()` needs to be fixed


File src/openvpn/forward.c:

http://gerrit.openvpn.net/c/openvpn/+/765/comment/3e5d8af2_a31c87b9 :
PS14, Line 1132:         for (int i =3D 0; i < c->c1.link_sockets_num; i++)
I assume this hunk is needed, but it's sort of "outside the scope of mroute=
 handling" (so should either move to #764 or be mentioned in the commit mes=
sage - I think "moving" is more reasonable).

Also I am not sure it is *correct* - if I read this correctly, the effect i=
s now

`if (!decrypt_status && we have *any* listening TCP socket) { SIGUSR1; }`

no?  As it's walking the whole array, not checking the socket where this pa=
cket was received.


http://gerrit.openvpn.net/c/openvpn/+/765/comment/35afcb51_f6ae0b38 :
PS14, Line 1135:                 /* on the instance context we have only on=
e socket, so just check the first one */
whatever the outcome is, this comment is no longer correct :-)


File src/openvpn/mroute.h:

http://gerrit.openvpn.net/c/openvpn/+/765/comment/cad156ad_89f96d93 :
PS14, Line 225:     return (uint32_t) a->len + 2;
if you change the start of the to-be-hashed block, but all the existing dat=
a should still be hashed, this looks like you also must increase the length=
 by +1?


File src/openvpn/mudp.c:

http://gerrit.openvpn.net/c/openvpn/+/765/comment/7a2c3469_2b108655 :
PS14, Line 196:     m->local.proto =3D real.proto;
This is a bit confusing.  I can see the assignment to `real.proto` (because=
 mroute_extract_openvpn_sockaddr() cannot do it) but what is `m->local`, an=
d who is poulating the rest of it?


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/765/comment/ff5809d5_e5708d45 :
PS14, Line 1156:                                    struct mroute_addr *add=
r,
this looks wrong.  A lookup function should not modify its arguments.

I see calls to `multi_get_instance_by_virtual_addr()` being prepared by `mr=
oute_extract_addr_from_packet()` calls - so if that function sets `proto =
=3D 0` (or just `CLEAR()`s the mroutes) we do not need to do anything here.


http://gerrit.openvpn.net/c/openvpn/+/765/comment/8164b377_9ec4fcaa :
PS14, Line 3356:
see comment above - now you're actually setting `proto` in the caller, even=
 if I do not agree this is the right place - so the change to `multi_get_in=
stance_by_virtual_addr()` is definitely not needed.

I'd still move this into `mroute_extract_addr_from_packet()`, with the comm=
ent.


http://gerrit.openvpn.net/c/openvpn/+/765/comment/81dba5d2_42f25dc3 :
PS14, Line 3561:         dest.proto =3D src.proto;
same thing -> `mroute_extract_addr_from_packet()`



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab
Gerrit-Change-Number: 765
Gerrit-PatchSet: 14
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Fri, 24 Jan 2025 08:00:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--ERSnRmIa2Jo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>Patch set 14:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail">V=
iew Change</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/765?tab=3Dcomments">Patch Set #14:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">There is a couple of things that need looki=
ng at</p><ul><li>the forward.c hunk should go to a patch in the series that=
 actually deals with socket arrays, and also very very closely checked for =
correctness</li><li>the `proto` initialization in the maddr could be done i=
n a more elegant way</li><li>`mroute_addr_hash_len()` needs to be fixed</li=
></ul></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openv=
pn/forward.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/765/comment/3e5d8af2_a31c87b9">Patch=
 Set #14, Line 1132:</a> <code style=3D"font-family:monospace,monospace">  =
      for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">I assume this hunk=
 is needed, but it&#39;s sort of &quot;outside the scope of mroute handling=
&quot; (so should either move to #764 or be mentioned in the commit message=
 - I think &quot;moving&quot; is more reasonable).</p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Also I am not sure it is *correct* - =
if I read this correctly, the effect is now</p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">`if (!decrypt_status &amp;&amp; we have *any=
* listening TCP socket) { SIGUSR1; }`</p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">no?  As it&#39;s walking the whole array, not chec=
king the socket where this packet was received.</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/765/comment/35afcb51_f6ae0b38">Patch Set =
#14, Line 1135:</a> <code style=3D"font-family:monospace,monospace">       =
         /* on the instance context we have only one socket, so just check =
the first one */</code></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">whatever the outcome is, this comment is no longer correct :-)</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/m=
route.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/765/comment/cad156ad_89f96d93">Patch Set =
#14, Line 225:</a> <code style=3D"font-family:monospace,monospace">    retu=
rn (uint32_t) a-&gt;len + 2;</code></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">if you change the start of the to-be-hashed block, b=
ut all the existing data should still be hashed, this looks like you also m=
ust increase the length by +1?</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/mudp.c:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/765/comment=
/7a2c3469_2b108655">Patch Set #14, Line 196:</a> <code style=3D"font-family=
:monospace,monospace">    m-&gt;local.proto =3D real.proto;</code></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">This is a bit confusi=
ng.  I can see the assignment to `real.proto` (because mroute_extract_openv=
pn_sockaddr() cannot do it) but what is `m-&gt;local`, and who is poulating=
 the rest of it?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File src/openvpn/multi.c:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/765/comment/ff5809d5_e57=
08d45">Patch Set #14, Line 1156:</a> <code style=3D"font-family:monospace,m=
onospace">                                   struct mroute_addr *addr,</cod=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">this looks=
 wrong.  A lookup function should not modify its arguments.</p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">I see calls to `multi_get_in=
stance_by_virtual_addr()` being prepared by `mroute_extract_addr_from_packe=
t()` calls - so if that function sets `proto =3D 0` (or just `CLEAR()`s the=
 mroutes) we do not need to do anything here.</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/765/comment/8164b377_9ec4fcaa">Patch Set #1=
4, Line 3356:</a> <code style=3D"font-family:monospace,monospace"></code></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">see comment ab=
ove - now you&#39;re actually setting `proto` in the caller, even if I do n=
ot agree this is the right place - so the change to `multi_get_instance_by_=
virtual_addr()` is definitely not needed.</p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">I&#39;d still move this into `mroute_extract_a=
ddr_from_packet()`, with the comment.</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/765/comment/81dba5d2_42f25dc3">Patch Set #14, Line =
3561:</a> <code style=3D"font-family:monospace,monospace">        dest.prot=
o =3D src.proto;</code></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">same thing -&gt; `mroute_extract_addr_from_packet()`</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/765?usp=3Demail">change 765</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic66eccb5058fe9c0fae64d8e2ca=
88728068a92ab </div>
<div style=3D"display:none"> Gerrit-Change-Number: 765 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jan 2025 08:00:10=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ERSnRmIa2Jo=--

