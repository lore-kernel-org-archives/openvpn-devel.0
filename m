Message-ID: <53BE842C.4020102@...1227...>
Date: Thu, 10 Jul 2014 14:16:44 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1404735142-31420-1-git-send-email-arne@...1227...>
	<1404811301-12860-1-git-send-email-arne@...1227...>
	<20140709203935.GZ1118@...1296...>
In-Reply-To: <20140709203935.GZ1118@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dI5NAuMeJkVVguiBSJb1fTP6941FjMkfo"
Subject: Re: [Openvpn-devel] [Patch v3] Remove #ifdefs for client nat
	support.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dI5NAuMeJkVVguiBSJb1fTP6941FjMkfo
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 09.07.14 22:39, schrieb Gert Doering:
> Hi,
>
> On Tue, Jul 08, 2014 at 11:21:41AM +0200, Arne Schwabe wrote:
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -1018,6 +1018,8 @@ process_ip_header (struct context *c, unsigned int=
 flags, struct buffer *buf)
>>    if (!c->options.passtos)
>>      flags &=3D ~PIPV4_PASSTOS;
>>  #endif
>> +  if (!c->options.client_nat)
>> +    flags &=3D ~PIPV4_CLIENT_NAT;
>>    if (!c->options.route_gateway_via_dhcp)
>>      flags &=3D ~PIPV4_EXTRACT_DHCP_ROUTER;
>>=20=20
> This...
>
>> @@ -1046,14 +1050,12 @@ process_ip_header (struct context *c, unsigned i=
nt flags, struct buffer *buf)
>>  	      if (flags & PIP_MSSFIX)
>>  		mss_fixup_ipv4 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.fram=
e)));
>>=20=20
>> -#ifdef ENABLE_CLIENT_NAT
>>  	      /* possibly do NAT on packet */
>>  	      if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
> ... sort of obsoletes this c->options.client_nat check, right?
>
> (I'm not sure I understand why it was done the way it is, but if you
> do the first change, maybe just get rid of the second bit of the=20
> condition here...)
>
> The rest is quite straightforward de-#ifdef-ing, which I like :)
>
> gert

That is actually a bugfix that "slipped" into the patch, but yes the
second part is kind of duplicated.

See alos the discussion on

Message-ID: <53584132.4030807@...515...>

and the mail before that. We probablly really should commit a fix for this =
stuff otherwise it pops up every 6 months or so.

Arne



--dI5NAuMeJkVVguiBSJb1fTP6941FjMkfo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO+hCwACgkQe8+cMNS4zReVQwCdEGIsvx4a0QUkBAUNerSQ/zRx
/IYAnjSo6ghZAwgj2mOuPkMbZV4iuyX3
=Im8h
-----END PGP SIGNATURE-----

--dI5NAuMeJkVVguiBSJb1fTP6941FjMkfo--

