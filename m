From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 15:31:16 +0000
In-Reply-To: <gerrit.1765547061000.Idd79f7cbd38e8b0831f15866339c3677a367cd49@...2715...>
References: <gerrit.1765547061000.Idd79f7cbd38e8b0831f15866339c3677a367cd49@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3b08b24abbc42017fde1000ea4b3e09b090fe56d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s7wvJB3jysE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: schedule: Rework
 documentation for schedule_add_entry
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

--s7wvJB3jysE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1439?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: schedule: Rework documentation for schedule_add_entry
......................................................................

schedule: Rework documentation for schedule_add_entry

The previous documentation was very misleading and made
it hard to understand how the sigma parameter is used.

Rewrite it so that it better reflects the actual
implementation.

Change-Id: Idd79f7cbd38e8b0831f15866339c3677a367cd49
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1439
Message-Id: <20251215144656.17299-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
070.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/schedule.h
1 file changed, 20 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1439/3

diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index 79311c5..3e2a2ad 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -81,17 +81,26 @@

 /* Public inline functions */

-/*
- * Add a struct schedule_entry (whose storage is managed by
- * caller) to the btree.  tv signifies the wakeup time for
- * a future event.  sigma is a time interval measured
- * in microseconds -- the event window being represented
- * starts at (tv - sigma) and ends at (tv + sigma).
- * Event signaling can occur anywere within this interval.
- * Making the interval larger makes the scheduler more efficient,
- * while making it smaller results in more precise scheduling.
- * The caller should treat the passed struct schedule_entry as
- * an opaque object.
+/**
+ * Add a struct schedule_entry to the scheduler btree or
+ * update an existing entry with a new wakeup time.
+ *
+ * @p sigma is only used when the entry is already present
+ * in the schedule. If the originally scheduled time and the new
+ * time are within @p sigma microseconds of each other then the
+ * entry is not rescheduled and will occur at the original time.
+ * When adding a new entry @p sigma will be ignored.
+ *
+ * @param s     scheduler tree
+ * @param e     entry to add to the schedule
+ * @param tv    wakeup time for the entry
+ * @param sigma window size for the event in microseconds
+ *
+ * @note The caller should treat @p e as opaque data. Only
+ * the scheduler functions should change the object. The
+ * caller is expected to manage the memory for the object
+ * and must only free it once it has been removed from the
+ * schedule.
  */
 static inline void
 schedule_add_entry(struct schedule *s, struct schedule_entry *e, const str=
uct timeval *tv,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1439?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idd79f7cbd38e8b0831f15866339c3677a367cd49
Gerrit-Change-Number: 1439
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--s7wvJB3jysE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1439?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">schedule: Rework documentation for =
schedule_add_entry<br><br>The previous documentation was very misleading an=
d made<br>it hard to understand how the sigma parameter is used.<br><br>Rew=
rite it so that it better reflects the actual<br>implementation.<br><br>Cha=
nge-Id: Idd79f7cbd38e8b0831f15866339c3677a367cd49<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1439<br>Me=
ssage-Id: &lt;20251215144656.17299-1-gert@...1296...&gt;<br>URL: https://ww=
w.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35070.html<br>Sig=
ned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/sc=
hedule.h<br>1 file changed, 20 insertions(+), 11 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
39/1439/3</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/schedule.h b/src/openvpn/schedul=
e.h</span><br><span>index 79311c5..3e2a2ad 100644</span><br><span>--- a/src=
/openvpn/schedule.h</span><br><span>+++ b/src/openvpn/schedule.h</span><br>=
<span>@@ -81,17 +81,26 @@</span><br><span> </span><br><span> /* Public inli=
ne functions */</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Add =
a struct schedule_entry (whose storage is managed by</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * caller) to the btree.  tv signifies the =
wakeup time for</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * a f=
uture event.  sigma is a time interval measured</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * in microseconds -- the event window being repr=
esented</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * starts at (=
tv - sigma) and ends at (tv + sigma).</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Event signaling can occur anywere within this interval.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Making the interval=
 larger makes the scheduler more efficient,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * while making it smaller results in more precise sc=
heduling.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The calle=
r should treat the passed struct schedule_entry as</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * an opaque object.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Add a struct schedule_entry to the scheduler btree or</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * update an existing en=
try with a new wakeup time.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p sig=
ma is only used when the entry is already present</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * in the schedule. If the originally schedul=
ed time and the new</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * time are within @p sigma microseconds of each other then the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * entry is not rescheduled and=
 will occur at the original time.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * When adding a new entry @p sigma will be ignored.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param s     scheduler tree</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param e     entry to add to th=
e schedule</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 tv    wakeup time for the entry</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param sigma window size for the event in microseconds</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @note The caller should treat @p e as =
opaque data. Only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 the scheduler functions should change the object. The</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * caller is expected to manage the memo=
ry for the object</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 and must only free it once it has been removed from the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * schedule.</span><br><span>  */</spa=
n><br><span> static inline void</span><br><span> schedule_add_entry(struct =
schedule *s, struct schedule_entry *e, const struct timeval *tv,</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1439?usp=3Demail">change 1439</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1439?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idd79f7cbd38e8b0831f15866339=
c3677a367cd49 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1439 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--s7wvJB3jysE=--

