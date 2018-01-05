References: <1515067670-13094-1-git-send-email-steffan.karger@...1435...>
 <6b64631e-2dbe-e4d8-e32f-4c22c394ceea@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2c70d0cb-365b-2885-33cb-2dad2e845d86@...1856...>
Date: Fri, 5 Jan 2018 22:30:45 +0100
MIME-Version: 1.0
In-Reply-To: <6b64631e-2dbe-e4d8-e32f-4c22c394ceea@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VO6l8jvMrp2woq7hdibvioasLqSiS8bfJ"
Subject: Re: [Openvpn-devel] [PATCH] Check for more data in control channel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VO6l8jvMrp2woq7hdibvioasLqSiS8bfJ
Content-Type: multipart/mixed; boundary="i5l1PEV3LsHRa2eLjEkHfeM864e82k2Q2";
 protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <2c70d0cb-365b-2885-33cb-2dad2e845d86@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Check for more data in control channel
References: <1515067670-13094-1-git-send-email-steffan.karger@...1435...>
 <6b64631e-2dbe-e4d8-e32f-4c22c394ceea@...2080...>
In-Reply-To: <6b64631e-2dbe-e4d8-e32f-4c22c394ceea@...2080...>

--i5l1PEV3LsHRa2eLjEkHfeM864e82k2Q2
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On 05-01-18 20:48, David Sommerseth wrote:
> On 04/01/18 13:07, Steffan Karger wrote:
>> If control channel packets arrive quickly after each other, or out of
>> order, there might be more data available than we can read in one
>> tls_process() call.  If that happened, and no further control channel
>> packet arrived (e.g. because the last two packets arrived out-of-order),
>> we would wait for 16 second ("coarse timer") before we would read the
>> remaining data.  To avoid that, always schedule ourself again if there
>> was control channel data, to check whether more data is available.
>>
>> For mbedtls, we could implement a slightly more elegant "is there more
>> data?" function, instead of blindly rescheduling.  But I can't find a way
>> to implement that for OpenSSL, and the current solution is very simple a=
nd
>> still has quite low overhead.
>=20
> I haven't looked at the code paths yet (except of the patch itself) ... b=
ut
> how will this affect a server config with a bit of load?  Like some hundr=
ed
> connected clients or more?  Will these other clients notice that a client=
 gets
> rescheduled instantly?  And as well, what if more clients trigger this
> behaviour approximately in the same time window?
Good question.  One extra tls_process() loop for each connecting client
should have barely any effect.  Based on the code, I would expect it to
be less processing than a single data channel packet.  For more
certainty, I ran some tests.

This is the average time for setting up 50 connections simultaneously
without bandwidth limits or packet loss (om my 5-year old dual core
laptop), and waiting for all 50 to finish (average over 20 runs):

Without the patch: Mean: 11.16 Stdev: 0.35
With the patch: Mean: 11.14 Stdev: 0.36

Same test, but now with an iperf maxing out the data channel at the same
time (laptop turns into a blowdryer...):

Without the patch: Mean: 11.17 Stdev: 0.68
With the patch: Mean: 11.33 Stdev: 0.55

(iperf reported for both a little over 400 Mbit/s)

I think these numbers are a strong indication that my 'barely any
effect' estimate is correct.

-Steffan


--i5l1PEV3LsHRa2eLjEkHfeM864e82k2Q2--

--VO6l8jvMrp2woq7hdibvioasLqSiS8bfJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEvBAEBCAAZBQJaT+6JEhxzdGVmZmFuQGthcmdlci5tZQAKCRCYAso9AH7SiGe4
B/wKTIEkh2r1lY3dUuzJaG71RXd/9GGP8lmbVFD5jRrCl5Ydc8uJvHBi8yH3R/XJ
iOVM3i8GXyFW2qClkhTiQiMqiteDLCX2bkPa8IRMQKAKzzmiSxRMX61BDGjPQ2o3
mCaouah7hilcev8Q9MHw6SntjL2SAlIw+jnn232dmw4+B+UZMPauIdqHP05i3l4O
vY8nMVPf85k4y1oYvjCPN6OEbZvCwgBCeZYzHLmqNdgO025A0eUD8HQALtqNHiIk
EsMm/tkn7rpUeWVe043dl1YfqvNycYvnr3rEVj01ml8RRWzJ7HSsz0qvXmp4j6mu
KuTrrpKCvzX6YePYmYjwjHR7
=8uvI
-----END PGP SIGNATURE-----

--VO6l8jvMrp2woq7hdibvioasLqSiS8bfJ--

