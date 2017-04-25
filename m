References: <d0cc2a54-cd65-9ebd-1e6f-8d2b75bfb223@...277...>
	<CAKuzo_iam5RwR=grdc9cT8OL6AWdEp_bEh9jo1dhiyVf9T21sQ@...278...>
	<67275b0c-0491-b8e0-23d8-7ed548a6f3e3@...277...>
	<16ad3121-4498-7a47-c481-f6e0c2b19084@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <79d0f18c-5817-b78c-ec7c-fe4d202f00a9@...2080...>
Date: Tue, 25 Apr 2017 23:06:49 +0200
MIME-Version: 1.0
In-Reply-To: <16ad3121-4498-7a47-c481-f6e0c2b19084@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pjAGPuhq6fXekdQ7qjtlFSQ31dvJ84dmB"
Subject: Re: [Openvpn-devel] Windows 10 Creators Update broke
 --block-outside-dns
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <valdikss@...277...>, Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pjAGPuhq6fXekdQ7qjtlFSQ31dvJ84dmB
Content-Type: multipart/mixed; boundary="wHxWjlKJ5unqeiV7udfHh8Urn6DKia1U0";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: ValdikSS <valdikss@...277...>, Selva Nair <selva.nair@...277...>,
	openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <79d0f18c-5817-b78c-ec7c-fe4d202f00a9@...2080...>
Subject: Re: [Openvpn-devel] Windows 10 Creators Update broke
	--block-outside-dns
References: <d0cc2a54-cd65-9ebd-1e6f-8d2b75bfb223@...277...>
	<CAKuzo_iam5RwR=grdc9cT8OL6AWdEp_bEh9jo1dhiyVf9T21sQ@...278...>
	<67275b0c-0491-b8e0-23d8-7ed548a6f3e3@...277...>
	<16ad3121-4498-7a47-c481-f6e0c2b19084@...277...>
In-Reply-To: <16ad3121-4498-7a47-c481-f6e0c2b19084@...277...>

--wHxWjlKJ5unqeiV7udfHh8Urn6DKia1U0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 25/04/17 22:40, ValdikSS wrote:
> Please check updated version
> https://github.com/ValdikSS/openvpn-with-patches/commit/80345eac823326299=
c5428a8db45dc06a8d10f7b
>=20
> set_interface_metric() needs to be called from interactive service but
> the service doesn't include win32.h/c so I had to copy/paste code into
> it. How could this be improved?

I've quickly looked at it.  I am by far no Windows developer, so I don't
understand all the deeper contexts of the details.  But I've left a few
comments on github with some questions I think could help clarify your
patch.

Adding a few comment lines of "why" and documentation pointers on some
of these details you set as "default" would help understand the code
better.  What your or we know as a fact today, doesn't mean we will
remember that and correlate it with today's context in a few years.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc




> On 18.04.2017 21:42, ValdikSS wrote:
>> On 18.04.2017 21:37, Selva Nair wrote:
>>>
>>> On Sat, Apr 15, 2017 at 6:41 PM, ValdikSS <valdikss@...277...
>>> <mailto:valdikss@...277...>> wrote:
>>>
>>> How does this registry entry tell Windows that TAP adapter should be
>>> preferred for DNS? Or is this to be done in addition to setting up a
>>> preferred ordering of network adapters?
>>
>> It doesn't. I just remembered that option and set it. It worked for me
>> when DNS is in the same subnet with user, but it fails if DNS is in
>> the internet.
>> Setting lower metric to the TAP interface correctly works in both
>> cases, without reg patch.
>>
>>>
>>> Can WFP be used to rewrite the source address? In that case we could
>>> just redirect all DNS requests through the TAP interface instead of
>>> dropping packets.
>>
>> Unfortunately not, not without kernel driver.
>>
>>> As for local ipv6 DNS servers, I do not think we should do anything
>>> about it unless the tunnel can handle v6 traffic.
>>>
>>> Selva
>>
>> I made a perliminary patch to set interface metric to 7:
>> https://github.com/ValdikSS/openvpn-with-patches/commit/0651c0469038dd0b=
a39329f4b83ecd7e1d04323e
>>
>> This is static change for the interface. Currently this patch does not
>> revert previous metric value if there were any or set it back to
>> automatic. Should it be implemented in your opinion? It still won't
>> revert this value back in case of OpenVPN crash or power outage. Yet I
>> don't think that lower metric on TAP interface would have any
>> influence for networking at all.
>>
>> Please tell your opinion guys. Selva said it should revert the
>> previous value upon termination.
>>
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20





--wHxWjlKJ5unqeiV7udfHh8Urn6DKia1U0--

--pjAGPuhq6fXekdQ7qjtlFSQ31dvJ84dmB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY/7ptAAoJEIbPlEyWcf3y76UQALE7xPwr0C6a4U7vt/dFnc1p
+k4iK6VT5FYRdZMT1+sicONeL1/TnbjVKZCKWTskL7o+cDEc/UzcMzVTtrQQcgWe
Ewg0SrKaG62QN44kXVMYDIy/IEc0/fh7Mg+EVUlZpe1nhvkW5hoKkOCsqI/l24M0
I1v1688NefaIEJKi0fZ1coINSEbNcHsjb+crASoaU29HIpvsKYWJrVEg5pV7DZn2
jZQfJM2cogNy9pW9AbSr4LdgNsEchZWkKTgJcHfNLE1jq/A/7VIftcN1is+hDTVJ
5B3YYTXX46scNuKxYiaz/m0BWzgEAAO4FSHhAiuLUTM3toIyD+64HYLL6hABLYtl
g8+nHeXKi/gdIUNrPiJ/BV9sPkEYiiNFfBgbZkmlEHHK6Tx+GaGM2oOjG0QbGRPz
q7pozZhn/M3EHbFxlH0sTU4VmVEXh5VStGllYYU1XB8L8cp1pYAjN2alETClSAsP
SLYTuGFyAKj+YRzytF696Rhnz8mAzr/xWEsPuK0TX4lWYYRN1LRfBemLFQ1iWUiU
WpSuDQuYKOq8c+hTffTcl8DbJqkIOnij6w3zrq7woPsBY9481Ogmcdr1/ulH7MPM
7omu7E4RYmUihXCUWiV8ckYJg/En3zYmSTVlL122pUkf3kjIL5YIKco4QrLTTeOf
mgChDvzoBoNejfj1Qo9o
=fssD
-----END PGP SIGNATURE-----

--pjAGPuhq6fXekdQ7qjtlFSQ31dvJ84dmB--

