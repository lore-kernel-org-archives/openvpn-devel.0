From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 20 Nov 2025 11:06:05 +0000
In-Reply-To: <gerrit.1763574430000.Id429241e1b17a8ff51d9019efc357c910f3bde4c@...2715...>
References: <gerrit.1763574430000.Id429241e1b17a8ff51d9019efc357c910f3bde4c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <dd552a100aabef7edc23300b5684efb42ac7d92e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U4ixeYsWuKE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extend '--multihome'
 to selectively ignore the incoming interface index.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--U4ixeYsWuKE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

flichtenheld has posted comments on this change by cron2. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1383?usp=3Demail )

Change subject: Extend '--multihome' to selectively ignore the incoming int=
erface index.
......................................................................


Patch Set 2: Code-Review-1

(1 comment)

File doc/man-sections/server-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/1383/comment/7385fd70_c3ceb20c?usp=3D=
email :
PS2, Line 357:     -  This will copy the "ip_ifindex" from the incoming to =
the outgoing
I don't really like this text. I think it is too much describing the code. =
How about:

```
- In addition to copying the source address this also copies the "interface=
 index", trying to send the packet out over the same interface where it cam=
e in on. This might not work if there are no usable routes on that interfac=
e.
- To avoid forcing an outgoing interface and only set the source address, s=
pecify the ``ignore-iif`` flag.
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1383?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id429241e1b17a8ff51d9019efc357c910f3bde4c
Gerrit-Change-Number: 1383
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Thu, 20 Nov 2025 11:06:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--U4ixeYsWuKE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1383?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/server-op=
tions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1383/comment/7385fd70_c3ceb20c?usp=3Dem=
ail">Patch Set #2, Line 357:</a> <code style=3D"font-family:monospace,monos=
pace">    -  This will copy the &quot;ip_ifindex&quot; from the incoming to=
 the outgoing</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I don&#39;t really like this text. I think it is t=
oo much describing the code. How about:</p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">```</p><ul class=3D"blocks"><li=
>In addition to copying the source address this also copies the &quot;inter=
face index&quot;, trying to send the packet out over the same interface whe=
re it came in on. This might not work if there are no usable routes on that=
 interface.</li><li>To avoid forcing an outgoing interface and only set the=
 source address, specify the ``ignore-iif`` flag.</li><li>```</li></ul></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1383?usp=3Demail">change 1383</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1383?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id429241e1b17a8ff51d9019efc3=
57c910f3bde4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1383 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 20 Nov 2025 11:06:05=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--U4ixeYsWuKE=--

