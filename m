Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
	<29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
	<20170531070258.GC97029@...1296...>
	<ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
	<20170531092817.GH97029@...1296...>
	<7bb03bbe8955dacd3a3130f64724024f.squirrel@...2257...>
	<8fb2b96f-67c8-73ba-3dfd-13ddce59b599@...2080...>
	<b18b1487fb12a6eb6b4ccb7c7f6ca517.squirrel@...2257...>
	<f3799853-eece-2f39-dd81-333f1b681297@...2080...>
Message-ID: <9eff25c4-2fe9-7037-3833-ebade48423ca@...2080...>
Date: Fri, 2 Jun 2017 12:18:51 +0200
MIME-Version: 1.0
In-Reply-To: <f3799853-eece-2f39-dd81-333f1b681297@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t0NaChKbU0Prv6ojcqhbvf5a7owL6lVuV"
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t0NaChKbU0Prv6ojcqhbvf5a7owL6lVuV
Content-Type: multipart/mixed; boundary="3BK04HwumL5QXqNJtx9fPStad0oowUTOj";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Simon Matter <simon.matter@...2249...>, openvpn-devel@lists.sourceforge.net
Message-ID: <9eff25c4-2fe9-7037-3833-ebade48423ca@...2080...>
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
 <29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
 <20170531070258.GC97029@...1296...>
 <ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
 <20170531092817.GH97029@...1296...>
 <7bb03bbe8955dacd3a3130f64724024f.squirrel@...2257...>
 <8fb2b96f-67c8-73ba-3dfd-13ddce59b599@...2080...>
 <b18b1487fb12a6eb6b4ccb7c7f6ca517.squirrel@...2257...>
 <f3799853-eece-2f39-dd81-333f1b681297@...2080...>
In-Reply-To: <f3799853-eece-2f39-dd81-333f1b681297@...2080...>

--3BK04HwumL5QXqNJtx9fPStad0oowUTOj
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 02/06/17 11:02, David Sommerseth wrote:
> On 31/05/17 17:48, Simon Matter wrote:
> [...snip...]
>>> Do you depend on building against OpenSSL 0.9.8?  If so, which
>>> OS/distribution do you use?
>> Yes, I have a case with very customized CentOS 5 systems where we also
>> backport security related patches.=20
>
> Well, officially we no longer support RHEL 5 or older as of v2.4.
> AFAIR, we even agreed late last year when getting ready for the 2.4
> release that we won't intentionally break 2.4 builds on unsupported
> distros but we will not bother supporting it when we want to move forward.

Just found some old IRC discussions from my archives.

It all starts back in February 9, 2016 where it was discussed what to do in
regards to support AEAD.  That is only supported in openssl-1.0.0 and newer.

[11:21:23] <syzzer> aead need polar 1.3+ or openssl 1.0.0+ (from the top of=
 my head)
[11:21:42] <syzzer> but since we have to support openssl 0.9.8 (RHEL5...), =
we need the #ifdefs
[11:22:01] <syzzer> I made it use-configureable just because OFB/CFB is too
[12:25:43] <plaisthos> syzzer: do we support RHEL5 in 2.4?
[12:27:17] <plaisthos> in 2.3 sure, but in 2.4?
[12:27:40] <plaisthos> dazo: any strong objections to drop RHEL5 support in=
 2.4?
[12:28:31] <plaisthos> 5.0 came out in 2007 and the last update (5.11) was =
in 2014
[12:28:38] <plaisthos> (still supported but still)
[12:30:24] <syzzer> plaisthos: dazo did argue for supporting RHEL5 a number=
 of times
[12:31:19] <plaisthos> syzzer: :(
[13:39:48] <mattock> what does "support RHEL5 mean in this context"?
[13:40:23] <mattock> afaik packages in RHEL5 have (security) patches backpo=
rted anyways
[13:40:52] <cron2> mattock: prehistoric OpenSSL, so "#ifdef in the AEAD cod=
e"
[13:41:04] <mattock> do we need to care about that?
[13:41:24] <cron2> well, I do care about the #ifdef, and dazo cares about R=
HEL5...
[13:41:31] <cron2> so, sort of stalemate :)

(cron2 =3D Gert, syzzer =3D Steffan, plaisthos =3D Arne, mattock =3D=3D Sam=
uli, dazo =3D=3D me)

At that time, the release plan for 2.4 was non-existing, but we wanted it
"soonish".  And Gert was right, at that time I cared about RHEL5 support.
But the time dragged with no eminent v2.4 release ahead.

In September 5, 2016 this came up again, this time in regards to how to
handle OpenSSL 1.1 support.

[14:27:17] <syzzer> I have an experimental branch with openssl 1.1 support,=
 but that requires a *lot* of changes
[14:27:52] <syzzer> and it will be quite hard/ugly to support both 0.x/1.0.=
x and 1.1.x :(
[14:29:01] <syzzer> they made a lot structs opaque, and require you to use =
accessors that are not available in 0.x/1.0.x...
[14:33:38] <plaisthos> so basically they did not give you the new apis in 1=
.0.x to make life easy
[14:33:54] <plaisthos> are the new accessor just wrappers?
[14:34:04] <plaisthos> so we can do a compat_openssl_1.0.x.c?
[14:34:23] <syzzer> so yes, we have to add our own wrappers
[16:09:23] <dazo> plaisthos: iirc, it is only the z-version which keeps the=
 API ... x.y versions updates API
[16:09:28] <dazo> (openssl that is)
[16:11:25] <dazo> Regarding compatibility ... for 2.4, we will need to supp=
ort 0.9.8 (RHEL5) ... unless we postpone 2.4 until EOL of RHEL5 .... for RH=
EL6 we can move to 1.0.1
[16:11:37] <dazo> syzzer: plaisthos: ^^^=20
[16:12:18] <dazo> openssl-1.0.1e-48 (RHEL6)   openssl-1.0.1e-51 (RHEL7)
[16:15:36] <plaisthos> ut RHEL5 is only on extended support right?
[16:25:27] <dazo> It has full support until end of March next year, IRC ...=
 after that it is extended support for 2-3 years (which we do not support)
[16:25:41] <dazo> (or extended support can stay on last supported version)
[16:25:57] <syzzer> well, as long as we support 2.3 until March, we're fine=
, right?
[16:26:02] <dazo> right
[16:26:34] <dazo> or 2.4 if that gets out the door in too too far future
[16:34:06] <syzzer> I mean, we can drop 0.9.8-support in master, if we pled=
ge to support 2.3 until RHEL5 goes EOL
[16:35:01] * syzzer likes to reduce the maintenance burden

And in October 11, 2016 the v2.4 release plan began to become more realisti=
c.
And here I have shifted my opinion in regards to RHEL5 support in v2.4.  Th=
at
discussion started of due to some NetBSD patches.

[12:43:31] <cron2> dazo: crossing the streams :) - that was about tun-ipv6 =
and NETBSD_MULTI_AF
[12:44:28] <dazo> for the NetBSD ... I'd say get rid of the #ifdef if not r=
eally needed ... 9 year old NetBSD release is not something I'd expect to s=
ee around=20
[12:45:32] <cron2> what I said :)
[12:45:48] <dazo> :)
[12:49:40] <plaisthos> okay like the 8 year old linux stuff :0
[12:50:01] <plaisthos> (8 year ago added, so older than 8 year probably)
[12:55:34] <dazo> plaisthos: kind of, even though we need to be somewhat ca=
reful in regards to Enterprise Linux, which have official 10 years+ support=
 - I don't think such long lasting commercial support exists for NetBSD, so=
 it goes into the same category as the other non-Enterprise Linux distros .=
.. does that make sense?
[12:59:11] <plaisthos> dazo: yes
[13:05:47] <dazo> I don't really care for stuff older than RHEL5, tbh ... a=
nd I wouldn't even complain if we're moving towards RHEL6 as the oldest rel=
ease for git master  (RHEL5 have the EOL in 6 months)
[13:06:11] <cron2> RHEL5 can fall into the same bucket as NetBSD 4.x - "it =
is supported in 2.3.x"



Now, in hindsight it is very easy to see at we have done a very poorly job =
in
regards to communicate out these expectations.  This is something we should
document far better, so the expectations are set as early as possible.

This was also mentioned in a discussion on the -devel mailing list in Febru=
ary
2017, this time when reviewing OpenSSL 1.1 support patches:
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14069.=
html>=20


Stefan did mention that SUSE Enterprise Linux 11 still ships with OpenSSL 0=
.9.8
by default, but that release also had support for OpenSSL 1.0.x..  So even
that distribution is moving forward.
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14742.=
html>


I hope you see that the support for old OpenSSL versions have been discusse=
d,
directly and indirectly over a longer period of time and that RHEL5 only ha=
ve
our v2.3 support and not v2.4.  With this in mind we should not feel commit=
ted
to carry support for OS/distributions not targeted in v2.4.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--3BK04HwumL5QXqNJtx9fPStad0oowUTOj--

--t0NaChKbU0Prv6ojcqhbvf5a7owL6lVuV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZMTuLAAoJEIbPlEyWcf3yL90QAKO9Qt9ELazM+HOrn/QwdeLt
4wsRj0spwfsYtveObLZWH2n4zJDk9opS/riPqJOq+Hsx6pyzcstPPshcwG/7YGt4
vhjTH9HdjsO2YGWdU6tJILRAFBuJOWj6bEwPNnZLvduC36HaARYzAKHzftQVT92w
Pc2q+ZlGfQ4LV1clrDCuC2a5Og1DK6sd4CL7WezdRXRv62blVDBJecMmyLDU3QlL
n/Z/jTRf8gCo3CQjBuIPA1GAc6PHSEEMuSBBsZk6lPtZ0q6Aba/Y0qavgSqDDt8x
xfgDkELaOe5wmP85rc9C5YeXHefmMSkU9dH1xHCH9BjTcdksjd8HMWKAEjHTp9wd
g4IC5erphaRgy4oS1e/JO7HfRp5MQeD3hUPHxFc9iX9VbhW4SCAzMKn631LSEJLT
hwlWLozRXLV2fqcJ3ivhyWVN8nOX0MmzRJ4CBotgLfgPMc9smwCxMKIu5Npmsl34
GPKrXP2ggN46pHJyahLZBx2mcdyzRLuNBPEIPn6q+JmH21ZepofulIx9J5I+TxGE
8lUo5RvS7idJYNBB0IRbq+YJ6Uwru2Dr9X2b8LG6Et7e2gOz3Th5/K4lWE9fL/Sd
t9qh5hfk9XuO4WgDclaClB/6XaTJyzM0uamAs0MhbTgie34Jhe46I/miKt2vzv0w
LENgW/Fe8eq12LyiZNYS
=8upN
-----END PGP SIGNATURE-----

--t0NaChKbU0Prv6ojcqhbvf5a7owL6lVuV--

