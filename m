Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170824075312.24801-1-a@...2181...>
 <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bff6ef6f-f02a-3a47-c78e-3eb27be0de49@...2080...>
Date: Thu, 24 Aug 2017 20:16:25 +0200
MIME-Version: 1.0
In-Reply-To: <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xJrUJbeAHwNpcfe9HFWpTERcdMu4FwhcF"
Subject: Re: [Openvpn-devel] [PATCH] avoid useless assignment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xJrUJbeAHwNpcfe9HFWpTERcdMu4FwhcF
Content-Type: multipart/mixed; boundary="dtwDERtO93j2MoKINNObQhxOhxATk73fl";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <bff6ef6f-f02a-3a47-c78e-3eb27be0de49@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] avoid useless assignment
References: <20170824075312.24801-1-a@...2181...>
 <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>
In-Reply-To: <f9c5ce4e-1527-c1a0-9427-7bfc316df306@...2181...>

--dtwDERtO93j2MoKINNObQhxOhxATk73fl
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 24/08/17 09:57, Antonio Quartulli wrote:
> My effort in writing the commit message has been quite poor.
>=20
> The assignment is useless because 'ret' is re-assigned a few lines later
> without ever being read.

Hmmm.  I'm not convinced of this change.  But I'm also weird in these
cases :)

I think it is good defensive programming to predefine the state of
variables.  When that is not done, it is up the the compiler to decide
what to do - which most of the times does a sane job these days.  But
you're at the mercy of the compiler.

In this case,  I would expect the compiler to optimize this out anyway,
regardless of the approaches used.  The compiler doesn't necessarily set
the value first to true and then to change it to the output of
multi_process_post().  It might just as well postpone the declaration.

So I think a better approach would be to completely move the "bool ret"
down.  So it will become:

   bool ret =3D multi_process_post(m, mi, mpp_flags);

Which I think is also closer to what the compiler would end up with anyway.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



> On 24/08/17 15:53, Antonio Quartulli wrote:
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>  src/openvpn/multi.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
>> index 5892ac07..6cdb0110 100644
>> --- a/src/openvpn/multi.h
>> +++ b/src/openvpn/multi.h
>> @@ -633,7 +633,7 @@ multi_process_outgoing_tun(struct multi_context *m, =
const unsigned int mpp_flags
>>  static inline bool
>>  multi_process_outgoing_link_dowork(struct multi_context *m, struct mult=
i_instance *mi, const unsigned int mpp_flags)
>>  {
>> -    bool ret =3D true;
>> +    bool ret;
>>      set_prefix(mi);
>>      process_outgoing_link(&mi->context);
>>      ret =3D multi_process_post(m, mi, mpp_flags);
>>


--dtwDERtO93j2MoKINNObQhxOhxATk73fl--

--xJrUJbeAHwNpcfe9HFWpTERcdMu4FwhcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZnxf5AAoJEIbPlEyWcf3yq4AP/jpmM4n2vRhp1r6CH2vDx+i+
jJxbegULbtYNwqaDylHhpknh/DYWTB8DVXPGOWQVoMm0knKe3UBphpE30EZyc+ig
s7Up41TUaIMdU2uvkdeOPxQ1pp9KqHwwPrFWtYAAEXRc38YwrVUgQqJ26cwznmTA
e0NkgB9+b+pd8WWx9j+LQ+i/KlL/hBN20a/RPpLr3K7Tlu+lrtc7U0M5qmmVbNRH
E+tww2czteic0RhDPtpi9o0yMcqilp70aJOwcCJ5Ynua5KEBYIMaTtf2H5mI8F1j
J9USZpgha/VYGuWjIA0F5ouLMqZX2izyHk/RmTCkqb2x0doyRg1itcAHYTdjwTtY
0ONWtNFl4tQ7qcpkxJTX4tJvwgk3SLM/aH/T75G8I3i6RHfyICyBJhDKmH0zvmgl
Bd8SLYWxtRjxGRyXAxiU8/hSn3af5VdeOkB3+011dnb0CYo+K5ZnDmaaCj0goKi3
99ER8fH5OqXrTqv1vQ4DArrWaizX0Fhf6cCyj93MvPFOLUJ3QMvkUAIiTqXyDLeN
YcxMbGmPRNjr5fWd/TPJmP188PhVI5fqYSn/nltfTvvhdaBz88CKN3Rr4rEB8HoG
MpVZs/IAOWfpvBaU5c7WsTdpTyXQPK91DEoH5jYjqpYqSnSkvUeJAeZU9nUS6R1U
Aj97LbU7f+2uWW/ssZkM
=s9sl
-----END PGP SIGNATURE-----

--xJrUJbeAHwNpcfe9HFWpTERcdMu4FwhcF--

