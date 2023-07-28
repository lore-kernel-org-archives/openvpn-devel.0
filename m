From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 28 Jul 2023 13:03:30 +0000
References: <gerrit.1690549401000.I78f92f363fe203af5661c6958b2417ea30f7055c@...2715...>
Reply-To: frank@...2641..., openvpn-devel@lists.sourceforge.net
Message-ID: <60951251cdb2f39b20cfc86130c2dc0570ba0363-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DbgGbkDkUgE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: Fix
 overriding return value of add_route3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DbgGbkDkUgE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has uploaded this change for review. ( http://gerrit.openvpn.n=
et/c/openvpn/+/319?usp=3Demail )


Change subject: route: Fix overriding return value of add_route3
......................................................................

route: Fix overriding return value of add_route3

The return value of add_bypass_routes overwrites
the return value of add_route3 instead of combining
them.

Coverity: CID 1539180 (#1 of 1): Unused value (UNUSED_VALUE)

Change-Id: I78f92f363fe203af5661c6958b2417ea30f7055c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/route.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/319/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 90e981e..9212186 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1062,7 +1062,7 @@

             /* route DHCP/DNS server traffic through original default gate=
way */
             ret =3D add_bypass_routes(&rl->spec.bypass, rl->rgi.gateway.ad=
dr, tt, flags,
-                                    &rl->rgi, es, ctx);
+                                    &rl->rgi, es, ctx) && ret;

             if (rl->flags & RG_REROUTE_GW)
             {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/319?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I78f92f363fe203af5661c6958b2417ea30f7055c
Gerrit-Change-Number: 319
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newchange

--DbgGbkDkUgE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>flichtenheld has uploaded this change for <strong>review</strong>.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/319?usp=3Demail">View Cha=
nge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">route: Fix overriding return value of add_route3<br><br>The return =
value of add_bypass_routes overwrites<br>the return value of add_route3 ins=
tead of combining<br>them.<br><br>Coverity: CID 1539180 (#1 of 1): Unused v=
alue (UNUSED_VALUE)<br><br>Change-Id: I78f92f363fe203af5661c6958b2417ea30f7=
055c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br=
>M src/openvpn/route.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br>=
<br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/319/=
1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br>=
<span>index 90e981e..9212186 100644</span><br><span>--- a/src/openvpn/route=
.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -1062,7 +10=
62,7 @@</span><br><span> </span><br><span>             /* route DHCP/DNS se=
rver traffic through original default gateway */</span><br><span>          =
   ret =3D add_bypass_routes(&amp;rl-&gt;spec.bypass, rl-&gt;rgi.gateway.ad=
dr, tt, flags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                             &amp;rl-&gt;rgi, es, ctx);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                    &am=
p;rl-&gt;rgi, es, ctx) &amp;&amp; ret;</span><br><span> </span><br><span>  =
           if (rl-&gt;flags &amp; RG_REROUTE_GW)</span><br><span>          =
   {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/319?usp=3Demail">change 319</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/319?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I78f92f363fe203af5661c6958b2=
417ea30f7055c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 319 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--DbgGbkDkUgE=--

