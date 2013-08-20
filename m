Message-ID: <52133EC8.2060003@...1114...>
Date: Tue, 20 Aug 2013 12:02:48 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAFHpkQHAAdBdPdtrtVpzUzwT5WdeEwWYpqPag=mLnSX-pMLaEw@...278...>
	<20130819104455.GH16543@...1296...>
	<5212620F.3060106@...515...>
	<20130819210137.GS16543@...1296...>
	<5213306D.2050205@...515...>
	<20130820092900.GA16543@...1296...>
In-Reply-To: <20130820092900.GA16543@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dkb3HH2RC6wqfblsHp6MEi1PJUC6eB3Cq"
Subject: Re: [Openvpn-devel] [Openvpn-users] pull requests on github
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dkb3HH2RC6wqfblsHp6MEi1PJUC6eB3Cq
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 20/08/13 11:29, Gert Doering wrote:
> Hi,
>=20
> On Tue, Aug 20, 2013 at 12:01:33PM +0300, Samuli Sepp=E4nen wrote:
>>> We've had questions on #openvpn-devel about pull request 7, which was t=
he
>>> first time (on request *7*) that anyone was taking note that we offer
>>> pull requests at all - so there's 7 pull requests out there that are ig=
nored.
>> Well, we don't have the manpower to look at Trac bug reporting, and we
>> still don't disable bug reporting, do we? :)
>=20
> This is a problem, indeed.  But it's not an argument for adding yet anoth=
er
> queue that we don't look at.

In addition, we don't have "competing" alternatives to bug tracking on
the table.  And we need bug tracking, unfortunately.

>> Anyways, I can keep an eye on the pull requests and if something
>> interesting pops up, I can forward those people to openvpn-devel. Or, if
>> we really want to disable pull requests, we should monitor the OpenVPN
>> forks in GitHub for something interesting, and encourage people to push
>> their stuff to main development line.
>=20
> I've never understood the hype around github, tbh.  If you see value in
> adding to your workload, feel free to - but really, evidence speaks again=
st
> enabling pull requests.

+1

> Also, Dazo and I won't actually *use* git-pull to fetch those, so one
> of the big reasons why you would want that ("to enable git pull") wouldn't
> apply anyway.  We have agreed on a workflow how to integrate patches, and
> "pull" is not part of it.  "git am" and "git push" are...

Even James sends patches to the mailing list for review nowadays, so we
don't even do git pull from his repos.

We've settled a long time ago that we wanted to review patches on the ML
to keep track of the process in a distributed manner (reviews are not
stored in a single server or with a single provider).

Github can have some kind of review as well, but is doing it in a
centralised manner.  And it would require us to write new scripts to
automate git pulls as well - to get those extra review lines we add to
the commit logs.  And if Github disappears, changes URL schema or
similar things, we've lost the references to the review.  On the mailing
list, there is at least the Message-ID which is unique enough to even
use in google searches.  Nothing is really lost if gmane.org or
sourceforge.net shuts down.


--=20
kind regards,

David Sommerseth


--dkb3HH2RC6wqfblsHp6MEi1PJUC6eB3Cq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlITPskACgkQDC186MBRfrplMACfcxSOeH2oqRHL/K65k8EowqMB
VkkAnjNmfut5LtvgooiOxTUyk4ZVimrW
=pFMz
-----END PGP SIGNATURE-----

--dkb3HH2RC6wqfblsHp6MEi1PJUC6eB3Cq--

