From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 12 Dec 2025 13:44:27 +0000
References: <gerrit.1765547061000.Idd79f7cbd38e8b0831f15866339c3677a367cd49@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <499a6ae8e432a4e52a012c05d45af1f70aa3d940-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F9AnpNhv+vk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--F9AnpNhv+vk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1439?usp=3Demail

to review the following change.


Change subject: schedule: Rework documentation for schedule_add_entry
......................................................................

schedule: Rework documentation for schedule_add_entry

The previous documentation was very misleading and made
it hard to understand how the sigma parameter is used.

Rewrite it so that it better reflects the actual
implementation.

Change-Id: Idd79f7cbd38e8b0831f15866339c3677a367cd49
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/schedule.h
1 file changed, 20 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1439/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idd79f7cbd38e8b0831f15866339c3677a367cd49
Gerrit-Change-Number: 1439
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--F9AnpNhv+vk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1439?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">schedule: Rework documentation for schedule=
_add_entry<br><br>The previous documentation was very misleading and made<b=
r>it hard to understand how the sigma parameter is used.<br><br>Rewrite it =
so that it better reflects the actual<br>implementation.<br><br>Change-Id: =
Idd79f7cbd38e8b0831f15866339c3677a367cd49<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/schedule.h<br>1 file ch=
anged, 20 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/1439/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h</span><br><span>i=
ndex 79311c5..3e2a2ad 100644</span><br><span>--- a/src/openvpn/schedule.h</=
span><br><span>+++ b/src/openvpn/schedule.h</span><br><span>@@ -81,17 +81,2=
6 @@</span><br><span> </span><br><span> /* Public inline functions */</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Add a struct schedule_ent=
ry (whose storage is managed by</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * caller) to the btree.  tv signifies the wakeup time for</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * a future event.  sigma is=
 a time interval measured</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * in microseconds -- the event window being represented</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * starts at (tv - sigma) and ends a=
t (tv + sigma).</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Eve=
nt signaling can occur anywere within this interval.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Making the interval larger makes the sch=
eduler more efficient,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * while making it smaller results in more precise scheduling.</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * The caller should treat the pa=
ssed struct schedule_entry as</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * an opaque object.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Add =
a struct schedule_entry to the scheduler btree or</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * update an existing entry with a new wakeup=
 time.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @p sigma is only used when =
the entry is already present</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * in the schedule. If the originally scheduled time and the new</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * time are within @p=
 sigma microseconds of each other then the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * entry is not rescheduled and will occur at the or=
iginal time.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * When=
 adding a new entry @p sigma will be ignored.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param s     scheduler tree</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param e     entry to add to the schedule</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param tv    wakeup time fo=
r the entry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m sigma window size for the event in microseconds</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @note The caller should treat @p e as opaque data. Only</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the scheduler functi=
ons should change the object. The</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * caller is expected to manage the memory for the object</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and must only free i=
t once it has been removed from the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * schedule.</span><br><span>  */</span><br><span> static i=
nline void</span><br><span> schedule_add_entry(struct schedule *s, struct s=
chedule_entry *e, const struct timeval *tv,</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1439?u=
sp=3Demail">change 1439</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1439?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idd79f7cbd38e8b0831f15866339=
c3677a367cd49 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1439 </div>
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

--F9AnpNhv+vk=--

