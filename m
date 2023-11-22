From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 22 Nov 2023 23:12:06 +0000
References: <gerrit.1700694723000.Ia3d5b4946138df322ebcd9e9e77d04328dacbc5d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <251a58bea595df5748f67cb92e65dc74943aa174-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iIRV5Q0ffVU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix
 check_session_buf_not_used using wrong index
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

--iIRV5Q0ffVU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/459?usp=3Demail

to review the following change.


Change subject: Fix check_session_buf_not_used using wrong index
......................................................................

Fix check_session_buf_not_used using wrong index

The inner loop used i instead of j when iterating through the buffers.
Since i is always between 0 and 2 and ks->send_reliable->size is
(when it is defined) always 6 (TLS_RELIABLE_N_SEND_BUFFERS) this does not
cause an index of out bounds. So while the check is not doing anything
really useful with i instead of  j, it at least is not crashing or
anything similar.

Noticed-By: Jon Williams (braindead-bf) on Github issue #449
Change-Id: Ia3d5b4946138df322ebcd9e9e77d04328dacbc5d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/459/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 400230c..b5d24b5 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3207,7 +3207,7 @@

         for (int j =3D 0; j < ks->send_reliable->size; j++)
         {
-            if (ks->send_reliable->array[i].buf.data =3D=3D dataptr)
+            if (ks->send_reliable->array[j].buf.data =3D=3D dataptr)
             {
                 msg(M_INFO, "Warning buffer of freed TLS session is still =
in"
                     " use (session->key[%d].send_reliable->array[%d])",

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/459?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3d5b4946138df322ebcd9e9e77d04328dacbc5d
Gerrit-Change-Number: 459
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--iIRV5Q0ffVU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/459?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix check_session_buf_not_used using wrong index<br><br>The i=
nner loop used i instead of j when iterating through the buffers.<br>Since =
i is always between 0 and 2 and ks-&gt;send_reliable-&gt;size is<br>(when i=
t is defined) always 6 (TLS_RELIABLE_N_SEND_BUFFERS) this does not<br>cause=
 an index of out bounds. So while the check is not doing anything<br>really=
 useful with i instead of  j, it at least is not crashing or<br>anything si=
milar.<br><br>Noticed-By: Jon Williams (braindead-bf) on Github issue #449<=
br>Change-Id: Ia3d5b4946138df322ebcd9e9e77d04328dacbc5d<br>Signed-off-by: A=
rne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file=
 changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/59/459/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 400230c..b5d24b5 100644<=
/span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/s=
sl.c</span><br><span>@@ -3207,7 +3207,7 @@</span><br><span> </span><br><spa=
n>         for (int j =3D 0; j &lt; ks-&gt;send_reliable-&gt;size; j++)</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (ks-&gt;send_reliable-&gt;array[i].buf.data =3D=3D dataptr=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (ks=
-&gt;send_reliable-&gt;array[j].buf.data =3D=3D dataptr)</span><br><span>  =
           {</span><br><span>                 msg(M_INFO, &quot;Warning buf=
fer of freed TLS session is still in&quot;</span><br><span>                =
     &quot; use (session-&gt;key[%d].send_reliable-&gt;array[%d])&quot;,</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/459?usp=3Demail">change 459</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/459?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3d5b4946138df322ebcd9e9e77=
d04328dacbc5d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 459 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--iIRV5Q0ffVU=--

