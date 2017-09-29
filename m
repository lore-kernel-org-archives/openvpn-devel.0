References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <97d5028c-4861-320b-c5ef-3e09de45e983@...2181...>
 <00bccb6d-164e-3773-105a-9d2e7014ba9f@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <cda9d511-43b5-cc6f-ead0-017f0f869e61@...2181...>
Date: Fri, 29 Sep 2017 10:40:13 +0800
MIME-Version: 1.0
In-Reply-To: <00bccb6d-164e-3773-105a-9d2e7014ba9f@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rCU67OrgPrfu9UMAAGwUGdRWUvHXVfK1p"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Don't throw fatal errors from
 create_temp_file()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rCU67OrgPrfu9UMAAGwUGdRWUvHXVfK1p
Content-Type: multipart/mixed; boundary="05xK9jlpQLMJwcp6wwjktwcnsugHN4lAW";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <cda9d511-43b5-cc6f-ead0-017f0f869e61@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Don't throw fatal errors from
 create_temp_file()
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <97d5028c-4861-320b-c5ef-3e09de45e983@...2181...>
 <00bccb6d-164e-3773-105a-9d2e7014ba9f@...1856...>
In-Reply-To: <00bccb6d-164e-3773-105a-9d2e7014ba9f@...1856...>

--05xK9jlpQLMJwcp6wwjktwcnsugHN4lAW
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi=C2=B2,

On 26/09/17 00:05, Steffan Karger wrote:
> Hi,
>=20
> On 21-09-17 19:15, Antonio Quartulli wrote:
>> On 15/09/17 05:34, Steffan Karger wrote:
>>> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
>>> index 5cb002b..5fe1734 100644
>>> --- a/src/openvpn/pf.c
>>> +++ b/src/openvpn/pf.c
>>> @@ -639,10 +639,10 @@ pf_init_context(struct context *c)
>>>                  }
>>>  #endif
>>>              }
>>> -            else
>>> -            {
>>> -                msg(M_WARN, "WARNING: OPENVPN_PLUGIN_ENABLE_PF disable=
d");
>>> -            }
>>
>> Why removing this chunk above? Isn't that supposed to be printed when
>> the init function of the plugin fails?
>=20
> Because it's no longer true; instead of disabling the firewall, we will
> now reject the connection.  I tried to explain that in the commit message:
>=20
>> On 15/09/17 05:34, Steffan Karger wrote:
>>> Note that this changes the behavior for pf plugins: instead of just not
>>> initializing the firewall rules and happily continuing, this now rejects
>>> the client in the case of an (unlikely) failure to initialize the pf.
>=20
> I think rejecting a client is the sensible thing to do when initializing
> the firewall failed.  (Rather than accepting the client and not
> enforcing the firewall rules.)

Right.
This makes sense, but don't you think this is worth its own commit
instead of hiding a behavioural change like this behind "Don't throw
fatal errors from create_temp_file()" ? :-)

It could be done in a patch preceding this one, imho.

>=20
>>> +        }
>>> +        if (!c->c2.pf.enabled)
>>> +        {
>>> +            register_signal(c, SIGUSR1, "plugin-pf-init-failed");
>>>          }
>>
>> Maybe it's just me missing how the signaling part really works, but what
>> happens on the server when the SIGUSR1 is delivered? And why registering
>> the signal when PF is disabled? I am missing something I think...
>=20
> This registers a SIGUSR1 on the instance context, not the top-level
> context.  This leads to an instance reset.  See e.g. check_tls_errors(),
> which does the same in case of an error (or even uses SIGTERM, if
> --tls-exit is used).
>=20
> Registering a signal is how error reporting is this part of the code work=
s.

I see, we basically use signals as they were flags. Thanks for
clarifying that. I can see this is handled in init_instance() where we
check for a signal and possibly abort the initialization of the child
context. I think it makes sense and as you are saying this is similar to
other error handling procedures.


Cheers,

>=20
>>>      }
>>>  #endif /* ifdef PLUGIN_PF */
>>> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
>>> index 9cd36d7..df2736c 100644
>>> --- a/src/openvpn/ssl_verify.c
>>> +++ b/src/openvpn/ssl_verify.c
>>> @@ -547,14 +547,14 @@ verify_cert_export_cert(openvpn_x509_cert_t *peer=
cert, const char *tmp_dir, stru
>>>      FILE *peercert_file;
>>>      const char *peercert_filename =3D "";
>>>=20=20
>>> -    if (!tmp_dir)
>>> +    /* create tmp file to store peer cert */
>>> +    if (!tmp_dir ||
>>> +        !(peercert_filename =3D create_temp_file(tmp_dir, "pcf", gc)))
>>
>> || at the beginning of the next line (as mentioned in my previous email)
>=20
> Will do, once we agree on the above discussion points.
>=20
> Hope this clarifies things.
>=20
> -Steffan
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--05xK9jlpQLMJwcp6wwjktwcnsugHN4lAW--

--rCU67OrgPrfu9UMAAGwUGdRWUvHXVfK1p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlnNspAACgkQB6U8WA7y
zXQifxAAwDCzY6RPkKK7Zy9aS15AwBH917086ggjqgrdgTXnZOwje60eokVfvLEA
iddDl7clKzCsvFQ3Wa3dGRU3kfd6l7DlCTw5J59k/QaDPeF21PCPUV8DzEFK6v0h
xlo3gRKZHc2LT2hJsH6j8lmga0/wLeeWQoohxRxFuQ5IhbQG7oBcXqHN26/1Shnq
1xjgdqqLA1JP+QVqJ9VrnFKgRwOlOiC9xgbC2DEGS4frHiCBxZresN5t/r9aaTsP
/8iFWuBjfFoy8DmJjO+2dqlKXjdZDxxUPjGrfkJ0vRzw5cCYq/dtI9LoX/6j5Rmn
0Yu56ULGE6R+QUcTRZCVG2RZ2spJocOhQcYpa35IyU2b3iMrfi8UjGs/DS3thrl9
5aKsLcrOjUVv9eEn6GCQ5UIGlkZXRtO8EFIpWZZElAI2zX1koZOwk+BkTLVoU/2v
KBgLuurViKiCKuGmclevWcdtzPPImIhjxv9ZMV5DxJzRVgjkV/oep+Ih1NTqqBxy
gJ1HXmihb49RbWDNrdiSWPUoGGiG6OevR8IITaxGPc6/aIROW87sGGYC0RcVsb+K
S6vY6OIXMfYSlryU1lW2dr7iKt/Uzki6i6d1ujJqFmAFIV/AUkcWtV9dVG6yw3HY
SsL3GmyduRRNENLJdLUg1hX9CCfI43cfFhtFd8WdT7MDt+HK0gw=
=2UOX
-----END PGP SIGNATURE-----

--rCU67OrgPrfu9UMAAGwUGdRWUvHXVfK1p--

