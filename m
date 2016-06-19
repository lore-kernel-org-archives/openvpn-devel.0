MIME-Version: 1.0
In-Reply-To: <CAFHpkQHX-m9-Ub0WxgpyDx5uWcjyFf=aRN-cUTYt=fJ7dEXc0w@...278...>
References: <CAFHpkQHX-m9-Ub0WxgpyDx5uWcjyFf=aRN-cUTYt=fJ7dEXc0w@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Sun, 19 Jun 2016 12:37:24 +0200
Message-ID: <CAA1AbxK5OUWtYhszHVpD7nXFu1Yh-PQgraZNDE0XtLcs_2_5dA@...278...>
Subject: Re: [Openvpn-devel] what is the best way of skipping tests when
 openvpn configured --disable-crypto ?
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

On Sun, Jun 19, 2016 at 10:41 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
> when playing with travis-ci, I encountered that t_lpback.sh and t_cltsrv.=
sh
> fails on "make check" if openvpn is configured with --disable-crypto
> (because --genkey is not available)
>
> what would be the best ?
>
> 1) run 'openvpn --help' and grep for --genkey ?
> 2) check exit code of 'openvpn --genkey' ?
> 3) run 'openvpn --show-ciphers' and see it is empty ?
> 4) somehow determine exact configure options ? (I haven't found a way yet)

I think 4.  You can use AC_SUBST to pass the value of $enable_crypto
to a Makefile.am, and just not run the t_client.sh, t_lpback.sh and
t_cltsrv.sh if it is 'no'.

Later on, we might want to add a test that verifies correct behaviour
of openvpn-without-crypto.

-Steffan

