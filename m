Message-ID: <4BC85F4C.8020505@...1338...>
Date: Fri, 16 Apr 2010 14:59:56 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <4BC78077.80301@...1114...> <4BC81AED.8010206@...1338...>
	<4BC824D3.8000008@...1114...>
	<4BC82AF0.5080905@...1114...>
	<20100416093554.GJ12312@...1296...>
	<4BC8385D.8040703@...1114...>
In-Reply-To: <4BC8385D.8040703@...1114...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6C1B5B19AD44B68F466CF8FD"
Subject: Re: [Openvpn-devel] [PATCH] Harden create_temp_filename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C1B5B19AD44B68F466CF8FD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

David Sommerseth wrote:
> On 16/04/10 11:35, Gert Doering wrote:
>> Hi,
>=20
>> On Fri, Apr 16, 2010 at 11:16:32AM +0200, David Sommerseth wrote:
>>> I'll look more into this, as the only advantage is that if open() with
>>> O_EXCL|O_CREAT fails if the file exists, it should be used instead.
>> Unfortunately, this won't help against symlink attacks directed to
>> non-existant files (like "-> /etc/nologin").=20=20
>=20
> That's right, this could create a local DoS.  I'm going to have a more
> careful look at test_file() afterwards.  Considering to make it use
> stat() instead of just trying to open the file for reading.

As Davide already pointed out, the problem is taken care of by open().
So ... there should be no need for additional checking after a
successful open() with O_CREAT|O_EXCL.

(BTW, I thought creat() took a flags parameter, but it only takes a mode
param. My mistake. So you're correct in wanting to use open() instead of
creat().)

To let the code speak, here's my suggestion (not compile-tested):

> do
>   {
>     uint8_t rndbytes[16];
>     const char *rndstr;
>=20
>     ++attempts;
>     mutex_lock_static (L_CREATE_TEMP);
>     ++counter;
>     mutex_unlock_static (L_CREATE_TEMP);
>=20
>     prng_bytes (rndbytes, sizeof rndbytes);
>     rndstr =3D format_hex_ex (rndbytes, sizeof rndbytes, 40, 0, NULL, gc);
>     buf_printf (&fname, PACKAGE "_%s_%s.tmp", prefix, rndstr);
>=20
>     retfname =3D gen_path (directory, BSTR (&fname), gc);
>     if (!retfname)
>       {
>         msg (M_FATAL, "Failed to create temporary filename and path");
>         return NULL;
>       }
>=20
>     /* Atomically create the file.  Errors out if the file already
>        exists.  */
>     fd =3D open (retfname, O_CREAT | O_EXCL | O_WRONLY, S_IRUSR | S_IWUSR=
);
>     if (fd !=3D -1)
>       {
>         close (fd);
>         return retfname;
>       }
>     else if (fd =3D=3D -1 && errno !=3D EEXIST)
>       {
>         /* Something else went wrong, no need to retry.  */
>         struct gc_arena gcerr =3D gc_new ();
>         msg (M_FATAL, "Could not create temporary file '%s': %s",
>              retfname, strerror_ts (errno, &gcerr));
>         gc_free (&gcerr);
>         return NULL;
>       }
>   }
> while (attempts < 6);
>=20
> msg (M_FATAL, "Failed to create temporary file after %i attempts", attemp=
ts);
> return NULL;

(Regarding the code style: The above uses what I had thought would be
the current style, but as I've only read parts of the OpenVPN code, I'm
likely to be wrong. Are there any code-parts / newer code-parts which
should be considered reference material?)

> I've dived into the kernel code to see what it *really* does (when the
> man page are so unclear), and it should behave as those other Unices
> does as well.  So, O_EXCL do make sense to avoid overwriting existing
> files if it is a symlink to an existing file.

IMHO the Linux man-page ist quite clear (I'm using version 3.24):

>        O_EXCL Ensure that this call creates the file: if this flag  is  s=
peci=E2=80=90
>               fied  in  conjunction with O_CREAT, and pathname already ex=
ists,
>               then open() will fail.  The behavior of O_EXCL is  undefine=
d  if
>               O_CREAT is not specified.
>=20
>               When  these two flags are specified, symbolic links are not=
 fol=E2=80=90
>               lowed: if pathname is a symbolic link, then open() fails re=
gard=E2=80=90
>               less of where the symbolic link points to.
>=20
>               O_EXCL  is  only  supported  on NFS when using NFSv3 or lat=
er on
>               kernel 2.6 or later.  In environments where NFS  O_EXCL  su=
pport
>               is not provided, programs that rely on it for performing lo=
cking
>               tasks will contain a race  condition.   Portable  programs =
 that
>               want  to  perform atomic file locking using a lockfile, and=
 need
>               to avoid reliance on NFS support for O_EXCL, can create a u=
nique
>               file  on  the same file system (e.g., incorporating hostnam=
e and
>               PID), and use link(2) to  make  a  link  to  the  lockfile.=
   If
>               link(2)  returns  0,  the  lock  is  successful.  Otherwise=
, use
>               stat(2) on the unique file  to  check  if  its  link  count=
  has
>               increased to 2, in which case the lock is also successful.

Using open with O_CREAT|O_EXCL:
  - makes the atomic guarantee, that the file was created by us (or
    the function call fails)
  - does not follow symlinks (if a symlink exists, it fails)
  - works over NFS for NFS implementations that support O_EXCL. (This
    should apply to all current Linux NFS implementations.)

So, anything remaining that you'd like cleared up?


> Btw ... When diving into the kernel code, I stumbled upon this comment
> in fs/namei.c:1872:
>=20
> 	/* Does someone understand code flow here? Or it is only
> 	 * me so stupid? Anathema to whoever designed this non-sense
> 	 * with "intent.open".
> 	 */
>=20
> Thought that one was worth sharing ;-)

:-D

Cheers
Fabian


--------------enig6C1B5B19AD44B68F466CF8FD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkvIX1IACgkQARH1aMTipzN8cgCgrg/uwRAp+lWp11WnFM5f4A4A
o3wAoNEEU3nln80c8N22VbeshWFnvWmI
=1CzR
-----END PGP SIGNATURE-----

--------------enig6C1B5B19AD44B68F466CF8FD--

