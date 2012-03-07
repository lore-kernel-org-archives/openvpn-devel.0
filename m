MIME-Version: 1.0
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 7 Mar 2012 07:48:32 -0500
Message-ID: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
Content-Type: multipart/alternative; boundary=20cf303f6c361daf4004baa696d8
Subject: [Openvpn-devel] 2.3alpha1 fails on OS X when the --up argument
 contains more than an execution path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--20cf303f6c361daf4004baa696d8
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

I'm the developer for Tunnelblick (open source GUI for OS X), having taken
over from Angelo Laub a couple of years ago. I'd like to make a beta of
Tunnelblick with OpenVPN 2.3alpha1 available for testing, but the alpha has
a bug that makes it useless for most users of Tunnelblick. Lots of people
use Tunnelblick betas, so it would be a good way to get 2.3alpha1 into the
hands of a lot of people -- there were more than 30,000 downloads of the
last beta in the ten days it was available. (Users can easily switch back
to using OpenVPN 2.2.1 with two clicks in the Tunnelblick GUI, so there's
not much downside for them to try it.

Almost all Tunnelblick users use the standard Tunnelblick up/down scripts,
which fail on 2.3alpha1. I don't want to provide a beta of Tunnelblick that
includes OpenVPN 2.3alpha1 if it will only work for a small percentage of
users.

I don't know OpenVPN well enough to work on this, so Samuli Sepp=E4nen
suggested that I email to this mailing list. Could one of you developers
provide a patch to 2.3alpha1 that fixes it? I would rather not wait until
alpha2 to start testing.


*Details
*

OpenVPN 2.3alpha1 fails when the argument to "--up" contains more than an
execution path. The problem also occurs for the "--down" option and the new
"--route-pre-down" option (and presumably any other options that take more
than just an execution path).

OpenVPN 2.2.1 and earlier work fine with an identical command line.

This happens on OS X; I don't know about other platforms but I assume
option processing is not very platform specific.

2.3alpha1 is apparently treating the entire argument that follows "--up" as
the path for a file to execute, instead of treating it as a shell command
consisting of a path optionally followed by arguments.

On 2.3alpha1:

     test jkb$ *openvpn-2.3-alpha1/openvpn --config
/private/tmp/test/config.ovpn  --up "/private/tmp/test/up.sh  -x"*
     Options error: --up script fails with '/private/tmp/test/up.sh  -x':
No such file or directory
     Options error: Please correct these errors.
     Use --help for more information.

But on 2.2.1:
     test jkb$ *openvpn-2.2.1/openvpn --config
/private/tmp/test/config.ovpn --up "/private/tmp/test/up.sh  -x"*
     Wed Mar  7 07:30:33 2012 OpenVPN 2.2.1 i386-apple-darwin10.8.0 [SSL]
[LZO2] [PKCS11] [eurephia] built on Mar  1 2012
     Enter Auth Username:
     Wed Mar  7 07:30:46 2012 ERROR: Auth username is empty
     Wed Mar  7 07:30:46 2012 Exiting

And
     test jkb$ *openvpn-2.3-alpha1/openvpn --config
/private/tmp/test/config.ovpn  --up "/private/tmp/test/up.sh"*
     Wed Mar  7 07:35:56 2012 OpenVPN 2.3-alpha1 i386-apple-darwin10.8.0
[SSL (OpenSSL)] [LZO2] [eurephia] [MH] [PF_INET6] [IPv6 payload 20110522-1
(2.2.0)] built on Mar  1 2012
     Enter Auth Username:
     Wed Mar  7 07:35:59 2012 ERROR: Auth username is empty
     Wed Mar  7 07:35:59 2012 Exiting due to fatal error

Notes:

   1. The above commands are simplified to show the problem. They won't
   actually work for making a connection.
   2. The double-quotes in the above command lines are used so bash will
   create single arguments that contain spaces. When starting OpenVPN,
   Tunnelblick uses an OS X interface that provides the arguments as separa=
te
   items, so they don't need to be enclosed in quotes. The actual argument
   that OpenVPN is passed will contain quotes if the path contains spaces.

If the path contains spaces, OpenVPN will be passed


     "/private/tmp/test path with spaces/up.sh"  -x

If the path does not contain spaces, OpenVPN will be passed

     /private/tmp/test/up.sh -x


I'd appreciate any help on this that I can get.

Thanks,

Jon Bullard

--20cf303f6c361daf4004baa696d8
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div>I&#39;m the developer for Tunnelblick (open source GUI for OS X), havi=
ng taken over from Angelo Laub a couple of years ago. I&#39;d like to make =
a beta of Tunnelblick with OpenVPN 2.3alpha1 available for testing, but the=
 alpha has a bug that makes it useless for most users of Tunnelblick. Lots =
of people use Tunnelblick betas, so it would be a good way to get 2.3alpha1=
 into the hands of a lot of people -- there were more than 30,000 downloads=
 of the last beta in the ten days it was available. (Users can easily switc=
h back to using OpenVPN 2.2.1 with two clicks in the Tunnelblick GUI, so th=
ere&#39;s not much downside for them to try it.</div>

<div><br></div><div>Almost all Tunnelblick users use the standard Tunnelbli=
ck up/down scripts, which fail on 2.3alpha1. I don&#39;t want to provide a =
beta of Tunnelblick that includes OpenVPN 2.3alpha1 if it will only work fo=
r a small percentage of users.</div>

<div><br></div><div>I don&#39;t know OpenVPN well enough to work on this, s=
o Samuli Sepp=E4nen suggested that I email to this mailing list. Could one =
of you developers provide a patch to 2.3alpha1 that fixes it? I would rathe=
r not wait until alpha2 to start testing.</div>

<div><br></div><div><br></div><div><b>Details<br></b></div><div><br></div><=
div>OpenVPN 2.3alpha1 fails when the argument to &quot;--up&quot; contains =
more than an execution path.=A0The problem also occurs for the &quot;--down=
&quot; option and the new &quot;--route-pre-down&quot; option (and presumab=
ly any other options that take more than just an execution path).</div>

<div><br></div><div>OpenVPN 2.2.1 and earlier work fine with an identical c=
ommand line.</div><div><br></div><div>This happens on OS X; I don&#39;t kno=
w about other platforms but I assume option processing is not very platform=
 specific.</div>

<div><br></div><div>2.3alpha1 is apparently treating the entire argument th=
at follows &quot;--up&quot; as the path for a file to execute, instead of t=
reating it as a shell command consisting of a path optionally followed by a=
rguments.</div>

<div><br></div><div>On 2.3alpha1:</div><div><br></div><div><div>=A0 =A0 =A0=
test jkb$ <b>openvpn-2.3-alpha1/openvpn --config /private/tmp/test/config.o=
vpn =A0--up &quot;/private/tmp/test/up.sh<span style=3D"background-color:rg=
b(255,255,102)"> =A0-x</span>&quot;</b></div>

<div>=A0 =A0 =A0Options error: --up script fails with &#39;/private/tmp/tes=
t/up.sh =A0-x&#39;: No such file or directory</div><div>=A0 =A0 =A0Options =
error: Please correct these errors.</div><div>=A0 =A0 =A0Use --help for mor=
e information.</div>

</div><div><br></div><div><div>But on 2.2.1:</div><div>=A0 =A0 =A0<font col=
or=3D"#999999">test jkb$</font> <b>openvpn-2.2.1/openvpn --config /private/=
tmp/test/config.ovpn --up &quot;/private/tmp/test/up.sh =A0-x&quot;</b></di=
v><div>

=A0 =A0 =A0Wed Mar =A07 07:30:33 2012 OpenVPN 2.2.1 i386-apple-darwin10.8.0=
 [SSL] [LZO2] [PKCS11] [eurephia] built on Mar =A01 2012</div><div>=A0 =A0 =
=A0Enter Auth Username:</div><div>=A0 =A0 =A0Wed Mar =A07 07:30:46 2012 ERR=
OR: Auth username is empty</div>

<div>=A0 =A0 =A0Wed Mar =A07 07:30:46 2012 Exiting</div></div><div><br></di=
v><div>And</div><div><div>=A0 =A0 =A0<font color=3D"#666666">test jkb$</fon=
t> <b>openvpn-2.3-alpha1/openvpn --config /private/tmp/test/config.ovpn =A0=
--up &quot;/private/tmp/test/up.sh&quot;</b></div>

<div>=A0 =A0 =A0Wed Mar =A07 07:35:56 2012 OpenVPN 2.3-alpha1 i386-apple-da=
rwin10.8.0 [SSL (OpenSSL)] [LZO2] [eurephia] [MH] [PF_INET6] [IPv6 payload =
20110522-1 (2.2.0)] built on Mar =A01 2012</div><div>=A0 =A0 =A0Enter Auth =
Username:</div>

<div>=A0 =A0 =A0Wed Mar =A07 07:35:59 2012 ERROR: Auth username is empty</d=
iv><div>=A0 =A0 =A0Wed Mar =A07 07:35:59 2012 Exiting due to fatal error</d=
iv></div><div><br></div><div>Notes:</div><div><ol><li>The above commands ar=
e simplified to show the problem. They won&#39;t actually work for making a=
 connection.<br>

</li><li>The double-quotes in the above command lines are used so bash will=
 create single arguments that contain spaces. When starting OpenVPN, Tunnel=
blick uses an OS X interface that provides the arguments as separate items,=
 so they don&#39;t need to be enclosed in quotes. The actual argument that =
OpenVPN is passed will contain quotes if the path contains spaces.</li>

</ol></div><blockquote style=3D"margin:0 0 0 40px;border:none;padding:0px">=
<div><div><div>If the path contains spaces, OpenVPN will be passed</div></d=
iv></div></blockquote><div><br></div><blockquote style=3D"margin:0 0 0 40px=
;border:none;padding:0px">

<div>=A0 =A0 =A0&quot;/private/tmp/test path with spaces/up.sh&quot; =A0-x<=
/div><div><br></div><div>If the path does not contain spaces, OpenVPN will =
be passed</div><div><br></div><div>=A0 =A0 =A0/private/tmp/test/up.sh -x</d=
iv></blockquote>

<div><br></div><div>I&#39;d appreciate any help on this that I can get.</di=
v><div><br></div><div>Thanks,</div><div><br></div><div>Jon Bullard</div><di=
v><br></div>

--20cf303f6c361daf4004baa696d8--

