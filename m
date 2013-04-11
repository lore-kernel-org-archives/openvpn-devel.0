Message-ID: <5166C2B1.8050707@...1114...>
Date: Thu, 11 Apr 2013 16:03:29 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1346422753-19520-1-git-send-email-arne@...1227...>
	<201304110933.r3B9XwPT011987@...1729...>
	<20130411105202.GA26778@...1296...>
	<5166B459.9020801@...515...>
In-Reply-To: <5166B459.9020801@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2RXKCWIHDXFSNJXIRHVKA"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add the client id (CID) to
 the output of the status command
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
------enig2RXKCWIHDXFSNJXIRHVKA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 11/04/13 15:02, Samuli Sepp=E4nen wrote:
>=20
>> Hi,
>>
>> On Thu, Apr 11, 2013 at 11:33:58AM +0200, Gert Doering wrote:
>>> Your patch has been applied to the master branch (ACK by me).=20=20
>>>
>>> I'm not sure whether we need this in release/2.3, but if people see the=
=20
>>> need, please speak up and I'll cherry-pick :-)
>>>
>>> commit 662ce6acc065bddf6490b3494725b8b3987b7def (master)
>> ... unfortunately, it breaks --disable-managemnt builds :-( - good that
>> we have buildbots, stupid me for not noticing it before ACK-and-push.
> I wonder if using a "staging" repo would be too much trouble? Buildbots
> could track it, and only after all builds have succeeded, the changes
> would be pushed to master.

Tempting thought.  But I'd say it will be more maintenance than real
benefit in the long run.

Using git-revert will actually document better what we tried and why we
didn't like that patch after all.  We don't need to try hide our
mistakes that well :)

Rather have a policy ... if a patch breaks something, fix it within
24-48 hours, if not use git-revert.

--=20
kind regards,

David Sommerseth


------enig2RXKCWIHDXFSNJXIRHVKA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFmwrEACgkQDC186MBRfrqJ1QCfTrsuMmNAVVW7/2EjR4Wpf/oQ
qGkAnj0Knavt/GPB2XvEip6PCEWeB5Ui
=QZoO
-----END PGP SIGNATURE-----

------enig2RXKCWIHDXFSNJXIRHVKA--

