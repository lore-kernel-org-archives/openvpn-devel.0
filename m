From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 24 Sep 2024 15:07:23 +0000
In-Reply-To: <gerrit.1727014533000.I00209b880cfcedd93e28f97fc3941d8b85e095f3@...2715...>
References: <gerrit.1727014533000.I00209b880cfcedd93e28f97fc3941d8b85e095f3@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0f0ede79aaa02f18e6f4808002a88be7c0d53d86-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/1eIJMfV5Do="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Automatically enable
 --compress migrate on the server
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

--/1eIJMfV5Do=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/756?usp=3Demail )

Change subject: Automatically enable --compress migrate on the server
......................................................................


Patch Set 4:

(1 comment)

File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/756/comment/834676ef_0db434b3 :
PS4, Line 3456:         if (options->comp.alg =3D=3D COMP_ALG_LZO || option=
s->comp.alg =3D=3D COMP_ALG_LZO_NO)
I think you need to check for &&  !options->comp.flag & COMP_F_SWAP for COM=
P_ALG_LZO because otherwise we also enable this for copress lzo. Although t=
hose configs that have compress lzo will also have pushable ciphers, so I d=
on't think there isa config that will break. But I would say that is the sa=
me as compress lz4 enabling compress migrate.

btw. instead of introducing COMP_ALG_LZO_NO here you could test for=20

(options->comp.alg =3D=3D COMP_ALG_STUB && !options->comp.flag & COMP_F_SWA=
P)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/756?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00209b880cfcedd93e28f97fc3941d8b85e095f3
Gerrit-Change-Number: 756
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 24 Sep 2024 15:07:23 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--/1eIJMfV5Do=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/756?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/756/comment/834676ef_0db434b3">Patch Set #4, Line 3456:</a=
> <code style=3D"font-family:monospace,monospace">        if (options-&gt;c=
omp.alg =3D=3D COMP_ALG_LZO || options-&gt;comp.alg =3D=3D COMP_ALG_LZO_NO)=
</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">I thi=
nk you need to check for &amp;&amp;  !options-&gt;comp.flag &amp; COMP_F_SW=
AP for COMP_ALG_LZO because otherwise we also enable this for copress lzo. =
Although those configs that have compress lzo will also have pushable ciphe=
rs, so I don&#39;t think there isa config that will break. But I would say =
that is the same as compress lz4 enabling compress migrate.</p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">btw. instead of introducing =
COMP_ALG_LZO_NO here you could test for </p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">(options-&gt;comp.alg =3D=3D COMP_ALG_STUB &amp=
;&amp; !options-&gt;comp.flag &amp; COMP_F_SWAP)</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/756?usp=3De=
mail">change 756</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/756?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00209b880cfcedd93e28f97fc39=
41d8b85e095f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 756 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 24 Sep 2024 15:07:23=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--/1eIJMfV5Do=--

