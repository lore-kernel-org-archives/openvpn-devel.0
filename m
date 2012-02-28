Message-ID: <4F4D1C29.5060606@...1114...>
Date: Tue, 28 Feb 2012 19:25:45 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
In-Reply-To: <CAOazyz0x4hKsREcGi+9TGc+AO0d+i1d5qbmPJ2hQfCsUbVanNQ@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: =?UTF-8?B?Q2Fyc3RlbiBLcsO8Z2Vy?= <C.Krueger@...448...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/12 19:07, Alon Bar-Lev wrote:
> 2012/2/28 Carsten Kr=C3=BCger <C.Krueger@...448...>:
>>> * New OpenVPN-GUI
>>=20
>> Are there any chances to get full non-admin support for windows in
>> version 2.3 final?
>>=20
>> I mean strict seperation between OpenVPN service running with local
>> system privileges (can modify routes, etc.) and usermode part
>> (command line, maybe GUI) that interacts with user (start/stop
>> tunnel, ask for passphrase, pin for smartcard, etc.).
>>=20
>> In companies that have security in mind it's impossible to allow=20
>> roadwarriors to connect via openvpn because they would need admin=20
>> privileges. Give them only the privilege to start/stop the openvpn
>> service didn't help because they can't supply credentials.
>>=20
>> I'm complaining about this show stoppper for ~4 years :-(
>>=20
>> I personally like openvpn very much and would like to deploy it for=20
>> our users but I've to buy Cisco because the windows client is
>> better.
>=20
> This is *THE* missing functionality in Windows environment. It seems
> that nobody interested in developing proper UI using management
> interface for Windows. Same goes to proper smartcard support.

I believe Jan Just Keijser and Heiko talked about this as well at FOSDEM,
how to provide a better integrated PKCS#11 support in the Windows GUI.
So I would expect this to progress too.  And of course, the new GUI Heiko
writes is using the management interface too, anything else would be
plain stupid these days.

Even though, the new communication pipe between the "helper service" and
openvpn.exe  might gain more features with time, which might cover much
of what the management interface provides today too.  But we're _not_
trying to kill the management interface.

> In Linux I am using OpenVPN using unprivileged user (completely!) the=20
> daemon runs under my own user, see[1].

This new communication pipe should also become available for the *nix
platform too.  Which again should make it easier to implement something
which does not depend on a safe sudo setup too.  Maybe even some
integration against NetworkManager via DBus for the Linux platform?

I'm at least playing with the idea that OpenVPN itself shouldn't
necessarily need to know much about how to configure the TUN/TAP device
and routes for all different platforms.  Rather write platform specific
"service helpers" which does that job via the the communication pipe.

This would make the OpenVPN code base simpler and perhaps even easier to
support more platforms, like Android - and maybe even iPhone and the new
Windows Mobile?


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9NHBQACgkQDC186MBRfrrs8ACfT93nLXZ727QLP24FFs/C5hw0
CSMAn0ECng3+celO1axW27gzyNq6aEJw
=3DtGiN
-----END PGP SIGNATURE-----

