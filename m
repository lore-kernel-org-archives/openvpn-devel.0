From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 26 Jun 2025 09:03:20 +0000
In-Reply-To: <gerrit.1750841904000.I55940b78e35f0e3d74aa6cba14378afed97a444e@...2715...>
References: <gerrit.1750841904000.I55940b78e35f0e3d74aa6cba14378afed97a444e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <57c3470a73129f89aa42986289027956cd430aa5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B4HlBqWmf7U="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: run forced
 --dns-updown without --script-security
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--B4HlBqWmf7U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1065?usp=3Demail )

Change subject: run forced --dns-updown without --script-security
......................................................................


Patch Set 1: Code-Review-2

(1 comment)

File src/openvpn/dns.c:

http://gerrit.openvpn.net/c/openvpn/+/1065/comment/5051e657_d2d6667f :
PS1, Line 583:     if (dns_updown_user_set(o))
```
dns.c: In function =E2=80=98do_run_up_down_command=E2=80=99:
dns.c:583:29: error: passing argument 1 of =E2=80=98dns_updown_user_set=E2=
=80=99 discards =E2=80=98const=E2=80=99 qualifier from pointer target type =
[-Werror=3Ddiscarded-qualifiers]
  583 |     if (dns_updown_user_set(o))
      |                             ^
In file included from dns.c:30:
dns.h:209:41: note: expected =E2=80=98struct dns_options *=E2=80=99 but arg=
ument is of type =E2=80=98const struct dns_options *=E2=80=99
  209 | dns_updown_user_set(struct dns_options *o)
      |                     ~~~~~~~~~~~~~~~~~~~~^
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1065?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I55940b78e35f0e3d74aa6cba14378afed97a444e
Gerrit-Change-Number: 1065
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Thu, 26 Jun 2025 09:03:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--B4HlBqWmf7U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1065?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dns.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1065/comment/5051e657_d2d6667f">Patch Set #1, Line 583:</=
a> <code style=3D"font-family:monospace,monospace">    if (dns_updown_user_=
set(o))</code></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">```<br>dns.c: In function =E2=80=98do_run_up_down_command=E2=
=80=99:<br>dns.c:583:29: error: passing argument 1 of =E2=80=98dns_updown_u=
ser_set=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier from pointer ta=
rget type [-Werror=3Ddiscarded-qualifiers]<br>  583 |     if (dns_updown_us=
er_set(o))<br>      |                             ^<br>In file included fro=
m dns.c:30:<br>dns.h:209:41: note: expected =E2=80=98struct dns_options *=
=E2=80=99 but argument is of type =E2=80=98const struct dns_options *=E2=80=
=99<br>  209 | dns_updown_user_set(struct dns_options *o)<br>      |       =
              ~~~~~~~~~~~~~~~~~~~~^<br>```</pre></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1065?usp=3Demai=
l">change 1065</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1065?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I55940b78e35f0e3d74aa6cba143=
78afed97a444e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1065 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Jun 2025 09:03:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--B4HlBqWmf7U=--

