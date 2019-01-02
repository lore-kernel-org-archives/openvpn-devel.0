References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
 <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>
 <24ac7730-c672-020c-2b8e-d8a9ef36ac5c@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <9280d234-8240-9bcd-98d5-71909e02efb2@...515...>
Date: Wed, 2 Jan 2019 08:35:43 +0200
MIME-Version: 1.0
In-Reply-To: <24ac7730-c672-020c-2b8e-d8a9ef36ac5c@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nPE5ElpLvg5dTDyFMURaqffWtHCjQ3OeR"
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nPE5ElpLvg5dTDyFMURaqffWtHCjQ3OeR
Content-Type: multipart/mixed; boundary="bYk8qRm77dWfBHBJv0oATZNL0lJbBrGsa";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: David Sommerseth <openvpn@...2080...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9280d234-8240-9bcd-98d5-71909e02efb2@...515...>
Subject: Re: [Openvpn-devel] Ubuntu 18.04 packages available for testing
References: <bd1a4942-aea3-bbe8-6f87-87c45f9ca009@...515...>
 <61f56d4b-1aa1-1459-c858-4cdcd176631b@...277...>
 <6b45e7db-4dd8-3880-a3da-9f78845d7fc3@...515...>
 <24ac7730-c672-020c-2b8e-d8a9ef36ac5c@...2080...>
In-Reply-To: <24ac7730-c672-020c-2b8e-d8a9ef36ac5c@...2080...>

--bYk8qRm77dWfBHBJv0oATZNL0lJbBrGsa
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Il 31/12/18 01:08, David Sommerseth ha scritto:
> On 30/12/2018 13:37, Samuli Sepp=E4nen wrote:
>> Il 28/12/18 16:21, tincanteksup ha scritto:
>>> Hi,
>>>
>>> On 27/12/2018 18:11, Samuli Sepp=E4nen wrote:
>>>> Hi,
>>>>
>>>> I've produced OpenVPN 2.4.6 packages for Ubuntu 18.04 and they're now
>>>> available here:
>>>>
>>>> https://build.openvpn.net/downloads/temp/
>>>>
>>>> The Debian packaging files are taken from Ubuntu's own 18.04 openvpn
>>>> package. They already used our openvpn-client@...1685... and
>>>> openvpn-server@...1685... so I only need to make a few enhancements:
>>>>
>>>> - Restart active VPN client and server instances on upgrade
>>>> - Stop activate VPN client and server instances on uninstall
>>>>
>>>> I also tested upgrading from Ubuntu's own openvpn package and that
>>>> worked fine.
>>>>
>>>> Let me know if these packages work for you or if they don't. I'd like =
to
>>>> get the to our official apt repositories soon.
>>>>
>>>
>>> Successfully installed openvpn_2.4.6-bionic0_amd64.deb in Ubuntu 18.04,
>>> tested newly installed openvpn-client@...1685... which worked correctly.
>>
>> Excellent! The openvpn-client@ and openvpn-server@ unit file templates
>> "sneak in" to the Debian package from our upstream tarball. When looking
>> at the Debian packaging files there's absolutely no sign of them. But
>> they get installed and seem to work, including the tmpfiles configuratio=
n.
> Those new service files are the ones everyone should use.  In our own
> packaging, we should abandon the b0rken unit files from the old-days Debi=
an
> packages.  This is especially true for OpenVPN 2.4+ when built with
> --enable-systemd (which should be mandatory on systemd systems!).  The re=
ason
> is that it uses much better systemd integration which allows systemd to
> understand better what openvpn is doing and when it fails.  Plus, the ope=
nvpn
> process is being run with lesser privileges as well and for openvpn-serve=
r@ it
> will even attempt to restart automatically the server instance if it dies
> unexpectedly.
> And IIRC, we managed to get the new unit files into the Debian openvpn 2.4
> package.  And I just hope that they are updated with whatever we provide =
in
> our tarballs; if not - it might be considered broken packaging.  The reas=
on
> you'll find the b0rken unit files in the upstream Debian packages is to n=
ot
> break old existing installs.  Which is nice, just that it behaves broken
> regardless.

And this is exactly the reason I did _not_ remove openvpn.service or
openvpn@...1685... from our Ubuntu 18.04 packages.

>=20
> So if anyone is in doubt ... UPGRADE to the openvpn-{server,client}@.serv=
ice
> unit files ASAP.

I'll mention this in the README.Debian. I added a short "notes from
upstream" section there anyways.

Do you have links to bug reports that would clarify why the old unit
files are broken? If I'm not mistaken one of the issues was related to
OpenVPN on Amazon EC2 and status check #2 not passing when an instance
of openvpn@...1685... was running.

Samuli


--bYk8qRm77dWfBHBJv0oATZNL0lJbBrGsa--

--nPE5ElpLvg5dTDyFMURaqffWtHCjQ3OeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlwsW78ACgkQKVhNn0CG
RXg8ZAf/aGkhQnsnY0oBEThQgzV153GHx7R7bJF/BRTKtf6zjSe0vhgPk7gFJ7bZ
j/sTj81syb2l2NE3jxmnTRTdV7/5PiUIv27BdQmcqpignzQraQTvHqesteEL1vwb
L0mlHvHfaE0i36E5gjRCKQsolG77bm6R3vzQgektE6S0sKP7naKL8ESKJAXnR+SP
NJAnxRI/fMSVzMkactvda+Wcw53EJ3DHGaW27c22/1UkDw3ruAKWksS/4Vl3g1n9
ukVXIT2EIA8GXm9Csln6KT6EqIx8WVJWZ6Dx64xJ4NfVsBXR6nMxMlJr3VoxUgwc
dkj8x8h9k6xAP6S3VGxn5K895TXU/A==
=zYhT
-----END PGP SIGNATURE-----

--nPE5ElpLvg5dTDyFMURaqffWtHCjQ3OeR--

