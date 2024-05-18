From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 18 May 2024 16:08:30 +0000
In-Reply-To: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
References: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <1aecf0843ff77721b92164dc606fb1cb57ee43ea-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="acB2g/sXn4k="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Windows: enforce
 'block-local' with WFP filters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--acB2g/sXn4k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/489?usp=3Demail )

Change subject: Windows: enforce 'block-local' with WFP filters
......................................................................


Patch Set 5: Code-Review-1

(2 comments)

Patchset:

PS5:
Overall the patch does what it says, but it is not -Werror clean.

Please fix, rebase (copyright dates have changed for the files renamed and =
commit 989b22cb6e0 moved around "pipe_message_t" + changed indentation).  T=
hanks.


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/a60e11c6_446166ef :
PS5, Line 2058:     unsigned long adapter_index;
This is not `-Werror` clean.  GH builds complain

```
init.c:2115:26: error: variable 'adapter_index' is uninitialized when used =
here [-Werror,-Wuninitialized]
68
        del_wfp_block(c, adapter_index);
69
                         ^~~~~~~~~~~~~
70
init.c:2047:32: note: initialize the variable 'adapter_index' to silence th=
is warning
71
    unsigned long adapter_index;
72
                               ^
73
                                =3D 0
74
1 error generated.
```

This is trivially adjusted (`=3D0`) but according to project rules I can't =
do that.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba
Gerrit-Change-Number: 489
Gerrit-PatchSet: 5
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Sat, 18 May 2024 16:08:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--acB2g/sXn4k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/489?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Overall the patch does what it says, but it i=
s not -Werror clean.</p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Please fix, rebase (copyright dates have changed for the files rena=
med and commit 989b22cb6e0 moved around &quot;pipe_message_t&quot; + change=
d indentation).  Thanks.</p></li></ul></li><li style=3D"margin: 0; padding:=
 0;"><p>File src/openvpn/init.c:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/a60e1=
1c6_446166ef">Patch Set #5, Line 2058:</a> <code style=3D"font-family:monos=
pace,monospace">    unsigned long adapter_index;</code></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">This is not `-Werror` clean.  GH=
 builds complain</p><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">```<br>init.c:2115:26: error: variable &#39;adapter_index&=
#39; is uninitialized when used here [-Werror,-Wuninitialized]<br>68<br>   =
     del_wfp_block(c, adapter_index);<br>69<br>                         ^~~=
~~~~~~~~~~<br>70<br>init.c:2047:32: note: initialize the variable &#39;adap=
ter_index&#39; to silence this warning<br>71<br>    unsigned long adapter_i=
ndex;<br>72<br>                               ^<br>73<br>                  =
              =3D 0<br>74<br>1 error generated.<br>```</pre><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">This is trivially adjusted (`=
=3D0`) but according to project rules I can&#39;t do that.</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
89?usp=3Demail">change 489</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f=
071db3e4832ba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 489 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 18 May 2024 16:08:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--acB2g/sXn4k=--

