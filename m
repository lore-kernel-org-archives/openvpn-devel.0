References: <25534afb-4dfc-fe21-6498-dc4aac20246f@...277...>
	<CAKuzo_gkTEh+-=z=dHm+sfHGqcHYwhCsOUvT=knNgj+X-B3HnA@...278...>
	<82c751dd-095d-cd1c-1422-24a443f1f1d0@...277...>
	<5c4e3f93-c584-4a19-4081-9bf4adaf417a@...277...>
	<502e093a-cb39-c76d-27b5-ab86fd4bcfd6@...515...>
	<73352d7f-521e-b968-2990-8783955da5c9@...2080...>
	<04516948-204e-57c2-fb57-f355157ed5af@...515...>
	<CAKuzo_gRDm566EwD_qtrYNM5AOYHF8xgCzsi1FQ3emjYGDeGmw@...278...>
	<43094758-efda-c613-c51d-e7980dfa6b24@...2080...>
	<CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>
	<90baad6a-25c5-2ecc-1ea8-b5a1febf1521@...2080...>
	<cadcd4fa-701e-2d35-4fe0-66707dae8b5b@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9ba106aa-7dc7-753b-d662-6a75c6d16314@...2080...>
Date: Mon, 31 Oct 2016 23:55:08 +0100
MIME-Version: 1.0
In-Reply-To: <cadcd4fa-701e-2d35-4fe0-66707dae8b5b@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="UG7NnviWGtLpUe6BJqPWsBB639cxLMP1B"
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
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UG7NnviWGtLpUe6BJqPWsBB639cxLMP1B
Content-Type: multipart/mixed; boundary="1eh8asvmaLJKlo4IoXTbo1296KQ1e75mL";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <9ba106aa-7dc7-753b-d662-6a75c6d16314@...2080...>
Subject: Re: [Openvpn-devel] trac 757 --auth-user-pass up + GUI 2.3 vs 2.4
References: <25534afb-4dfc-fe21-6498-dc4aac20246f@...277...>
	<CAKuzo_gkTEh+-=z=dHm+sfHGqcHYwhCsOUvT=knNgj+X-B3HnA@...278...>
	<82c751dd-095d-cd1c-1422-24a443f1f1d0@...277...>
	<5c4e3f93-c584-4a19-4081-9bf4adaf417a@...277...>
	<502e093a-cb39-c76d-27b5-ab86fd4bcfd6@...515...>
	<73352d7f-521e-b968-2990-8783955da5c9@...2080...>
	<04516948-204e-57c2-fb57-f355157ed5af@...515...>
	<CAKuzo_gRDm566EwD_qtrYNM5AOYHF8xgCzsi1FQ3emjYGDeGmw@...278...>
	<43094758-efda-c613-c51d-e7980dfa6b24@...2080...>
	<CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>
	<90baad6a-25c5-2ecc-1ea8-b5a1febf1521@...2080...>
	<cadcd4fa-701e-2d35-4fe0-66707dae8b5b@...277...>
In-Reply-To: <cadcd4fa-701e-2d35-4fe0-66707dae8b5b@...277...>

--1eh8asvmaLJKlo4IoXTbo1296KQ1e75mL
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 31/10/16 23:25, debbie10t wrote:
>=20
>=20
> On 31/10/16 21:30, David Sommerseth wrote:
>=20
>> So let's try to aim at pleasing the end user than being picky about the
>> wording of a track ticket.  Because most users will be thankful for a
>> related feature than no feature at all.
>>
>> Which is also why this core feature was added to the core OpenVPN 2.3
>> branch.  It wasn't important *how* this was solved.  It was important
>> that it was solved in *some* way; for non-Windows having a single line
>> auth-pass file was the solution.   For Windows the solution might need
>> to be different, just for the similar reasons we don't support bash
>> scripts on Windows - but we provide support for alternatives.
>>
>> Of course the contra argument is that 2.4 have this support.  But should
>> we start recommending users to upgrade to 2.4_alpha in production?  I
>> don't think so - as then we could have jumped straight to the final
>> release instead.  It will be a while until the final 2.4 version is
>> released.
>>
>>
>=20
> I believe the *vast* majority of people would prefer to see an Official=20
> Release of 2.4 take precedence over 'adding a /convenience/ feature' for=
=20
> a user-base that can/have/will:- not upgrade their operating system.
>=20
> <redacted>
>=20
> Anything else would be a waste of time.

How long will users be willing to wait?  I'd be really surprised if 2.4
is out the door before Christmas 2016.  When also considering we've said
that 2.4_alpha was soon ready for about 1 year or so before it really
got released, I'd even say I am overly optimistic.

I'm just trying to be realistic.


--=20
kind regards,

David Sommerseth


--1eh8asvmaLJKlo4IoXTbo1296KQ1e75mL--

--UG7NnviWGtLpUe6BJqPWsBB639cxLMP1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYF8vMAAoJEIbPlEyWcf3ytcsP/iT7sGbKF2XWita+5gsWNgMH
BwUUAW7qX8H6d8biqE72Sogtksy/9dqtjILMQv/x7QEJYVc4IKjp+XTx0Yd2qnWm
b2VCZaBrLS+GZkKcLbNBGCWeQCXN9FRG85qprTzEkJKIs3nI77sC4BiQrFuBGGwE
rlxmWKtadzP8MHmniTjj+dxsBmJVUMUOQFzQqlxzzX9S+awPmxPWGcKtsLdIRTmo
DXCt/YyHhDieimwB1iTVRnaMmArfkCDZQyYBIvGVfNSVso3Cs9IwUQtazRLViHNd
HJmzi9fTJVzSXoU88TefdeIIZJGUPf4L013yypznjEwzNPHwaKovmwkLO6DnEa2x
bTxz5P/ePjca8ZhAJ9ajl9nFL4HIl29yXe2i6j9kgm6Vo1MF9dNnvCXj9I4bIoAZ
Uce7yakccQY9rGigPPo1e7nSvHdmAPuonqFyR8QyFHFWgdN9OAwo3SbZzd+EBsIV
TMulqzlTzx93bIgqUM8q9+eO8zzoKCEbowRVJX5YroVnst5aRyJULuWVCxbut2S7
Y76wscQ6gtNKRln6mrpq80DXZnxaVfv7i2leQlWJSmpmrFb7rwsS0ARYL9aK6t9L
iiucaSukMA7IZdPRfy9SS9Sjnxj0dpCvFA+oeLHhg6pzwKs90kVtTkWljz2PZpEz
eLVQVhFi9x1tNw5iF/iv
=HLC1
-----END PGP SIGNATURE-----

--UG7NnviWGtLpUe6BJqPWsBB639cxLMP1B--

