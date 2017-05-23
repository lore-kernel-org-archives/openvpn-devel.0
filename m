References: <20170225004014.28638-1-a@...2181...>
	<20170225091908.GX93896@...1296...>
	<f7ac719e-0b28-4c4d-5e8a-2932827789b6@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c11a42bc-0748-eec7-875b-aecbc6d73cbf@...1227...>
Date: Tue, 23 May 2017 23:52:21 +0200
MIME-Version: 1.0
In-Reply-To: <f7ac719e-0b28-4c4d-5e8a-2932827789b6@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="pAX04C7tpimJR57FxgOLsnriHX6am8HcK"
Subject: Re: [Openvpn-devel] [PATCH] Ignore auth-nocache for auth-user-pass
 if auth-token is pushed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pAX04C7tpimJR57FxgOLsnriHX6am8HcK
Content-Type: multipart/mixed; boundary="xElKMnSCALUGoNtl7N6HHOvmlCPrtRqhD";
	protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <c11a42bc-0748-eec7-875b-aecbc6d73cbf@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Ignore auth-nocache for auth-user-pass if
	auth-token is pushed
References: <20170225004014.28638-1-a@...2181...>
	<20170225091908.GX93896@...1296...>
	<f7ac719e-0b28-4c4d-5e8a-2932827789b6@...2080...>
In-Reply-To: <f7ac719e-0b28-4c4d-5e8a-2932827789b6@...2080...>

--xElKMnSCALUGoNtl7N6HHOvmlCPrtRqhD
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 25.02.17 um 14:10 schrieb David Sommerseth:
> On 25/02/17 10:19, Gert Doering wrote:
>> Hi,
>>
>> On Sat, Feb 25, 2017 at 08:40:14AM +0800, Antonio Quartulli wrote:
>>> When the auth-token option is pushed from the server to the client,
>>> the latter has to ignore the auth-nocache directive (if specified).
>>>
>>> The password will now be substituted by the unique token, therefore
>>> it can't be wiped out, otherwise the next renegotiation will fail.
>>
>> Without looking at the patch itself - is this suitable material for
>> inclusion in 2.3?  We do have quite a few "slow adopters" - and this
>> is a very useful feature to mitigate SWEET32 in 2FA environments...
>=20
> The code paths involved shouldn't be very differ too much between v2.3
> and v2.4.  So I would say this should go into v2.3 as well.
>=20
> Attached is a very preliminary (and only compile and 'make check'
> tested) patch of a backport to v2.3.  This needs to get a thorough test
> as well before we'll send an official patch to this ML.
>=20
> Btw. since I have worked closely with Antonio on this patch,  testing
> and debugging and discussing it for some time, I think it would be good
> if someone else than me does the final code review and ACK/NAK it.  I'm
> not able to be objective on this patch.
>=20

Code looks good. So ACK. We probably need another revision on this
auth-token client support (for reconnects) but this is going in the
right direction.

Arne



--xElKMnSCALUGoNtl7N6HHOvmlCPrtRqhD--

--pAX04C7tpimJR57FxgOLsnriHX6am8HcK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQReA6r9qqhQzJnD/WZ7z5ww1LjNFwUCWSSvJAAKCRB7z5ww1LjN
F0OJAKDPxRGvzaPXReSYpPVePdEIDy8VNQCeJj0cIYXYmFzgDh8NGs8XEpr43Mo=
=Pkte
-----END PGP SIGNATURE-----

--pAX04C7tpimJR57FxgOLsnriHX6am8HcK--

