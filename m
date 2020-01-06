MIME-Version: 1.0
From: =?UTF-8?Q?Ga=C3=ABtan_Harter?= <hartergaetan@...277...>
Date: Mon, 6 Jan 2020 01:49:43 +0100
Message-ID: <CAPCTCuhc0UOApVNWqnGD1UKAsvW_BRbd6Pp6XrWnY1aCKHdd4w@...278...>
Content-Type: multipart/alternative; boundary="0000000000002a7ade059b6e0b1f"
Subject: [Openvpn-devel] Environment not passed to --iproute script during
 'ip route del' in openvpn 2.4.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000002a7ade059b6e0b1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear openvpn developers,

I would like to talk about an issue that got fixed in December 2018 in the
git repository but not in any 2.4.X following releases.
It was fixed at least on linux but maybe without being aware of it, so
could still be there on other platforms, be nice to mention on the next
release changelog and be fixed if there is a `2.4.9`.

With openvpn `2.4.8`, when using `--iproute` in conjunction with
`--setenv`, the environment variable are not passed to the `ip` command
when removing ip addresses so when executing `ip addr del` and `ip -6 addr
del`.
From my observations, it is correctly passed for the other calls I have in
my configuration.

I tried in master and it is working. Curious about what fixed it I bisected
to find the commit.
It found me the commit dc7fcd714188989966ac2bd9315485603813fe0f [1] that
updated to a new API but nothing in the commit messages talks about fixing
the issue.
I dug a bit further and the mailing-list thread [2] mentions "diff from v1:
fixed env passed to ip command".
But when looking on the original patch answer [3] it seems the author was
referring to an issue with the new implementation and not the old one:

> This behaviour does not reflect the original one as in the current code
> we always pass the complete ENV coming from the openvpn context.
>

So it seems like the change was not expecting to fix an issue in the
current code base.
From the wording, it feels like the issue was unknown and could still be
present in the repository for other targets.

I hope this information is useful and could provide a new test case.
If it is already known, sorry for the noise.
I added my testing procedure in appendix.

1:
https://sourceforge.net/p/openvpn/openvpn/ci/dc7fcd714188989966ac2bd9315485=
603813fe0f
2:
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18026.h=
tml
3:
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16807.h=
tm

Best Regards,
Ga=C3=ABtan HARTER


Testing Procedure
-----------------

I used Arch Linux with the packaged `openvpn_2.4.8` version, but also tried
compiling `v2.4.8` from the repository with `--enable-iproute2` and got the
same result.

My testing procedure is having an executable "ip" file with

#! /bin/sh -xu
echo VARIABLE=3D${VARIABLE}
exec ip $@

Then compile, execute `openvpn` with `timeout` and look at the log

autoreconf -vi && ./configure --enable-iproute2 && make
sudo timeout 10 ./src/openvpn/openvpn --setenv VARIABLE value --iproute
./ip --script-security 2 --config vpn.conf

With v2.4.8, when openvpn exits, it fails the `ip` command as the variable
is not set when calling `ip addr del`

Mon Jan  6 01:18:22 2020 Closing TUN/TAP interface
Mon Jan  6 01:18:22 2020 ./ip addr del dev tun0 X.X.X.X/27
./ip: line 2: VARIABLE: unbound variable
Mon Jan  6 01:18:22 2020 Linux ip addr del failed: external program exited
with error status: 1
Mon Jan  6 01:18:22 2020 ./ip -6 addr del XXXX::1/64 dev tun0
./ip: line 2: VARIABLE: unbound variable
Mon Jan  6 01:18:22 2020 Linux ip -6 addr del failed: external program
exited with error status: 1
Mon Jan  6 01:18:22 2020 SIGTERM[soft,exit-with-notification] received,
process exiting

With `master` or after the mentioned commit it works as expected:

Mon Jan  6 01:19:24 2020 Closing TUN/TAP interface
Mon Jan  6 01:19:24 2020 ./ip addr del dev tun0 X.X.X.X/27
+ echo VARIABLE=3Dvalue
VARIABLE=3Dvalue
+ exec ip addr del dev tun0 X.X.X.X/27
Mon Jan  6 01:19:24 2020 ./ip -6 addr del XXXX::1/64 dev tun0
+ echo VARIABLE=3Dvalue
VARIABLE=3Dvalue
+ exec ip -6 addr del XXXX::1/64 dev tun0
Mon Jan  6 01:19:24 2020 SIGTERM[soft,exit-with-notification] received,
process exiting

--0000000000002a7ade059b6e0b1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"font-family:monospace">Dear openvpn de=
velopers,<br><br></span><div><span style=3D"font-family:monospace">I would =
like to talk about an issue that got fixed in December 2018 in the git repo=
sitory but not in any 2.4.X following releases.</span></div><div><span styl=
e=3D"font-family:monospace">It was fixed at least on linux but maybe withou=
t being aware of it, so could still be there on other platforms, be nice to=
 mention on the next release changelog and be fixed if there is a `2.4.9`.<=
/span></div><span style=3D"font-family:monospace"><br>With openvpn `2.4.8`,=
 when using `--iproute` in conjunction with `--setenv`, the environment var=
iable are not passed to the `ip` command when removing ip addresses so when=
 executing `ip addr del` and `ip -6 addr del`.<br>From my observations, it =
is correctly passed for the other calls I have in my configuration.<br><br>=
</span><div><span style=3D"font-family:monospace">I tried in master and it =
is working. Curious about what fixed it I bisected to find the commit.<br><=
/span></div><div><span style=3D"font-family:monospace">It found me the comm=
it dc7fcd714188989966ac2bd9315485603813fe0f [1] that updated to a new API b=
ut nothing in the commit messages talks about fixing the issue.</span></div=
><span style=3D"font-family:monospace">I dug a bit further and the mailing-=
list thread [2] mentions &quot;diff from v1: fixed env passed to ip command=
&quot;.</span></div><div><span style=3D"font-family:monospace">But when loo=
king on the original patch answer [3] it seems the author was referring to =
an issue with the new implementation and not the old one:<br></span></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><span style=3D"font-family=
:monospace">This behaviour does not reflect the original one as in the curr=
ent code<br>we always pass the complete ENV coming from the openvpn context=
.<br></span></blockquote><div><span style=3D"font-family:monospace"><br>So =
it seems like the change was not expecting to fix an issue in the current c=
ode base.<br></span></div><div><span style=3D"font-family:monospace">From t=
he wording, it feels like the issue was unknown and could still be present =
in the repository for other targets.<br></span></div><div><span style=3D"fo=
nt-family:monospace"><br></span></div><div><span style=3D"font-family:monos=
pace">I hope this information is useful and could provide a new test case.<=
br></span></div><div><span style=3D"font-family:monospace">If it is already=
 known, sorry for the noise.<br></span></div><div><span style=3D"font-famil=
y:monospace">I added my testing procedure in appendix.<br></span></div><div=
><span style=3D"font-family:monospace"><br>1: <a href=3D"https://sourceforg=
e.net/p/openvpn/openvpn/ci/dc7fcd714188989966ac2bd9315485603813fe0f">https:=
//sourceforge.net/p/openvpn/openvpn/ci/dc7fcd714188989966ac2bd9315485603813=
fe0f</a><br>2: <a href=3D"https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg18026.html">https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg18026.html</a><br>3: <a href=3D"https://www.mail-ar=
chive.com/openvpn-devel@lists.sourceforge.net/msg16807.htm">https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg16807.htm</a><br></spa=
n></div><div><br><span style=3D"font-family:monospace"></span></div><div><s=
pan style=3D"font-family:monospace">Best Regards,<br>Ga=C3=ABtan HARTER</sp=
an></div><div><span style=3D"font-family:monospace"><br></span></div><div><=
span style=3D"font-family:monospace"><br></span></div><div><span style=3D"f=
ont-family:monospace">Testing Procedure</span></div><div><span style=3D"fon=
t-family:monospace">-----------------<br></span></div><div><span style=3D"f=
ont-family:monospace"><br></span></div><div><span style=3D"font-family:mono=
space">I used Arch Linux with the packaged `openvpn_2.4.8` version, but als=
o tried compiling `v2.4.8` from the repository with `--enable-iproute2` and=
 got the same result.<br><br>My testing procedure is having an executable &=
quot;ip&quot; file with<br><br></span><div style=3D"margin-left:40px"><span=
 style=3D"font-family:monospace">#! /bin/sh -xu<br>echo VARIABLE=3D${VARIAB=
LE}<br>exec ip $@<br></span></div><div style=3D"margin-left:40px"><span sty=
le=3D"font-family:monospace"><br></span></div><span style=3D"font-family:mo=
nospace">Then compile, execute `openvpn` with `timeout` and look at the log=
<br></span></div><div><span style=3D"font-family:monospace"><br></span></di=
v><div><div style=3D"margin-left:40px"><span style=3D"font-family:monospace=
">autoreconf -vi &amp;&amp; ./configure --enable-iproute2 &amp;&amp; make<b=
r>sudo timeout 10 ./src/openvpn/openvpn --setenv VARIABLE value --iproute .=
/ip --script-security 2 --config vpn.conf</span></div></div><div><span styl=
e=3D"font-family:monospace"><br>With v2.4.8, when openvpn exits, it fails t=
he `ip` command as the variable is not set when calling `ip addr del`</span=
></div><div><span style=3D"font-family:monospace"><br></span><div style=3D"=
margin-left:40px"><span style=3D"font-family:monospace">Mon Jan =C2=A06 01:=
18:22 2020 Closing TUN/TAP interface<br>Mon Jan =C2=A06 01:18:22 2020 ./ip =
addr del dev tun0 X.X.X.X/27<br>./ip: line 2: VARIABLE: unbound variable<br=
>Mon Jan =C2=A06 01:18:22 2020 Linux ip addr del failed: external program e=
xited with error status: 1<br>Mon Jan =C2=A06 01:18:22 2020 ./ip -6 addr de=
l XXXX::1/64 dev tun0<br>./ip: line 2: VARIABLE: unbound variable<br>Mon Ja=
n =C2=A06 01:18:22 2020 Linux ip -6 addr del failed: external program exite=
d with error status: 1<br>Mon Jan =C2=A06 01:18:22 2020 SIGTERM[soft,exit-w=
ith-notification] received, process exiting<br></span></div><span style=3D"=
font-family:monospace"><br>With `master` or after the mentioned commit it w=
orks as expected:<br><br></span><div style=3D"margin-left:40px"><span style=
=3D"font-family:monospace">Mon Jan =C2=A06 01:19:24 2020 Closing TUN/TAP in=
terface<br>Mon Jan =C2=A06 01:19:24 2020 ./ip addr del dev tun0 X.X.X.X/27<=
br>+ echo VARIABLE=3Dvalue<br>VARIABLE=3Dvalue<br>+ exec ip addr del dev tu=
n0 X.X.X.X/27<br>Mon Jan =C2=A06 01:19:24 2020 ./ip -6 addr del XXXX::1/64 =
dev tun0<br>+ echo VARIABLE=3Dvalue<br>VARIABLE=3Dvalue<br>+ exec ip -6 add=
r del XXXX::1/64 dev tun0<br>Mon Jan =C2=A06 01:19:24 2020 SIGTERM[soft,exi=
t-with-notification] received, process exiting</span></div><div style=3D"ma=
rgin-left:40px"><span style=3D"font-family:monospace"><br></span></div></di=
v></div>

--0000000000002a7ade059b6e0b1f--

