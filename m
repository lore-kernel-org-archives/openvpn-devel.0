From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 12 Oct 2025 11:18:28 +0000
In-Reply-To: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
References: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1388712bcbe7e8b8a132d486dc09adab3aba8e12-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Mwz3bjxAOPU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE server:
 remove old IP(s) from vhash after sending a messa...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Mwz3bjxAOPU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

cron2 has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/1253?usp=3Demail )

Change subject: PUSH_UPDATE server: remove old IP(s) from vhash after sendi=
ng a message containing ifconfig(-ipv6)
......................................................................


Patch Set 3: Code-Review-1

(7 comments)

Patchset:

PS3:
I like this latest version, and it should work nicely.

There might be a missing `free()` - this needs to be checked.  While at it,=
 I've found a few other things that could use a bit of polishing.


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1253/comment/723a899a_4779f06b?usp=3D=
email :
PS3, Line 4296:     msg(D_MULTI_LOW, "MULTI: Remove: %s -> %s", mroute_addr=
_print(&r->addr, &gc), multi_instance_string(mi, false, &gc));
this is too much logging ;-)

I'd remove one of them, and change the other to include something like `MUL=
TI: multi_unlearn_addr(): DEL %s` so it's clear it's not the normal "MULTI:=
 DEL" path.

Also, if we want to be totally fancy, we could use the mi prefix code here

```
set_prefix(mi);
msg(...)  // no multi_instance_string() needed, as that's handled by msg_se=
t_prefix()
clear_prefix();
```

as for the message level, I'd use `D_MULTI_LOW` (as that is used by multi.c=
 for the "Learn" message).


http://gerrit.openvpn.net/c/openvpn/+/1253/comment/80047d20_27d7418e?usp=3D=
email :
PS3, Line 4301:
we might have a memleak here.  I looked at the code in "multi.c" that delet=
es mroutes (check_stale_routes(), multi_reap_range()), and those call `mult=
i_route_del(r)` to do

```
    route_quota_dec(mi);
    multi_instance_dec_refcount(mi);
    free(route);
```

so you have the first two here, but not the `free()` - not 100% sure if thi=
s is required, but it smells like it.

(`hash_remove_by_value()` seems to not do anything about the thing pointed =
to)

Maybe just calling `multi_route_del(r)` here is the right thing (after the =
hash_remove_by_value() call, to avoid a use-after-free)?


http://gerrit.openvpn.net/c/openvpn/+/1253/comment/f301c3e7_e77a6296?usp=3D=
email :
PS3, Line 4320:     ASSERT(mroute_extract_openvpn_sockaddr(&addr, &remote_s=
i, false));
This works, but feels more clumsy than needed - looking through mroute.c, I=
 find

`mroute_get_in_addr_t(struct mroute_addr *out, const in_addr_t in, int mask=
)`

which should do the same with less lines of intermediate structure filling =
:-)  (have not tested this, just compared code)


http://gerrit.openvpn.net/c/openvpn/+/1253/comment/8290fc03_3b80051e?usp=3D=
email :
PS3, Line 4339:
`mroute_get_in6_addr(&addr, a6, 0)` does this for you


http://gerrit.openvpn.net/c/openvpn/+/1253/comment/cbc56eb6_41bab12b?usp=3D=
email :
PS3, Line 4366:             old_addr.s_addr =3D ntohl(mi->context.c2.push_i=
fconfig_local);
we could just do `in_addr_t old_addr =3D ...` here and save the detour via =
`struct in_addr`?


File src/openvpn/push_util.c:

http://gerrit.openvpn.net/c/openvpn/+/1253/comment/07ab8769_ed9bfa83?usp=3D=
email :
PS3, Line 158:     memset(&o, 0, sizeof(struct options));
please use `CLEAR(o);` for that.  It does exactly the same, but we use it i=
n this situation so it's clear "this is not just a random memset() but to 0=
-initialize the options struct".



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde98702a9801616a5f
Gerrit-Change-Number: 1253
Gerrit-PatchSet: 3
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Sun, 12 Oct 2025 11:18:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Mwz3bjxAOPU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">V=
iew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1253?tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I like thi=
s latest version, and it should work nicely.</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">There might be a missing=
 `free()` - this needs to be checked.  While at it, I&#39;ve found a few ot=
her things that could use a bit of polishing.</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1253/comment/723a899a_4779f06b?usp=3Demail">Patch Set #3, Line 4296:=
</a> <code style=3D"font-family:monospace,monospace">    msg(D_MULTI_LOW, &=
quot;MULTI: Remove: %s -&gt; %s&quot;, mroute_addr_print(&amp;r-&gt;addr, &=
amp;gc), multi_instance_string(mi, false, &amp;gc));</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">this is too=
 much logging ;-)</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">I&#39;d remove one of them, and change the other to i=
nclude something like `MULTI: multi_unlearn_addr(): DEL %s` so it&#39;s cle=
ar it&#39;s not the normal &quot;MULTI: DEL&quot; path.</p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Also, if we wan=
t to be totally fancy, we could use the mi prefix code here</p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>set_=
prefix(mi);<br>msg(...)  // no multi_instance_string() needed, as that&#39;=
s handled by msg_set_prefix()<br>clear_prefix();<br>```</p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">as for the mess=
age level, I&#39;d use `D_MULTI_LOW` (as that is used by multi.c for the &q=
uot;Learn&quot; message).</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1253/comment/80047d20_27d7418e?usp=3Demail">Patch Set #3, Line =
4301:</a> <code style=3D"font-family:monospace,monospace"></code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">we mi=
ght have a memleak here.  I looked at the code in &quot;multi.c&quot; that =
deletes mroutes (check_stale_routes(), multi_reap_range()), and those call =
`multi_route_del(r)` to do</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">```<br>    route_quota_dec(mi);=
<br>    multi_instance_dec_refcount(mi);<br>    free(route);<br>```</pre><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">s=
o you have the first two here, but not the `free()` - not 100% sure if this=
 is required, but it smells like it.</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">(`hash_remove_by_value()` seems to=
 not do anything about the thing pointed to)</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Maybe just calling `mult=
i_route_del(r)` here is the right thing (after the hash_remove_by_value() c=
all, to avoid a use-after-free)?</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1253/comment/f301c3e7_e77a6296?usp=3Demail">Patch Set #3=
, Line 4320:</a> <code style=3D"font-family:monospace,monospace">    ASSERT=
(mroute_extract_openvpn_sockaddr(&amp;addr, &amp;remote_si, false));</code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">This works, but feels more clumsy than needed - looking through mroute=
.c, I find</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">`mroute_get_in_addr_t(struct mroute_addr *out, const in_addr=
_t in, int mask)`</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">which should do the same with less lines of intermedi=
ate structure filling :-)  (have not tested this, just compared code)</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253/comment/8290fc=
03_3b80051e?usp=3Demail">Patch Set #3, Line 4339:</a> <code style=3D"font-f=
amily:monospace,monospace"></code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">`mroute_get_in6_addr(&amp;addr, a6, =
0)` does this for you</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1253/comment/cbc56eb6_41bab12b?usp=3Demail">Patch Set #3, Line 4366=
:</a> <code style=3D"font-family:monospace,monospace">            old_addr.=
s_addr =3D ntohl(mi-&gt;context.c2.push_ifconfig_local);</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">we coul=
d just do `in_addr_t old_addr =3D ...` here and save the detour via `struct=
 in_addr`?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/push_util.c:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253/comment/07ab8769_ed9b=
fa83?usp=3Demail">Patch Set #3, Line 158:</a> <code style=3D"font-family:mo=
nospace,monospace">    memset(&amp;o, 0, sizeof(struct options));</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">please use `CLEAR(o);` for that.  It does exactly the same, but we use it=
 in this situation so it&#39;s clear &quot;this is not just a random memset=
() but to 0-initialize the options struct&quot;.</p></li></ul></li></ul><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3D=
email">change 1253</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde987=
02a9801616a5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1253 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 12 Oct 2025 11:18:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--Mwz3bjxAOPU=--

