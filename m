References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
	<1491996924-24576-1-git-send-email-steffan.karger@...1435...>
	<024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
	<afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>
	<193f3a1c-dab5-f1f1-7ed4-f34740c066a0@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0f9ad475-2cf0-de38-f6ed-be2389a87947@...2080...>
Date: Thu, 13 Apr 2017 18:40:10 +0200
MIME-Version: 1.0
In-Reply-To: <193f3a1c-dab5-f1f1-7ed4-f34740c066a0@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6pRxIV5qOVax3M3TQrmCRoSVh58lkfUKM"
Subject: Re: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
 mbedtls builds
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6pRxIV5qOVax3M3TQrmCRoSVh58lkfUKM
Content-Type: multipart/mixed; boundary="QGOWx8NMOixusCwcUIxbb04cxJAUfvX2Q";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <0f9ad475-2cf0-de38-f6ed-be2389a87947@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
	mbedtls builds
References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
	<1491996924-24576-1-git-send-email-steffan.karger@...1435...>
	<024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
	<afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>
	<193f3a1c-dab5-f1f1-7ed4-f34740c066a0@...1435...>
In-Reply-To: <193f3a1c-dab5-f1f1-7ed4-f34740c066a0@...1435...>

--QGOWx8NMOixusCwcUIxbb04cxJAUfvX2Q
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/04/17 15:37, Steffan Karger wrote:
> On 13-04-17 15:09, David Sommerseth wrote:
>> I'm however a bit puzzled of the "non-changes" (well, the indenting is
>> changing, unless I'm blind to other changes) to --remote-cert-cu,
>> --remote-cert-tls and --ns-cert-type.  If we want to change the
>> indenting, I think that should be kept in a separate patch, and keep
>> --tls-cert-profile as a patch of its own.
>=20
> Ah, indeed.  The indenting change is needed to make Github parse the rst
> correctly.  Feel free to remove the indenting changes and I'll send a
> follow-up patch doing just that.

Thanks!  I'll have a closer look and test the patch again.

>> On a more generic note to this patch.  I wonder if we should keep
>> "legacy" the default in the v2.4 branch.  In the Fedora 26 (and
>> Rawhide/27) builds I had to do something similar [1] to keep users
>> happy.  As OpenVPN isn't ready for OpenSSL v1.1, I had to switch to mbed
>> TLS.  Unfortunately that haven't been as successful as I really hoped it
>> would be, but that's an entirely different story (and mail thread).  As
>> long as the Fedora builds need to be built with mbed TLS, I will need to
>> ensure 'legacy' is the default there for a while.  For the coming Fedora
>> Rawhide (which will be F28), I can make some announcements preparing
>> users to move to stricter defaults.
>>
>> [1]
>> <http://pkgs.fedoraproject.org/cgit/rpms/openvpn.git/tree/0001-workaroun=
d-Allow-weaker-RSA-keys-and-MD-algorithms-i.patch?h=3Df26>
>=20
> The current mbed TLS builds already reject legacy crypto (except the
> fedora packaged build, apparently).  With this patch users have the
> ability to use legacy stuff again, but I would prefer to not go any
> further than that.  I think we should encourage people to drop the
> legacy.  Just like the browser vendors are doing.

I do agree.  But the pain as a package maintainer is quite noticeable
when you're getting complaints about configurations this breaks.  In
fact, I got quite some dissatisfied remarks even for moving from 2.3 to
2.4 on the OpenSSL builds (F25 + EPEL) - as that also broke some setups
- mostly due to our option parser now doesn't ignore configuration
errors any more or we actually implement the dual stack IPv4/IPv6
properly on the transport side.  For mbedtls, the biggest issue now is
the lack of PKCS#11 and PKCS#12 support.  For PKCS#11, that is moving
forward as the Fedora mbedtls package now enables that feature.  PKCS#12
seems to be a far harder nut to crack.

> And for Fedora, they chose to experience intense pain when they chose to
> go for OpenSSL 1.1 this fast, that's their problem I guess...  If they
> want to be that cutting edge, they should also stop using legacy crypto.
>  And otherwise, it will be a simple patch in the fedora packaging.

Well, they do make things move forward fast.  And they do a lot of work
to get upstream projects moving towards OpenSSL 1.1.  As there is a
major Fedora release roughly every 6 months, it is a fast moving target.

But Fedora users as side, they know each major release is a huge step
forward in many areas.  For most OpenVPN users, regardless of OS or
distro, they are used to the more sloppy legacy crypto support of
OpenSSL.  So enforcing a stricter set of crypto parameters in OpenVPN
v2.4 only on mbed TLS seems a bit odd to me.  And it is a big hassle for
our users.

The reason I now receive more noise about these things nowadays is
actually that I've pushed forward for mbed TLS to actually be able to
provide a somewhat functional OpenVPN package in Fedora.  So the amount
of OpenVPN users with mbed TLS suddenly got a considerable lift.
Unfortunately, many of them are looking forward for OpenVPN switching
back to OpenSSL.  So being smart here, may actually make it more
interesting for users to look more into mbed TLS later on.  If all they
remember from mbed TLS that it broke OpenVPN configurations, that's not
a good "sales argument".

So we do need to find a good compromise between modern security and our
users, regardless of if they are Fedora users or not.  Hence I think
pushing forward for 'preferred' in v2.4 is too early.  I agree we can do
that in v2.5/git master though, as that does give us time to communicate
this to users and perhaps even do something similar for the OpenSSL
builds as well.

And it is also a bit challenging to defend, at least for me, that mbed
TLS based builds are more conservative and stricter on the security
parameters than OpenVPN builds against OpenSSL - especially when the
OpenVPN version itself is the same.  I do understand and agree that it
is needed to move forward, but that must be done in a way which doesn't
alienate us with our users.

And this is basically the same argument why James have moved OpenVPN 3
builds against mbed TLS also use the 'legacy' profile as default.  My
initial port from PolarSSL 1.3 to mbed TLS 2.3 for OpenVPN 3 did what
you suggest, raise the security requirements.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--QGOWx8NMOixusCwcUIxbb04cxJAUfvX2Q--

--6pRxIV5qOVax3M3TQrmCRoSVh58lkfUKM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY76nqAAoJEIbPlEyWcf3yOawP/1AsjftGyAyuWDJhV2y0ysXI
u8tQwE6U8OAnYcfpGj0xi3zoctLqf2J3qKhy9Hm26bPDyts8A5M1xPyl8xBerjpP
A935HBL1rikVZbLunQDGf4gHs172SxGiNCqP6f1mFCGdeuPws77ix+WEqlTMD7A1
paZnPQ7Nq4ruUuYbAxkWtYEgGn/IHQJLwy2ELDYO6wOwWne8T4Ow6f4qyaZAwzWT
bIulYly+fsJ+JpL2ZsC1c29iiPFYnxWeY3OxdKFYSY6sLw2Ukcq0agjm3SBoIGMq
p4ypSOmvK5CwDQQF8JXTH75/CiSMJYQ17wpcTiyR7tUNUXo0WSOmWRLayXvqKN/S
0AQV7OsKAXSLkrUFq7PRA9dWotB8jERQZcwMDtVCQ9C8V4GuKVvBnQR9nAUVVGs6
Coyd2qbucUnH83rqzBtoSDLccpX5sRkla0lgq6hHCTb68xZtTB3HFpm+jziYl0jp
RYP0Hf7lk96WUyh2IISKi7IY3O1wsz1x7VNSJ28jZTdXCIDByRjtaJKrqfl77dlH
mWCAcq4aD0VYU9BIkpwqhnNL0hOthnNRVLMvfH+i9y6cGlzwlX3h3QteMbh5ZjHe
PC9PkbnP6cGn+UXri78PLT0ke6Xy/C4OCGPAkT39WNaYwy8TCxf1GleLhgwtZkCa
C4Pccd4ZUc/EI7I5Ga7O
=Z6Fw
-----END PGP SIGNATURE-----

--6pRxIV5qOVax3M3TQrmCRoSVh58lkfUKM--

