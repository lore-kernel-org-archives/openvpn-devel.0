From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 19 Jun 2024 09:13:14 +0000
In-Reply-To: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a3a2795c2ec98a5fbfd817d5e5c3f12ec16ae904-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AVvN+MoOISc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Route: add support
 for user defined routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AVvN+MoOISc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/524?usp=3Demail )

Change subject: Route: add support for user defined routing table
......................................................................


Patch Set 4: Code-Review-1

(1 comment)

Patchset:

PS4:
Sorry for being late to the party - I have looked at it, and while the gene=
ral code works, I find it a bit excessive in lines of code.  Namely, I woul=
d opt for "do not support route-table as an extra argument to `route`", as =
this + the checks really makes up half the code - for little value.  Since =
it's not supposed to be pushable, routes-with-table need to be in the clien=
t config, and in that case, I could just put

```
route-table 123
route
route
route-table 456
route
route
route-table 999
# for everything that comes in pushed
```

into my config.  If I ever really need more than 1-2 route tables.

Also, we shouldn't have `#ifdef ENABLE_SITNL` in the parser for `route` and=
 `route-ipv6`...

Further, the hunk

```
+    int table_id =3D 0; /* unspec table */
...
+    if (options->route_default_table_id)
+    {
+        table_id =3D options->route_default_table_id;
+    }
```

is sort of semi-useful - if route_default_table_id is 0, we do not assign i=
t to table_id, which is also 0.  Why bother with an extra variable here tha=
t will have the same value as the `options` variable, at all times?  I'd ju=
st pass `options->route_default_table_id` downwards, and be done with it.

The `do_init_route_ipv6_list()` code also does the `table_id =3D ...` dance=
, but then passes NULL towards `add_route_ipv6_to_option_list()`, which doe=
s not look intentional...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede5617ee98bf218a7
Gerrit-Change-Number: 524
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Wed, 19 Jun 2024 09:13:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--AVvN+MoOISc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/524?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Sorry for being late to the party - I have loo=
ked at it, and while the general code works, I find it a bit excessive in l=
ines of code.  Namely, I would opt for &quot;do not support route-table as =
an extra argument to `route`&quot;, as this + the checks really makes up ha=
lf the code - for little value.  Since it&#39;s not supposed to be pushable=
, routes-with-table need to be in the client config, and in that case, I co=
uld just put</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
```<br>route-table 123<br>route<br>route<br>route-table 456<br>route<br>rou=
te<br>route-table 999<br># for everything that comes in pushed<br>```</p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">into my config.  I=
f I ever really need more than 1-2 route tables.</p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Also, we shouldn&#39;t have `#ifdef ENA=
BLE_SITNL` in the parser for `route` and `route-ipv6`...</p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Further, the hunk</p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>+    int table_id=
 =3D 0; /* unspec table */<br>...<br>+    if (options-&gt;route_default_tab=
le_id)<br>+    {<br>+        table_id =3D options-&gt;route_default_table_i=
d;<br>+    }<br>```</p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">is sort of semi-useful - if route_default_table_id is 0, we do not a=
ssign it to table_id, which is also 0.  Why bother with an extra variable h=
ere that will have the same value as the `options` variable, at all times? =
 I&#39;d just pass `options-&gt;route_default_table_id` downwards, and be d=
one with it.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
The `do_init_route_ipv6_list()` code also does the `table_id =3D ...` dance=
, but then passes NULL towards `add_route_ipv6_to_option_list()`, which doe=
s not look intentional...</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail">change 524</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/524?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede56=
17ee98bf218a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 524 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Jun 2024 09:13:14=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--AVvN+MoOISc=--

