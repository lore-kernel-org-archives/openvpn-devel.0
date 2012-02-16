From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 16 Feb 2012 13:36:37 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B901293369C9F@...1436...>
References: <CB62AEE8.E86%brabander@...1435...>
In-Reply-To: <CB62AEE8.E86%brabander@...1435...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Cipher problem on Mac OS X
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
To: Frank de Brabander <brabander@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> -----Original Message-----
> From: Frank de Brabander [mailto:brabander@...1435...]
>=20
> Hello,
>=20
> I have looked into the problem, it seems to be caused by the return
> type of cipher_kt_mode() in crypto_backend.h being declared as a bool.
> This function is called from init_key_type() of crypto.c during the
> tests. The actual mode value in cipher_kt_mode() of openssl_backend.c
> during the failed test is 2, but is converted to 1 due to this boolean
> return type.
> My guess is that this is only happening on OS X because of a specific
> GCC compiler version or custom Apple patches.
>=20
> Below I have included a patch that changes the bool return type to an
> int.
> This will result in 'make check' to pass.
>=20

Ack, I saw this work on Frank's mac :). Apologies for the missed bool.

Adriaan


