From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 16 Nov 2025 22:02:26 +0000
In-Reply-To: <gerrit.1761324750000.I6bc3147d10ca50291110335cd9fc3be961280c1b@...2715...>
References: <gerrit.1761324750000.I6bc3147d10ca50291110335cd9fc3be961280c1b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d2d4550403543477dbdffb50486d0cce08a3a590-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZRDAHJThgUk="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZRDAHJThgUk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1299?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1299
Message-Id: <20251116183622.11727-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
482.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
1 file changed, 8 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/1299/6

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 2d24f5e..92a68d0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1107,11 +1107,11 @@
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
@@ -1119,11 +1119,6 @@
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
@@ -1338,7 +1333,7 @@
     /* For now we hardcode this to be 16 for the software based data chann=
el
      * DCO based implementations/HW implementation might adjust this number
      * based on their expected speed */
-    const int future_key_count =3D 16;
+    const uint8_t future_key_count =3D 16;

     int key_direction =3D server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_N=
ORMAL;
     struct key_direction_state kds;
@@ -1785,6 +1780,11 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6bc3147d10ca50291110335cd9fc3be961280c1b
Gerrit-Change-Number: 1299
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZRDAHJThgUk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1299?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">ssl: Change update argument of comp=
ute_earliest_wakeup to time_t<br><br>Since we usually input a diff of two t=
ime_t values here<br>the input value will be officially time_t. So avoid<br=
>conversion warnings at almost every caller site.<br><br>We can safely cast=
 it to interval_t here because we<br>checked that it is smaller than the in=
terval_t value<br>earliest. And all negative values are treated equal,<br>s=
o exact value doesn&#39;t matter.<br><br>Change-Id: I6bc3147d10ca5029111033=
5cd9fc3be961280c1b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https=
://gerrit.openvpn.net/c/openvpn/+/1299<br>Message-Id: &lt;20251116183622.11=
727-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg34482.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file changed, 8 insert=
ions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/99/1299/6</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 2d24f5e..92a68d0 10064=
4</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn=
/ssl.c</span><br><span>@@ -1107,11 +1107,11 @@</span><br><span>  * called a=
gain.</span><br><span>  */</span><br><span> static inline void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-compute_earliest_wakeup(interval_t=
 *earliest, interval_t seconds_from_now)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+compute_earliest_wakeup(interval_t *earliest, time_t s=
econds_from_now)</span><br><span> {</span><br><span>     if (seconds_from_n=
ow &lt; *earliest)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        *earliest =3D seconds_from_now;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        *earliest =3D (interval_t)s=
econds_from_now;</span><br><span>     }</span><br><span>     if (*earliest =
&lt; 0)</span><br><span>     {</span><br><span>@@ -1119,11 +1119,6 @@</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC di=
agnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> /*</span><br><span>  * Return true if &quot;lame duc=
k&quot; or retiring key has expired and can</span><br><span>  * no longer b=
e used.</span><br><span>@@ -1338,7 +1333,7 @@</span><br><span>     /* For n=
ow we hardcode this to be 16 for the software based data channel</span><br>=
<span>      * DCO based implementations/HW implementation might adjust this=
 number</span><br><span>      * based on their expected speed */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const int future_key_count =
=3D 16;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ui=
nt8_t future_key_count =3D 16;</span><br><span> </span><br><span>     int k=
ey_direction =3D server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;</sp=
an><br><span>     struct key_direction_state kds;</span><br><span>@@ -1785,=
6 +1780,11 @@</span><br><span>     return true;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool<=
/span><br><span> write_string(struct buffer *buf, const char *str, const in=
t maxlen)</span><br><span> {</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1299?usp=3Demail">cha=
nge 1299</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1299?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6bc3147d10ca50291110335cd9f=
c3be961280c1b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1299 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ZRDAHJThgUk=--

