Date: Tue, 7 Aug 2018 20:59:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180807185937.GH55859@...1296...>
References: <1516833453-18991-1-git-send-email-selva.nair@...277...>
 <1532486093-24793-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aUBkjfEwC4w8RlCu"
Content-Disposition: inline
In-Reply-To: <1532486093-24793-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Parse static challenge response in
 auth-pam plugin
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

--aUBkjfEwC4w8RlCu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 24, 2018 at 10:34:53PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> If static challenge is in use, the password passed to the plugin by openv=
pn
> is of the form "SCRV1:base64-pass:base64-response". Parse this string to
> separate it into password and response and use them to respond to queries
> in the pam conversation function.
>=20
> On the plugin parameters line the substitution keyword for the static
> challenge response is "OTP". For example, for pam config named "test" that
> prompts for "user", "password" and "pin", use
>=20
> plugin openvpn-auth-pam.so "test user USERNAME password PASSWORD pin OTP"
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
>=20
> ---
> v2: Depends on the base64 export patch
> v3: match password string with "SCRV1:" instead of "SCRV1"
> (pointed out by Joe Bell <joeaintexas@...277...>)

Nicely works and does what it says on the lid.  So...

Acked-By: Gert Doering <gert@...1296...>


I've tried to make it work for our use case, but in combination with
pam_auth_linotp, it actually doesn't work - the latter wants=20
pin+otp to be "one string" (to be parsed by the server), so there
is no separate "OTP" challenge.

I've made it work by hacking a "combine password+otp together"=20
substitution

+                    else if (strstr(match_value, "PASS+OTP"))
+                    {
+                       char temp[100];
+                       snprintf( temp, sizeof(temp), "%s%s", up->password,=
 up->response );
+                        aresp[i].resp =3D searchandreplace(match_value, "P=
ASS+OTP", temp);
+                   }

... but that's not exactly pretty.  It works, though :-)


Plugin logging is also something we should improve.  The current approach
"just log to stderr" is failing if the main openvpn process is started
by init/rc and stderr is not available...  we have logging functions
in the v3 api nowadays, so maybe we should use them :-)

 *
 * plugin_log
 * plugin_vlog : Use these functions to add information to the OpenVPN log =
file.
 *               Messages will only be displayed if the plugin_name paramet=
er
 *               is set. PLOG_DEBUG messages will only be displayed with pl=
ug-in
 *               debug log verbosity (at the time of writing that's verb >=
=3D 7).



There's another catch which we might want to at least document: if you
build this plugin and run it from a slightly older openvpn binary which=20
doesn't export the base64 functions, it will core dump most ungraciously

Aug  7 20:17:19 openvpn-tcp kernel: pid 49459 (openvpn), uid 0: exited on s=
ignal 11 (core dumped)

(unsurprisingly, jumping over an uninitialized function pointer)


So, shall we bump the plugin API version "with base64" to 5, and change
this plugin to actually check it?

(Applying it anyway, because this can all be addressed in a subsequent
patch)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aUBkjfEwC4w8RlCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbaewZAAoJEB2Cnv7KVigSh18L/iVWLLzWO5zvi7sLw9VEzuFm
uCXJV6vFncC8AGgM54KIa0ElKrPeF0qRdbqDsMH8e2gxKrjCC+OBDF309EIbZ859
R+24h4kZt1c7NB1kcmodknaIR8cm2RWAIRJLxxu5GFd2w7tCo53ZFPMJDxYXQIvd
wiz4E929ig/mEoXttx2gT2EaKEclrt3bCrP42SvA0AuPcUEDL34D18FOeKN5q8LA
YlmnCZofzZZToJOvMjBpyFcDLmvmX5+4KdDin76JkANBOZ0d2j8YCvQ7e5eFuM6s
YnUNY7JetuKjMvUCX0Ql2pyzLzWABR2qMDYADO/54LjXfUIv4zLlEPI6CJ3zRbqa
D6T19CB2IeAWrn4hup36dAnK23TcrG0zz3+xVw52lSeAhXccHsJvCIhMC4nmle51
W1z0mm32/yLihS7FCHLEPxzAyA4UFUzwfbvt0+E3PmczpsuQ72WPmsWHD5WGYR/Y
QZy91325W9Orzy2f4tlEqz/8dUNliz+LyCcMxyDO+A==
=G1or
-----END PGP SIGNATURE-----

--aUBkjfEwC4w8RlCu--

