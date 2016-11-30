References: <20161129152739.11582-1-list@...1798...>
	<20161130085908.23248-1-list@...1798...>
	<a856d529-7825-4a03-1cfc-19fb0e58735e@...1435...>
	<20161130101519.0cdce781@...1799...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <626285a8-9d4d-5142-c8fa-fb7b4c87c129@...2080...>
Date: Wed, 30 Nov 2016 12:54:50 +0100
MIME-Version: 1.0
In-Reply-To: <20161130101519.0cdce781@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="uLbQNrrjBm2hR2J3umaBMjCN6nsiHDlKt"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Refuse to daemonize when running
 from systemd
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uLbQNrrjBm2hR2J3umaBMjCN6nsiHDlKt
Content-Type: multipart/mixed; boundary="tO8s5o15kXdONfVBpOkaCwebWQ67VxHN0";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>, Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <626285a8-9d4d-5142-c8fa-fb7b4c87c129@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Refuse to daemonize when running from
	systemd
References: <20161129152739.11582-1-list@...1798...>
	<20161130085908.23248-1-list@...1798...>
	<a856d529-7825-4a03-1cfc-19fb0e58735e@...1435...>
	<20161130101519.0cdce781@...1799...>
In-Reply-To: <20161130101519.0cdce781@...1799...>

--tO8s5o15kXdONfVBpOkaCwebWQ67VxHN0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 30/11/16 10:15, Christian Hesse wrote:
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

Ahh ... okay, I'll test the patch more thoroughly and I revoke my NAK if
everything works as expected.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--tO8s5o15kXdONfVBpOkaCwebWQ67VxHN0--

--uLbQNrrjBm2hR2J3umaBMjCN6nsiHDlKt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYPr4KAAoJEIbPlEyWcf3y5nMQALDcuCzdxGyHGj9xchfM8xta
02g5jgvGhseAWmT8W0KjakobF42dV8oC4JvCf2MjL8W8M6igf7ebT+Ys9peBGRx0
DHbMBJVeSXaezR+GbHtXCHe9l74a7H2Csaz6OqtBZslX5T8N6kRKTX6LhLHV1FEA
FIrX21qk2VdCwUTopnY43j0i1xHGV7KVhQxrxDVLrzN5wyaeMoppOJcN3BiTNVi5
7ardobaRHwuqA4dqJKK3KxPQ8SfrRiv0FPd2zPCrEG2ERJC2wCKF6MuTvwE+74z4
W606LdbMYJtBwpOItuZaUnptNHWlfpa2/SrfFymL6v6v8tI3f/toBUujPFLagjmq
AP/pV0mNBDY41G6DDD47XzqClD6TjOCpXhKrc3bkeCsUl1J1zjLkuiZ7IiPh8Mne
T99o75BaDZbTU6qTD/BLBmJ5Xio8azmljIuJJLRIR1QWLdnYj04Ozaxc/Kg+U2bd
8ppiz1BbyQijw2UD+xF+6qTJsJP4/mVEp8bl9fUS2u1sVdacKCvP6GG0zbCmd+Gy
+j4/vDHlAeuszACWVzKZCIj0so1I2SMqpRVFHIpjNhi46+0+vT4IKlJTXZtaQJv3
7IqVH7E6hz1yzEGPNoFCtBo5oMKxesNw6+61xynZfuflLr2cWwlhUIehAn8TKrV8
HdgesES5d8utWcp4TTi9
=o7dt
-----END PGP SIGNATURE-----

--uLbQNrrjBm2hR2J3umaBMjCN6nsiHDlKt--

