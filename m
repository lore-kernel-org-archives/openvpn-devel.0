References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
Date: Wed, 5 Apr 2017 17:58:46 +0200
MIME-Version: 1.0
In-Reply-To: <049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ju7wg0WN8rcQ4ENWjtCGJTJa4tlRBQrUP"
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ju7wg0WN8rcQ4ENWjtCGJTJa4tlRBQrUP
Content-Type: multipart/mixed; boundary="InsnI5bfxMNEXxMC74mecchpKavN8gvis";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net,
	openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
	component to --reneg-sec intervals
References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
	<6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
In-Reply-To: <049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>

--InsnI5bfxMNEXxMC74mecchpKavN8gvis
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 05/04/17 17:53, David Sommerseth wrote:
> On 05/04/17 16:42, debbie10t wrote:
>>
>>
>> On 05/04/17 05:34, Simon Matter wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, Apr 04, 2017 at 08:29:49AM +0200, Simon Matter wrote:
>>>>>> Interesting to see that there is zero interest in this patch here.
>>>>>
>>>>> This is a misinterpretation.
>>>>>
>>>>
>>>> Hi Gert,
>>>>
>>>> Thanks for the explanation, I'll be patient then :)
>>>>
>>>> If it's preferred for the patch to keep it even simpler and compatible=
 the
>>>> current configs, it could be broken down to something like this in ini=
t.c:
>>>
>>> I've attached v2 now which works without any config change:
>>>
>>> --reneg-sec n
>>>     Renegotiate data channel key after n seconds (default=3D3600).
>>>
>>>     Note that the effective value used here is a per session pseudo-
>>>     randomized 25% of n deducted from n.  With the default value  of
>>>     3600 this results in an effective per session value in the range
>>>     of 2701 ... 3600 seconds.
>>>
>>
>>
>> A different approach could be like so:
>>
>> --reneg-sec 3600
>> --reneg-sec-1sttime-rand 1|0 (The name here for detail)
>=20
> Too complicated ;-)
>=20
> --reneg-sec      # 60 minutes, with X % in randomness
> --reneg-sec 1800 # 30 minutes, with X % in randomness
> (X is what we figure is reasonable by default; between 10-25%)
>=20
> --reneg-sec 3600 30  # 60 minutes, 30% randomness
> --reneg-sec 1800 0   # 30 minutes, no randomness
>=20
> This won't break any configurations and gives full flexibility without
> adding new options (which we really try to avoid).

Oh, and in regards to the first-time/non-first-time .... if we decide
for such flexibility, that can be a flag after the randomness.

For example  --reneg-sec 3600 12 first-only

I am far from convinced if that should be configurable or not.  But
still, this approach is still far better than introducing new options.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--InsnI5bfxMNEXxMC74mecchpKavN8gvis--

--ju7wg0WN8rcQ4ENWjtCGJTJa4tlRBQrUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY5RQ2AAoJEIbPlEyWcf3yb7gQAL9h2HnLvym71/yW3WQgQQkF
mkTtYiJmFbdg2EuBWsvu2d8DQwse3eH8bLZX4FTP1NwPLcoF+3wt437uWeAAH4P/
dBgmTEF4pkLYdtipopmgTIReZy5BoXPE5E6v+hFpHGzFLnbEU1E46zHH5Rr1WQ55
yOm7RaLQLBiwA3lPb5bF1ehCTEG1KmbQFLg9TSVKEVTX2XjBpTGPG5q0GqR9osuM
2vqKVZKaZvVQ/O+jWEsIjWOmLF+WatwMyUmr73FY6j4jRkNQ7ijr12RIimAe8xSJ
sKlDyLuYh8aCQhdGCSt1Fdg62Mw2PCp2vFuwf+sm+Aos3CrSwthqwb7atRAQMNt0
UeAWuCkn8/c8L8oSGva30DD28SPVaHRTsxPyVMoUZ5QqWR457vCrmNxenQF88msX
KyxSQqG754EwcFUZy4sIM9ryKRYn2l9bAkPZpCKDpFBywWQyevYhMRCPZWMSQO5i
idfA6GBUTnmttFHJRxfBE9wj7f73Jky9U6BIkLkucOWLEGigV/wJmFmpz9UdDVuW
TDWrWklvgT2ztJYWBNxQnvcOOXyrjooUCask8hNk0cGneu6s2O02TpBO2oohtFpJ
/UaouQtxbxGLBKi2H7WtVWZZ5dzGzFHhPZYoWAD+dAF5ZSh5AmpfbCfXtlmn6eaM
XgV9+97Dv/acTveUIn4x
=SQLi
-----END PGP SIGNATURE-----

--ju7wg0WN8rcQ4ENWjtCGJTJa4tlRBQrUP--

