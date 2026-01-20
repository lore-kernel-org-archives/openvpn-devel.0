From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 20 Jan 2026 12:19:50 +0000
References: <gerrit.1768911587000.Iac4af315c6d7798f09a27383fc0a755a874b9881@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0c5febadbaf32966026b319129a40816fc83ebce-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VCzoEmnO/Vs="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: reliable: Avoid
 conversion warning in reliable_send_timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VCzoEmnO/Vs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1480?usp=3Demail

to review the following change.


Change subject: reliable: Avoid conversion warning in reliable_send_timeout
......................................................................

reliable: Avoid conversion warning in reliable_send_timeout

It is not realistic that this produced big values
and we already discard negative values. So just use
whatever we get.

Change-Id: Iac4af315c6d7798f09a27383fc0a755a874b9881
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/reliable.c
1 file changed, 1 insertion(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1480/1

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 52adacf..690e50d 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -687,11 +687,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /* in how many seconds should we wake up to check for timeout */
 /* if we return BIG_TIMEOUT, nothing to wait for */
 interval_t
@@ -713,7 +708,7 @@
             }
             else
             {
-                ret =3D min_int(ret, e->next_try - local_now);
+                ret =3D min_int(ret, (int)(e->next_try - local_now));
             }
         }
     }
@@ -724,10 +719,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Enable an incoming buffer previously returned by a get function as acti=
ve.
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1480?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iac4af315c6d7798f09a27383fc0a755a874b9881
Gerrit-Change-Number: 1480
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--VCzoEmnO/Vs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1480?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">reliable: Avoid conversion warning in relia=
ble_send_timeout<br><br>It is not realistic that this produced big values<b=
r>and we already discard negative values. So just use<br>whatever we get.<b=
r><br>Change-Id: Iac4af315c6d7798f09a27383fc0a755a874b9881<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/reliab=
le.c<br>1 file changed, 1 insertion(+), 10 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/148=
0/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c</s=
pan><br><span>index 52adacf..690e50d 100644</span><br><span>--- a/src/openv=
pn/reliable.c</span><br><span>+++ b/src/openvpn/reliable.c</span><br><span>=
@@ -687,11 +687,6 @@</span><br><span>     }</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* in how many seconds sh=
ould we wake up to check for timeout */</span><br><span> /* if we return BI=
G_TIMEOUT, nothing to wait for */</span><br><span> interval_t</span><br><sp=
an>@@ -713,7 +708,7 @@</span><br><span>             }</span><br><span>     =
        else</span><br><span>             {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                ret =3D min_int(ret, e-&gt;next_try -=
 local_now);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         ret =3D min_int(ret, (int)(e-&gt;next_try - local_now));</span><br=
><span>             }</span><br><span>         }</span><br><span>     }</sp=
an><br><span>@@ -724,10 +719,6 @@</span><br><span>     return ret;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Enable an incom=
ing buffer previously returned by a get function as active.</span><br><span=
>  */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1480?usp=3Demail">change 1480</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1480?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac4af315c6d7798f09a27383fc0=
a755a874b9881 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1480 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--VCzoEmnO/Vs=--

