Reply-To: openvpn-devel@lists.sourceforge.net
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8a543794-fa2e-cc1b-5db5-7cc9106d126b@...2080...>
Date: Wed, 21 Jun 2017 23:06:05 +0200
MIME-Version: 1.0
In-Reply-To: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HBsS87H3dCXHn2CkV52Xba7U4Hp1H6fwC"
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HBsS87H3dCXHn2CkV52Xba7U4Hp1H6fwC
Content-Type: multipart/mixed; boundary="cXF7IqKjAjwpCtspa6WQLU0K5MErsVdkq";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>,
 "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>,
 openvpn-announce@lists.sourceforge.net
Message-ID: <8a543794-fa2e-cc1b-5db5-7cc9106d126b@...2080...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
In-Reply-To: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>

--cXF7IqKjAjwpCtspa6WQLU0K5MErsVdkq
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 21/06/17 12:47, Samuli Sepp=C3=A4nen wrote:
> The OpenVPN community project team is proud to release OpenVPN 2.4.3. It
> can be downloaded from here:
>=20
> <http://openvpn.net/index.php/open-source/downloads.html>
>=20
> OpenVPN v2.4.2 was analyzed closely using a fuzzer by Guido Vranken. In
> the process several vulnerabilities were found, some of which are
> remotely exploitable in certain circumstances. We recommend you to
> upgrade to OpenVPN 2.4.3 or 2.3.17 as soon as possible. More details are
> available in our official security announcement:
>=20
> <https://community.openvpn.net/openvpn/wiki/VulnerabilitiesFixedInOpenVPN=
243>
>=20
> In addition a number of bugs with no security impact have been fixed.
> The one big feature in the 2.4.3 release is support for building with
> OpenSSL 1.1.
>=20
> A summary of all included changes is available here:
>=20
> <https://github.com/OpenVPN/openvpn/blob/release/2.4/Changes.rst>
So just trying to hijack this discussion which is to be found a few more
places elsewhere in this mail thread.  No need to let this discussion
run longer.

There are several area where we definitely can improve the release
process.  Last round where we managed to mess up the 2.3.15 release, so
I wrote a brand new "prepare release tarballs" script, which also
handles the signing.  This script _was_ used to produce the files to be
pushed out for the 2.4.3/2.3.17 releases.

But for reasons unknown to me, those tarballs got re-created somewhere
later in the release chain.  The contents of all tarballs are
essentially the same, but due to the "nice" artefact that the tar format
is non-deterministic on the output, even though the input is the same,
that begins to prepare the stage for this chaos.  Especially when what
is being uploaded is partly from the initial run and then some files
from a different run.

All that is history now.  Now we need to look forward.  Many good points
have been raised.

- Do we need .tar.gz and .zip files?  Where and why?
  The fewer source tarballs we need to handle, the less chance for
  errors

- Improve Makefile.am to not generate dist-gz files when running
  distcheck.  The distcheck run often provides very good indicator if we
  have packaged all the needed files in the source tarball.  If this
  doesn't pass, something is really wrong.

- Do we really need to re-create the source tarballs which the new
  ./dev-tools/gen-release-tarballs.sh?  Why?

- What can be done with Cloudflare to fully ensure their caches are
  truly purged when we ask for it?  As Jonathan noticed, their caches
  are tightly connected to the web browser and have a non-deterministic
  behaviour across browsers, even on the same computer.

- What else in the release process can be automated and put into a
  script?  This to ensure consistency between all releases we do.

- We need to write down a proper check-list of all the steps needed
  for a release, including putting a clear responsibility for each
  release.  This list must also mention which scripts to be run.  Again,
  automation is key to reduce the risk for errors.

- Consider how many who really needs to be involved in producing a
  release.  More chefs in a kitchen can result in great food, but it can
  also end up quite messy.

- At the same time, ensure we don't end up in a "single point of
  failure".  More of us core developers need to be able to step in for
  others, and still be able to produce a release without errors.  This
  can be the end result if we have proper scripts, both for automated
  and manual tasks.


My intention with these points are primarily "food for thought".  I
don't fully believe it will be easy to have a well structured debate
about the complete release process in a mailing list thread.

So I suggest we take a few weeks holiday, let this sink in, and then we
can schedule a meeting some time in August where we discuss these
issues.  And lets hope we don't need to rush yet another release before
August :)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--cXF7IqKjAjwpCtspa6WQLU0K5MErsVdkq--

--HBsS87H3dCXHn2CkV52Xba7U4Hp1H6fwC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZSt/FAAoJEIbPlEyWcf3yJ/sQAJRdMqQ8697PSubRNEYJNXzd
zjy9wqeWLoKKg2I2HxPXVR9Mr4d/23DKcBnqzfH9AsADQJz7a2JFVwG59pKx45ti
X62PYqr0A/57VNJvlYZfU2akX7/V35cwmQRVLyqYyc0/RKuj/wQ9ThB81LtIlUth
pq4YBkHpjWycpQgmFWhSenI+dwIGeaz/rTyGCaRwEtYXbFyPYRnJoKddj3k/cMJG
5RGzYgw5opGH1kj63Z9heRdp7UErYklanZ3K5WE2v+usX6VInxMRfJ+tXgOo/Z76
GT3lhQmGQIOk+rkmUYKpiMQo5K5KV9a+MFJluBn0qZNx3gS13zOd8WcjApagb4+r
9HnuJZ7/6ix9NtOTh7XivNtTEj2ujizqkozLv90xJDQHG6Lmvcx88yOuLMZMSh36
WVB1Gk7WOJ3usb/mSujdL+8ZR5mZXckYipzi5EPyiGb2PmSkrkmj3FIAdAatSxi8
ti8Z3f9UsL8EWymJl8I1V/2/CG8AGwnT3C9IXc9NVeRfD5HUkPik7C+Wv0ZV87UB
Jwxzg4DBhsUqD3Ksx0YHYX0GZGGfq0mkyz1XlZzhcNCC7eIIX2FVSJkFxQHZUfKT
58OM1QcFHURz0SYx/hsCWSU4ncY4xfTbLXMKVuYGvf9XvcpQ3NmYVvMp4kFJoIg0
Pf5wt+XnBXmxSRGLVgYx
=6co7
-----END PGP SIGNATURE-----

--HBsS87H3dCXHn2CkV52Xba7U4Hp1H6fwC--

