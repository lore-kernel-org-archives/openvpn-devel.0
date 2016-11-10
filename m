References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-8-git-send-email-heiko.hund@...1489...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b03806c9-d95f-9e2f-01a4-57f312f21e0f@...2080...>
Date: Thu, 10 Nov 2016 16:01:20 +0100
MIME-Version: 1.0
In-Reply-To: <1477672963-5724-8-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="N6KUhnXaLILhQe9cWk5lekcTteEI0RlNF"
Subject: Re: [Openvpn-devel] [PATCH 7/7] Add gc_arena to struct argv to save
 allocations
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N6KUhnXaLILhQe9cWk5lekcTteEI0RlNF
Content-Type: multipart/mixed; boundary="rsiMxBn3v2sQmsrcXV9OEdOJKQp2jdSFV";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b03806c9-d95f-9e2f-01a4-57f312f21e0f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 7/7] Add gc_arena to struct argv to save
	allocations
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-8-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-8-git-send-email-heiko.hund@...1489...>

--rsiMxBn3v2sQmsrcXV9OEdOJKQp2jdSFV
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/10/16 18:42, Heiko Hund wrote:
> With the private gc_arena we do not have to allocate the strings
> found during parsing again, since we know the arena they are
> allocated in is valid as long as the argv vector is.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/argv.c                   | 37 ++++++++++++++++++------------=
------
>  src/openvpn/argv.h                   |  1 +
>  tests/unit_tests/openvpn/test_argv.c | 21 ++++++++++++++++++++
>  3 files changed, 40 insertions(+), 19 deletions(-)
>=20
> diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
> index 664785b..9f139bb 100644
> --- a/src/openvpn/argv.c
> +++ b/src/openvpn/argv.c
> @@ -62,6 +62,7 @@ argv_init (struct argv *a)
>    a->capacity =3D 0;
>    a->argc =3D 0;
>    a->argv =3D NULL;
> +  a->gc =3D gc_new ();
>    argv_extend (a, 8);
>  }

Any specific reason we want to keep our own gc_arena on argv?  Why not
pass an existing gc_arena pointer to the argv_new()/argv_init()
functions?  I believe the majority of places argv functions are called
already have a gc_arena prepared.  But I do see it may complicate the
argv_reset() function.


> +  const char *args[] =3D {
> +    "good_tools_have_good_names_even_though_it_might_impair_typing",
> +    "--long-opt=3Dlooooooooooooooooooooooooooooooooooooooooooooooooong",
> +    "--long-cat=3Dloooooooooooooooooooooooooooooooooooooooooooooooooooon=
ger",

Great examples! :)

> +    "file_with_very_descriptive_filename_that_leaves_no_questions_open.j=
pg.exe"

And this made me laugh!  Leaves absolutely no open questions ;)



When looking over the final argv.c file, I also wonder about this:

const char *
argv_str (const struct argv *a, struct gc_arena *gc, const unsigned int
flags)
{
  return print_argv ((const char **)a->argv, gc, flags);
}

Why not use our own internal gc_arena?  Especially when considering the
current callers:

void
argv_msg (const int msglev, const struct argv *a)
{
  struct gc_arena gc =3D gc_new ();
  msg (msglev, "%s", argv_str (a, &gc, 0));
  gc_free (&gc);
}

The situation is identical for argv_msg_prefix().

AFAICS, struct argv objects doesn't live very long, so it would be
minimal impact on the overall memory usage.  At least when we have our
own internal gc_arena.  Using a more global gc_arena (provided via
argv_new()/argv_init()) makes the object live somewhat longer.  But even
most of those places the gc_arenas doesn't live very much longer.


The overall impression I have is that this patch-set is truly valuable
and does important clean-ups and fixes a lot of ambiguity and odd
behaviours.  And getting proper unit tests on top of it all is truly
great!  But there's still some improvements needed in the last 3 patches
(patch 5, 6 and 7).


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--rsiMxBn3v2sQmsrcXV9OEdOJKQp2jdSFV--

--N6KUhnXaLILhQe9cWk5lekcTteEI0RlNF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYJIvAAAoJEIbPlEyWcf3yo9cP/RP8I/miyAGGRpG3M+6LlVKO
mVSEKS8txpUxNyfESPTeImhz74voCbK/5BNjGuZtO41Pksmt4VHOIr7dKsUjF4PG
XQzGXM+2nJNj7VNM/1+/1GwkqWfxEcQC/UujPbLdO9FoUTvNacziJVHVZosGlOzA
aRWDWhBD/OGOlr9G3cOLnXygKsGU79PmgtFPmmVdbArfIhGcDR5bar8oUZQ4BE/i
xMuT4tTOhih68Rl/7QFKzK+P2mj8eZtvE9sWPf5F+wN0/bTCq989ypKbS4TKjqyP
yS3PDsdv85g7iUeaKfOvij2MkHDuk0o4XDndIn4jDwZ2ubJxZ4r5e29qx739iPc7
sBytofQftrUGMjsKrXoBAKqyKhB69m3s2l09QolyYmLPw/+5uH1DTn9gY8BE5L7Y
pYxxOKXjnzEPCHGgebdoWu5MjmoUm8JKLveHHP/5e8fQArIaQGMg0Ls7g6h3jV6G
vExMoRpJTdDjqsfqXh/qXZyYQNWqFX2TbWT20LnkYnVm0TT7EkMiLirV1+TAHoHx
O4rg4YskY5KaaGLf3vON8g60nuhUQ0+po9OYfWPMm9rYfzMdMFXibZ3ASY+sjU2z
iNqRyfD6Ydb+Uw7qNDw9CFBSWMLqiTKREx6hspa0kHeGfG/Babrb8EwM6ekBBuIR
Aj0RPQvvL7YM1ex0APF3
=EeU+
-----END PGP SIGNATURE-----

--N6KUhnXaLILhQe9cWk5lekcTteEI0RlNF--

