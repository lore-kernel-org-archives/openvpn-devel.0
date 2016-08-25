References: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
	<1472133483.61594.587.camel@...1866...>
	<8e9eb1dd-2505-7414-4828-6d6b6d1e25f0@...2080...>
	<CAKuzo_j0XwQ7OR8E-wGcTQDwEjdRbTZZy84wK68qgZLS30sT7g@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <edab23db-978e-ec86-c9c2-5768b468cbdd@...2080...>
Date: Thu, 25 Aug 2016 17:36:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_j0XwQ7OR8E-wGcTQDwEjdRbTZZy84wK68qgZLS30sT7g@...278...>
Subject: Re: [Openvpn-devel] [RFC] - Enable 2FA to be used with
	renegotiations
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 25/08/16 16:32, Selva Nair wrote:
>=20
> On Thu, Aug 25, 2016 at 10:15 AM, David Sommerseth=20
> <openvpn@...2080...=20
> <mailto:openvpn@...2080...>> wrote:
>=20
> On 25/08/16 15:58, David Woodhouse wrote:
>> On Thu, 2016-08-25 at 15:45 +0200, David Sommerseth wrote:
>>>=20
>>>=20
>>> I've been working a bit on a new patch-set which enables=20
>>> third-party user/password authentication mechanisms using two=20
>>> factor authentications [2FA] (such as OTP) and not needing to=20
>>> disable the renegotiation features of OpenVPN.
>>=20
>> Hm, you handle the server side of OTP through PAM alone?
>=20
> This change does not change the initial authentication at all.
> You still need an authentication plug-in or
> --auth-user-pass-verify script.  But once this first authentication
> passes successfully, the OpenVPN server takes over the coming
> authentications required due to re-negotiations.
>=20
>=20
> Why not let the auth-user-pass-verify script do this verification=20
> bypass? The server knows whether its an initial CONNECT or REAUTH
> and can pass that info to the verify script. Then the script can
> bypass verification if appropriate. Currently
> management-client-auth is already capable of doing this as "REAUTH"
> versus "CONNECT" info is passed to it. Adding that to the env and
> passing to scripts should be easy.

This is to avoid needing to modify any third-party authentication
mechanisms.  But passing information that it is a re-auth is might be
a good idea, that isn't too hard to add.

However, it would need to be a flag to --auth-gen-token in addition -
otherwise third party authentication mechanisms which have not been
updated will fail.  On the other hand, if anyone is willing to update
an auth-plugin or script to support this, they could just as well
implement the auth-token generation themselves independently and not
require --auth-gen-token at all; which speaks against such a flag.

Also remember that this implementation covers both --plugin and
- --auth-user-pass-verify.  For many it will be quite hard to modify a
plug-in compared to updating a script.

I'll grant that the 'auth-token' feature is a well hidden and not
documented.  But the issue with 2FA and --reneg-* options have been a
long standing issue, which have not been fixed in most of the
authentication plug-ins used by the community.

In regards to documentation, I'll try to improve that as well -
regardless of this patch-set.  And there's another benefit if making
use of this auth-token feature itself, as the client doesn't need to
cache the users password any more. (I do need to verify that though,
but there is no reason why it would be needed.)

Also, this patch becomes even more important now when it is
recommended to enable --reneg-bytes 64MB if using ciphers using 64 bit
cipher blocks.


- --=20
kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXvxCbAAoJEIbPlEyWcf3yWvAQALnZ4QiwJlUPbPz52aq5tf87
786pgA/m0hUbpHbv969M7RIEDvRW2UnDxrlmtlAHSxIU9NeEReZX1Ux8uQ4OGCKA
J0y4qMF3jxAnxop00CKWCMxht/S4kCzSNNIro4ibIGTMWidELIPWvkfG2EXoUsZV
U0mQrjBTi07T27g3nov+6VLFIp7gh/F1oN7GsdyjhdqVzK/TsP2WEbvWc2gDkOmk
RgS50zWOta7kDU6v2maRPvlxFzN+f4QFbJGWlC4F29wthwt4wSQhi05Yd2nFLUbo
HSKjR+KqPrPi9B66acFWABW3y4BpMN4B9CqQPPixA5oMVkpQKtt6tg0O2OUNKHjZ
/hdUzYa2lK5iX6MxGVBCp9V0jYZIEfZPGXVrhXzKpyHU1OU3X8oYaVG9fvIr1ORF
idRA5EUhdDL6S0aifBJeWxiKsk4RUvgiS4qn7uE0mwBU0AW1i7vAGQTXUYmVP5cU
YzEU28ZS2wkfE9r137UuwyIDnfeDq2ZYclXRXd85F3GUZt3+qrQiwxA4YIMB1X6H
DAMelsZ7JfnIzIFY/WsyI9eLp/MR2GZkW4gSjV9SFb5jBu5+Sj9D46AQJOA8xiI4
hfnxC7EMqJRC91PVC3uxuEHqH1jpzFmiM2nOLkZPiOioYR3yqhVwIg49swZHd5Qo
2rVcB9smEkQdknLwCibI
=3D1kcX
-----END PGP SIGNATURE-----

