Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <CAEsd45Q6PbNZoutzKMXVP7xPSEmb0C3A3jQEQYidcTRGJaXTmQ@...278...>
Date: Sun, 21 Oct 2012 18:03:38 -0500
Message-Id: <98D66839-416A-4E66-9C88-418A0B1384E8@...1286...>
References: <CAEsd45Q6PbNZoutzKMXVP7xPSEmb0C3A3jQEQYidcTRGJaXTmQ@...278...>
Subject: Re: [Openvpn-devel] Bug in program, bug in documentation,
	or something else?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This sounds like a Tunnelblick failure.  I'd suggest checking with them fir=
st, they do all sorts of things with scripts and such.

Cheers
-----
Eric F Crist



On Oct 21, 2012, at 17:40:08, Jonathan K. Bullard <jkbullard@...277...> wro=
te:

> A Tunnelblick user has reported odd behavior with name resolution failure=
s. I can't tell if it is a bug in OpenVPN, a bug in the documentation, or s=
omething else. The behavior is apparently the same in OpenVPN 2.2.1 and 2.3=
alpha1.
>=20
> The 2.3 man page says:
> --resolv-retry n
>      If hostname resolve fails for --remote, retry resolve for n seconds =
before failing.
>      Set n to "infinite" to retry indefinitely.
>      By default, --resolv-retry infinite is enabled.  You can disable by =
setting n=3D0.
>=20
> But the behavior seems very different:
>=20
> If a name resolution failure (caused, for example, by losing the network =
connection) occurs
> and --resolv-retry is:
> 1, the first resolution failure terminates the connection;
> 5, resolution attempts are made dozens of times per second, seemingly for=
ever; or
> 10, resolution attempts are made every five seconds, seemingly forever.
>=20
> Any ideas if this is a program bug, a documentation bug, or something els=
e, for example, a problem that only occurs on OS X?
> -------------------------------------------------------------------------=
-----
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics
> Download AppDynamics Lite for free today:
> http://p.sf.net/sfu/appdyn_sfd2d_oct_____________________________________=
__________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


