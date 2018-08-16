References: <20180815061240.5027-1-a@...2181...>
 <28816122-839b-fc8d-4953-1b4b7e2883f3@...68...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ca006e8a-2bdb-7fd6-70a0-9e15bb2cf330@...2181...>
Date: Thu, 16 Aug 2018 19:17:09 +0800
MIME-Version: 1.0
In-Reply-To: <28816122-839b-fc8d-4953-1b4b7e2883f3@...68...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Q5Ntems1mNUOFpyXsAya5dkUeRQRhNHMh"
Subject: Re: [Openvpn-devel] [PATCH v2] ssl_verify: define label only when
 required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q5Ntems1mNUOFpyXsAya5dkUeRQRhNHMh
Content-Type: multipart/mixed; boundary="Q1YGbVOGVRiUnZpV3LgAIUZKTKFnBvo9W";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Matthias Andree <matthias.andree@...68...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ca006e8a-2bdb-7fd6-70a0-9e15bb2cf330@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] ssl_verify: define label only when
 required
References: <20180815061240.5027-1-a@...2181...>
 <28816122-839b-fc8d-4953-1b4b7e2883f3@...68...>
In-Reply-To: <28816122-839b-fc8d-4953-1b4b7e2883f3@...68...>

--Q1YGbVOGVRiUnZpV3LgAIUZKTKFnBvo9W
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 16/08/18 19:08, Matthias Andree wrote:
> Am 15.08.2018 um 08:12 schrieb Antonio Quartulli:
>> The "cleanup" label in ssl_verify.c:verify_user_pass_plugin() is used
>> only when PLUGIN_DEF_AUTH is defined, therefore make the label
>> definition dependent on the same define.
>>
>> Fixes the following warning when PLUGIN_DEF_AUTH is not defined:
>>
>> ssl_verify.c: In function 'verify_user_pass_plugin':
>> ssl_verify.c:1223:1: warning: label 'cleanup' defined but not used [-Wun=
used-label]
>>  cleanup:
>>  ^~~~~~~
>>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>  src/openvpn/ssl_verify.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
>> index 61872251..5b46ea72 100644
>> --- a/src/openvpn/ssl_verify.c
>> +++ b/src/openvpn/ssl_verify.c
>> @@ -1220,7 +1220,9 @@ verify_user_pass_plugin(struct tls_session *sessio=
n, const struct user_pass *up,
>>          msg(D_TLS_ERRORS, "TLS Auth Error (verify_user_pass_plugin): pe=
er provided a blank username");
>>      }
>>=20=20
>> +#ifdef PLUGIN_DEF_AUTH
>>  cleanup:
>> +#endif
>>      return retval;
>>  }
>>=20=20
>=20
> NAK.
>=20
> This is useless #ifdef noise in the code and makes it harder to read,
> for compile-time cosmetics.
>=20
> If you don't want the warnings, feed a proper -Wno-unused-label to your
> compiler and move on.

Thanks for taking the time to look at this!

Actually we are in the process of getting rid of the various ifdef
around the code or at least we are trying to bring that to a more
reasonable state (it takes time....and right now we are more focussed on
the networking and platform side of things).

I totally agree with you that more ifdefs are just ugly and make the
code worse. However this "new" ifdef is just part of some logic that is
already there (a few lines above).

This said, in the past months we have tried moving towards a
0-warnings-tolerance, so that we could catch as many bugs as possible
hidden by "just annoying warnings".
For this reason using "-Wno-unused-label" is not an option (especially
in CI/automated build tests where this was spotted).

Imho we should just get this patch through and then try to get rid of
the whole #ifdef PLUGIN_DEF_AUTH logic at once.


Cheers,



--=20
Antonio Quartulli


--Q1YGbVOGVRiUnZpV3LgAIUZKTKFnBvo9W--

--Q5Ntems1mNUOFpyXsAya5dkUeRQRhNHMh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlt1XTUACgkQB6U8WA7y
zXQqMg//ScZKToUjnxStyKXtOMHsQZEr3MemwvbutNiNwFsNv8MtlpVCX193/+aD
K20JIK5k4+CCm202iM0QnGWDVXtn9i7VDff/7Kwb0nU6uAEri3xfTHqLjdtU7QtH
uKtg2trVWjSJuEWCE2my9p345WK1kUPlbX3ZLVeHucZWNH3F/2iiJB2Gmw4jPqgv
YB/LriPEaksZSVeEUnCvZ8nNKe1YGR3r/ysUZsP1q+kc3JZlu8n/BNFUcJNfqlJ3
tbik26SzzVyDweMnAHvF6kSH6rNE7uP6ig32ViRH9XDNFz/8WeSVyBfrxSqN8r8w
oFsblpxhczAjYCygiFu7unwnBfXo7AMlLpaVKAIsxUMWlueqnFEtnIEINj/SgTdn
rfFRU3P8pCbWdJLnkW1TR5qmi74qiFnkIVT9drtE4bNxE9Bnz1+SDbYKzq/LAP11
rfPp9JiRr7A29JZ12mZ2XzUODCkLH/xvRApag+OJNfrYsIB3BKh7LLZFaR3tLew2
VMajUULe6OzMGklBqf8xKro2+o+7ER8MPyIYEvTzNHSwjPIkQIh6OD+u2Kn61qjZ
CqP4/00qOJA2ofljflLtS4h/WE9gLiot9yqk7nxnqBo0jp4PSHj4i1TLLWJtqpPO
ebExwsGWNAhY3Smmi+NALQeuK34euDpWlxjUfuOMtroQ3V7b7G0=
=xBwa
-----END PGP SIGNATURE-----

--Q5Ntems1mNUOFpyXsAya5dkUeRQRhNHMh--

