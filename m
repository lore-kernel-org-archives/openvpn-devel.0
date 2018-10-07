Date: Sun, 7 Oct 2018 09:38:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20181007073824.GA962@...1296...>
References: <1520185442-22901-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hze9XmyoPo8YE0yg"
Content-Disposition: inline
In-Reply-To: <1520185442-22901-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Do not assume that
 SSL_CTX_get/set_min/max_proto_version are macros
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--hze9XmyoPo8YE0yg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 04, 2018 at 12:44:02PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Openssl docs do not explicitly state these to be macros although they
> are currently defined as such. Use AC_CHECK_DECLS to test for these so th=
at
> both function and macro forms could be detected.
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> Though not meant as a fixup for libressl, as a side effect
> this also makes 2.4.5 build with newer libressl versions.
> (built on freebsd 11 using libressl 2.6.4 while testing patch 238)
> Notes: (i) libressl defines only the set functions and neither
> are macros. So get functions will get used from the compat layer.

So, going through open patches in patchwork I came to this one.

Reading through the thread, I'm not sure what the final outcome on
the patch and the problem was?  LibreSSL seems to be fixed (thanks,
Jeremie :-) ) and if we build with OpenSSL 1.1.0g+, all is good?

Phrased differently: does anything need to be done with this patch or
should I click on "superceded" in patchwork now?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--hze9XmyoPo8YE0yg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbubfwAAoJEB2Cnv7KVigS62ML/23MlR5hcQD77vB8B7h4Ua57
1FCOG5JkvQwoa4A10+qZQI21Mgpy8t+pDv/RQw6W/wGdI6W3wd3B808dHTSWgL7e
y8Xp8l+MypNoXJXNfk+FgGTZKZ6/nreDF6EF/gZ9pgnvJrUl3fr0TdjP801JdC+e
Zg0naadjqSVno1t4nw6NqeXbHIU8BQEQc0yf+astxP9xu9n8RLEf6KV5GJNeGZoz
LwnTVa1tuIsDKnIFbyYzFrm7ELzAd5bhAg8vi1gLC+FaHfFWVhNE+D6Jc8PexD3p
O4SzNOaDADSY2XmWuAN4DtqtBw9E9mJbj2LvgKLVw8iPdbTJtCIZ+1j7i4E6U/Wi
FhOzJaaulm4UwykPNmLzIWAErkCtYx7dmKkVLFgk+6ufZWfGB+HE8Is2l8OKqS++
OaU9gjOOHjZIjtcBqiW/XmipffYHifIDL5X3CEwFwaERxwkqHuM30wXK9/5uaWak
er3WLx/Fq68pZBFoH3N0YzEWHflCgeff5WsjTPAx7w==
=0twm
-----END PGP SIGNATURE-----

--hze9XmyoPo8YE0yg--

