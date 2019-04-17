MIME-Version: 1.0
References: <CAFHpkQFauuHVbkLAVCz2b1s2m4dwUjxQPyBn9Laa0BmwyYQmGQ@...278...>
 <CAFHpkQFwOTOrqucoFs+mcLr7bCvVzYnUhK7hEM084suOFjm85Q@...278...>
In-Reply-To: <CAFHpkQFwOTOrqucoFs+mcLr7bCvVzYnUhK7hEM084suOFjm85Q@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 17 Apr 2019 11:45:23 +0200
Message-ID: <CAA1AbxLG8Ab+zU-V8N_5u8mnLRGXWXy5a9FYgVEM6NVHr8_2HA@...278...>
Subject: Re: [Openvpn-devel] cirrus-ci: freebsd builds ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Thu, 11 Apr 2019 at 00:54, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
> 1) error when built with mbedtls-2.16.0 (surprizingly, build does not fai=
l)
>
> [       OK ] tls_crypt_v2_wrap_unwrap_no_metadata
> [ RUN      ] tls_crypt_v2_wrap_unwrap_max_metadata
> [       OK ] tls_crypt_v2_wrap_unwrap_max_metadata
> [ RUN      ] tls_crypt_v2_wrap_too_long_metadata
> ERROR: could not crypt: insufficient space in dst

This is not a test error, but an error message printed by the code
that is tested. See the test name, it feeds the code too much
metadata, and checks that the code errors out as expected.

> 2) base64 is missing --> build is ok (we have similar "failures" on travi=
s-ci osx builds)
>
> Testing tls-crypt-v2 key generation (max length metadata)..../t_lpback.sh=
: base64: not found
> OK
> PASS: t_lpback.sh

This is an error in t_lpback.sh, will check it out.

-Steffan

