From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 23 Aug 2013 10:00:04 +0200
Message-ID: <3175682.0C6cFygpIW@...1526...>
In-Reply-To: <521668C9.5070003@...515...>
References: <521668C9.5070003@...515...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Proposed change to allow use of statically
	linked OpenSSL
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
To: openvpn-devel@lists.sourceforge.net

On Thursday 22 August 2013 22:38:49 Samuli Sepp=E4nen wrote:
> In today's meeting we briefly touched upon this suggested fix to
> configure.ac to allow using statically linked OpenSSL:
> <https://community.openvpn.net/openvpn/ticket/305>
>=20
> We couldn't figure out if the proposed change would have negative
> side-effects, so we didn't dare to implement it as-is.

What the proposed patch does is always link against openssl's libcrypto whe=
n=20
testing for libssl availability, but only if pkg-config didn't already prov=
ide=20
the info. So, it's a bit of a corner case where no dynamic openssl libs are=
=20
available and pkg-config info was not installed with the static libs.

I see no potential for breakage, so ACK.

Heiko

