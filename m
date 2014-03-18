Message-ID: <53288533.3060509@...1114...>
Date: Tue, 18 Mar 2014 18:41:07 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1395017376-24554-1-git-send-email-james@...515...>	<20140317202910.GM16637@...1296...>	<532775DD.4050106@...515...>	<1CED409804E2164C8104F9E623B08B90155646D4C1@...1436...>	<53281720.2050504@...1147...>
	<5328463F.7090704@...1114...>	<53284DA8.1010709@...1147...>
	<1CED409804E2164C8104F9E623B08B9016F95AD5DC@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B9016F95AD5DC@...1436...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Up4oNcv2C4cqF5BDxbpDOh7CqPvnOsCrD"
Subject: Re: [Openvpn-devel] [PATCH] Set SSL_OP_NO_TICKET flag in SSL
 context for OpenSSL builds, to disable TLS stateless session resumption.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Up4oNcv2C4cqF5BDxbpDOh7CqPvnOsCrD
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 18/03/14 17:40, Steffan Karger wrote:
> Hi,
>=20
> On 18/03/2014 14:44, Jan Just Keijser wrote:
>> On 18/03/14 14:12, David Sommerseth wrote:
>>> On 18/03/14 10:51, Jan Just Keijser wrote:
>>>> On 18/03/14 10:39, Steffan Karger wrote:
>>>>>> On 17/03/2014 23:23, James Yonan wrote:
>>>>>>
>>>>>> On 17/03/2014 14:29, Gert Doering wrote:
>>>>>>> Right now, if I read configure.ac correct, we require 0.9.6 or
>>>>>>> later (and check this only if pkg-config is available) - but
>>>>>>> obviously, SSL_OP_NO_TICKET was added later on.
>>>>>>>
>>>>>>> Fix 1: only use SSL_OP_NO_TICKET if available Fix 2: require a
>>>>>>> more recent OpenSSL version
>>>>>> I would think an #ifdef should be fine.
>>>>> SSL_OP_NO_TICKET was added in OpenSSL 0.9.8f / 1.0.0. The ECDH-
>> patchset (for 2.4) already requires 0.9.8, so I would prefer to require
>> 0.9.8f or newer for master/2.4, but just add #ifdef's for 2.3.
>>>>>
>>>>>
>>>> I disagree. It is not safe to assume that the #ifdef is bound to a
>>>> particular version of Openssl; for example, on my Centos 6.5 box I
>>>> have openssl 1.0.1e yet the define
>>>>     #define SSL_OP_NO_TICKET                0x00004000L
>>>> is NOT present in the system ssl.h file.
>>> I just checked RHEL 6.5 and ScientificLinux 6.4
>>> (openssl-1.0.1e-16.el6_5.4) ... they both have it this:
>>>
>>> # grep SSL_OP_NO_TICKET /usr/include/openssl/*
>>> /usr/include/openssl/ssl.h:#define SSL_OP_NO_TICKET
>> 0x00004000L
>>>
>> this is most odd - I just checked a few other machines (CentOS 6.5) and
>> there the SSL_OP_NO_TICKET is present.
>> I then reinstalled openssl on the 'flawed' box and now it is present
>> also.
>> So it seems I spoke too soon... sorry for the noise, although I must
>> say that I'm still in favour of checking for the existence of an IFDEF
>> instead of relying on a particular version...
>=20
> Point taken, just checking the OpenSSL version does not suffice.
> Still, I'd like to prevent more #ifdef's in the code. We could check the
> #ifdef in configure.ac, and refuse to build when it's not present. Any
> objections against requiring SSL_OP_NO_TICKET to be present for OpenVPN
> 2.4+? We have to drop support for 'ancient stuff' at some point.

I don't disagree with you ... but we need to think about what our users
may have installed.  James was concerned about RHEL4 support some years
ago, when we discussed if we should support OpenSSL 0.9.6 or not (which
was available in RHEL4, iirc).  At that time we agreed upon moving
towards a 0.9.8 requirement when RHEL4 was out of the normal support
cycle (which was February 29, 2012).

RHEL5 is fully supported until March 31, 2017.

I think it makes sense to follow RHEL's life cycle, as that is usually
one of the distributions at an enterprise level which is kept up-to-date
on critical issues throughout its life cycle.


--=20
kind regards,

David Sommerseth


--Up4oNcv2C4cqF5BDxbpDOh7CqPvnOsCrD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMohTMACgkQDC186MBRfrquJACfUDqRdgVzk1TeyFVBRv6EFL7d
pIcAoKs7MM8eFnaTWyY/RtotVIW6R4/m
=93lT
-----END PGP SIGNATURE-----

--Up4oNcv2C4cqF5BDxbpDOh7CqPvnOsCrD--

