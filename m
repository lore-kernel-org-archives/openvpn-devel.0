References: <20161227112436.5045-1-a@...2181...>
	<97c51277-d8b7-b768-5205-706492e92f84@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <45d27aa6-4720-5cd9-3b70-0e566b6d4b66@...2080...>
Date: Thu, 12 Jan 2017 03:14:22 +0100
MIME-Version: 1.0
In-Reply-To: <97c51277-d8b7-b768-5205-706492e92f84@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="q5gfSTB2EMLQ3iLhRDvgnBBtJhKewixWH"
Subject: Re: [Openvpn-devel] [PATCH v2] convert *_inline attributes to bool
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q5gfSTB2EMLQ3iLhRDvgnBBtJhKewixWH
Content-Type: multipart/mixed; boundary="VGJP7hhDw3NaB1Sn7C4OAGKmEK7AVUWKl";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, Antonio Quartulli <a@...2181...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <45d27aa6-4720-5cd9-3b70-0e566b6d4b66@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] convert *_inline attributes to bool
References: <20161227112436.5045-1-a@...2181...>
	<97c51277-d8b7-b768-5205-706492e92f84@...1856...>
In-Reply-To: <97c51277-d8b7-b768-5205-706492e92f84@...1856...>

--VGJP7hhDw3NaB1Sn7C4OAGKmEK7AVUWKl
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 10/01/17 22:35, Steffan Karger wrote:
>> @@ -5154,7 +5194,8 @@ add_option(struct options *options,
>>          {
>>              options->plugin_list =3D plugin_option_list_new(&options->g=
c);
>>          }
>> -        if (!plugin_option_list_add(options->plugin_list, &p[1], &optio=
ns->gc))
>> +        if (!plugin_option_list_add(options->plugin_list, &p[1], is_inl=
ine,
>> +                                    &options->gc))
> Can we inline a plugin?  I wouldn't think so, but I've been surprised by
> our option parser before ;-)  (Arne or David might know this.)

Oh dear ... No it should be possible to inline a plug-in.  Our code uses
dlopen() to load plug-ins, which expects a full path.  So I would expect
to see dlopen() fail.

And no, we should not ever be able to inline a plug-in.  I'll probably
get nightmares this night due to all the potential security issues
related to this.  Neither should any of the script-hooks be possible to
inline.

> If not, you don't need to add the is_inline argument to
> plugin_option_list_add(), but just add a 'false' when someone down the
> chain calls make_extended_arg_array().

Yes, that sounds reasonable.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--VGJP7hhDw3NaB1Sn7C4OAGKmEK7AVUWKl--

--q5gfSTB2EMLQ3iLhRDvgnBBtJhKewixWH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYduZ+AAoJEIbPlEyWcf3ygVsP/RYvpMIMCxDi2K4zs219qppJ
2FEPdnLITvHZRCarQqotA891SSTafAVtELzdWyJsR6X4lzXoBvE+IbaVLg77fRue
Crbfh1CmrJ3F5qVMtjngJHB/8CQ8Vp/cNMu8/aOkjI9yGNOp7L42nLZCmRpqZWSg
q6YmeYt/OsjQEBzsW1pnUhgeV1tc24uorwfVt8imWb7s0woJ1z03DAxtQChTgECi
9jXxJgKklUggIBWQ4xvyXvQXyjf3OiXnsjAMzOpTV/gvPMIcALcna6DWeV6qN7rH
0gYH+PrqbELbW0T4i6Z2qeWhZQ2Mmb5KHolp4xUVFQgcMTU0yiyd2F9HQ9lQaMk8
jw4u19jkmRbRYd6qaiVdZOErh6UIvbC5SjiFGAliBCoZrubU0wZPR3xNvdBez4ur
C4xpOVdooQPt2xsFK+1GUrB8Qe/R0V3l/wwCs0OAQp4zs5NQGOyeUu1nnvY71pB6
SwnsFrFwVTFjsZ4HUO6C6rLxk0zixcSU0WgeTaHaHWAsHRvIAxn6+S8PNa3FG+ml
dC3SvsPeFYqP24eqFxmmOzH9itjDHn4/bPo8ajAn/a+s8AMuc80CD1yI4nuArkXd
sAJxpJJI8iH/x4fhepNfAQcV5+0F30rpReTllFXSoWVsuQaLV9PzpOrg3DUXAYSU
76Sw6pqvV6qEgxJ/bJ4f
=vL4H
-----END PGP SIGNATURE-----

--q5gfSTB2EMLQ3iLhRDvgnBBtJhKewixWH--

