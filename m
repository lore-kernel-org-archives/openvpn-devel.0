References: <20181207123303.70827-1-gert@...1296...>
 <4e683bf2-541b-b320-5166-5753716e75ca@...2181...>
 <20181208080305.GR962@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0c112c52-57bd-6cc3-000a-242a8cd755f7@...2181...>
Date: Mon, 17 Dec 2018 16:31:48 +1000
MIME-Version: 1.0
In-Reply-To: <20181208080305.GR962@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2Kz4SJ6mxCmOlsRoDO1pC58UTWGcFko8n"
Subject: Re: [Openvpn-devel] [PATCH] Add 'printing of port number' to
 mroute_addr_print_ex() for v4-mapped v6.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Kz4SJ6mxCmOlsRoDO1pC58UTWGcFko8n
Content-Type: multipart/mixed; boundary="lgwxNNcXPxHXjVEMrZ9BgVcE7b4N9Do4V";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <0c112c52-57bd-6cc3-000a-242a8cd755f7@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Add 'printing of port number' to
 mroute_addr_print_ex() for v4-mapped v6.
References: <20181207123303.70827-1-gert@...1296...>
 <4e683bf2-541b-b320-5166-5753716e75ca@...2181...>
 <20181208080305.GR962@...1296...>
In-Reply-To: <20181208080305.GR962@...1296...>

--lgwxNNcXPxHXjVEMrZ9BgVcE7b4N9Do4V
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/12/2018 18:03, Gert Doering wrote:
> Hi,
>=20
> On Sat, Dec 08, 2018 at 09:47:37AM +1000, Antonio Quartulli wrote:
>>> +		    /* we only print port numbers for v4mapped v6 as of
>>> +		     * today, because "v6addr:port" is too ambiguous
>>> +		     */
>>
>> The comments above are indented with tab+spaces, while the code below is
>> just all spaces. Please use the all spaces everywhere.
>=20
> Gah.  That was the intention, but the comment was added later on and
> using the wrong editor :-)
>=20
>>> +                    if (maddr.type & MR_WITH_PORT)
>>> +                    {
>>> +                        buf_printf(&out, ":%d", ntohs(maddr.v6.port));
>>> +                    }
>>
>> I don't understand how is this solving the ambiguity?=20
>=20
> These are *v4* addresses, just masquerading as v6 in the socket structure.
>=20
> So 1.2.3.4:567 is never ambiguous.
>=20
> For "true v6 addresses" (the other branch) we keep on not printing the
> port number.
>=20
>> Or you are just
>> saying: "we can't do much, let's just print the port anyway"? My
>> suggestion would be to surround the address with [], so basically change
>> the printf format above from %s to [%s]. Does it make sense?
>=20
> This is something I want to discuss.  Changing mroute_print_addr_ex()
> for "true v6 addresses" and printing the port number in a new format
> will affect status file printing, management interface, etc. - so it
> needs to be well considered.
>=20
> *This* patch just fixes the discrepancy that v4 addresses are printed
> "with port" if doing "proto udp4", and "without port" if a v4 connect
> comes in on a "proto udp / v6only=3Dno" socket.  (We do not need to discu=
ss
> how many problems the v4mapped v6 address format brings with it...)
>=20

Thanks for the clarification.

The patch looks good and does what it says on the lid.
Tested by checking the status output (with and without the patch) and
everything looked good.

Now it only needs to have the tabs fixed on the comment lines, but other
than that:

Acked-by: Antonio Quartulli <antonio@...515...>


Regards,

--=20
Antonio Quartulli


--lgwxNNcXPxHXjVEMrZ9BgVcE7b4N9Do4V--

--2Kz4SJ6mxCmOlsRoDO1pC58UTWGcFko8n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlwXQtQACgkQ9FVsWUWD
Dm1YFg/+Is+To1o208yU8GbyO8c/R2tYJJ3NnCUcylPBXdDK2+ALNNClbNXEEiEK
Rhih3GHmxEeBFGJ1gcADfLZ3DK10io4yrlwYn86syFsC/EYNJwjqlkiiAHb3dvsH
YZkAMaQcs5oXz8sFc/Yo25I6RP1iraTmxW7DTFTaELMaGJ6LiO5KoxJ0WobfFSar
OhXXoK36r1PcqFPPK3tDiAISYeQnrl1Yr1+IYKNNaYoW0jWWo9zEaYAhSm5MnpyS
9tCxOhppmiQ/j+VrWkm4ucng7RkO42B8yxBKpxEBR2o1KrH08ztAXaV6lONu1khl
oXfE6Fnet9TzmZjvsSs/45ZCAM1FQx5tLh9icxx76t9aVO7LHZf7A01K7lnntrNf
JOe01+J4wSL4m75b/3tWpfAkBri78k2H/Gsf78yuMW9I5w4MU0TiWq+N85N2c0sN
mkEOojlCzA6LLRpS9a2yIQHPWqOnq2mZvULyEPuizI6Zx40FP9Opkt4jo0etyUrD
8Z6wwC4xP1inotsDrpiMJN1sdbz7PYXzUMdc3nX737IM06MZYCKK9LWEtS5aqehY
dN0lQ/zKf5b/gCn4Yq7JPddrsszUW2XmNO4rz/VqU7lgqZOEKY0O5up/4/SyGFLH
5kSt0eTHquHMQI1rwU1io5RwVggbDDJ1OVt3+4VojjigDXv1dJM=
=ZeJD
-----END PGP SIGNATURE-----

--2Kz4SJ6mxCmOlsRoDO1pC58UTWGcFko8n--

