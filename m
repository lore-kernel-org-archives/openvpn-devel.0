From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 16 Sep 2024 12:39:30 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <0533abe0108febd6a801abd82cad461c4a816ee2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eV/aMQHOsPo="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Support CIDR on
 options and extend netbits usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eV/aMQHOsPo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/739?usp=3Demail )

Change subject: Support CIDR on options and extend netbits usage
......................................................................


Patch Set 3:

(12 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/af57c291_7928346b :
PS3, Line 9: Add support for CIDR notation on all suitable options (client-=
nat,
Maybe give some more motivation here. Why is this good for users? Is the as=
sumption that this notation is easier to use for users?


Patchset:

PS3:
Finished with first pass over the whole change.


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/442c7c8d_d509e97e :
PS3, Line 324:     const in_addr_t default_netbits =3D IPV4_NETBITS_HOST;
unsigned int?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/49b38146_172bf62a :
PS3, Line 331:     const char *cidr =3D strchr(network, '/');
Would convert to bool here to make it clear purpose


http://gerrit.openvpn.net/c/openvpn/+/739/comment/9927b3a3_4809d0a7 :
PS3, Line 347: convert
Want to do a drive-by fix? "a a" -> "to an"?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/86ce371b_4860dec8 :
PS3, Line 1105: route
Maybe add a 0.0.0.0/1 and 128.0.0.0/1 to the comments just to make it sligh=
tly easier to read?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/f88439ab_4ecf8430 :
PS3, Line 1166: route (
Same (0.0.0.0/1 and 128.0.0.0/1) here.


http://gerrit.openvpn.net/c/openvpn/+/739/comment/77dbbd70_ab423838 :
PS3, Line 1456:
Maybe we could move this into the if block? Not sure why we would create it=
 otherwise?


File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/739/comment/cbb88db5_f07c3af6 :
PS3, Line 512:     const bool looks_like_netmask =3D addr && ((addr & 0xFF0=
00000) =3D=3D 0xFF000000);
Isn't this redundant? If addr is 0 the second part never matches anyway


http://gerrit.openvpn.net/c/openvpn/+/739/comment/79c39edc_b5bdb970 :
PS3, Line 524:
Shouldn't that be "&&" ?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/e80071f2_d2431db9 :
PS3, Line 562:             const in_addr_t public_net =3D public &netmask;
Add space after & ?


http://gerrit.openvpn.net/c/openvpn/+/739/comment/7d0d0823_03c88869 :
PS3, Line 591: &
Add space after &



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9
Gerrit-Change-Number: 739
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Mon, 16 Sep 2024 12:39:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--eV/aMQHOsPo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, ralf_lici. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">View C=
hange</a></p><p>12 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/739/comment/af57c291_7928346b">Patch Set #3, Line 9:</a> <code style=
=3D"font-family:monospace,monospace">Add support for CIDR notation on all s=
uitable options (client-nat,</code></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Maybe give some more motivation here. Why is this go=
od for users? Is the assumption that this notation is easier to use for use=
rs?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/739?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Finished with first pass ov=
er the whole change.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/route.c:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/442c7c8d=
_d509e97e">Patch Set #3, Line 324:</a> <code style=3D"font-family:monospace=
,monospace">    const in_addr_t default_netbits =3D IPV4_NETBITS_HOST;</cod=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">unsigned i=
nt?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/commen=
t/49b38146_172bf62a">Patch Set #3, Line 331:</a> <code style=3D"font-family=
:monospace,monospace">    const char *cidr =3D strchr(network, &#39;/&#39;)=
;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Woul=
d convert to bool here to make it clear purpose</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/739/comment/9927b3a3_4809d0a7">Patch Set =
#3, Line 347:</a> <code style=3D"font-family:monospace,monospace">convert</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Want to=
 do a drive-by fix? &quot;a a&quot; -&gt; &quot;to an&quot;?</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/86ce371b_4860dec=
8">Patch Set #3, Line 1105:</a> <code style=3D"font-family:monospace,monosp=
ace">route</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Maybe add a 0.0.0.0/1 and 128.0.0.0/1 to the comments just to make it =
slightly easier to read?</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/739/comment/f88439ab_4ecf8430">Patch Set #3, Line 1166:</a> <cod=
e style=3D"font-family:monospace,monospace">route (</code></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Same (0.0.0.0/1 and 128.0.0.0=
/1) here.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/=
comment/77dbbd70_ab423838">Patch Set #3, Line 1456:</a> <code style=3D"font=
-family:monospace,monospace">  </code></p><p style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Maybe we could move this into the if block? Not s=
ure why we would create it otherwise?</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/tun.c:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739/c=
omment/cbb88db5_f07c3af6">Patch Set #3, Line 512:</a> <code style=3D"font-f=
amily:monospace,monospace">    const bool looks_like_netmask =3D addr &amp;=
&amp; ((addr &amp; 0xFF000000) =3D=3D 0xFF000000);</code></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Isn&#39;t this redundant? If a=
ddr is 0 the second part never matches anyway</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/739/comment/79c39edc_b5bdb970">Patch Set #3=
, Line 524:</a> <code style=3D"font-family:monospace,monospace">  </code></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Shouldn&#39;t =
that be &quot;&amp;&amp;&quot; ?</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/739/comment/e80071f2_d2431db9">Patch Set #3, Line 562:</=
a> <code style=3D"font-family:monospace,monospace">            const in_add=
r_t public_net =3D public &amp;netmask;</code></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Add space after &amp; ?</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/739/comment/7d0d0823_03c88869">=
Patch Set #3, Line 591:</a> <code style=3D"font-family:monospace,monospace"=
>&amp;</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Add space after &amp;</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">change 739</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/739?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9=
a766c9604efc9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 739 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Sep 2024 12:39:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--eV/aMQHOsPo=--

