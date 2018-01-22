Reply-To: openvpn-devel@lists.sourceforge.net
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-3-git-send-email-selva.nair@...277...>
 <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
 <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
 <CAKuzo_hYwcRDJjYW7i=Ekmi93TAXRb+n=sNyi4y=+gS+vbbtAA@...278...>
 <caf0faaa-428f-29c4-797f-8be8ac4f0f47@...1435...>
 <CAKuzo_jRh+7KSfw6GTVuXTDnMQCDfrH3g5m=N9GGDTDVLijBhg@...278...>
 <07f28923-1023-fe7b-2b3e-e57ad3f6bc8f@...2080...>
 <CAKuzo_iVUouudtkpuRBJj_x2RrgD0q07RUg4T1q6RNghAwCbOg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f06320ac-5b89-0cdd-9ef1-eddde02b848a@...2080...>
Date: Mon, 22 Jan 2018 18:18:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iVUouudtkpuRBJj_x2RrgD0q07RUg4T1q6RNghAwCbOg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="B1H0ULHC2WTRJp7qrBi3JKzNA2lP8IN25"
Subject: Re: [Openvpn-devel] [PATCH 2/3] Allow external EC key through
 --management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B1H0ULHC2WTRJp7qrBi3JKzNA2lP8IN25
Content-Type: multipart/mixed; boundary="P2dVpmnYouZpgAXhWNdlHoxDDQ3NkADGj";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <f06320ac-5b89-0cdd-9ef1-eddde02b848a@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Allow external EC key through
 --management-external-key
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-3-git-send-email-selva.nair@...277...>
 <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
 <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
 <CAKuzo_hYwcRDJjYW7i=Ekmi93TAXRb+n=sNyi4y=+gS+vbbtAA@...278...>
 <caf0faaa-428f-29c4-797f-8be8ac4f0f47@...1435...>
 <CAKuzo_jRh+7KSfw6GTVuXTDnMQCDfrH3g5m=N9GGDTDVLijBhg@...278...>
 <07f28923-1023-fe7b-2b3e-e57ad3f6bc8f@...2080...>
 <CAKuzo_iVUouudtkpuRBJj_x2RrgD0q07RUg4T1q6RNghAwCbOg@...278...>
In-Reply-To: <CAKuzo_iVUouudtkpuRBJj_x2RrgD0q07RUg4T1q6RNghAwCbOg@...278...>

--P2dVpmnYouZpgAXhWNdlHoxDDQ3NkADGj
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 22/01/18 16:27, Selva Nair wrote:
> - Present patch: connection process appears stuck (but UI is still
> responsive) and logs show the daemon is waiting for signature
>=20
> - This proposal: connection fails with: "External EC cert/key not
> supported in this config. Try using --management-external-key 2"
> User edits the config option and the connection process appears stuck ...=
..
>=20
> I suppose the latter is a bit better.

Well, it should probably be tweaked slightly better.  First of all, if run =
via
a GUI front-end, it's the GUI which should set this argument.  We could
consider to add a "fail-safe" on this option, so once set - it can't be
changed again.  The more advanced rabbit whole fix would be that the command
line provided --management-external-key option overrides whatever is in the
configuration file; doing this will require more work though.

This will make the VPN connection will still fail, but it won't be stuck any
more.  The user may complain "but I did add that option!?" which then is a
better starting point for support cases ... "Yes, it is most likely ignored=
 as
your user interface is not capable of this feature".

Another alternative is to extend an already longer error log entry, by
mentioning "also ensure that your management interface front-end supports
version 2."


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--P2dVpmnYouZpgAXhWNdlHoxDDQ3NkADGj--

--B1H0ULHC2WTRJp7qrBi3JKzNA2lP8IN25
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaZhznAAoJEIbPlEyWcf3yU8cP/1AWlyAaoopZlByTZs+syVoS
WNGCZCt8BxJckPyAZHRvrwvgUn33MmHFFh3tI9vO/NAZoYJbtEIrwyZrMmBEAjAx
5uTm/MofGpgl6V7ySVJELpi7IW5canoEWcL+L4rkWOw3KEKEVFR9uswBZJhD0Jgw
FfW6uMaMnVG159NZNvskfulNpNarWdNJVLBPGpicolAdCXoSQsibpUgDDMSbucw+
hTyR+0JEEKVvmSmaCeatr1z2LgTPArcWtccor1e5Hn36w101ek8DM/YfyOVJiXOn
90XViDRdT2flw5sW0J7zUf0COFrV7zqx4UR50hSmzup6ilRAjJpvFOrdWv9JaWmW
AazqsQPFnCFbfSX5iC8e1aQsKlHk5Rbi6SzHbprSuc5tLe4kEVyUkdF+2VeOMXPY
8riKiC3zmwwxwYeFJSj37mnV+uMzxlnPrmGxWU/B75WiPjPtE6MNgHrbG3y+un9w
mBNl2Ob+NLA6mEmmyyTXPVcCdEpE3AzD5iVQZTCjXs/FK9JA+W4V+ZuunivNAhsr
xWOmBXz71FmOtDm1RkNbKJHQDhzPrb2Woqw5bKdxOqWub35s+IiT0wl0pBYILi5M
sldr5lkmPTvirBtPZ6k4upebdLeDzNbqu5BTX6ZydKNbWnhe6sSDorfERWmGvxvh
zzTvuM1iZJGK4EFhbWkx
=LFoy
-----END PGP SIGNATURE-----

--B1H0ULHC2WTRJp7qrBi3JKzNA2lP8IN25--

