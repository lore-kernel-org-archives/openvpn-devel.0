References: <CAAM7bARYZSecZZb2aU7dTaRc1a6rP8dz4hsHR=tDUbTmSTpgFg@...278...>
	<cf21397207efaf34f82aa44ea0082180@...1286...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <57337B75.2060308@...2080...>
Date: Wed, 11 May 2016 20:35:33 +0200
MIME-Version: 1.0
In-Reply-To: <cf21397207efaf34f82aa44ea0082180@...1286...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="19LbT9KWelGk9a7dUlbr6nb1t5FSet3Th"
Subject: Re: [Openvpn-devel] Need help for adding feature: Selecting remote
 servers by best latency
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric F Crist <ecrist@...1286...>, Paul Garnier <paul.garnier3@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--19LbT9KWelGk9a7dUlbr6nb1t5FSet3Th
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 11/05/16 17:54, Eric F Crist wrote:
> Why try to connect to the process itself?  I think a standard ICMP ping=20
> to the server address should be sufficient for your test.

This implies that the OpenVPN servers respond to ICMP echo requests, and
that there is no "firewall" in between which lets ICMP pass but not
OpenVPN connections.

I think it makes a lot of sense to probe servers using a real connect -
even though it usually takes longer time ... and it will be far more
complex process all in all.


--=20
kind regards,

David Sommerseth


> On 2016-05-11 10:41, Paul Garnier wrote:
>> Hello,
>>
>> I=E2=80=99m actually trying to add an option in openvpn which will allow=
 the
>> client to connect to the server with the lowest latency in his remote
>> list. For now there are only two options to choose between servers :
>> =E2=80=9C--REMOTE-RANDOM=E2=80=9D  which randomize the order of the addr=
ess list,
>> the default one which will try the hosts in the order of the config
>> file, and I want to add  a 3rd one. To start I want to do it for udp
>> and unix servers and clients.
>>
>> I=E2=80=99m a beginner in things like this so I started  very simply : I
>> wrote a little program in C to ping a host:port using udp but I
>> can=E2=80=99t get an answer from an openvpn server. The only way I found=
 to
>> get an answer was to make the packet I send look like the start of a
>> TLS transaction, but because of the TLS processing I can only get the
>> first ping right, after it takes way too long to come back to be
>> accurate.
>>
>> So I started digging  in the source code to find where my packet is
>> thrown away and why I don=E2=80=99t get any answer (even an error message
>> would be enough). I=E2=80=99ve found how a =E2=80=9Cnormal=E2=80=9D pack=
et is sent but
>> what I want is the latency with the server, not in the tunnel.  I
>> don=E2=80=99t want to establish a connection to test my link with each
>> server and, how I understand it, if I want use function like
>> ENCRYPT_SIGN() so my packet is recognized I need to have a tunnel set.
>> I can=E2=80=99t replicate how the existing PING and OCC packets are sent.
>>
>> What I would like to know is :
>>
>> - where my packet is processed and rejected ?
>>
>> - why I don't get any answer at all nor an error message on my server
>> ?
>>
>> - is there a major issue making what I want to do impossible ?
>>
>> Kind regards,
>>
>> Paul Garnier
>> ------------------------------------------------------------------------=
------
>> Mobile security can be enabling, not merely restricting. Employees who
>> bring their own devices (BYOD) to work are irked by the imposition of=20
>> MDM
>> restrictions. Mobile Device Manager Plus allows you to control only the
>> apps on BYO-devices by containerizing them, leaving personal data=20
>> untouched!
>> https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
> -------------------------------------------------------------------------=
-----
> Mobile security can be enabling, not merely restricting. Employees who
> bring their own devices (BYOD) to work are irked by the imposition of MDM
> restrictions. Mobile Device Manager Plus allows you to control only the
> apps on BYO-devices by containerizing them, leaving personal data untouch=
ed!
> https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20




--19LbT9KWelGk9a7dUlbr6nb1t5FSet3Th
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlcze3UACgkQDC186MBRfrrzfQCgovwtfJxNOoaoyYMird7yLMjS
5C8An3m337uqLGC825zRJwqvhJY4FS1q
=I6ZC
-----END PGP SIGNATURE-----

--19LbT9KWelGk9a7dUlbr6nb1t5FSet3Th--

