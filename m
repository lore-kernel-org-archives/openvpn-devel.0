Message-ID: <4AFBCF2A.4090201@...1114...>
Date: Thu, 12 Nov 2009 10:02:34 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20091110161632.GA31301@...1276...>	<4AFA789B.4070607@...1114...>
	<20091111102515.GA19782@...1066...>	<4AFA9AA7.4030600@...260...>
	<4AFAAD5C.4070303@...1114...> <1257974134.24141.3@...1207...>
In-Reply-To: <1257974134.24141.3@...1207...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending on
 the validity of a certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net, Mathieu GIANNECCHINI <mat.giann@...260...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/11/09 22:15, Karl O. Pinc wrote:
> On 11/11/2009 06:26:04 AM, David Sommerseth wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> On 11/11/09 12:06, Mathieu GIANNECCHINI wrote:
>>> Victor Wagner a =E9crit :
>=20
>>>> But if entire certificate would be available, it would be possible
>> to
>>>> extract any information from it (or hash it with any algorithm)
>> from the
>>>> script using openssl command line utility or some binding or
>> OpenSSL
>>>> libraries to the choosen script language.
>=20
>> Indeed!  And you're about to get my vote for this implementation ...
>> but
>> I have two concerns.
>=20
>> 2) If an attacker sends a certificate with his certificate and 999 CA
>> certificates in a chain, what will happen?  What happens if the disk
>> goes full or the certificate cannot be written?
>=20
> You're a lot less likely to fill the disk than you are to run out
> of RAM.

Indeed true, but its also a scenario to consider.  If the certificates
cannot be written to either memory or disk, proper error handling must
make sure the situation is handled correctly.  And running openvpn on
embedded systems with small filesystems or RAM disks can cause this
error as well.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr7zycACgkQDC186MBRfrryuACgjw9Je6aQWGNeCbWQRDWfGdCg
x7QAoI5ETmIDWNXhycJN5TrRbydM1Tij
=3DHrZ/
-----END PGP SIGNATURE-----

