References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
	<93f91c48-94cb-c421-3f06-d7d76eb58511@...2080...>
	<de982e46-7014-13a0-44e9-5d888233e299@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6e5f9ee2-8ef3-1d01-158a-df984765eee3@...2080...>
Date: Thu, 6 Apr 2017 01:21:23 +0200
MIME-Version: 1.0
In-Reply-To: <de982e46-7014-13a0-44e9-5d888233e299@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IeBnLRW7pppaq33kkijHvH2AQsFOSEiWb"
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
--IeBnLRW7pppaq33kkijHvH2AQsFOSEiWb
Content-Type: multipart/mixed; boundary="2rqKjUsrPrSSEwkmIuP5UOkWLVxOKkFMA";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <6e5f9ee2-8ef3-1d01-158a-df984765eee3@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
	component to --reneg-sec intervals
References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
	<93f91c48-94cb-c421-3f06-d7d76eb58511@...2080...>
	<de982e46-7014-13a0-44e9-5d888233e299@...277...>
In-Reply-To: <de982e46-7014-13a0-44e9-5d888233e299@...277...>

--2rqKjUsrPrSSEwkmIuP5UOkWLVxOKkFMA
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 05/04/17 23:57, debbie10t wrote:
> Hi,
>=20
> On 05/04/17 22:39, David Sommerseth wrote:
>> On 05/04/17 23:13, debbie10t wrote:
>>> I don't believe there is any need to specify "max" because that would be
>>> --reneg-sec as is. Otherwise specify a smaller or larger --reneg-sec
>>
>> I think you, probably without being aware of it, are agreeing to what
>> the current proposal is:
>>
>>   --reneg-sec max
>>     A renegotiation happens within 'max' seconds, but with a 10%-ish
>>     randomness
>  >
>>   --reneg-sec min max
>>     A renegotiation happens within 'min' and 'max' seconds, fully
>>     controllable
>>
>> So using --reneg-sec 3600 3600, effectively removes the randomness.
>=20
> I understand the proposed methods ..
>=20
> Of the two above, I would be inclined toward option 2.
> eg: (for me) --reneg-sec 0 3600 is ideal.

We are not going to change the behaviour much of what is already
available today.  So if we end up at 10% ... the new default will be:

   --reneg-sec 3240 3600

If you you do  --reneg-sec 1800, that will effectively become:

   --reneg-sec 1620 1800

If you want to have a larger time window, then you do what you say
above.  Your "0 3600" will not become any default value.  But you may
choose to use those values if you want to.

The key point is that

   --reneg-sec 1800

will work; thus not breaking any configurations - this we will not
deviate away from.  This syntax just calculates the "min" value
automatically for you.  If you provide both "min" and "max" values,
that's what ends up being used.

Currently, I don't see the need to make it more complicated than this.
And I don't think Gert nor Arne does either.

What will need to be discussed though is if this randomness should only
happen on the first or on all renegotiations; and if that should be
configurable or not.  And we need a discussion around if we will allow
this to be pushable or not.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--2rqKjUsrPrSSEwkmIuP5UOkWLVxOKkFMA--

--IeBnLRW7pppaq33kkijHvH2AQsFOSEiWb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY5XvzAAoJEIbPlEyWcf3y/5gQAJxnDx798xZcguURBpYbohLg
gzzg1rwiKPwBXwuKHByA+GwPlzKyM55xcZIiNFp2Pza0NJnQR0mdQRR8EeQvJ0Fc
tN+nV9IcsSavgqVslQP5hTIRaUmk3Ez1QJoccOBEoOOqFD49Dtuog3fT0//GrDnY
Xd7he9PQ85DtLnWpJeisP77VLBjZ7H69BeFPXlqQyk+FEepFX+fkhVLy9aXOjSQq
zbJrRMmZRTCeiYvBBUM/uqcKhrP5Tzrk1NWNIMZBYzYDr9TQAif2+vaduisOAhAd
hgrDteWcgghPkhAHAWbaW2D7MbSwcf2hjcxGPVNdfYWSpGAvsrEv8ixG62+3XWSv
bjTM57xPE3IozvZYxqXs5C4RIn8+w1o6ROxAU2YAJgqFIA+BEWNXKqv8MUk966qA
UpZGvQz85gCpW9/EWki+xAHDzn5b1I3zEGszPNrH8UMyQGIlIdNhGRzy1f7UTn5d
PfSO+JGXy2F64+RcyIz7HrQCmCoLN+4D9WDU0VyKwQT91Gvm5gmQMa7BzXYbzFyE
GCX8oYgQV8UecCei3Kg02kf4l7sKppopjg0/Qp+HLHC5+fbJSs5qlt1ihKBavlGH
zsXrwV+plUryBOE1vI6suVEPzchTM8dy9UKccnluLRqQ4sBYD50kGx3gx6sCQhGd
3iz9xDWiAOngIYNhg+7l
=Gvnt
-----END PGP SIGNATURE-----

--IeBnLRW7pppaq33kkijHvH2AQsFOSEiWb--

