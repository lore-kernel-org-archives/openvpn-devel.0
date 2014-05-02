Content-Type: multipart/signed;
	boundary="Apple-Mail=_63F32BDE-ED5C-4F84-9AF7-114F5D50BFDA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <5362CC90.7020601@...1114...>
Date: Thu, 1 May 2014 20:52:05 -0500
Message-Id: <7C9C4EE6-8A7A-4CF7-9EF3-FDC825A43AAC@...1286...>
References: <536262FD.1090105@...1901...> <53627F26.1060208@...515...>
	<20140501191514.GQ16637@...1296...>
	<5362CC90.7020601@...1114...>
Subject: Re: [Openvpn-devel] IRC & Community...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: OpenVPN Users <Openvpn-users@lists.sourceforge.net>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Timothe Litt <litt@...1901...>

--Apple-Mail=_63F32BDE-ED5C-4F84-9AF7-114F5D50BFDA
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sorry about the logs, I'll update the wiki.  My cronjob was putting the fil=
es in the wrong location.  It's better, so I'm going to leave them where th=
ey are now.

#openvpn: http://secure-computing.net/logs/openvpn.log
#openvpn-devel: http://secure-computing.net/logs/openvpn-devel.log

-----
Eric F Crist



On May 1, 2014, at 17:37:04, David Sommerseth <openvpn.list@...1114...> wro=
te:

> On 01/05/14 21:15, Gert Doering wrote:
>> Hi,
>>=20
>> On Thu, May 01, 2014 at 08:06:46PM +0300, Samuli Sepp=E4nen wrote:
>>> A few notes about where we get our patches from... in the documentation
>>> we do say that "post the patch to openvpn-devel list". That was a
>>> decision that was reached some years ago. However, we, in practice, do
>>> accept patches from Trac, GitHub and IRC. We should probably change the
>>> documentation to reflect this.
>>=20
>> Actually, openvpn-devel *is* the way, with trac being second (due to
>> the way we reference every commit to a mail on openvpn-devel, trac
>> patches basically need someone re-sending them to the list).
>>=20
>> Github and IRC are *not* a welcome input for patches, because it doesn't
>> match the agreed-upon workflow ("ack or nack on the list, reference that
>> message in the commit"), and doesn't have the benefit of trac to be
>> tied to a ticket that can be set to a given milestone, etc.
>>=20
>> IRC is very welcome to bounce around ideas ("should we fix this?  if
>> yes, in which way?") but it needs to result in a patch being sent to
>> openvpn-devel.  Actually, this is often the reason why some patches get
>> ACKed much quicker than others - they have been discussed, the reason
>> for the change is well-understood, and for complicated stuff, the details
>> how to tackle it might have been agreed-upon beforehand.
>=20
> +1
>=20
> [...snip...]
>=20
> On 01/05/14 19:06, Samuli Sepp=E4nen wrote:
>> Lack of developer time is the biggest issue for us, and that lack of
>> time results in unnecessary work having to be done later; like having
>> and maintaining a patch tracking page instead of just handling the
>> patches immediately as they are sent to the list.
>=20
> +1 ... For some more info to Timothe, I used to be quite active for a lon=
g=20
> time.  But I almost "hit the wall" late last summer, and had to pull the=
=20
> emergency break and reduce my workload.  I simply did too much and OpenVP=
N was=20
> one of the things which took quite some time for me.  I've not resigned=20
> completely, but I'm incredibly grateful Gert was able to pick up where I =
had=20
> to drop.  Gert has done an amazing job, far better than I could ever do! =
 I'll=20
> come back somehow, and I even have a few patches on the ML which lingers =
too -=20
> but I need to step carefully forward.  But these patches which already ar=
e on=20
> the ML does need help to get tested and reviewed.
>=20
> We're really lacking developer time.  And developers often needs to also =
try=20
> to keep track of what happens a few places too.  So this is a bad circle,=
 as=20
> to where to put the efforts today.  So I'm open to discuss a way to move =
this=20
> patch tracking and some of the administrative work "away" from the develo=
pers,=20
> if anyone is available and have time and energy.  That's not something wh=
ich=20
> requires really deep developer skills, but interest and somewhat knowledg=
e=20
> about development is always good.  And it can be a good starting point to=
 get=20
> more involved in more core development with time as well, as it's a perfe=
ct=20
> way to gain more knowledge about OpenVPN and how it works ... And if no-o=
ne=20
> chimes in, things won't change all too much.
>=20
> So the key point is probably: Do you dare to get your hands dirty?  Then =
there=20
> might absolutely be a possibility to join in :)
>=20
>=20
> --=20
> kind regards,
>=20
> David Sommerseth
>=20
> -------------------------------------------------------------------------=
-----
> "Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
> Instantly run your Selenium tests across 300+ browser/OS combos.  Get=20
> unparalleled scalability from the best Selenium testing platform availabl=
e.
> Simple to use. Nothing to install. Get started now for free."
> http://p.sf.net/sfu/SauceLabs
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--Apple-Mail=_63F32BDE-ED5C-4F84-9AF7-114F5D50BFDA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJTYvpFAAoJEHKWQhk5DQ0OMxEH/2mkjFeK1WgtuOka+E8ekadY
rNkva3M1LxKCYBKk1QX0EQwkAnQYi88aCsy3nlVsIkF635OwrV6JtLNVqj/dIW2v
P/dJ+qt3vUxFBorjoHIP44Is3rB24CU4IC0BTUyEhsHOsr+MYPKWHjLIXESWyoid
yazHOgT98Ige4rqh7iXWkxKUPYWYwWaiTN4UowaFPVuI22Tw86CgdZvtJk0hFCqW
0ppb0Szhc7m5aQOigg/cCS9yCYtEmQl3r7+d9fiVuwFQpnZeI0Xn5QM0TGT6nr03
IFbOdeGd1Zp4aAJ+f42e5YkuqNtKyjvdVKbTxjH6bRbFYxJ9HqgdMErPz88K/dc=
=PJQV
-----END PGP SIGNATURE-----

--Apple-Mail=_63F32BDE-ED5C-4F84-9AF7-114F5D50BFDA--

