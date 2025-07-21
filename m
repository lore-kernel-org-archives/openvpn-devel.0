From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 21 Jul 2025 18:08:07 +0000
In-Reply-To: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
References: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <2b33e02a8ac59e8cbed5ce24bb1ac7d5c6f5fe34-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ul0rUlzOpio="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: Allow
 OpenVPN in client mode to receive and handle PUSH ...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ul0rUlzOpio=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, mrbff, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/808?usp=3Demail )

Change subject: PUSH_UPDATE: Allow OpenVPN in client mode to receive and ha=
ndle PUSH UPDATE control messages to allow options updating at runtime.
......................................................................


Patch Set 19: Code-Review-1

Copied votes on follow-up patch sets have been updated:
* Code-Review-1 has been copied to patch set 20 (copy condition: "changekin=
d:NO_CHANGE OR changekind:TRIVIAL_REBASE OR is:MIN").

(10 comments)

Patchset:

PS19:
So, I think this works and is sufficently save and efficient, but I'm and o=
ld man and like my lawn orderly... so as discussed on IRC, please adjust a =
few minor points.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/849fb9c1_8109d087 :
PS19, Line 5567: apply_push_options(struct options *options,
please do not move that one around in options.c, this makes comparing old/n=
ew harder without good benefit, also breaks git blame...


http://gerrit.openvpn.net/c/openvpn/+/808/comment/25512e6f_b2eb183f :
PS19, Line 5654:
so I would call check_push_update_option_flags() from here, possibly moving=
 the "while isspace(*line) { line++; }" part up here as well.  Then we can =
keep "apply_pull_filter()" focused on "pull filter", not dealing with a num=
ber of extra conditions...  (just "is_update", see there)


File src/openvpn/options_util.c:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/5c5cd074_1394fe2c :
PS19, Line 198:     if (!line || !*line || !**line)
the use of a double pointer irritates me, because we never move the pointer=
, instead `memmove()` the buffer...

I think we should just do `(*line)++` instead of the `memmove()` below - po=
ssibly also getting rid of the `strlen(str)` thing, or `str` altogether :-)=
 - so keep the pointer, call it from `apply_push_options()` and accept a mo=
ving `*line` pointer.

Also, I'm not sure if "empty string" should be treated as `false` or just i=
gnored (return true, that is) - the existing environment where `apply_pull_=
filter()` is used does not care for "empty lines".

A NULL pointer is a programming error that must never happen, so an ASSERT(=
line) is valid.


http://gerrit.openvpn.net/c/openvpn/+/808/comment/6ffca9a9_893ed859 :
PS19, Line 231:
If there is whitespace here (`?  route`) we'll fail with `pushed option is =
not updateable: '  route'`, if I'm not misreading it.

I'd document that "there must not be whitespace between the flag letters an=
d the option" and then we could add an `if (isspace(**line)) { complain; re=
turn false; }` here... the documentation is important, the error handling n=
ot so much (as it will hit the `return false` anyway)


http://gerrit.openvpn.net/c/openvpn/+/808/comment/bc8b42ab_3cf0ba0c :
PS19, Line 252:             msg(D_PUSH, "Pushed option is not updatable: '%=
s'", *line);
Maybe add an " Ignoring." to the string, so it's clear "this is information=
al, but not an error, and this is how we handle it"?  Since the other one h=
as "Restarting"...


http://gerrit.openvpn.net/c/openvpn/+/808/comment/ce24fecc_c0a39fcd :
PS19, Line 270:     if (!o->pull_filter_list && !(is_update))
So, if we call `check_push_update_option_flags()` from outside, we do not n=
eed this extra dance, checking o->pull_filter_list twice...


http://gerrit.openvpn.net/c/openvpn/+/808/comment/8974bb49_5a803112 :
PS19, Line 276:     while (isspace(*line))
It makes sense to move that upwards to `apply_push_options()`, before calli=
ng anything on the line.  So both all functions called do not need to bothe=
r about leading whitespace.


http://gerrit.openvpn.net/c/openvpn/+/808/comment/8689afde_5d9ee877 :
PS19, Line 310:                 return true;
This duplication of the messages and `return true` looks a bit silly :-) - =
I would suggest to do

```
        /* on PUSH_UPDATE, "reject" and "ignore" filters are treated the sa=
me */
        else if ( (f->type =3D=3D PUF_TYPE_IGNORE || is_update)
                   && strncmp(line, f->pattern, f->size) =3D=3D 0)
        {
            msg(D_PUSH, "Pushed option removed by filter: '%s'", line);
            return true;
        }
```


File src/openvpn/push_util.c:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/b8dd5363_84e249de :
PS19, Line 23:                                true))
Just for the record - this is the really-old-style OpenVPN formatting, whic=
h we no longer use.  That said, I know it's the same as in `process_incomin=
g_push_reply()`, so it makes sense to keep it the same, and then clang-form=
at will change both at once.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595c742aeec6064a
Gerrit-Change-Number: 808
Gerrit-PatchSet: 19
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Mon, 21 Jul 2025 18:08:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--ul0rUlzOpio=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, mrbff, stipa=
. </p>
<p>Patch set 19:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">V=
iew Change</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/808?tab=3Dcomments">Patch Set #19:</a> </p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">So, I think this works and is sufficently =
save and efficient, but I&#39;m and old man and like my lawn orderly... so =
as discussed on IRC, please adjust a few minor points.</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/808/comment/849fb9c1_8109d087">Patch Set #19, Line 5567:</a=
> <code style=3D"font-family:monospace,monospace">apply_push_options(struct=
 options *options,</code></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">please do not move that one around in options.c, this makes co=
mparing old/new harder without good benefit, also breaks git blame...</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/25512e6=
f_b2eb183f">Patch Set #19, Line 5654:</a> <code style=3D"font-family:monosp=
ace,monospace"></code></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">so I would call check_push_update_option_flags() from here, possi=
bly moving the &quot;while isspace(*line) { line++; }&quot; part up here as=
 well.  Then we can keep &quot;apply_pull_filter()&quot; focused on &quot;p=
ull filter&quot;, not dealing with a number of extra conditions...  (just &=
quot;is_update&quot;, see there)</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/options_util.c:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
08/comment/5c5cd074_1394fe2c">Patch Set #19, Line 198:</a> <code style=3D"f=
ont-family:monospace,monospace">    if (!line || !*line || !**line)</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">the use of a =
double pointer irritates me, because we never move the pointer, instead `me=
mmove()` the buffer...</p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">I think we should just do `(*line)++` instead of the `memmove()` =
below - possibly also getting rid of the `strlen(str)` thing, or `str` alto=
gether :-) - so keep the pointer, call it from `apply_push_options()` and a=
ccept a moving `*line` pointer.</p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Also, I&#39;m not sure if &quot;empty string&quot; shoul=
d be treated as `false` or just ignored (return true, that is) - the existi=
ng environment where `apply_pull_filter()` is used does not care for &quot;=
empty lines&quot;.</p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">A NULL pointer is a programming error that must never happen, so an A=
SSERT(line) is valid.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/808/comment/6ffca9a9_893ed859">Patch Set #19, Line 231:</a> <code s=
tyle=3D"font-family:monospace,monospace"></code></p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">If there is whitespace here (`?  route`=
) we&#39;ll fail with `pushed option is not updateable: &#39;  route&#39;`,=
 if I&#39;m not misreading it.</p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I&#39;d document that &quot;there must not be whitespace =
between the flag letters and the option&quot; and then we could add an `if =
(isspace(**line)) { complain; return false; }` here... the documentation is=
 important, the error handling not so much (as it will hit the `return fals=
e` anyway)</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
08/comment/bc8b42ab_3cf0ba0c">Patch Set #19, Line 252:</a> <code style=3D"f=
ont-family:monospace,monospace">            msg(D_PUSH, &quot;Pushed option=
 is not updatable: &#39;%s&#39;&quot;, *line);</code></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Maybe add an &quot; Ignoring.&quot=
; to the string, so it&#39;s clear &quot;this is informational, but not an =
error, and this is how we handle it&quot;?  Since the other one has &quot;R=
estarting&quot;...</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/808/comment/ce24fecc_c0a39fcd">Patch Set #19, Line 270:</a> <code styl=
e=3D"font-family:monospace,monospace">    if (!o-&gt;pull_filter_list &amp;=
&amp; !(is_update))</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">So, if we call `check_push_update_option_flags()` from outsid=
e, we do not need this extra dance, checking o-&gt;pull_filter_list twice..=
.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/=
8974bb49_5a803112">Patch Set #19, Line 276:</a> <code style=3D"font-family:=
monospace,monospace">    while (isspace(*line))</code></p><p style=3D"white=
-space: pre-wrap; word-wrap: break-word;">It makes sense to move that upwar=
ds to `apply_push_options()`, before calling anything on the line.  So both=
 all functions called do not need to bother about leading whitespace.</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808/comment/8689afd=
e_5d9ee877">Patch Set #19, Line 310:</a> <code style=3D"font-family:monospa=
ce,monospace">                return true;</code></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">This duplication of the messages and `=
return true` looks a bit silly :-) - I would suggest to do</p><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">```<br>        /=
* on PUSH_UPDATE, &quot;reject&quot; and &quot;ignore&quot; filters are tre=
ated the same */<br>        else if ( (f-&gt;type =3D=3D PUF_TYPE_IGNORE ||=
 is_update)<br>                   &amp;&amp; strncmp(line, f-&gt;pattern, f=
-&gt;size) =3D=3D 0)<br>        {<br>            msg(D_PUSH, &quot;Pushed o=
ption removed by filter: &#39;%s&#39;&quot;, line);<br>            return t=
rue;<br>        }<br>```</pre></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/push_util.c:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808/commen=
t/b8dd5363_84e249de">Patch Set #19, Line 23:</a> <code style=3D"font-family=
:monospace,monospace">                               true))</code></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Just for the record -=
 this is the really-old-style OpenVPN formatting, which we no longer use.  =
That said, I know it&#39;s the same as in `process_incoming_push_reply()`, =
so it makes sense to keep it the same, and then clang-format will change bo=
th at once.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/808?usp=3Demail">change 808</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/808?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595=
c742aeec6064a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 808 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 21 Jul 2025 18:08:07=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ul0rUlzOpio=--

