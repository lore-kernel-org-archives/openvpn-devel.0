Date: Tue, 10 Jan 2023 21:04:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y73EuV4BJLLcg7WU@...1296...>
References: <20221130205718.79765-1-gert@...1296...>
 <20221229072746.19169-1-themiron@...2010...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Wy96pGqEUMj5wA6z"
Content-Disposition: inline
In-Reply-To: <20221229072746.19169-1-themiron@...2010...>
Subject: Re: [Openvpn-devel] [PATCH v15] Add DNS SRV remote host discovery
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>
Cc: openvpn-devel@lists.sourceforge.net, gert@...1296...

--Wy96pGqEUMj5wA6z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 29, 2022 at 12:27:46PM +0500, Vladislav Grishenko wrote:
>   client will move on to the next connection entry.
>=20
> v15:
>     rebase to master (Dec 2022)
>     add optional port argument to --remote and --remote-srv usage message
>     fix --proto option coexisting with --remote-srv
>     fix --nobind option coexisting with --remote-srv
>     fix options postprocess mutation lost in v13/v14
>     recover --mtu-test handling with --remote-srv
>     use explicit srv resolve stub for openbsd for the future
>     fix comments

Getting close... but, alas, we need another rebase - the signal handling
fixes from Selva cause conflicts.  Can you do a v16, please?

Also, please have a very close look at the code now - it looks like
the previous rebase is now creating quite a bit of (undesired!) code
duplication.  For example, this new hunk:

+static bool
+options_postprocess_verify_ce_proto(const struct options *options,
+                                    const struct connection_entry *ce)
+{
+    int msglevel =3D M_WARN|M_NOPREFIX|M_OPTERR;
+
+    /*
+     * Sanity check on --local, --remote, and --ifconfig
+     */
+
+    if (proto_is_net(ce->proto)
+        && string_defined_equal(ce->local, ce->remote)
+        && string_defined_equal(ce->local_port, ce->remote_port))
+    {
+        msg(msglevel, "--remote and --local addresses are the same");
+        return false;
+    }
+
+    if (string_defined_equal(ce->remote, options->ifconfig_local)
+        || string_defined_equal(ce->remote, options->ifconfig_remote_netma=
sk))
+    {
+        msg(msglevel,
+            "--local and --remote addresses must be distinct from --ifconf=
ig "
+            "addresses");
+        return false;
+    }


... these checks are existing today, in options_postprocess_verify_ce(),
but your patch is not *moving* them to the new function, but *duplicating*
them.  This can happen if "git --rebase" gets confused by too many
unrelated changes, but is not the desired end state.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Wy96pGqEUMj5wA6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjvcS5AAoJEB2Cnv7KVigS6NwMAJX882bFGZdXsIMOBlSA8wnw
mKxfwy4B6MyblMjaJYcrNpzuaVjVEtfFPVxesSDxmc3luVRITIfZM2O32CSGXtBn
EIX3Z0MoWMqDRsU0xBrm6XAPcieeEMZFaQXWKppAfvLXs4FloElzhggnAD9KEAJL
rGzKn1y6p4P4QRUzAELHzoLGy0O3s9X3qVpax2lkMe5pjy7mb4TJuA9qwl2smCT1
LBXPATw3V6kdeRmjHKepNGug8RpyttEUJFFQPJUaCsXhsdDJB1V4ofimF1Kyq3rh
N5grOd4Vrnpr0mzqgkHjmf8ytlpWHpd0gEUVj67h1pUpgkg/JENMbmmu4StfhnAn
OMya/p8GSOIRpg+RYB5kfzHzF6o/fvk6l3Rw8mXKycrwE5iEJQKsXNF1ECyZF2FA
qRMHZlXfnV+3KONPshTz0JYxSa8bYJYthLc6B1A2X8KnkKi2LkM6hsmCRa8BB4og
CddYxkXO0R3FRtCvRB1TV2G9OQpqObfeZ6te85uzOA==
=CoQ/
-----END PGP SIGNATURE-----

--Wy96pGqEUMj5wA6z--

