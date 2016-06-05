MIME-Version: 1.0
In-Reply-To: <CAFHpkQHNu9qOVeQjco9ywL1iFUZqCjU5-LFt8PsYra1usyjkVA@...278...>
References: <CAFHpkQHNu9qOVeQjco9ywL1iFUZqCjU5-LFt8PsYra1usyjkVA@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 5 Jun 2016 10:01:36 +0200
Message-ID: <CAA1Abx+iih31Sby-9bvM5h9n9LA3HaOcOwF+C_Px9zxN_kZtPg@...278...>
Subject: Re: [Openvpn-devel] travis-ci (smoke testing)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Jun 5, 2016 at 12:21 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
> I was impressed by unit testing efforts, so I suggest to implement someth=
ing
> like that
>
> https://travis-ci.org/chipitsine/openvpn/builds/135318558
>
> ( https://github.com/OpenVPN/openvpn/pull/52 )
>
> we can use Linux, Mac OSX, gcc, clang, various configure options.
>
> (unfortunately, ssl cert at mbed tls website was expired and Xcode7.3 does
> not compile openvpn with openssl)

Cool.  This looks like a very decent start.

Afaik, OSX no longer ships with up-to-date versions of openssl.  We'd
need to build openssl before building openvpn, just like you currently
do with mbedtls.

-Steffan

