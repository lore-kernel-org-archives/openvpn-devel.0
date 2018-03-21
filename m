Reply-To: openvpn-devel@lists.sourceforge.net
References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b2ad8955-512b-086b-1b5a-bcf0faa77db4@...2080...>
Date: Wed, 21 Mar 2018 14:22:51 +0100
MIME-Version: 1.0
In-Reply-To: <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="vsUEd4ycLp5V7Fy8OdwB0YiubBZcnFUuM"
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 21st Mar 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vsUEd4ycLp5V7Fy8OdwB0YiubBZcnFUuM
Content-Type: multipart/mixed; boundary="RgedLC8cRrJ6p0U1NXxehtzFassjLfLkf";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Message-ID: <b2ad8955-512b-086b-1b5a-bcf0faa77db4@...2080...>
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed, 21st Mar
 2018)
References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
In-Reply-To: <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>

--RgedLC8cRrJ6p0U1NXxehtzFassjLfLkf
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 21/03/18 12:45, Samuli Sepp=E4nen wrote:
>=20
> Dazo informed that OpenVPN 3 developers will start using openvpn-devel
> for their patches. We will need to figure out how to make patchwork
> detech whether a patch belongs to openvpn2 or openvpn3.

Just to elaborate a bit more on this topic.  I will try to explain a bit mo=
re
in detail how OpenVPN Inc staffers will contribute to the development more
openly and in a publicly, auditable approach.

Current situation: OpenVPN Inc developers push changes to a private git
repository for peer-review, and at random intervals these changes are pushed
out to the public.  This is not considered a good long-term approach when
wanting to have the community involved in the further development.  So we a=
re
adjusting our own processes to be far more community friendly.

This is our current proposal:

Patches submitted with the patch author carrying an @openvpn.net address wi=
ll
in most cases have been through internal peer-review before being accepted.
These patches will thus have at minimum one "Approved-By:" tag line.  This =
is
similar to the Acked-by: tag-line used in OpenVPN 2 patches.  The reason
"Approved-by:" is used is simply due to the internal tools used by OpenVPN =
Inc
for peer-review - which adds this automatically.  But seeing an "Approved-b=
y:"
line means the commit has been through peer-review by OpenVPN Inc developers
and was ACKed.

It is also preferred that OpenVPN Inc developers which have their patches
reviewed internally to make patches available in a publicly available git
repository (like GitHub, GitLab, Bitbucket, etc) - at any time.  This enabl=
es
the use of a git feature we've not used before for OpenVPN - git request-pu=
ll.
 This combined with git format-patch with the --cover-letter option will
generate a e-mail template where it is possible to validate the authenticity
of the patches on the ML against an external git repository.

Patches sent through the git request-pull approach can then be merged direc=
tly
into the official openvpn3 git repository.  We also try to ensure that as m=
any
 commits as possible added to the openvpn3 git repository are PGP signed.  =
But
we have to find a good way to tackle this as automated as possible.

The community may, of course, dispute commits post-merge, where after a
discussion with the OpenVPN Inc developers will figure out if this needs to=
 be
reverted or if it can be improved by adding another patch fixing issues.  B=
ut
we are open and happy to take those discussions whenever needed.


The rest of the OpenVPN community may also use the 'git request-pull'
approach, or take the approach used for OpenVPN 2.x patches over many years.
But all patches from the community [1] need to receive a public "Acked-by:"
response, sent explicitly to the mailing list.  We do not restrict the
Acked-by to be by OpenVPN Inc developers only; we use the same approach as
with OpenVPN 2 patches - contributors who have built up credibility among t=
he
core developers over time will have their Acked-by responses handled easier
and quicker.  But any Acked-by: responses are valuable.


And even though a lot of the process is pretty much laid out - nothing is s=
et
in stone yet.  But we (OpenVPN Inc) needed to find an approach which works
well for us and at the same time encourage the community to participate in =
the
development.  We do a lot of work on the OpenVPN 3 code base but also want
this development to happen in the open and public space as well.  But as we
gain experience, we will adopt this process to what works best for both the
community and OpenVPN Inc.  The main goal is to make OpenVPN 3 as attractive
for contribution as what we have managed with OpenVPN 2.

But see this mail as an early heads-up.  OpenVPN Inc is still adjusting the
internal tooling and processes.  But we expect to be ready internally in not
too long (a few weeks, not months - unless we hit some nasty challenges).  =
And
if there are ideas how to make things better, please let us know asap!

All this said ... In todays community meeting concerns about Patchwork was
raised.  We will need to ensure that OpenVPN 3 related patches won't affect
and make a big mess of the OpenVPN 2.x development and the Patchwork
integration used there.  And we (OpenVPN Inc) would like to make Patchwork
work well with OpenVPN 3 patches as well.  So this is something needed to be
handled properly before we start for real.  But we will do a few tests and =
see
what happens.


[1] With "the community" it is meant: Patch from a sender _not_ carrying an
    @openvpn.net address with at least one "Approved-by: " tag-line with an
    @openvpn.net address.  Both addresses needs to be well known OpenVPN Inc
    employees.



--=20
kind regards,

David Sommerseth
OpenVPN Inc



--RgedLC8cRrJ6p0U1NXxehtzFassjLfLkf--

--vsUEd4ycLp5V7Fy8OdwB0YiubBZcnFUuM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaslywAAoJEIbPlEyWcf3ypOYQALB0gcuM0tp4bhLBMVbpsjR5
05+H6BM2aYBihNpsHZobgRCciHWonFDjnUQMGyZn1ZL5WeeoRqumfksvmK4QbLJS
FcuggECS0dmKhnShVDaQ8VxB74YIMBQuTV58saWVY6HHjVWwkh7oRxIg2eSh2iuX
N2C9ZMzqQ3FwYelfiW5BtLvydYLmaZFvsCNfsppOrbKIhD4V4AlQo/npp5SAY6BZ
X9m66VLe6K5m8e7WI/AmTTr66P9jRw2YIEiG/Q/dyZ3JUMuAoz8m45rFzmNM6xmv
0EMD4fEEdNGvl5Cswrv+g1X3TGgpDP3NRHgbn1uo41u9o1HaXEPqbIesWoYB9AIt
xPfY8e0mZgPopkjD2lb/GCHCieUtkBKX1p8Zw50tlFios1xKwVuYV++xWppnlcwb
StmY2PQOgRMO+6GzpLQFOlorffGxXAGqx7WUJBLM9qlOeSXjyBvXc1M3LhZBkFrz
IYLUz3WqPzhPRDEv+PFlAa569T2/3xcvHUjkitp0Pc+4PhMsW61ihn3fPU8tKUBo
6WN6jstYejByBww0BNIZehc8wPChBisrX7ZrvGEzBg1OwCACD4Y/4iXm1/TXqqqv
rFOwF1vpQ3oCuwA7K9/FPnzbCUJeGSfI+El1tGiBKnKrsbW3nfkrv2JPpVRkrhXb
w6wun6v3DI+mpBDGYdJy
=+t7N
-----END PGP SIGNATURE-----

--vsUEd4ycLp5V7Fy8OdwB0YiubBZcnFUuM--

