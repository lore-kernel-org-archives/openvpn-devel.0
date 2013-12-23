Message-ID: <52B89D2C.9070306@...1085...>
Date: Mon, 23 Dec 2013 14:29:32 -0600
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
References: <l8qvsn$jif$1@...1062...> <52B79339.2040202@...1800...>
	<52B8049B.6040407@...1147...> <52B88DD2.6060600@...1800...>
In-Reply-To: <52B88DD2.6060600@...1800...>
Subject: Re: [Openvpn-devel] Easy-RSA v3 release planning
Reply-To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 12/23/13 13:24, Mike Tancsa wrote:
>> > the newer Safenet java etokens require the Safenet driver software (or
>> > Aladdin eToken driver v5.0+). If you don't have access to this software
>> > then you're out of luck. If you do have access then generating keys on
>> > the token is doable (but not supported by easy-rsa at this moment).
>> > I've written scripts that work in both Windows (cygwin) and Linux to
>> > generate and install keys and certs on Aladdin/SafeNet etokens
>> > (32K/64K/72K). At one point I documented this for an older version of
>> > the eToken driver
>> >  http://wiki.nikhef.nl/grid/EToken
>> > esp section
>> > http://wiki.nikhef.nl/grid/Storing_your_grid_certificate_on_an_Aladdin_eToken
>> > 
>> > but the basic principe is the same for the newer driver (use
>> > eTPKcs11.dll on Windows)
>> > If there's any interest we could integrate this into the easy-rsa
>> > scripts, but as Eric Crist pointed out, this is VERY hardware and
>> > platform dependent.
> Thanks! I will give this a try over the holidays. I do have the drivers
> and client software for Windows. I just was never able to get a cert
> generated under windows

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm curious to hear about your results.

If you are able to get keypair generation working on your device through
OpenSSL and/or the driver software for your token, I'd welcome the
ability to integrate this into easy-rsa if you'd like to help make that
happen.

Part of my plan at this point is to better separate the keypair
generation from the request; this allows better flexibility by enabling
a new request to be generated from an existing keypair, for instance.
This flexibility also has the benefit of making PKCS#11 integration
easier.

In particular, if you have success with your token and want to help
maintain support for your platform & token combination, consider sharing
some of the following details:

1) How is the keypair generated? It would be nice to support both RSA
and EC keypairs, although partial support is still better than no
support.

2) What else is needed to generate the request? Does creating another
request require another keypair to be generated for the token?

3) How does a signed certificate get loaded back onto your token?
Remember that in the easy-rsa v3 model, it is more likely that the
request is sent to a separate CA for signing, which means this may be a
logically separate step.

Thanks for the interest!

- --
Josh Cepek

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJSuJytAAoJENcx2Xpgb9RjtpMMAKCQR5C3y9omZ6folnusAyaC
QKzKUnGL5mad7fsHxZSfWBMZYavb6q1TFW0qbrpBbP1WkWsLVf8Qtz8i8/f2oMK7
qrcJ4ZAGJ1y9y84sdAvwpn4Q6nGYSsDOVQ1sy312kUdvaTC388Vf2TKn4ekRs3pp
pjkGLLyRm5u4lIp98bKgG9qRVGI4nOAmU2HveQUe3KKsFqq3ypvORbV+69lzn1gJ
Hv5PmEiAQdaK+EIMzAZBtYptmy5vbw8eOUgOJ4MnXNThQ/QOxxBUWzgtjCRscfs1
GAMXw9PNYIDazmvK7ieZ5ruKBSJdxRBlo5PEoxOPwL9H2CLYAyhbyAA73QmVgUh8
VNnKOtQV0gU3XDoVexN2ByHSU/Vs8oqa+BT/Uh+aa4W6SUsA19FnMn/etP2mtw9s
LVb0rq2oe/yBT55PBxXNeyR4PNJCN6QvH5jIqSV2pDaBZKR612FLrryhpFjCg+gv
GT1l3AShxAfZfbPgeSeG8Fqzisb+xorzNVSTabkwvg==
=TReB
-----END PGP SIGNATURE-----


