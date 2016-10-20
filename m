References: <20161019062231.2845-1-a@...2181...>
	<20161019062231.2845-4-a@...2181...>
	<20161020084234.GR12558@...2182...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <015ff7fa-be6d-070e-1d06-3f04bf713bd2@...2080...>
Date: Thu, 20 Oct 2016 12:36:17 +0200
MIME-Version: 1.0
In-Reply-To: <20161020084234.GR12558@...2182...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="9b27eg0M3MkjCnirR1LBTkP1lmeJRRPDb"
Subject: Re: [Openvpn-devel] [PATCH 3/3] openssl: implement crl-persist
 related functions
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9b27eg0M3MkjCnirR1LBTkP1lmeJRRPDb
Content-Type: multipart/mixed; boundary="oTrN6O9RI0ko1bbgHDiwS4XMjFtbtLwOJ";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <015ff7fa-be6d-070e-1d06-3f04bf713bd2@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] openssl: implement crl-persist
	related functions
References: <20161019062231.2845-1-a@...2181...>
	<20161019062231.2845-4-a@...2181...>
	<20161020084234.GR12558@...2182...>
In-Reply-To: <20161020084234.GR12558@...2182...>

--oTrN6O9RI0ko1bbgHDiwS4XMjFtbtLwOJ
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 20/10/16 10:42, Antonio Quartulli wrote:
> On Wed, Oct 19, 2016 at 02:22:31PM +0800, Antonio Quartulli wrote:
>> Implement the functions needed by the crl-persist logic when openssl
>> is enabled. Such functions are used in the ssl_verify module.
>>
>> Note that the CRL file is stored in an adhoc data structure and no
>> openssl specific object is used. The data structure being used is a
>> sorted array or serials that can later be looked up in log(N) with
>> a binary search, thus guaranteeing a fast lookup operation.
>>
>> Such data structure may be changed in the future with an optimized
>> openssl specific object.
>>
>> Tests have been performed by using a CRL file having size 143MB.
>> Original delay upon client connection was around 5-8 seconds.
>> With this patch the delay gets close to 0.
>>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>=20
> As discussed on IRC, it might be better to first change the CRL handling =
code in
> the OpenSSL module to use the internal routines provided by the OpenSSL l=
ibrary.
> (apparently a patch to implement this change is in the work on somebody e=
lse's
> desk)
>=20
>=20
> At that point my patch could be changed to re-use the same code instead of
> implementing my own optimized logic.
>=20
>=20
> Note: also OpenSSL uses a sorted array + bsearch for CRL handling, theref=
ore
> the performance of OpenSSL vs my approach should be similar.
>=20
>=20
> Does anybody else have any opinion against this?

First of all, thank you very much for this patch set!  As I said on the
IRC, this patch-set is well done when it comes to overall style and
layout.   I have not dug into the details, but the overall quick look
gave a good impression.

This new feature sounds reasonable.  The improved OpenSSL CRL handling
will be most welcome.  So basing your work on top of that makes a lot of
sense, and hopefully it can simplify your patch as well.

But I also think that we should look more carefully at the whole CRL
handling as a hole unit.  To me the --crl-persist looks like a
reasonable feature, but I'm still hoping to see more responses to this
feature from others as well.  But if it turns out that we can implement
this feature and also improve the current CRL handling, that will
hopefully give even less code duplication and an even simpler patch to
when adding the --crl-persist feature.

On IRC we also briefly discussed that the mbedTLS CRL code oaths is not
too clever and efficient (like, no btree search, just a simple
for-loop).  I would encourage you to look if you can improve the mbedTLS
code too, and provide that patch to them.  I'm sure the mbedTLS guys
will appreciate that effort.  This will again indirectly benefit us, and
we need to have even less specialized code to make the mbedTLS
integration perform well.  So it's a win-win for all of us :)

And I'm happy to see more people looking into these parts of the OpenVPN
code as well!  So thank you!


--=20
kind regards,

David Sommerseth



--oTrN6O9RI0ko1bbgHDiwS4XMjFtbtLwOJ--

--9b27eg0M3MkjCnirR1LBTkP1lmeJRRPDb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYCJ4mAAoJEIbPlEyWcf3y85UQAKXeLWtj0CyouewMvZheWTK+
F/9VqtJQXghelvKw/fe+HLY7hT6spVrLhE1luBWOELYFZtyL8fzWz7WX5Ko2aDuo
1SVgPTMfch+fCN1mk7oR2U0YSTmJz8O27IVcrw55wR8sMEAgK7TQRfL1nqu1ukCu
ONuPzBsakv8rvWjEV42asUnck0tT/2cehsSr/bwb3AGrTyH3C4/niJijFBImntwT
jdtgGMghFsb/ozZjbzYG1V71N/k9NQZZiVDegzNWLc3891XEXajKLMxvOE7lAHOV
hey519RuV0aHTv9WCtZtHmm9zzbfqN/vM0+3wkueDCPC0gV7DoAJ6nLbQw0KCzlu
ZXVNhdbCbWYM0q6L7R1Rbg0fOAlcgmbGTOkfF+d/h7rS0HLSqGc4/OrQQ0OdrX8S
UtoU7QKPH9J75MOleKyu6ovcTBNpAQ9i74vn+EXAoXJyCINpdzoQUN9gCurKLKIu
9gVBHXs8PWActPWlSnk3/E+dm3uYe0G6O6UQmENbPd7BJZLo3z6cCXkGAG1dQvZt
AwRp4ubofoRKuY5isyaXQx6xpwxGP+5phF/TnO4nDV+7iX5t06PUXAfzcqTE8mAp
rAPlF7wvP+ocQtgdB0086C3FqnMY64WlVnPnV+Ckr+8Uas0Y+PGEnIILOACvD9To
ERZw5s7z/+2cGgVS9NUU
=pprE
-----END PGP SIGNATURE-----

--9b27eg0M3MkjCnirR1LBTkP1lmeJRRPDb--

