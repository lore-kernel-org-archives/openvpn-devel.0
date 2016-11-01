References: <5c4e3f93-c584-4a19-4081-9bf4adaf417a@...277...>
	<502e093a-cb39-c76d-27b5-ab86fd4bcfd6@...515...>
	<73352d7f-521e-b968-2990-8783955da5c9@...2080...>
	<04516948-204e-57c2-fb57-f355157ed5af@...515...>
	<CAKuzo_gRDm566EwD_qtrYNM5AOYHF8xgCzsi1FQ3emjYGDeGmw@...278...>
	<43094758-efda-c613-c51d-e7980dfa6b24@...2080...>
	<CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>
	<90baad6a-25c5-2ecc-1ea8-b5a1febf1521@...2080...>
	<cadcd4fa-701e-2d35-4fe0-66707dae8b5b@...277...>
	<9ba106aa-7dc7-753b-d662-6a75c6d16314@...2080...>
	<20161101111010.GH28918@...1296...>
	<17b0a8f9-ebc5-d46a-b024-eb0bf57bafe2@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <dbafdc8e-a383-4e38-1ddb-9adc349a7ccf@...2080...>
Date: Tue, 1 Nov 2016 15:05:26 +0100
MIME-Version: 1.0
In-Reply-To: <17b0a8f9-ebc5-d46a-b024-eb0bf57bafe2@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="rhKALOE2bs7Virwm4swMUSNkbBVKwsPmi"
Subject: Re: [Openvpn-devel] trac 757 --auth-user-pass up + GUI 2.3 vs 2.4
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rhKALOE2bs7Virwm4swMUSNkbBVKwsPmi
Content-Type: multipart/mixed; boundary="bhNxUW31NnSdqTQv62gTDDKTXnMBibSK4";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <dbafdc8e-a383-4e38-1ddb-9adc349a7ccf@...2080...>
Subject: Re: [Openvpn-devel] trac 757 --auth-user-pass up + GUI 2.3 vs 2.4
References: <5c4e3f93-c584-4a19-4081-9bf4adaf417a@...277...>
	<502e093a-cb39-c76d-27b5-ab86fd4bcfd6@...515...>
	<73352d7f-521e-b968-2990-8783955da5c9@...2080...>
	<04516948-204e-57c2-fb57-f355157ed5af@...515...>
	<CAKuzo_gRDm566EwD_qtrYNM5AOYHF8xgCzsi1FQ3emjYGDeGmw@...278...>
	<43094758-efda-c613-c51d-e7980dfa6b24@...2080...>
	<CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>
	<90baad6a-25c5-2ecc-1ea8-b5a1febf1521@...2080...>
	<cadcd4fa-701e-2d35-4fe0-66707dae8b5b@...277...>
	<9ba106aa-7dc7-753b-d662-6a75c6d16314@...2080...>
	<20161101111010.GH28918@...1296...>
	<17b0a8f9-ebc5-d46a-b024-eb0bf57bafe2@...515...>
In-Reply-To: <17b0a8f9-ebc5-d46a-b024-eb0bf57bafe2@...515...>

--bhNxUW31NnSdqTQv62gTDDKTXnMBibSK4
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 01/11/16 13:20, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> Il 01/11/2016 13:10, Gert Doering ha scritto:
>> Hi,
>>
>> On Mon, Oct 31, 2016 at 11:55:08PM +0100, David Sommerseth wrote:
>>> How long will users be willing to wait?  I'd be really surprised if 2.4
>>> is out the door before Christmas 2016.  When also considering we've said
>>> that 2.4_alpha was soon ready for about 1 year or so before it really
>>> got released, I'd even say I am overly optimistic.
>>
>> If we could spend our time on a somewhat focused work on 2.4, instead
>> of exhausting ourselves discussing feature backports to 2.3, this could
>> happen faster.
>>
>> And more *focused* work: less rounds of review, buildbot explosions, etc=
.,
>> which eats up everyone else's precious time.
>=20
> It would be good to:
>=20
> 1) Catch the issues before buildbot
>=20
> In my recent INSTALL-win32.txt removal patch the breakage could have=20
> been avoided if I had been less sloppy and had actually tried to build=20
> the thing before sending in the patch.
>=20
> A basic "make check" goes a long way, but I intend to de-bashify the=20
> Vagrant integration soonish, so that we can merge it. This should make=20
> it easier for developers to catch runtime errors before sending in patche=
s:
>=20
> <https://github.com/OpenVPN/openvpn/pull/45>
>=20
> 2) Have buildbot catch issues before code is in Git "master"
>=20
> This could be solved by tracking an "experimental" or "buildslave"=20
> branch in Git, which would be basically Git "master" preview with forced=
=20
> update (history rewrite) option. Normal people should never use this=20
> branch, as the history would get rewritten whenever a patch would have=20
> to be rolled back. This would help ensure that Git "master" is always in=
=20
> a good shape.
>=20
> That said, doing 1) properly should help mitigate the risk of Git=20
> "master" breaking often. The less trivial issues will not be found on a=20
> single developer machine anyways.

I thought that we initially started with buildbot to *identify* such
build errors before *release*; as we happened to have a few releases
where we broke in similar ways during releases.  IIRC, the argument
which surfaced back then was something along the line that it is too
much to expect developers to do builds with all reasonable configuration
options.  So if that has changed over the year, I surely have missed
that memo.

To avoid this, we *must* have this automated somehow; otherwise things
either won't improve or people just avoid contributing due to too heavy
process - which some already do complain about today.
--bhNxUW31NnSdqTQv62gTDDKTXnMBibSK4--

--rhKALOE2bs7Virwm4swMUSNkbBVKwsPmi--
