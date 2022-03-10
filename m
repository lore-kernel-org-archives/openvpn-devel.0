Date: Thu, 10 Mar 2022 16:13:44 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YioVqLia58hlN1RI@...1296...>
References: <20220310115718.11188-1-gert@...1296...>
 <CAAYFXLmCztuh1AZHzdGW=3cKM9g5GjaEWy4pBWzbsaGsp7ri+w@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7A0ExbOB/SfD1TdN"
Content-Disposition: inline
In-Reply-To: <CAAYFXLmCztuh1AZHzdGW=3cKM9g5GjaEWy4pBWzbsaGsp7ri+w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Enable deferred auth for multiple
 plugins (RFC).
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pete Nelson <petiepooo@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--7A0ExbOB/SfD1TdN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 10, 2022 at 01:57:01PM +0000, Pete Nelson wrote:
> One of the behaviors that brought this to light was a user who had an LDAP
> (non-deferred) plugin followed by a Duo MFA (deferred) plugin.  He noted
> that, even if the LDAP call returned failure, the Duo plugin was still
> called.  That would generate a push notification to his phone even though
> the authentication was already destined to fail due to LDAP.  It looks li=
ke
> this patch returns failure when the first plugin fails, so would resolve
> that scenario by not calling the Duo plugin at all if LDAP returned failu=
re.

Yes, your report triggered this work.  I think I misunderstood the=20
original scenario (I thought it involved two plugins both going=20
"deferred"), but this patch introduces a "short circuit" approach=20
to plugin authentication where anything that fails will immediately
abort all other plugin calls.  So, it will fix that scenario(*).

Now, if you have two deferred plugins, OpenVPN wouldn't know that
"the deferred LDAP will fail in 0.1s", so would still fire up the
DUO plugin.  I thought about sequentializing them (the moment the
first plugin goes "deferred", wait for that plugin to finish, and
only then call the next one) but have not found a good way to do that
in our current code.  Might be worth having another look.


(*) for that scenario ("first plugin is direct, fails, then do not
call second plugin at all") the possible fix is much easier, though -
in plugin.c, plugin_call_ssl(), just leave the inner for() loop
whenever "error" becomes true.  So line 810 would change from

        for (i =3D 0; i < n; ++i)

into

        for (i =3D 0; i < n && !error; ++i)

... the existing behaviour is "run all plugins, always, and report
if any of them failed".  That change would it make "abort on the first
failure, do not run the rest".  Which sounds like it makes sense for
authentication related, but maybe not so much for housekeeping=20
(client-connect etc.)...  to be discussed further :-)


> Is the source for the "auth-multi" plugin you tested with available
> anywhere?  I could not find it, and had wanted something like it for my o=
wn
> testing.

It is part of the patchset that David has prepared for the "two plugins=20
going deferred is not well defined" problem.  It will hit the list
"real soon now", but I'll send it to you unicast.  It comes with detailed
instructions how to run multiple instances that have their own "log id"
and defined direct/deferred success/failure behaviour.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7A0ExbOB/SfD1TdN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiKhWoAAoJEB2Cnv7KVigSLkoL/1/n8mJvvkD4GoazEWTAUhD+
iR6R8vvRoKJ433coKYivuD+O8Fa5si3AGA0oAhfTw+AlAHBXsA4tnM89ZmKNa1Tw
4umsbN2yn9UwZJUux7LOuCQdR38DDi3mxDKf4H0Hhm3HWPo2qdj06esQ1GMZxsKr
Bz8VllZuhhZkIkDiC4HIiW2o/slnFV+fNRZz3Kseeh3eBlUhmirpg52sL4OlObKf
lZ8IKfYM5YUxLAwCz4H3KKS19XO075yv5AMBsY4vIvKxtRhg7aB7OXq22ESoXEYF
zLQTJ6Mo0on6RLln+ZlI33ohXZNvphQ9+qmPpD/VYHR8LPlA2FJ8RNB4ueoaWZgQ
t/6P+ml0zrtZafX/tgnc5TbeKxQeKUsn2/1BDrY9xohsIYfeBrOA+cHS4GIbIUs5
1Lw2OfA1su7jNUnc27xQNtuEIHGKUzKsqZxLloAdiZQr05++n+YvfuNENR8ppRlz
EwuHmqUQnhOk+dzF7Xk2hNd6Mwaie+CW292LocpvsQ==
=3rNC
-----END PGP SIGNATURE-----

--7A0ExbOB/SfD1TdN--

