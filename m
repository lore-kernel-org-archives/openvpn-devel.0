Date: Thu, 7 May 2020 13:55:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200507115501.GC1431@...1296...>
References: <1532486093-24793-1-git-send-email-selva.nair@...277...>
 <201808071901.w77J1bEd015348@...2054...>
 <CAKuzo_iwqCQ-hQo=uc1_NTa845HBWEAMr98QvVzULQFuLN3SYw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="USJBhEEH8TT+Is94"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iwqCQ-hQo=uc1_NTa845HBWEAMr98QvVzULQFuLN3SYw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Parse static challenge
 response in auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--USJBhEEH8TT+Is94
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 23, 2020 at 10:02:10AM -0400, Selva Nair wrote:
> On Tue, Aug 7, 2018 at 3:01 PM Gert Doering <gert@...1296...> wrote:
> > Your patch has been applied to the master branch.
> >
> > (I'm a bit undecided about release/2.4 - this is in "new feature!" land,
> > and all the challenge stuff is "master" territory.  OTOH, it's not open=
vpn
> > main code, and the code is sane enough - so if folks think it should be
> > in release/2.4, tell me)
> >
> > commit 7369d01bf360bcfa02f26c05b86dde5496d120f6 (master)
>=20
> I failed to respond to this that time.
>=20
> Although this is a new feature, I too think its safe and useful to
> include this in 2.4.
> If we do, we'll need this one (commit
> 7369d01bf360bcfa02f26c05b86dde5496d120f6) and the followup one
> 7a8109023f4c345fe12f23421c5fa7e88e1ea85b
>=20
> Both should cherry-pick without conflicts.

If you tell me we should have it, I'm with you :-)

(Given that this is only affecting the auth-pam plugin, and that this is
a very useful addition, I think it makes sense)


commit cab48ad43eaba51c54fa23e55b0b2eb436dd921f (HEAD -> release/2.4)
Author: Selva Nair <selva.nair@...277...>
Date:   Tue Aug 7 22:44:31 2018 -0400

    Accept empty password and/or response in auth-pam plugin
    (cherry picked from commit 7a8109023f4c345fe12f23421c5fa7e88e1ea85b)

commit b89e48b015e581a4a0f5c306e2ab20da34c862ea
Author: Selva Nair <selva.nair@...277...>
Date:   Tue Jul 24 22:34:53 2018 -0400

    Parse static challenge response in auth-pam plugin
    (cherry picked from commit 7369d01bf360bcfa02f26c05b86dde5496d120f6)


I've only done very limited testing - quick look at the changes (nothing
conflicting or "funky" here), and a test build.

> See also Trac #1275 https://community.openvpn.net/openvpn/ticket/1275

Noted!

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--USJBhEEH8TT+Is94
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJes/cVAAoJEB2Cnv7KVigS6p8L/j1b0yQu6MsOAKSbIOf0dkAm
6Sah7ZF0zuLnYjnXjuq63WJTmvdHC8TZTQpew6kAjPxQ5lhEmFQ+5q89PPvt9gfg
FkfhRE0oPerDS5p9RtWMvnDc/JB9Y/7mFZVH38ziYTHpjxIfCpMGgOGKXXxAPE3M
tU4O0BQczAMB+OgC75RCtBAjQ9TYERHvDsSFZ4Tvc3cxAjClZGNGdFrxAkiMKRvi
aLvqoGTwokWZrTIVh8ZkXw6qLMqcvCtcPfd+Ke0NdUfYCTGe8+ksc5AZNFo1z2Qb
NZ0wJcDwQhWKEocB2mDsvyrtCyRvd8wUu6gIsoP6yXoicL61zxwQNNPVLn0p8XpE
6X3/irSImGGqhgqEyk0JUaGPrA86e9+pvtm4ji+uVccttwrmzEiBvWSWRKduuvqZ
NfCYQgwtPRa7GmuPvPY55lGoP8NhKeXldYbsmtIQDpJolcplsUIT6aKmx+qvUXV3
q5RW07EVcNgUQheeVWboj7v6ffDNdC3fHrVr6/4eIg==
=hlzl
-----END PGP SIGNATURE-----

--USJBhEEH8TT+Is94--

