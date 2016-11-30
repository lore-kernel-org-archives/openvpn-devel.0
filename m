References: <20161129152739.11582-1-list@...1798...>
	<20161130085908.23248-1-list@...1798...>
	<a856d529-7825-4a03-1cfc-19fb0e58735e@...1435...>
	<20161130101519.0cdce781@...1799...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <17116269-c5b3-08b6-479b-73a3c4ca73c2@...1435...>
Date: Wed, 30 Nov 2016 10:19:09 +0100
MIME-Version: 1.0
In-Reply-To: <20161130101519.0cdce781@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LrlTEuGmkew2PVPqI7AcQVW2MO5BSrIpv"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Refuse to daemonize when running
 from systemd
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net

--LrlTEuGmkew2PVPqI7AcQVW2MO5BSrIpv
Content-Type: multipart/mixed; boundary="AJXpItTmnX9X3tQoaUUMR1ujqqCxd2IWE";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <17116269-c5b3-08b6-479b-73a3c4ca73c2@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Refuse to daemonize when running from
	systemd
References: <20161129152739.11582-1-list@...1798...>
	<20161130085908.23248-1-list@...1798...>
	<a856d529-7825-4a03-1cfc-19fb0e58735e@...1435...>
	<20161130101519.0cdce781@...1799...>
In-Reply-To: <20161130101519.0cdce781@...1799...>

--AJXpItTmnX9X3tQoaUUMR1ujqqCxd2IWE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 30-11-16 10:15, Christian Hesse wrote:
> Steffan Karger <steffan.karger@...1435...> on Wed, 2016/11/30 10:06:
>> Hi,
>>
>> On 30-11-16 09:59, Christian Hesse wrote:
>>> --- a/src/openvpn/init.c
>>> +++ b/src/openvpn/init.c
>>> @@ -926,6 +926,13 @@ bool
>>>  possibly_become_daemon (const struct options *options)
>>>  {
>>>    bool ret =3D false;
>>> +
>>> +#ifdef ENABLE_SYSTEMD
>>> +  /* return without forking if we are running from systemd */
>>> +  if (sd_notify(0, "READY=3D0") > 0)
>>> +    return ret;
>>> +#endif
>>> +
>>>    if (options->daemon)
>>>      {
>>>        ASSERT (!options->inetd);=20=20
>>
>> Does this mean I cannot run openvpn --config bla.conf --daemon from the
>> command line any more on a systemd system?  This would be a deal-breaker
>> for me.
>=20
> No. That means openvpn knows when it is run from within a system service.
> Daemonization is refused there as we we start with "Type=3Dnotify".
>=20
> sd_notify() is a no-op when run from command line. So everything works as
> usual.

Perfect.  Thanks for the swift response.  (Confusing API though...)

-Steffan



--AJXpItTmnX9X3tQoaUUMR1ujqqCxd2IWE--

--LrlTEuGmkew2PVPqI7AcQVW2MO5BSrIpv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYPpmRAAoJEEEwndWOY1w5Eb8H/29ZmQBa8YM9dt9YdpuNWxaR
uTkY6gAabx+xS1C0JaIdyWWm2s52vljD6YxqWk0pn05zqgAi3/F6v2rIJELg2+6p
CzdeGA55mh46bkErOoomYAikYredethEjYKeSkt6ivah0eXPCCGc6HB6bSah8QSG
z/1N5cjSUvNY7chcTKoDTKfa+E8rDnkAai8iaMbfgB41bUeRrdsw+GahFO0a3zA6
PKG/o8YDdhVpUILn5HzTua8b4MkPFXZRF3a6a+G8YGOXfZh3P4hFVrLwCSi8U1hY
zU50l+SgxXGKAVlb8prkjV3/XqHstiEu4edP6zh3UQOW07K8u2wxqsMprwU+vEs=
=C/94
-----END PGP SIGNATURE-----

--LrlTEuGmkew2PVPqI7AcQVW2MO5BSrIpv--

