References: <1445277979-21591-1-git-send-email-gert@...1296...>
	<5625FF23.70203@...1400...>
	<20151020212827.GN22054@...1296...>
	<5626C540.2080907@...1114...> <56274788.6060801@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5629EBF4.2060405@...2080...>
Date: Fri, 23 Oct 2015 10:12:36 +0200
MIME-Version: 1.0
In-Reply-To: <56274788.6060801@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="leeLreqMRTu1ebA0nBDTU4hHlJT4TaaHw"
Subject: Re: [Openvpn-devel] [PATCH] Add option --push-suppress-ipv6 to stop
 sending IPv6 info to clients.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--leeLreqMRTu1ebA0nBDTU4hHlJT4TaaHw
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 21/10/15 10:06, Arne Schwabe wrote:
>=20
>=20
> Am 21.10.15 um 00:50 schrieb David Sommerseth:
>>> >  --push-filter ifconfig-ipv6 tun-ipv6 route-ipv6
>>> >=20
>>> > which would do exactly what the current patch did, but is much more f=
lexible
>>> > depending on what exactly needs to be worked around with *this* clien=
t...
>>> >=20
>>> > (There's a trac ticket about "--push-reset", which we might resolve w=
ith
>>> > this as well :-) )
>> I agree with the intention.  Just not sure 'filter' is a clever word.  A=
s it
>> can be understood both as "remove these options" or "only include these
>> options".  Both interpretations are results of a filter.
>
> push-suppress?

That's better.  Another suggestion could be --push-remove.  But I have
no strong opinion either way.


--=20
kind regards,

David Sommerseth


--leeLreqMRTu1ebA0nBDTU4hHlJT4TaaHw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYp6/cACgkQDC186MBRfrqMhgCfRTMFFaTuzSdAT9c+ORZWbp3i
OhYAmweXKUbiNZLT4zhE407f+PHQFAqD
=DMqo
-----END PGP SIGNATURE-----

--leeLreqMRTu1ebA0nBDTU4hHlJT4TaaHw--

