Message-ID: <554D4B33.4060401@...1114...>
Date: Sat, 09 May 2015 01:48:03 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1430518805.21119.82.camel@...1866...>	<CAOazyz0KoSiUn=DA_0QBf3JXU=eQ1NJGQgtRw0z7DCo+E066Kw@...278...>
	<1430523426.21119.113.camel@...1866...>
In-Reply-To: <1430523426.21119.113.camel@...1866...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="DkMqbMxwSgcmiIF0IDaL2nrOmlc76vo15"
Subject: Re: [Openvpn-devel] [PATCH] Use vfork() in openvpn_execve() instead
 of fork()
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DkMqbMxwSgcmiIF0IDaL2nrOmlc76vo15
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 02/05/15 01:37, David Woodhouse wrote:
> On Sat, 2015-05-02 at 01:54 +0300, Alon Bar-Lev wrote:
>> not sure what systemd-ask-password is, but the proper interaction=20
>> with openvpn process in this case is via the management interface,=20
>> there is an example here[1].
>=20
> It's a tool which gets spawned to ask the user (sysadmin) for a
> password. I've never actually seen it working in practice, but I think
> it's something vaguely similar to ssh-askpass.

systemd-ask-password is a utility which prepares systemd to query the
user for some information, usually a password or PIN.

Very simply said, it prepares a pipe to a front-end which does the real
querying.  So consider systemd-ask-password the back-end side.  The
front-end presents the prompt it received from the back-end, collects
the user input and  sends the result back to the forked out process
which then ends up in OpenVPN in the end.  The idea around this concept
is that systemd (via for example systemd-tty-ask-password-agent) may not
need to kick off the front-end if it already have cached the information
needed.

With that said, I mentioned earlier today that there is some talks about
improving the whole query interface in systemd, where a DBus interface
will be available.  Thus removing the need to fork out this little
helper program.

> I think it's designed to work even during a graphical boot sequence
> before any real UI is present (for example for asking for root file
> system encryption passphrases).

That is correct.


> Perhaps one might argue this is simply a bug in OpenVPN =97 it
> *shouldn't* be spawning the systemd password request tool in that
> case. And that's 100% true for the PIN request, since the pkcs11
> -helper documentation explicitly forbids the application from forking
> in the PIN callback.

I agree this is a misbehaviour in OpenVPN, when it does things which is
clearly stated what is forbidden.


>> what we do require is to move the entire processing of remote
>> connection details, certificate enumeration and private key operations
>> into the management interface, removing the PKCS#11 support from
>> openvpn core, and move it into the management implementation, hence
>> will always run at the user context. We discussed that in the past,
>> not sure if someone promoted it.
>=20
> I think the management interface has been able to provide a
> certificate for a while. It's recently also gained the ability to
> perform the signing step too, so we really can offload it all now.

Yes, there are some features available via the management interface
which allows an external process to do the RSA signing and verification,
iirc.  I also believe interface is used on Android, to be able to make
usage of the keystorage in Android.

> Persuading the OpenVPN developers that such should be the *only*
> possible mode of operation, however, is a different prospect :0

If it breaks existing users configs and setups, it's generally a no-go.
 We've already tried that a few times, and reverted when enough users
started complaining.

> Although I do wonder how many other provider modules are going to
> suffer similar issues, and it doesn't *hurt* to be defensive in
> OpenVPN and use vfork() instead of fork(). I don't really see the down
> -side.

I've spent my evening reading more about vfork() and fork().  I've based
my trust this time in two books [1] on Linux system programming.

Both books are really clear that vfork() should be avoided, and even
claiming it was a mistake by introducing that syscall in Linux.  Its
semantic can in many cases cause other issues, such as the execve()'d
process not using _exit() but exit().  This can cause plenty of mess in
regards to flushing of buffers and other file descriptors.

The reason I believe vfork() "works" and fork() "does not work" is
simply due to the fact that fork() does a copy-on-write-copy to the
child, which includes the inheritance of the atexit() handlers.  I
believe also that p11-helper also uses pthreads_atexit(), which is also
executed when a fork()ed process exits.  When uysing vfork(), this copy
does not happen at all, and then execve() takes over completely.  So
when vfork() exits, it doesn't do anything than just "die" (*as long as*
_exit() is used).  It is in fact utterly important that exit() is not
used in a process which has been vfork()ed, it has to be _exit() to
avoid undefined behaviours.

Then regarding to standards and portability.  SUSv3/POSIX.1-2001 lists
vfork() as deprecated, and SUSv4/POSIX.1-2008 doesn't even include vfork().

[1] - Linux System Programming, Rob Love
    - The Linux Programming Interface, Michael Kerrisk


>> NAK my side, openvpn code is ok.
>=20
> Well, not quite. Even apart from the 'be liberal in what you accept'
> principle as discussed above, the systemd_ask_password handling is
> clearly broken. And actually further testing shows that part is *not*
> fixed by my patch, since I only modified openvpn_execve(). We can't
> use vfork() in openvpn_popen() because that does other things between
> the fork and the execve().

I acknowledge that you have found a potential solution for solving this
issue.  I'm grateful for that!  But I do question if it is the proper
solution.

The current patch gets a NAK from me as well.  When two system
programming books recommend strongly /not/ to use vfork() but fork(),
plus the deprecation in SUS, it scares me too just much to make this
change on all systems which supports vfork() - not just Linux systems
with systemd.

As a temporarily hack, I could maybe accept it if we can contain the
fork() to vfork() change to a scenario where ENABLE_SYSTEMD in addition
to HAVE_VFORK_H/HAVE_WORKING_VFORK; I'll have to sleep on that for a
couple of days first.  But this may just as well get NAK from the other
developers.

Anyone got better ideas?  The Management interface is one option which
has been mentioned, but I am not too happy about that implementation
(mentioned in another e-mail).  But if it can be made to work more
smoothly, I prefer that over using a deprecated libc/system call.


--=20
kind regards,

David Sommerseth


--DkMqbMxwSgcmiIF0IDaL2nrOmlc76vo15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVNSzQACgkQDC186MBRfrqQ6gCdHnoEI/L1xF0UsBLcQyDXjdBi
PLQAnAxM7CxGsTc0epf0doDVGOwmHLBC
=j7j0
-----END PGP SIGNATURE-----

--DkMqbMxwSgcmiIF0IDaL2nrOmlc76vo15--

