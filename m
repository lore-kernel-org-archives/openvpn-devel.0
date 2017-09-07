Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
 <20170907081340.GG70062@...1296...>
 <e9b6e95e-7a98-23a1-e6cd-4d250a6cee05@...2080...>
 <20170907130754.GK70062@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <189587dc-a237-c221-e0c3-b6c80fec1c40@...2080...>
Date: Thu, 7 Sep 2017 15:15:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170907130754.GK70062@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xSmfUNOXHMuW2Ad64rmfLhsAlqQg5PSk8"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xSmfUNOXHMuW2Ad64rmfLhsAlqQg5PSk8
Content-Type: multipart/mixed; boundary="G0D0hsxnJECu2g47mJbw0wxc5RjHt0q9t";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>
Message-ID: <189587dc-a237-c221-e0c3-b6c80fec1c40@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
 <20170907081340.GG70062@...1296...>
 <e9b6e95e-7a98-23a1-e6cd-4d250a6cee05@...2080...>
 <20170907130754.GK70062@...1296...>
In-Reply-To: <20170907130754.GK70062@...1296...>

--G0D0hsxnJECu2g47mJbw0wxc5RjHt0q9t
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/09/17 15:07, Gert Doering wrote:
> Hi,
>=20
> On Thu, Sep 07, 2017 at 03:02:20PM +0200, David Sommerseth wrote:
>>> Which is not what I hoped for... "turn it off and leave it so" is non
>>> helpful (it might be a transient error preventing the startup).
>>
>> I'm confused.  What is it you want?
>>
>> * try restarting in an endless loop?
>> * try restarting X times and then stop trying?
>=20
> "exponential decay"
>=20
> Restart a few times quickly, and then slow down, like "re-try after 1s, 3=
s,
> 5s, 10s, 15s, 30s, 60s, ... and then stick to every-5-minutes" or so
> (like OpenVPN's own connection re-try logic :-) ).=20=20=20

Yes, that is a nice idea.  But to my knowledge, that is not something
systemd supports today.  So we can't have that easily.  We could look
into a ExcePreStart=3D, which tracks how long time it has gone since the
last restart and adds the "exponential decay" sleep.  But that means
more code to maintain.

> That way you get quick restart if a temporary failure happens, and avoid=
=20
> filling logs with useless crap if the error persists - like "bind to an
> IP address that is not present in the system, because the ppp0 interface
> where it would show up is down", or something like this.
>=20
> But if that cannot be done, that's how it is - and in that case, "stop
> trying" is not what I want.
Which means the current patch is what is possible to achieve today.  :)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--G0D0hsxnJECu2g47mJbw0wxc5RjHt0q9t--

--xSmfUNOXHMuW2Ad64rmfLhsAlqQg5PSk8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsUZ7AAoJEIbPlEyWcf3yEYAP/jp+qJGlbUJNLz5Qf4bLQOnR
x1yYjII67dI2d5cuKC2QH2xXTqhWD2UWbx/CR1Ds0Raxii+UGThWrtNGUnn+Mhwd
h2nKtbIpWE8AD6n8iu0IEFy2hx65rZ/byat0U5/wSKpMTAVR/1krXK135VkO5TMf
LXlPPythB8mH/53ki0jcnaxdT/o8+FYHABdLWp47SOrm9vIpAVsQ3gXVt076HeTv
3c+BQ5ZYMPJxUvXsiP95Fd8w7Z5hghjKDo+H7hyrOOclSWu/F/OGh/nFXhmWNtgA
XHDgT3lYa2bwAbM46fIWHOgnf8nu4cWxBfusJkOziGhUuJdj5rAXBJCpgvUmBFBR
/EA7UqRtB5vrRvPJMnVS6JgRvwDkQvauwCZMWSKQ1HKhnHnkXSQ14UPYh4Mtc9RO
uykAX3g5WJ0ABGacY1J6JT0QIVy9+wXbKe7ap3TaNT4bdfwq2LVZgC5cMuaQWUcn
xS7RyXnS3p2JD1hdbckAHNtPnfM/q9SC08O3V1p/KMRF/0Cl7lXo8FOgNralAGk/
LQaOD4+jCOtdhFTkVgOa6dAdTMuKf9EnCARD5v7V8iBVXFnoFie0XIaZd+QI0oYk
7BYKWJbuQoVtNmW/3FPD59pU7sj237cM6KKNJuumIm1LY2ouwEdADLuysC1HKz/W
Q+mOUs+XhjkXzVToSFJ9
=KluL
-----END PGP SIGNATURE-----

--xSmfUNOXHMuW2Ad64rmfLhsAlqQg5PSk8--

