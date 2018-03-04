Date: Sun, 4 Mar 2018 17:17:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180304161716.GN69387@...1296...>
References: <f2QLEJM1WzOC1xj4piTlsJBomEfPUdWmlThT__H6xyGvqxgyw4KunQ0wTkM-JAVhB0oHDaqI3J5ls6QggiH6jwAzrxHWKtR5ck9vnpwQLVo=@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5NmCl6OEQDB0SMwx"
Content-Disposition: inline
In-Reply-To: <f2QLEJM1WzOC1xj4piTlsJBomEfPUdWmlThT__H6xyGvqxgyw4KunQ0wTkM-JAVhB0oHDaqI3J5ls6QggiH6jwAzrxHWKtR5ck9vnpwQLVo=@protonmail.com>
Subject: Re: [Openvpn-devel] LibreSSL support in OpenVPN 2.4.5
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mina Barret <mina.barret@...2282...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--5NmCl6OEQDB0SMwx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 04, 2018 at 07:43:14AM -0500, Mina Barret via Openvpn-devel wro=
te:
> The release last week was different than the releases before.
> Usually all i have to do is updating the version, rebuild and QA.
> The release notes state 'This is primarily a maintenance release,
> with further improved OpenSSL 1.1'. To my surprise the build-openvpn
> repository now uses the OpenSSL 1.1 dependency, but why should
> OpenSSL 1.0 no longer work right?

1.0 should work fine - most of the buildbots are on some version of=20
openssl 1.0.x.  Windows builds were changed to 1.1 to get access to
the latest and greatest features (TLS 1.2 with cryptoapi, I think?)

It seems we broke 0.9.8 compilation by missing two #ifdef - this is an
issue we need to fix - our current buildbot farm uses the same settings=20
for 2.4 and "master" testing, so pointing to an openssl version that is
no longer supported for "master" (to get the 2.4 testing) will break=20
things.  Dedicated test setups for "2.4 with 0.9.8" are needed.


Which 1.0 version did we break?  1.0.0, 1.0.1 and 1.0.2 are quite=20
different from what I can read in our commit logs - maybe it's the same
issue that broke 0.9.8 that also broke 1.0.0 (both are EOLed, but=20
our goal is to never intentionally break a working dependency in the
middle of a release train).

> It does not, and this is fine as it's reaching EOL soon anyway.
> And maybe it is not breaking the OpenVPN API so its ok to increase
> only the last version digit. This adds more patch to my openvpn-build
> repository as now the 2.3.18 version _needs_ openssl 1.0 and cannot
> use 1.1 while 2.4.5 needs openssl 1.1 and does no longer build with
> 1.0 - but thats my problem i guess.

As I said, the aim was to have 2.4.5 build with the same libraries (exact
versions) that 2.4.4 worked with.   So 1.0.<x> should be fine, but
there's large differences in the <x> here...

If we broke something that we say we support, please let us know which=20
versions, and whether the already committed patch for 2.4 for older=20
openssl versions (88abb911ea22a30) already fixes your problems as well.


> After the OpenSSL switch worked with 2.3.18 and 2.4.5, LibreSSL
> had one compile error - not what i experienced in the last years
> but ok, I can patch, and i have a system for patches anyway (eg for
> xor). To save other people the trouble - as long as they build the
> unmodified source - I'd like to contribute to your project with a
> simple pull request, one that makes the latest OpenVPN version work
> with the latest LibreSSL. Maybe you just do not build it this way,
> but soon others may run into this. In the end its not more than a
> typo/broken link on wikipedia.

This particular LibreSSL breakage is even more annoying than "normal" -=20
we do test on OpenBSD 6.0 with the LibreSSL version on that system, and
it seems a *newer* LibreSSL version added API functions that they did
not have previously, adding them as a function where OpenSSL uses=20
a macro.  This sort of API differences (while still defining an=20
OPENSSL_VERSION that claims "of course we have all the cool stuff!")
is what annoys our crypto developers enough that they considered to
drop LibreSSL support completely...=20

Since we do want OpenBSD support, we compromised on "we're not going
to intentionally break it, but if *they* break it, we're not going to
chase their changes to see what we have to do now".


[..]
> Ok, bummer, the (german) wikipedia experience again - rejected.
> The second and third read of the well distributed Changelog(s) and
> release note(s) does not bring up a 'We do no longer support LibreSSL'
> note. The sourcecode contains ifdefs that already take care about
> LibreSSL. There are recent patches that handle mbedSSL, so you must
> be interested in supporting other crypto libraries. Do i really
> have to write a email to the developer that made the last LibreSSL
> patch, bribe her or him with *hugs* or *backrubs* (sorry!) to get
> the simplest possible patch into upstream? What do i have to do
> then to get more complex stuff approved? Weekly meetings?

Well, first of all, the fact that we do not accept PRs is very well
documented *in* the PR form.  Github does not let us turn off PRs
completely, otherwise we'd have done that long ago - but we put
documentation in there to state this quite clearly.

Github is not our primary working platform.  We push there, to have
resiliency (and to sf.net and to gitlab) but our workflow is "incoming
mail with patches goes to the list, it gets reviewed, ACKed on the list=20
[=3D archived], then merged".

The ChangeLog I was referring to can be found here:

https://openvpn.net/index.php/open-source/downloads.html

"Please note that LibreSSL is not a supported crypto backend. We
 accept patches and we do test on OpenBSD 6.0 which comes with
 LibreSSL, but if newer versions of LibreSSL break API compatibility
 we do not take responsibility to fix that."


I think a patch adding these LIBRESSL_VERSION checks has a reasonable
chance of being ACKed and merged :-) - but LibreSSL support stuff has
to come from some who cares, so Steffan or Antonio are not going to
go out and check patches for "will it break LibreSSL?"...

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--5NmCl6OEQDB0SMwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJanBwMAAoJEB2Cnv7KVigSAO0L/ipHt/3GTuUedDGN9fFem31O
pk3Xk2vwStc+uCmC+85sygwk4YoJI4VwTHIadM6REk5ytfQ+2nXo+kmHpHRgOn55
nXNIsYZ0cJ4hoZbbvgazEPrcUhN1eyHHKWujf9c+NQ8qHWpUEDwGDKaZq9Wu5pOE
/2Bomq15LS4Vw7PSZaCUJ9tGxGOLJfGT345/E0K78DsWuiirW9PNQVZXoVMr6nMh
1kRDtV7RbpcK2gPPtRlvE8YwpOAOePu6r88WERbq6VP5LE0hqpmuLUPfC/geSf/E
LHzLnhjUroF266dAp0Ory49VmyF3kQ+t0r0afjjw0isLkWkQtKNIIOaYWJEi+Mhj
etuJNhjVCptqPTpGv9oE+8n+NrdZXmNAIAvJEA3w4HPpHF17TlLSsXxBU7tiKEKB
6ONT5wj/z8OeKVc9cyNqynKQAAmtTrnST3qxqW8MFi8mYAdkN9PuN1yE/17mwYKc
pqTJ3U0YdZjEooTdDUJvReLFFomNSR9tabgxx/L6sg==
=WvDY
-----END PGP SIGNATURE-----

--5NmCl6OEQDB0SMwx--

