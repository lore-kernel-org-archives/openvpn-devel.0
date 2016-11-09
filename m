References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-6-git-send-email-heiko.hund@...1489...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9c305096-7d5c-5272-85a4-df5b9652a8d7@...2080...>
Date: Wed, 9 Nov 2016 21:41:21 +0100
MIME-Version: 1.0
In-Reply-To: <1477672963-5724-6-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="rULKf636l7CkQNrH721fqBskoiVDvKnV6"
Subject: Re: [Openvpn-devel] [PATCH 5/7] re-implement argv_printf_*()
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
--rULKf636l7CkQNrH721fqBskoiVDvKnV6
Content-Type: multipart/mixed; boundary="0t1q90OEWRnuinCfWmeeIGw1IPOGiKNDn";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net
Message-ID: <9c305096-7d5c-5272-85a4-df5b9652a8d7@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 5/7] re-implement argv_printf_*()
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-6-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-6-git-send-email-heiko.hund@...1489...>

--0t1q90OEWRnuinCfWmeeIGw1IPOGiKNDn
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/10/16 18:42, Heiko Hund wrote:
> The previous implementation had the problem that it was not fully
> compatible with printf() and could only detect % format directives
> following a space character (0x20).
>=20
> It modifies the format string and inserts marks to separate groups
> before passing it to the regular printf in libc. The marks are
> later used to separate the output string into individual command
> line arguments.
>=20
> The choice of '\035' as the argument delimiter is based on the
> assumption that no "regular" string passed to argv_printf_*() will
> ever have to contain that byte (and the fact that it actually is
> the ASCII "group separator" control character, which fits its
> purpose).
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/argv.c                   | 203 ++++++++++++++---------------=
------
>  src/openvpn/argv.h                   |   4 +-
>  src/openvpn/route.c                  |   8 +-
>  src/openvpn/tun.c                    |  22 ++--
>  tests/unit_tests/openvpn/test_argv.c |  34 +++++-
>  5 files changed, 130 insertions(+), 141 deletions(-)

This one was harder to review.  Had to use 'git diff --histogram' to
make it easier to read and parse.  And there I spotted a few odd things.

In the new argv_prep_format() function:

+      if (!in_token)
+        {
+          ++*count;
+          if (f[0])
+            f[j++] =3D delim;
+        }

What is the purpose of the f[0] check?  At first glance it looks like a
NOOP, as you'd expect f[0] to always have a value > 0.  But that is just
until you've parsed something which have been put into f, so I presume
it is some kind of "lock" to not write a delimiter as the first byte in
a string.

Can this whole function be made a bit simpler to understand, as I'm
struggling to fully follow what happens and why?  If I spend enough time
digging into this, I will understand it ... but I prefer code which is
easier to understand at first glance, unless the task can't be resolved
with less complexity.

Suggestion: Why not just do a memmove()/memcpy() to the destination
buffer first, then loop through the destination buffer and flip the
in_token flag and replace spaces with delim where needed, but directly
on the destination buffer?  With this method, you could even skip the
first byte easily before the loop.


So to argv_printf_arglist():

+  va_copy (tmplist, arglist);
+  len =3D vsnprintf (NULL, 0, f, tmplist);
+  va_end (tmplist);
+  if (len < 0)
+    goto out;

This is reasonably okay, but would benefit from a comment simply
explaining what you do here.  I presume it is a kind of estimated
strlen() operation of the final formatted string.

The vsnprintf(NULL, 0, ...) should also have a little note, as this
requires C99 mode to work - otherwise it will return something
completely unexpected.


Otherwise it looks good.  Valgrind tests reports no leaks, t_client.sh
and t_lpback.sh tests are good.  BUT t_cltsrv.sh fails, so that is also
something which needs to be fixed.  The error is:

Wed Nov  9 21:37:26 2016
Wed Nov  9 21:37:26 2016 openvpn_execve: called with empty argv
Wed Nov  9 21:37:26 2016 Exiting due to fatal error

Reverting this patch makes t_cltsrv.sh succeed, so pretty sure this
patch is the one to blame for this error.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--0t1q90OEWRnuinCfWmeeIGw1IPOGiKNDn--

--rULKf636l7CkQNrH721fqBskoiVDvKnV6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYI4nyAAoJEIbPlEyWcf3y558P/jIYHmHrutIziwadP91OY1Th
lCN2hax4qe41glr9vSIc/5e0ogTRvKq6HezWvj20yrorKv6hBymFQ9T4OHU6sPot
sfGsKUlfdC0o1vr7mP9oLHj+UGJjqNnlB4p2J0lJXPGx3kjdJZb4/mTkKvROFaZq
5JxkDsCefxm4GUrvFTUo9TwipxZ8T4ylCgViT5qWbi90yr4FmDst4Iqg0bo2fa0l
gJxiXsvfd+7wLLpKtMROm3fYH/P1nKVNCtttzkrhUtvJCkRaa/9dEtCTo0vcD/zF
04W/yNBkscThUo6ZlLtqfQY+7Kt28SwTIhmBh+jUA7VHoGTkY5ZXkCG6ayOP1JTT
OS3F/KHfFzw3iS4iULKx2AlRNND13oNBxJobnoRShXeQDJb/MjrnOaVJLxVGyUNz
Ei9Q/Ut0LY2dAy1NV9+N8swaB6dMpxGENUclM7Mk9Q5iL1YiBOeJDb22HvLmLrwM
r5iyZZQmamLduvhMPklR11zTNXqbT5RoQyYJT+5gvJFN+ko9nvxsXAQPh7P+uQcO
wwWObxIFCxvN32BepvT7cJAFR1lA3eIUS7gOpKa3sRX94YwCiGu+fBXSBvwqZdN/
o0lD3wpkKRvLtnwiSx7nT6Dt0vaHsNZNMHJXnqL3Bz3RusYv974L8PjQJ0dq2cio
hxHot0LnL8sR4GE69NQh
=BidU
-----END PGP SIGNATURE-----

--rULKf636l7CkQNrH721fqBskoiVDvKnV6--

