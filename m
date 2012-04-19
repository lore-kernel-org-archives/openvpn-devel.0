From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 19 Apr 2012 16:35:30 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B9012CBF71221@...1436...>
References: <4F901987.9080009@...1147...>
In-Reply-To: <4F901987.9080009@...1147...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] openssl ouch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> -----Original Message-----
> From: Jan Just Keijser [mailto:janjust@...1147...]
> Sent: donderdag 19 april 2012 15:56
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] openssl ouch
>=20
> ouch:
>   http://www.openssl.org/news/secadv_20120419.txt
>=20
> we need to investigate whether and how openvpn is affected.
>=20

Good catch!

OpenVPN does use a number of these functions when loading PKCS#12 files in =
ssl_openssl.c.=20

I'm not entirely sure what the impact is yet, as these files should be gene=
rated by the same user that actually uses the connection (they contain the =
user's private key). If the user hasn't generated these files themselves (w=
hich I wouldn't recommend), they might be affected.

Adriaan

