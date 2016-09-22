References: <4e9afe58-f398-7163-18fe-9113bf0cdfbc@...277...>
	<283c21d2-c51c-b2e6-0c5e-5055b6bec3cd@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <12c6df78-5506-886f-93f3-a13ed99662a4@...2080...>
Date: Thu, 22 Sep 2016 15:47:48 +0200
MIME-Version: 1.0
In-Reply-To: <283c21d2-c51c-b2e6-0c5e-5055b6bec3cd@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="etMNhN4di5RaCTmgwPPSJq7PI1D8LPddj"
Subject: Re: [Openvpn-devel] Linux: Use /tmp for log problem ?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--etMNhN4di5RaCTmgwPPSJq7PI1D8LPddj
Content-Type: multipart/mixed; boundary="2I9wK8ruFNB1Fxuji69w8v8iLG2eEbaq1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <12c6df78-5506-886f-93f3-a13ed99662a4@...2080...>
Subject: Re: [Openvpn-devel] Linux: Use /tmp for log problem ?
References: <4e9afe58-f398-7163-18fe-9113bf0cdfbc@...277...>
	<283c21d2-c51c-b2e6-0c5e-5055b6bec3cd@...515...>
In-Reply-To: <283c21d2-c51c-b2e6-0c5e-5055b6bec3cd@...515...>

--2I9wK8ruFNB1Fxuji69w8v8iLG2eEbaq1
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 22/09/16 15:32, Samuli Sepp=E4nen wrote:
> Il 22/09/2016 16:07, debbie10t ha scritto:
[...snip...]
>> Obviously, systemctl start openvpn@...2166... appends more options
>> when starting openvpn (in my hand written service the only
>> addition is --daemon client1) So I presume that by daemonizing
>> something changes with regard to writing the log file to /tmp ??
>>=20
>> Also note, in the forum post --daemon is used within the config
>> file.
>>=20
>> I did grep -E "/tmp" src/openvpn/* and found some code in init.c=20
>> (line 664) but it's all C, foo, bar to me (Sea food bar ;-) )
>>=20
>> Anyhoo, can anybody provide a brief and simple explanation ?
>>=20
>> Many thanks
>>=20
>=20
> Hi,
>=20
> I did some testing on my Ubuntu 16.04 VM, and this seems like a=20
> permission issue, probably related to the capabilities set in the=20
> openvpn unit file:
>=20
> /lib/systemd/system/openvpn@...1685...
>=20
> Basically --log and --log-append will work, if the logfile is
> stored under /etc/openvpn. If you try to put the it under /tmp, it
> will never appear.

Eeek ... never suggest putting log data into /etc ... /var/log please!

Okay ... as /tmp is mentioned .... I presume this is related to
PrivateTmp being enabled in the unit file.  This provides each service
where this is enabled with its own (private) /tmp directory and not
the old system-wide /tmp directory.

See the systemd.exec(5) man page for more info.

Simple and brief enough?  ;-)


> That said, you probably would not need a logfile, as you can view
> them with
>=20
> $ journalctl /usr/sbin/openvpn

Interesting approach.  It is usually better to use

  $ journalctl -u openvpn@...2167...

If you add -b or --since you can narrow down how far back it will go too.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--2I9wK8ruFNB1Fxuji69w8v8iLG2eEbaq1--

--etMNhN4di5RaCTmgwPPSJq7PI1D8LPddj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJX4+EEAAoJEIbPlEyWcf3yXCAP/iiVdDHObDcaYL1hqZelC7jF
cUeCD+jhBgHbJB/lB2W++aid0l94KfaMulkPoY/qHVL2LAHysyJWggr6D2caeQby
Dcy1N02MUQxRuL4W4QqJxORCGFnL2rYo8LQGjdgplE9yZAsZ/cQbechxqr2l+N7n
GdqMsX8dQ95QkgZfgUDi7uCUQVfC+YYXEn0VdR+pV60yqhmi5fEiMmE7HETgRVWR
aBzb1lalkf3nLss4uA0zFkHOsj04+vHGUuQO78cutCtIcmUXBeVUEF6jcuCzPvH1
G9iP9769RL59PWg83aYn0U1EzuKVtdK1znoJE2k3nWu79cdjnAvjXwYObWM7iBcz
Q4qoVVi2rkqkUdjc9msMfe+d4jyCOqWRQ6FuYnKvhA4i/PCprbQjguZdzYiP3lbm
ziUaKCOOzaN89INBFFpgpdOwVvbrwjvgrIAAm55FCnnV7wbQGRJphdcEDpLyRLxe
mb5U+8Whr2/817ZUJL14U8BckoEfMH8tfuzmjfMietL2zBe8CzUQzh0ipm4XMKzo
6j9XgDTrVmmi7ssYyAT1Hx3POR7+loe4I68M1HdgTa90R2Qjmrt3XYEnM/zP2rzZ
r4BGPEtOkuiCoVfSxe31mEeTh86j4Szmxavx8CXjAU+akfFjM5PGbk/7mSe2pPJT
EC2ZYEupfpLuH5X+LUO3
=klkr
-----END PGP SIGNATURE-----

--etMNhN4di5RaCTmgwPPSJq7PI1D8LPddj--

