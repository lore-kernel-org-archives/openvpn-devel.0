MIME-Version: 1.0
In-Reply-To: <4C2E2652.8000607@...1114...>
References: <AANLkTima8VCnIP08BwlXrwvbtZRcRM-ZLeOM6FPty5Jc@...278...> 
	<4C2E2652.8000607@...1114...>
From: =?UTF-8?Q?Henno_T=C3=A4ht?= <henno.taht@...277...>
Date: Fri, 2 Jul 2010 21:51:12 +0300
Message-ID: <AANLkTintkNT0hY8cRHz-MEbfAFdd25mfMNOH-r3FTbE0@...278...>
Content-Type: multipart/alternative; boundary=0016e6d6440e66477c048a6c1364
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN server listening both
	on udp and tcp?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--0016e6d6440e66477c048a6c1364
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!

2010/7/2 David Sommerseth <openvpn.list@...1114...>

> On 02/07/10 19:38, Henno T=C3=A4ht wrote:
> > Hello!
> >
> > Can anyone experienced and helpful scribble a little guide how to have
> > the same OpenVPN server listening both on 1194 UDP (reason: fast,
> > preferable) and 443 TCP (reason: always works, fallback)?
>
> That is not possible.  OpenVPN can only listen to TCP or UDP, not both.
>  To do this, you will need two independent OpenVPN configurations and
> run two separate OpenVPN daemons
>
> Having that said, this is a common question and a feature which is under
> evaluation for the next generation OpenVPN.
>

Great news!

A client config file should also support this. Something like this:
remote 198.51.100.15:1194 proto udp wait 10
remote 203.0.113.234:443 proto tcp  wait 1
remote 192.168.0.1:8080->203.0.113.234:443 proto tcp wait 1

Explanation:
First try direct connection to udp port 1194, wait 10 seconds (should be
enough to survive OpenVPN server restarts after config change).
If that fails (timeout of 10 seconds is past and no answer), try another ip
with tcp 443 and wait 1 second for reply (443 tcp is usually left open for
https).
If that too fails, assume that the user is again visiting NSA-like
institution but which luckily has a local proxy (which allows only for tcp
port 80 and 443 connections for that matter).

This is just some thoughts of me how OpenVPN should treat the --remote
option in the future.
I'm hoping that someone picks this up to start a discussion.

Henno

--0016e6d6440e66477c048a6c1364
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello!<div><br><div class=3D"gmail_quote">2010/7/2 David Sommerseth <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:openvpn.list@...1114...">openvpn.list@...1386...=
114...</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div class=3D"im">On 02/07/10 19:38, Henno T=C3=A4ht wrote:<br>
&gt; Hello!<br>
&gt;<br>
&gt; Can anyone experienced and helpful scribble a little guide how to have=
<br>
&gt; the same OpenVPN server listening both on 1194 UDP (reason: fast,<br>
&gt; preferable) and 443 TCP (reason: always works, fallback)?<br>
<br>
</div>That is not possible. =C2=A0OpenVPN can only listen to TCP or UDP, no=
t both.<br>
=C2=A0To do this, you will need two independent OpenVPN configurations and<=
br>
run two separate OpenVPN daemons<br>
<br>
Having that said, this is a common question and a feature which is under<br>
evaluation for the next generation OpenVPN.<br></blockquote><div><br></div>=
<div>Great news!</div><div><br></div><div>A client config file should also =
support this. Something like this:</div><div>remote=C2=A0<a href=3D"http://=
198.51.100.15:1194">198.51.100.15:1194</a> proto udp wait 10</div>

<div>remote=C2=A0<a href=3D"http://203.0.113.234:443">203.0.113.234:443</a>=
 proto tcp =C2=A0wait 1</div><div>remote=C2=A0192.168.0.1:8080-&gt;<a href=
=3D"http://203.0.113.234:443">203.0.113.234:443</a> proto=C2=A0tcp wait 1</=
div><div><br></div><div>

Explanation:</div><div>First try direct connection to udp port 1194, wait 1=
0 seconds (should be enough to survive OpenVPN server restarts after config=
 change).</div><div>If that fails (timeout of 10 seconds is past and no ans=
wer), try another ip with tcp 443 and wait 1 second for reply (443 tcp is u=
sually left open for https).</div>

<div>If that too fails, assume that the user is again visiting NSA-like ins=
titution but which luckily has a local proxy (which allows only for tcp por=
t 80 and 443 connections for that matter).</div><div><br></div><div>This is=
 just some thoughts of me how OpenVPN should treat the --remote option in t=
he future.=C2=A0</div>

<div>I&#39;m hoping that someone picks this up to start a discussion.</div>=
<div><br></div><div>Henno</div></div></div>

--0016e6d6440e66477c048a6c1364--

