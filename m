Message-ID: <4F66EE39.5050405@...515...>
Date: Mon, 19 Mar 2012 10:28:41 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
	<4F633670.1000807@...1114...>
	<CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
	<4F633B0C.8080502@...515...>
	<20120316152145.GF1359@...1296...>
In-Reply-To: <20120316152145.GF1359@...1296...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
 disabled by default?
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
To: Gert Doering <gert@...1296...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hi,
>
> On Fri, Mar 16, 2012 at 03:07:24PM +0200, Samuli Sepp=E4nen wrote:
>> Having as much stuff as possible disabled by default and then enabled
>> selectively _feels_ cleaner. But I'm fine with either approach.
>>
>>
>>
>>
>> - enable crypto and ssl
>> - enable lzo
>>
>>
>>
>
> I think the default should be "what most people are using".
>
> - enable crypto and ssl
> - enable lzo

Everybody made good remarks. That said, let's enable crypto, ssl and lzo
by default and get over with this, shall we? Otherwise this discussion
will never end :).

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9m7jkACgkQwp2X7RmNIqNJ+ACfVq7DUWRWVJgKyz6PNgL7uNpN
FYkAoKXbAOEKXrrw+jCWNw1aRnmGibBy
=3DrhRm
-----END PGP SIGNATURE-----


