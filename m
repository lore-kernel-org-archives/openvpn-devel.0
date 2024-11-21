From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 21 Nov 2024 13:10:07 +0000
In-Reply-To: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
References: <gerrit.1732124549000.I6ecd4cb47571cc8c20e46de8595c742aeec6064a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <02b0d8925f05fb3a7a8c5a0fdf050aa839fa2726-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="puXQMVGEDVg="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--puXQMVGEDVg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mrbff, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/808?usp=3Demail )

Change subject: PUSH_UPDATE: Allow OpenVPN in client mode to receive and ha=
ndle PUSH UPDATE control messages to allow options updating at runtime.
......................................................................


Patch Set 1: Code-Review-1

(2 comments)

File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/808/comment/f6e72862_6ae239a4 :
PS1, Line 5472:         if (!apply_pull_filter(options, line))
```
options.c: In function =E2=80=98apply_push_options=E2=80=99:
options.c:5472:14: error: too few arguments to function =E2=80=98apply_pull=
_filter=E2=80=99
 5472 |         if (!apply_pull_filter(options, line))
      |              ^~~~~~~~~~~~~~~~~
In file included from options.c:66:
options_util.h:34:1: note: declared here
   34 | apply_pull_filter(const struct options *o,
      | ^~~~~~~~~~~~~~~~~
```


http://gerrit.openvpn.net/c/openvpn/+/808/comment/09d1a5a6_ed8662d7 :
PS1, Line 5618: apply_push_options(struct context *c,
```
options.c:5456:1: error: conflicting types for =E2=80=98apply_push_options=
=E2=80=99; have =E2=80=98_Bool(struct options *, struct buffer *, unsigned =
int,  unsigned int *, struct env_set *)=E2=80=99
 5456 | apply_push_options(struct options *options,
      | ^~~~~~~~~~~~~~~~~~
In file included from ssl.h:40,
                 from options.c:45:
options.h:875:6: note: previous declaration of =E2=80=98apply_push_options=
=E2=80=99 with type =E2=80=98_Bool(struct context *, struct options *, stru=
ct buffer *, unsigned int,  unsigned int *, struct env_set *, _Bool)=E2=80=
=99
  875 | bool apply_push_options(struct context *c,
      |      ^~~~~~~~~~~~~~~~~~
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595c742aeec6064a
Gerrit-Change-Number: 808
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Thu, 21 Nov 2024 13:10:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--puXQMVGEDVg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mrbff, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options.c:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/808/comment/f6e72862_6ae239a4">Patch Set #1, Line 547=
2:</a> <code style=3D"font-family:monospace,monospace">        if (!apply_p=
ull_filter(options, line))</code></p><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">```<br>options.c: In function =E2=80=98ap=
ply_push_options=E2=80=99:<br>options.c:5472:14: error: too few arguments t=
o function =E2=80=98apply_pull_filter=E2=80=99<br> 5472 |         if (!appl=
y_pull_filter(options, line))<br>      |              ^~~~~~~~~~~~~~~~~<br>=
In file included from options.c:66:<br>options_util.h:34:1: note: declared =
here<br>   34 | apply_pull_filter(const struct options *o,<br>      | ^~~~~=
~~~~~~~~~~~~<br>```</pre></li><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/808/comment/09d1a5a6_ed8662d7">Patch Set #1, Line 5618:</a> <code s=
tyle=3D"font-family:monospace,monospace">apply_push_options(struct context =
*c,</code></p><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">```<br>options.c:5456:1: error: conflicting types for =E2=80=98a=
pply_push_options=E2=80=99; have =E2=80=98_Bool(struct options *, struct bu=
ffer *, unsigned int,  unsigned int *, struct env_set *)=E2=80=99<br> 5456 =
| apply_push_options(struct options *options,<br>      | ^~~~~~~~~~~~~~~~~~=
<br>In file included from ssl.h:40,<br>                 from options.c:45:<=
br>options.h:875:6: note: previous declaration of =E2=80=98apply_push_optio=
ns=E2=80=99 with type =E2=80=98_Bool(struct context *, struct options *, st=
ruct buffer *, unsigned int,  unsigned int *, struct env_set *, _Bool)=E2=
=80=99<br>  875 | bool apply_push_options(struct context *c,<br>      |    =
  ^~~~~~~~~~~~~~~~~~<br>```</pre></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/808?usp=3Demail">change 808</a=
>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:=
//gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/808?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6ecd4cb47571cc8c20e46de8595=
c742aeec6064a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 808 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 21 Nov 2024 13:10:07=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--puXQMVGEDVg=--

