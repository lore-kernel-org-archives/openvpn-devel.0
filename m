MIME-Version: 1.0
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sun, 21 Oct 2012 18:40:08 -0400
Message-ID: <CAEsd45Q6PbNZoutzKMXVP7xPSEmb0C3A3jQEQYidcTRGJaXTmQ@...278...>
Content-Type: multipart/alternative; boundary=047d7b671efaad2b1e04cc996d46
Subject: [Openvpn-devel] Bug in program, bug in documentation,
	or something else?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--047d7b671efaad2b1e04cc996d46
Content-Type: text/plain; charset=UTF-8

A Tunnelblick user has reported odd behavior with name resolution failures.
I can't tell if it is a bug in OpenVPN, a bug in the documentation, or
something else. The behavior is apparently the same in OpenVPN 2.2.1 and
2.3alpha1.

The 2.3 man page says:

> --resolv-retry n
>      If hostname resolve fails for --remote, retry resolve for n seconds
> before failing.
>      Set n to "infinite" to retry indefinitely.
>      By default, --resolv-retry infinite is enabled.  You can disable by
> setting n=0.


But the behavior seems very different:

If a name resolution failure (caused, for example, by losing the network
connection) occurs
and --resolv-retry is:

1, the first resolution failure terminates the connection;
5, resolution attempts are made dozens of times per second, seemingly
forever; or
10, resolution attempts are made every five seconds, seemingly forever.


Any ideas if this is a program bug, a documentation bug, or something else,
for example, a problem that only occurs on OS X?

--047d7b671efaad2b1e04cc996d46
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A Tunnelblick user has reported odd behavior with name resolution failures.=
 I can&#39;t tell if it is a bug in OpenVPN, a bug in the documentation, or=
 something else. The behavior is apparently the same in OpenVPN 2.2.1 and 2=
.3alpha1.<div>


<br></div><div>The 2.3 man page says:</div><div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">--resolv-r=
etry n<br>


=C2=A0 =C2=A0 =C2=A0If hostname resolve fails for --remote, retry resolve f=
or n seconds before failing.<br>=C2=A0 =C2=A0 =C2=A0Set n to &quot;infinite=
&quot; to retry indefinitely.<br>=C2=A0 =C2=A0 =C2=A0By default, --resolv-r=
etry infinite is enabled. =C2=A0You can disable by setting n=3D0.</blockquo=
te>


</div><div><br></div><div>But the behavior seems very different:</div><div>=
<br></div><div>If a name resolution failure (caused, for example, by losing=
 the network connection) occurs</div><div>and --resolv-retry is:</div>

<div>
<blockquote style=3D"margin:0px 0px 0px 40px;border:none;padding:0px">1, th=
e first resolution failure terminates the connection;<br>5, resolution atte=
mpts are made dozens of times per second, seemingly forever; or<br>10, reso=
lution attempts are made every five seconds, seemingly forever.<br>


</blockquote><div><br></div><div>Any ideas if this is a program bug, a docu=
mentation bug, or something else, for example, a problem that only occurs o=
n OS X?</div></div>

--047d7b671efaad2b1e04cc996d46--

