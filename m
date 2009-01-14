Message-ID: <496E1D39.9090606@...41...>
Date: Wed, 14 Jan 2009 10:13:29 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <496DA8AB.3070301@...1185...>
In-Reply-To: <496DA8AB.3070301@...1185...>
Subject: Re: [Openvpn-devel] OpenVPN affected? - Incorrect checks for
 malformed signatures in OpenSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-15?Q?=22Michael_A=2E_G=FCtlbauer=22?= <mail@...1185...>
Cc: Openvpn-devel@lists.sourceforge.net, OpenVpn-Users <openvpn-users@lists.sourceforge.net>

I don't believe this issue significantly affects OpenVPN.  OpenVPN does=20
not use the EVP_VerifyFinal function.  The issue is that some internal=20
OpenSSL functions do not properly check the return value of this=20
function.  The issue is primarily of concern if you are using DSA or=20
ECDSA certificates, however these are not generally used with OpenVPN=20
(OpenVPN uses RSA certificates and does not currently support DSA or=20
ECDSA certificates).

James

Michael A. G=FCtlbauer wrote:
> Hallo!
>=20
> I'm sure, you know the "OpenSSL Security Advisory [07-Jan-2009]"=20
> (http://www.openssl.org/news/secadv_20090107.txt)
>=20
> Because there's absolutely no information on your website, whether=20
> OpenVPN is affected and/or a bug-fix will be available, I'd like to ask=20
> you to do so.
>=20
> Many thanks!
>=20
> Michael

