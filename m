From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 24 Oct 2025 16:52:50 +0000
References: <gerrit.1761324750000.I6bc3147d10ca50291110335cd9fc3be961280c1b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c59db43ab03d97b7f9f4948c76778521b6247924-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qo/L/eUFLiw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Change update
 argument of compute_earliest_wakeup to time_t
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

--qo/L/eUFLiw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1299?usp=3Demail

to review the following change.


Change subject: ssl: Change update argument of compute_earliest_wakeup to t=
ime_t
......................................................................

ssl: Change update argument of compute_earliest_wakeup to time_t

Since we usually input a diff of two time_t values here
the input value will be officially time_t. So avoid
conversion warnings at almost every caller site.

We can safely cast it to interval_t here because we
checked that it is smaller than the interval_t value
earliest. And all negative values are treated equal,
so exact value doesn't matter.

Change-Id: I6bc3147d10ca50291110335cd9fc3be961280c1b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl.c
1 file changed, 7 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/1299/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 54b69ea..925c5af 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1108,11 +1108,11 @@
  * called again.
  */
 static inline void
-compute_earliest_wakeup(interval_t *earliest, interval_t seconds_from_now)
+compute_earliest_wakeup(interval_t *earliest, time_t seconds_from_now)
 {
     if (seconds_from_now < *earliest)
     {
-        *earliest =3D seconds_from_now;
+        *earliest =3D (interval_t)seconds_from_now;
     }
     if (*earliest < 0)
     {
@@ -1120,11 +1120,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Return true if "lame duck" or retiring key has expired and can
  * no longer be used.
@@ -1786,6 +1781,11 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static bool
 write_string(struct buffer *buf, const char *str, const int maxlen)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1299?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6bc3147d10ca50291110335cd9fc3be961280c1b
Gerrit-Change-Number: 1299
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--qo/L/eUFLiw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1299?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl: Change update argument of compute_earl=
iest_wakeup to time_t<br><br>Since we usually input a diff of two time_t va=
lues here<br>the input value will be officially time_t. So avoid<br>convers=
ion warnings at almost every caller site.<br><br>We can safely cast it to i=
nterval_t here because we<br>checked that it is smaller than the interval_t=
 value<br>earliest. And all negative values are treated equal,<br>so exact =
value doesn&#39;t matter.<br><br>Change-Id: I6bc3147d10ca50291110335cd9fc3b=
e961280c1b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>=
---<br>M src/openvpn/ssl.c<br>1 file changed, 7 insertions(+), 7 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/99/1299/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl.c b/src/open=
vpn/ssl.c</span><br><span>index 54b69ea..925c5af 100644</span><br><span>---=
 a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><spa=
n>@@ -1108,11 +1108,11 @@</span><br><span>  * called again.</span><br><span=
>  */</span><br><span> static inline void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-compute_earliest_wakeup(interval_t *earliest, interval_=
t seconds_from_now)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
compute_earliest_wakeup(interval_t *earliest, time_t seconds_from_now)</spa=
n><br><span> {</span><br><span>     if (seconds_from_now &lt; *earliest)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       *earliest =3D seconds_from_now;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        *earliest =3D (interval_t)seconds_from_now;</spa=
n><br><span>     }</span><br><span>     if (*earliest &lt; 0)</span><br><sp=
an>     {</span><br><span>@@ -1120,11 +1120,6 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quo=
t;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> /*</span><br><span>  * Return true if &quot;lame duck&quot; or retiring k=
ey has expired and can</span><br><span>  * no longer be used.</span><br><sp=
an>@@ -1786,6 +1781,11 @@</span><br><span>     return true;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wco=
nversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
static bool</span><br><span> write_string(struct buffer *buf, const char *s=
tr, const int maxlen)</span><br><span> {</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1299?usp=
=3Demail">change 1299</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1299?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6bc3147d10ca50291110335cd9f=
c3be961280c1b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1299 </div>
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

--qo/L/eUFLiw=--

