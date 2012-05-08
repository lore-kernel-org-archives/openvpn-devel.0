Message-ID: <4FA8EE84.8090502@...1114...>
Date: Tue, 08 May 2012 11:59:32 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F901987.9080009@...1147...> <4FA87BA3.3050707@...1147...>
	<4FA8D9BB.3020908@...515...>
In-Reply-To: <4FA8D9BB.3020908@...515...>
Subject: Re: [Openvpn-devel] openssl ouch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/05/12 10:30, Samuli Sepp=E4nen wrote:
>=20
>> Jan Just Keijser wrote:
>>> ouch: http://www.openssl.org/news/secadv_20120419.txt
>>>=20
>>> we need to investigate whether and how openvpn is affected.
>>>=20
>>>=20
>> did somebody end up writing an 'authoritative' answer to the
>> question if and how openvpn is affected by this bug?
>>=20
>> cheers,
>>=20
>> JJK
>>=20
> Hi all,
>=20
> Got a response from James:
>=20
> ---
>=20
> My reading on this is that OpenVPN is probably not vulnerable.
>=20
> Scanning the OpenVPN source for usage of the vulnerable methods=20
> (d2i_*_bio or d2i_*_fp), I'm seeing several calls of the methods in
>  ssl.c, however the data passed to these methods is coming from
> local sources.
>=20
> $ grep -Er '\bd2i_.*_(bio|fp)\b' . ./ssl.c:          p12 =3D
> d2i_PKCS12_bio(b64, NULL); ./ssl.c:          p12 =3D
> d2i_PKCS12_fp(fp, NULL);
>=20
> For example, above, we are passing the PKCS12 file to OpenSSL
> methods that have been cited as vulnerable, however the PKCS12 file
> is locally obtained so there's no capability for a malicious client
> or server to try to push a malformed file to its peer as a part of
> the OpenVPN or SSL/TLS protocols.
>=20
> Aside from this, the vulnerability text says that "In particular
> the SSL/TLS code of OpenSSL is *not* affected." so the core SSL/TLS
>  implementation in OpenVPN should be immune.
>=20
> And in general, using the "tls-auth" option gives you another level
> of protection against any OpenSSL issues that would involve a
> direct attack on the SSL/TLS protocol.
>=20
> James

I'm not sure which version James checked against, but those code paths
shouldn't have changed much since the 2.1 release and to our latest
master.  And to confirm that:

$ git grep -E '\bd2i_.*_(bio|fp)\b'
src/openvpn/ssl_openssl.c:      p12 =3D d2i_PKCS12_bio(b64, NULL);
src/openvpn/ssl_openssl.c:      p12 =3D d2i_PKCS12_fp(fp, NULL);

Which identifies the same file. The ./ssl.c code got moved to
./ssl_openssl.c with Adriaan's PolarSSL implementation and further
moved to src/openvpn/ssl_openssl.c with Alon's build clean-up.

So I would say James' statement covers all 2.2, 2.3-alpha and up to
the latest git master code.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+o7oIACgkQDC186MBRfrrLtQCdHfXeKvGypSe4nMRTv5GbCjLs
g1oAn34P/Zn6GE9ZVcmDT/zGlf77mrP3
=3DSWwd
-----END PGP SIGNATURE-----

