References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
Date: Wed, 6 Jun 2018 00:22:31 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Z6uM7HWKGwhw1fjDw8TTAaBjgD5XiAuxp"
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z6uM7HWKGwhw1fjDw8TTAaBjgD5XiAuxp
Content-Type: multipart/mixed; boundary="pyut18qP46xLv1PUIQTuQcG7DTbqiSY2m";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...> <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
In-Reply-To: <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>

--pyut18qP46xLv1PUIQTuQcG7DTbqiSY2m
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/06/18 23:54, Selva Nair wrote:
[cut]
>> ACK on the feature, but NAK on "we can do this more nicely" reasons :-)
>>
>> First, I'd leave off the bits about "this can be useful" of the commit
>> message - because that's not the point of this patch, you can *ignore*
>> the settings already today.    Maybe word this
>>
>>   "This patch enables the client to run IPv6-only on the tun/tap interfa=
ce,
>>    but will not make it ignore a pushed IPv4 config.  To achieve that, o=
ne
>>    can use 'pull-filter ignore "ifconfig "' on the client or 'push-filte=
r' on
>>    the server".
>>
>> (if we want to go into this here at all)
>=20
>=20
> I don't think this belongs here and such advice could include other
> details like what
> to do with routes, redirect gateway etc. Better add it to the howto.
>=20

Agreed to both comments. I'll trim the commit and make it more objective.

> A more serious thing:
>=20
> - On windows we require that ifconfig is required with --dev tun. This
> has to change. Could be tricky as TAP_WIN_IOCTL_CONFIG_TUN requires a
> v4 address.

Is 0.0.0.0 a valid address for this ioctl?
Or does it need to be meaningful?
I think this could be tested by applying only this patch and ignoring
the pushed 'ifconfig ' directive (as explained in the commit).

>=20
> Minor stuff:
>=20
> - If no v4 address is set but still v4 routes are specified we should at =
least
> print a warning as we do with ipv6.
>=20

Right. Will add the warning.

> - redirect-gateway : we may want to force !ipv4 if ifconfig is missing
>  or should we mutate it to "ipv6 !ipv4" ?
>=20

This is more about changing the current default behaviour.

Why is it !ipv6 by default in the first place?

I'd rather keep default behaviours as they are now, to avoid messing up
the user experience.

However, I also understand that if there is no IPv4 and gateway-redirect
is specified, then the user wants a default route for IPv6.

Maybe we should keep the current behaviour as it is (!ipv6 by default)
but print a warning when only ifconfig-ipv6 is provided?



> May be there are more such nuances -- this patch will need some thoroug
> testing before being ready for review.
>=20
>>
>> Of course we'll also need to check if typical consumers of the management
>> interface explode if you're not giving an IPv4 address to them...
>>
>> Selva, Jonathan, how will our GUI and Tunnelblick handle that?
>=20
> Windows GUI uses configured IPs only for logging and display so I
> don't think it will complain, let alone explode. If any changes are
> needed, likely to be minimal. We have to just keep the format of
> reporting configured IPs unchanged even if some elements may be blank.
>=20
> Selva
>=20

Cheers,

--=20
Antonio Quartulli


--pyut18qP46xLv1PUIQTuQcG7DTbqiSY2m--

--Z6uM7HWKGwhw1fjDw8TTAaBjgD5XiAuxp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlsWuMcACgkQB6U8WA7y
zXRdFRAAuJKRPIh4bEJlEc8z27jN+oUJatv1IkunXvSgHzetpoZgtVT48u5DiUj1
kxSZv/Pt9T5c8loryNtYujinVXAjlQPW0N92i6DpR83pH6qeZPF0puU7pgJWCvdX
2LLQmwqJm1OWWiTcagS9gAvPUdIfjqBn+h/3Otpor0brLjlYWo9iuTK49yF+/h5g
WM2H8alhwDidoLPv2yulHTB6UhPHnJWYiz1WDWWbFJBle3Hlt5f90J7az4yVtTt5
j2c42wPLAYCfepLdaCEVhoQhtiFLZ1PLE5W0hjNAR0B8y60VCR0spnMwdjhYfCyY
QNIZaxNLEns/VEIpu380NAcLbw/64PPuOoLWjeMk7/0M6N7a37XY9rDoBIPNrklV
tijyjUyix89d2ie5hCn4ajNC75DQN+2a3e8LayFYi9rTuj5ZzmysqMqlpdkl5zGx
D1X018onopFPJ2UNlcQ/T8R6fvap8xcYP+w3QZEq10WGO9cMJbAzxQ6ijzxDToEJ
GI2t16SBXO7b/Hcvw9V8bfQzLw+Yp4+SfDVstkmtmMS3+E1tjQRIQC4YVeWntglU
/WoWctXRGyLDR9RoLgGuviEG6yTSehZneAE9vjcyTBTGUCeW8wqkPvsDt0uywCDi
ph/uWW6Gpw2xR5+PZxSNzj+lfSa/olDF71aF2cwSJLZSpQdEgus=
=fWVM
-----END PGP SIGNATURE-----

--Z6uM7HWKGwhw1fjDw8TTAaBjgD5XiAuxp--

