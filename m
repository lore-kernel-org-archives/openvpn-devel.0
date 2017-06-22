References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<8a543794-fa2e-cc1b-5db5-7cc9106d126b@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <52f2b2b6-5e10-7178-ef21-635ac020f337@...515...>
Date: Thu, 22 Jun 2017 11:59:11 +0300
MIME-Version: 1.0
In-Reply-To: <8a543794-fa2e-cc1b-5db5-7cc9106d126b@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V6PFuLsQQAmXhcnssarfVh7PxN33p95LA"
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V6PFuLsQQAmXhcnssarfVh7PxN33p95LA
Content-Type: multipart/mixed; boundary="UqAUw5ah2wvqdBxHimCDnQbgIX1GSrFut";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net,
 "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>,
 openvpn-announce@lists.sourceforge.net
Message-ID: <52f2b2b6-5e10-7178-ef21-635ac020f337@...515...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
 <8a543794-fa2e-cc1b-5db5-7cc9106d126b@...2080...>
In-Reply-To: <8a543794-fa2e-cc1b-5db5-7cc9106d126b@...2080...>

--UqAUw5ah2wvqdBxHimCDnQbgIX1GSrFut
Content-Type: multipart/mixed;
 boundary="------------7A05DCD9B8DD6C37A1C245AE"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------7A05DCD9B8DD6C37A1C245AE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

> So just trying to hijack this discussion which is to be found a few more
> places elsewhere in this mail thread.  No need to let this discussion
> run longer.
>=20
> There are several area where we definitely can improve the release
> process.  Last round where we managed to mess up the 2.3.15 release, so
> I wrote a brand new "prepare release tarballs" script, which also
> handles the signing.  This script _was_ used to produce the files to be
> pushed out for the 2.4.3/2.3.17 releases.
>=20
> But for reasons unknown to me, those tarballs got re-created somewhere
> later in the release chain.  The contents of all tarballs are

The tarballs were created by my release script which is available on our
internal Bitbucket. I always try to be very careful in what I upload,
but some mistakes seem unavoidable due to the really complex nature of
the release process.

My release script predates the script you wrote for OpenVPN 2.4.2
release. My script operates on the assumption that a fully up-to-date
Git repository with release tags and everything is available. This has
generally been the case, as we've usually updated Git first and _then_
started the release machinery.

For me it would be easiest if I could handle the entire release process
starting from an fully up-to-date Git repository. That would allow my
script(s) to automatically handle most technical parts of the release:

- Produce the tarballs
- Sign them with the security@...515... key
- Verify the signatures
- Generate changelogs for Trac and Debian packages
- Generate a man-page suitable for copy-and-pasting in Trac
- Generate a CloudFlare flush file
  - Copy-and-paste to CloudFlare to flush caches for all the files;
    this is a routine release procedure nowadays
- Push everything to the download servers
- Download everything from the download servers _and_ verify the signatures

All of this is already handled and works well enough. I _can_ use
tarballs as the source, but I also need a Git repo to get Git logs, so
the tarballs are a bit redundant.

> essentially the same, but due to the "nice" artefact that the tar format
> is non-deterministic on the output, even though the input is the same,
> that begins to prepare the stage for this chaos.  Especially when what
> is being uploaded is partly from the initial run and then some files
> from a different run.
>=20
> All that is history now.  Now we need to look forward.  Many good points
> have been raised.
>=20
> - Do we need .tar.gz and .zip files?  Where and why?
>   The fewer source tarballs we need to handle, the less chance for
>   errors

I would love if we could drop everything except tar.xz. This way the
amount of files and signatures on the download page would drop
significantly. I think it would be reasonable to expect that people who
need OpenVPN _sources_ on Windows are able to extract tar.xz, especially
if we document how it can be done.

>=20
> - Improve Makefile.am to not generate dist-gz files when running
>   distcheck.  The distcheck run often provides very good indicator if we
>   have packaged all the needed files in the source tarball.  If this
>   doesn't pass, something is really wrong.
>=20
> - Do we really need to re-create the source tarballs which the new
>   ./dev-tools/gen-release-tarballs.sh?  Why?

No. But another question is whether we need gen-release-tarballs.sh
which implements a limited subset of the release script I had written
earlier? The gen-release-tarballs.sh came as a surprise to me -
otherwise I would told you that what it does is already covered.

Before answering the question, though, we should figure out our overall
release strategy.

>=20
> - What can be done with Cloudflare to fully ensure their caches are
>   truly purged when we ask for it?  As Jonathan noticed, their caches
>   are tightly connected to the web browser and have a non-deterministic
>   behaviour across browsers, even on the same computer.
>=20

As mentioned above, I've routinely purge CloudFlare caches for all
release files on every release for a long time. Initially this was
because CloudFlare cached 404's for some people. Occasionally issues
arose when a wrong version of a file ended up on the download server.

Regardless of all these precautions we still get some CloudFlare-related
complaints on every release.

> - What else in the release process can be automated and put into a
>   script?  This to ensure consistency between all releases we do.

The following things rob a surprising amount of time from me during a
release:

1. Producing release announcement in three different formats:
   - Download page
   - Forums
   - Mailing list
2. Playing with various Git repos
   - easy-rsa-old, openvpn-build, openvpn-gui, openvpnserv2
   - For each of them in one or more branches
     - Pushing to my fork
     - Pushing version changes and tags to upstream repo
       - Must ensure that what is pushed is the bare minimum
3. Building and testing Debian packages
4) Building and testing Windows installers
5) Playing with CloudFlare caches

Producing release announcements (1) from a template would help quite a
bit actually, as the announcements are generally very similar to each
other. This script could potentially be public.

Parts of 2) have been automated by my release script, but there is still
room for improvement. This also could potentially be public.

Debian package (3) building generally goes smoothly, but there are
occasional hickups when something has changed somewhere (e.g. OpenVPN or
the underlying OS). Plus building tons of packages simply takes a lot of
time. This is already public, but could be automated further.

Windows installer building (4) is fairly straightforward and testing has
been automated using openvpn-windows-test (see GitHub). Still several
different versions have to be built atm:

- 2.4.x combined (32/64-bit) installer for Vista+
- 2.3.x installers (32/64-bit) for Vista+
- 2.3.x installers (32/64-bit) for XP

Building and testing these takes a lot of time and care. All the scripts
are public already, but further automation is possible.

CloudFlare (5) cache clearing could probably be automated fairly easily.
A separate Python script, for example, could be used. If this part is
made generic enough it could be made public.

> - We need to write down a proper check-list of all the steps needed
>   for a release, including putting a clear responsibility for each
>   release.  This list must also mention which scripts to be run.  Again,
>   automation is key to reduce the risk for errors.

We have a pretty thorough internal checklist in JIRA.

> - Consider how many who really needs to be involved in producing a
>   release.  More chefs in a kitchen can result in great food, but it can
>   also end up quite messy.

Agreed.

Many of the tasks in the JIRA ticket do not require any special access
to OpenVPN Technologies internal services (CloudFlare) or servers
(download/build/management servers). So those tasks could potentially be
handled by community developers. But would that make sense? Would it not
be easier to handle the entire release process from one point and just
ensure that the process can be replicated by more than one person (an
employee)?

What we could do is split the release into logical single-purpose steps
each of which is handled by a separate script. The scripts which would
not need access to OpenVPN Tech servers or CloudFlare could then be
published on GitHub. Or, if the scripts are generic enough they could
(potentially) be used by others by simply modifying a configuration file
or command-line options.

I've done this for some of the larger scripts I use for releases:

- openvpn-windows-test (the Powershell test suite)
- sbuild_wrapper (used to produce Debian packages)

> - At the same time, ensure we don't end up in a "single point of
>   failure".  More of us core developers need to be able to step in for
>   others, and still be able to produce a release without errors.  This
>   can be the end result if we have proper scripts, both for automated
>   and manual tasks.

I think you are the best fit for the role :). You have a good
understanding of the release process and have or can be granted the
access that is needed to handle all the release steps.

> My intention with these points are primarily "food for thought".  I
> don't fully believe it will be easy to have a well structured debate
> about the complete release process in a mailing list thread.
>=20
> So I suggest we take a few weeks holiday, let this sink in, and then we
> can schedule a meeting some time in August where we discuss these
> issues.  And lets hope we don't need to rush yet another release before
> August :)
>=20
>=20

Makes sense.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------7A05DCD9B8DD6C37A1C245AE
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------7A05DCD9B8DD6C37A1C245AE--

--UqAUw5ah2wvqdBxHimCDnQbgIX1GSrFut--

--V6PFuLsQQAmXhcnssarfVh7PxN33p95LA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZS4bfAAoJEClYTZ9AhkV4AZ4H/2BeOUh7UfE+otrQAMnhLTIb
4irRBv2SJyVatjqdqhefH/F3t/mizCn7Iho2L8hoUI2fnkECfq8khjCp8jDV+8mf
kyGXETSytsVQp5uzAFU2BGfPmu1yxk2/AzqB9d2nxao75HzXeHD4IFM8+CexZfyT
dE+wrkv/XA+XoKAM7TGWDjVz7nBigN7SiwSDRsAsOXSpvr0zz2GGCrE6NsEbOd9j
gl63OWIr6u66eGTwD/RLE4VhYnwaCF01UQBNXVJwwjQsUfIh3hawaPEULHCQrV/c
IZ5D0B6+bf7pCUVl4fKXG3CuHW88XEleYltjo82rWeaKmbfV8bWHtwfkGDZmE8E=
=XnS1
-----END PGP SIGNATURE-----

--V6PFuLsQQAmXhcnssarfVh7PxN33p95LA--

