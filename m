From: Heiko Hund <heiko.hund@...1489...>
Date: Sat, 4 Feb 2012 14:27:02 +0100
Message-ID: <5460047.rRj6FZSu1U@...1524...>
In-Reply-To: <1328360184-15865-1-git-send-email-heiko.hund@...1489...>
References: <1328360184-15865-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] UTF-8 X.509 distinguished names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi list,

On Saturday 04 February 2012 12:56:24 Heiko Hund wrote:
> The UTF-8 support that came with commit 2627335 does allow international
> usernames and passwords. This patch introduces UTF-8 support for X.509 DN=
s.
> Additionally, instead of using the legacy openssl format, DNs are now
> displayed in RFC 2253 format; "/C=3Dru/L=3D\xD0\x9C\xD0\xBE\xD1\x81\xD0\x=
BA\xD0
> \xB2\xD0\xB0/O=3D\xD0\x9A\xD1\x80\xD0\xB5\xD0\xBC\xD0\xBB\xD1\x8C/CN=3Dkr=
eml.ru
> " becomes "C=3Dru, L=3D=D0=9C=D0=BE=D1=81=D0=BA=D0=B2=D0=B0, O=3D=D0=9A=
=D1=80=D0=B5=D0=BC=D0=BB=D1=8C, CN=3Dkreml.ru".

this is almost an 1:1 repost of this previous one (at=20
http://thread.gmane.org/gmane.network.openvpn.devel/5112). The only thing t=
hat=20
was changed is that openssl_get_subject() was moved to ssl_verify_openssl.[=
ch]=20
as discussed at the FOSDEM meeting.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=C3=9Fe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=C3=BCnter Junk, Dr. Frank Nellissen




