Message-ID: <554D13DE.1010406@...1114...>
Date: Fri, 08 May 2015 21:51:58 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1430942786-31419-1-git-send-email-openvpn.list@...1114...>
	<1430952572.31614.10.camel@...1866...>
In-Reply-To: <1430952572.31614.10.camel@...1866...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6ePdnD11Q92VoI8hE6F0UUEr297QsfSdp"
Subject: Re: [Openvpn-devel] [PATCHv2 0/4] Reworking the interface for
 querying users
Reply-To: openvpn-users@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6ePdnD11Q92VoI8hE6F0UUEr297QsfSdp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07/05/15 00:49, David Woodhouse wrote:
> On Wed, 2015-05-06 at 22:06 +0200, David Sommerseth wrote:
>>
>> All patches has been tested locally with different configurations,
>> requiring username, password and passphrases to PKCS#12 files.  The
>> challenge/response interface has not been tested, as well as PKCS#11.
>> All runs via valgrind shows no memory leaks with this new
>> implementation.
>=20
> I've given some pointers in ticket 538 on how you can test PKCS#11
> without actually having a hardware token =E2=80=94 you can use GNOME keyr=
ing in many cases, or in this case where you really want to test=20
> password input,
> you can use a NSS "softokn" database.
>=20
> Even if I make these patches build by fixing the issue that leads to
> libsystemd_MODVERSION being set to '219\n219' when both systemd.pc and
> libsystemd.pc exist, they still don't solve the problem described in
> that ticket.
>=20
> You are still calling fork() from a context (the PIN request callback
> from pkcs11-helper) in which it is forbidden, and in which it
> deadlocks:
>=20
> #2  0x00007ffff7d9c096 in _pkcs1h_threading_mutexLockAll () at pkcs11h-th=
reading.c:306
> #3  0x00000038412c8362 in __libc_fork () at ../sysdeps/nptl/fork.c:89
> #4  0x0000003841a0f4a5 in __fork () at pt-fork.c:25
> #5  0x000000000042893b in openvpn_popen (a=3Da@...1851...=3D0x7fffffff9be=
0, es=3Des@...1851...=3D0x0) at misc.c:374
> #6  0x000000000046f0e8 in get_console_input_systemd (capacity=3D4096, inp=
ut=3D0x7fffffffb1f2 "", echo=3Dfalse,=20
>     prompt=3D0x73cdc8 "Enter PIV_II (PIV Card Holder pin) token Password:=
") at console_systemd.c:72
> #7  query_user_exec (setup=3D<optimized out>) at console_systemd.c:111
> #8  0x0000000000427aed in get_user_pass_cr (up=3Dup@...1851...=3D0x7fffff=
ffa1f0, auth_file=3D<optimized out>, auth_file@...1851...=3D0x0,=20
>     prefix=3Dprefix@...1851...=3D0x7fffffff9df0 "PIV_II (PIV Card Holder =
pin) token", flags=3Dflags@...1851...=3D21, auth_challenge=3Dauth_challenge=
@...1851...=3D0x0) at misc.c:1144
> #9  0x0000000000435711 in get_user_pass (flags=3D21, prefix=3D0x7fffffff9=
df0 "PIV_II (PIV Card Holder pin) token", auth_file=3D0x0, up=3D0x7fffffffa=
1f0) at misc.h:268
> #10 _pkcs11_openvpn_pin_prompt (global_data=3D<optimized out>, user_data=
=3D<optimized out>, token=3D<optimized out>, retry=3D<optimized out>, pin=
=3D0x7fffffffc250 "K{`f=3D",=20
>     pin_max=3D1024) at pkcs11.c:236
> #11 0x00007ffff7d9e0cb in _pkcs11h_session_login (session=3D0x6e9220, is_=
publicOnly=3Dis_publicOnly@...1851...=3D0, readonly=3Dreadonly@...1851...=
=3D1, user_data=3D0x0,=20
>     mask_prompt=3D<optimized out>) at pkcs11h-session.c:1023
>=20
> Perhaps the solution might be to *always* operate in 'management
> interface' mode, and to shift all the direct console access out to a
> separate process. *That* process would be permitted to run fork(),
> when the core OpenVPN process requests a password...

THanks a lot for a lot of value input, both here and in the trac ticket!
 I'll go through that and digest it carefully.

In regards to fork()/vfork().  Personally, I'm not against changing it.
 However, I don't know what the other reviewers may think.  I'll dig
deeper into this matter and.

Having that said, looking isolated on systemd and pkcs#11.  I've heard
from a few of the systemd developers that they are going to retire the
current approach for quering for user input for something more flexible.
 And they point at some kind of DBus interface as a natural next step
(it has not yet materialized into code, so I'm currently sitting on the
fence).  That means that OpenVPN would not fork at all, it would send a
request via a DBus interface describing what the user (or session) must
provide. And the result is then returned via DBus.  And this is what
I've had in mind when changing these code paths.  Which is also the
reason that console_systemd.c isn't compiled unless configured with
--enable-systemd ... to easier split out code which may make the
non-Linux guys of the openvpn community scream and panic when seeing
DBus library dependencies.

The current management interface works fairly well, but it has
limitations which can cause some cause some hang-ups due to the single
threaded nature of OpenVPN - there are also some who claims they notice
performance drops when management commands are processed.  I've not dug
into these claims yet, but it doesn't surprise me if there is something
to it.  In addition the connection to the management interface is
basically not authenticated (well, you can have a password but it's a
clear-text connection).

Again, thanks a lot for all your input!  I'm fairly loaded with work, so
openvpn does unfortunately suffer from that from my part.  But I do
appreciate your involvement!


--=20
kind regards,

David Sommerseth


--6ePdnD11Q92VoI8hE6F0UUEr297QsfSdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVNE+AACgkQDC186MBRfrq+zACggcNm91BB2sedmm86TdVOpC6i
NAUAoIDufjyXfCYUA9oK0H0v3e1BJDSz
=Dkac
-----END PGP SIGNATURE-----

--6ePdnD11Q92VoI8hE6F0UUEr297QsfSdp--

