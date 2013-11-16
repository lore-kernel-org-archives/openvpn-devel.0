Message-ID: <52878BCA.70307@...1114...>
Date: Sat, 16 Nov 2013 16:14:18 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <l142b7$15v$1@...1062...>
In-Reply-To: <l142b7$15v$1@...1062...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="JWQbQH9TBM82ikXrsTo1tOcSwuFQvwOTP"
Subject: Re: [Openvpn-devel] [PATCH] Fix file access checks when using
	--chroot
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Josh Cepek <josh.cepek@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JWQbQH9TBM82ikXrsTo1tOcSwuFQvwOTP
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 15. sep. 2013 11:42, Josh Cepek wrote:
> The attached patch fixes bug #330 which causes a regression from 2.2.x
> where valid configs won't work in certain cases when using --chroot. A
> more terse overview of the change is presented in the patch itself.
>=20
> The additional error checking for files & scripts introduced for 2.3
> don't take into account that the file path changes after the chroot
> operation, preventing options_postprocess_filechecks() from checking the
> proper paths.
>=20

Hi Josh,

Thanks a lot for your patch!  First of all, I fully agree to the what
this patch resolves, and I agree some of code as well.  But I'm giving
it a NAK currently.

I'm not fully convinced we're doing it the right way.  I find the
complexity a bit too much.  But I'm also struggling to instantly see a
better approach.  So I just wanted to share my thoughts, and we can
hopefully find a better approach.

What I'm struggling with is that we're passing struct options just to
get access to o->chroot_dir.  But I see your approach can seem cleaner
this way than pass a char *chroot_dir.

Further, we change a lot of places (the majority in fact) which does not
depend on chroot at all.  That is my biggest issue.  So I'm wondering if
we should not touch check_file_access() at all and rather have a
separate check_file_access_chroot() which takes the chroot_dir as an
additional const char * variable.  This function will just do your
gc_arena stuff, to add the chroot dir to the file name, and pass that
directly to check_file_access().  And this function will be used those
few places it's really needed to check for files/dirs inside a chroot.

In this way, we simplify some of the code paths and avoid introducing
CHKACC_NOOP and CHKACC_CHROOT, also the set_user_script() has access to
struct options, so it can use check_file_access_chroot() directly too.

Does this sounds reasonable to you?

Then there's a few other minor issues.  You declare variables in middle
of code blocks.  This works fine reasonable compilers.  But some Windows
compilers (Visual Studio, I'm looking at you) will choke on that.  So we
must declare all variables at the top of the block.

And there are also several whitespace issues.  Please ensure your code
is aligned well through 'git diff', that's an easy way to spot these
issues.  An example is like this:

@@ -4017,7 +4046,8 @@ static void
 set_user_script (struct options *options,
                 const char **script,
                 const char *new_script,
-                const char *type)
+                const char *type,
+     int access_flags)


Again, thanks a lot for you patch!  I like that it resolves a real issue
we've been seeing, and I hope we can find a good way how to improve this
for full inclusion.


--=20
kind regards,

David Sommerseth


--JWQbQH9TBM82ikXrsTo1tOcSwuFQvwOTP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKHi8oACgkQDC186MBRfrqV9ACdG7b5YEmlY7BwDdnMVfqEx7Q1
BewAn2dMfjdLz96QGooXGeniPoc2etUY
=uCwv
-----END PGP SIGNATURE-----

--JWQbQH9TBM82ikXrsTo1tOcSwuFQvwOTP--

