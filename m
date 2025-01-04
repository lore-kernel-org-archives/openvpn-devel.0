From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 4 Jan 2025 22:52:10 +0000
References: <gerrit.1736031115000.Id1632e4e47f5a9019afecae60457634c4a3c4d31@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <70ededc245c6c214e5626dd879ac4297e55c3397-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UcyB++KQW6o="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: fixup! Add methods
 to read/write packet ids for epoch data
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

--UcyB++KQW6o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/850?usp=3Demail

to review the following change.


Change subject: fixup! Add methods to read/write packet ids for epoch data
......................................................................

fixup! Add methods to read/write packet ids for epoch data

Change-Id: Id1632e4e47f5a9019afecae60457634c4a3c4d31
---
M src/openvpn/packet_id.h
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/850/1

diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index e78d912..9c0f464 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -336,7 +336,7 @@
 /**
  * Writes the packet ID containing both the epoch and the packet id to the
  * buffer specified by buf.
- * @param p         packed id send structure to use for the packet id
+ * @param p         packet id send structure to use for the packet id
  * @param epoch     epoch to write to the packet
  * @param buf       buffer to write the packet id/epoch to
  * @return          false if the packet id space is exhausted and cannot b=
e written
@@ -347,7 +347,7 @@
 /**
  * Reads the packet ID containing both the epoch and the per-epoch counter
  * from the buf.  Will return 0 as epoch id if there is any error.
- * @param p       packet_id struct to popupulate with the on-wire counter
+ * @param p       packet_id struct to populate with the on-wire counter
  * @param buf     buffer to read the packet id from.
  * @return        0 for an error/invalid id, epoch otherwise
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/850?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id1632e4e47f5a9019afecae60457634c4a3c4d31
Gerrit-Change-Number: 850
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--UcyB++KQW6o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/850?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">fixup! Add methods to read/write packet ids for epoch data<br=
><br>Change-Id: Id1632e4e47f5a9019afecae60457634c4a3c4d31<br>---<br>M src/o=
penvpn/packet_id.h<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><b=
r></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/850/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h</spa=
n><br><span>index e78d912..9c0f464 100644</span><br><span>--- a/src/openvpn=
/packet_id.h</span><br><span>+++ b/src/openvpn/packet_id.h</span><br><span>=
@@ -336,7 +336,7 @@</span><br><span> /**</span><br><span>  * Writes the pac=
ket ID containing both the epoch and the packet id to the</span><br><span> =
 * buffer specified by buf.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param p         packed id send structure to use for the packet id=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param p        =
 packet id send structure to use for the packet id</span><br><span>  * @par=
am epoch     epoch to write to the packet</span><br><span>  * @param buf   =
    buffer to write the packet id/epoch to</span><br><span>  * @return     =
     false if the packet id space is exhausted and cannot be written</span>=
<br><span>@@ -347,7 +347,7 @@</span><br><span> /**</span><br><span>  * Read=
s the packet ID containing both the epoch and the per-epoch counter</span><=
br><span>  * from the buf.  Will return 0 as epoch id if there is any error=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param p       pa=
cket_id struct to popupulate with the on-wire counter</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param p       packet_id struct to pop=
ulate with the on-wire counter</span><br><span>  * @param buf     buffer to=
 read the packet id from.</span><br><span>  * @return        0 for an error=
/invalid id, epoch otherwise</span><br><span>  */</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
850?usp=3Demail">change 850</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/850?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id1632e4e47f5a9019afecae6045=
7634c4a3c4d31 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 850 </div>
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


--UcyB++KQW6o=--

