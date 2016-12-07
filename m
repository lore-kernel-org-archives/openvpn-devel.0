References: <1481067951-28917-1-git-send-email-lstipakov@...277...>
	<20161207081907.GS78624@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7c5da0da-7587-efc2-1a79-b0d13d77d111@...2080...>
Date: Wed, 7 Dec 2016 14:22:08 +0100
MIME-Version: 1.0
In-Reply-To: <20161207081907.GS78624@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="kfU0dd2WhlfOGS4Ad8WiTpHbKabF31oBf"
Subject: Re: [Openvpn-devel] [PATCH] Arm inotify only in server mode
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kfU0dd2WhlfOGS4Ad8WiTpHbKabF31oBf
Content-Type: multipart/mixed; boundary="OmIPq4gFIrfWuMU6kCEqvLXAWKOGeod1e";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <7c5da0da-7587-efc2-1a79-b0d13d77d111@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Arm inotify only in server mode
References: <1481067951-28917-1-git-send-email-lstipakov@...277...>
	<20161207081907.GS78624@...1296...>
In-Reply-To: <20161207081907.GS78624@...1296...>

--OmIPq4gFIrfWuMU6kCEqvLXAWKOGeod1e
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/12/16 09:19, Gert Doering wrote:
> Hi,
>=20
> On Wed, Dec 07, 2016 at 01:45:51AM +0200, Lev Stipakov wrote:
>>  #ifdef ENABLE_ASYNC_PUSH
>>    /* arm inotify watcher */
>> -  event_ctl (c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void*)&fil=
e_shift);
>> +  if (c->options.mode =3D=3D MODE_SERVER)
>> +    event_ctl (c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void*)&f=
ile_shift);
>>  #endif
>=20
> I find this a non-robust approach to this.
>=20
> What is wrong with
>=20
>    if ( c->c2.inotify_fd > 0 )
>      {
>        event_ctl (c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void*)&=
file_shift);
>      }
>=20
> (as I suggested on IRC yesterday evening)?

That scenario is already tackled in tunnel_server_tcp() [mtcp.c:708] and
tunnel_server_udp_single_threaded() [mudp.c:300], which I would say is
the proper place to catch this error.

The race we saw in trac ticket #786 is related to being in non-server
mode.  So if OpenVPN is not running in server mode, we shouldn't touch
c->c2.inotify_fd at all.

> This will ensure that inotify is armed *if* it got prepped, independent of
> "whatever other flags are active in the system" - next thing, someone adds
> a "--no-inotify" run-time switch, and you'll have to revisit this place
> again - or someone else finds a use for inotify in client mode, and this
> will also need touching.

If such a --no-inotify option is added, it would need to be handled in
the tunnel_server_*() functions anyhow.  And to implement such a feature
without checking all the ENABLE_ASYNC_PUSH #ifdefs would be a poor
implementation.

> Also, braces.  See CodingStyle in the wiki.

Yes, that is right once we've formatted the whole code tree to be
consistent.  Currently this kind of missing braces is just as common.
Which is why I didn't really react to this one in this round.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--OmIPq4gFIrfWuMU6kCEqvLXAWKOGeod1e--

--kfU0dd2WhlfOGS4Ad8WiTpHbKabF31oBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYSA0BAAoJEIbPlEyWcf3yCH8P/RiYIIs3ysaCxMMgBfG6QkIX
50UTNSZoyLrR0SQpjhsuU2ITE6ZDQ3IOhLzZvhpufBPryQ0d45ePzJw0AnB9enu4
qFznGA6sL/16WuBxLyWi7X4j744JRD97sCjeiHX3yxYXM90TlwNUIcYTDjKrEMT/
qi4M74dsTPD8SZFQ8D0EyJNYA5wLvMCxsD+5ukMeXYwVleQC4FHF+jW8H1HHAle0
mdqGx+eTfTpSMUrAIFp0L/ivuLp8pxg6U5+hQYjPvNMYxwjd08fW4qffEiD57Ijc
MvpRfaP0cPDOtUIwiKhhMeEhtyzjeQ5kLI4y2o4KUfRYM7yOOJUOg2tTBZOOguaY
byV+Bkz8s//ci1tpXNG0YkZ1KKVn+jyV/hyZyxHH/60iYD9eOONvQPu3apKppn0S
PrXICGyihdzE6KpJPGZTX7tuJ+1/49dOdY5R2mNwIN3+qEmeOGaklrrHqB4wjm/u
cpGtlIP3KCFaHg+XLZMMTM1xIrIoeFoZ1mv/DntLtGzzO+FGq62BXXhIoV2M/3Wh
6FFok9HSLimYRVXM8mcaiRbO/vFCEXobjQQMAGw7k4s9MfGbNYeXzXNOdT8py2jT
iQlC4bS7a9xXG+NWdHvdaIueD1zBHGydYQmpXF4t6bMEdnn4/vKfVh6f7rGVIPFo
ySqvG0KUqaEsVYm6KsiY
=u71J
-----END PGP SIGNATURE-----

--kfU0dd2WhlfOGS4Ad8WiTpHbKabF31oBf--

