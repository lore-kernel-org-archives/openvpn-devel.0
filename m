MIME-Version: 1.0
In-Reply-To: <4F4B4660.5020108@...1114...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
	<1329787361-26096-8-git-send-email-alon.barlev@...277...>
	<4F4B4660.5020108@...1114...>
Date: Mon, 27 Feb 2012 13:02:27 +0200
Message-ID: <CAOazyz1pPsu_k9B_SaN+KOhZdFs9O75otW=xCZx5CLRqFEVxtA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 07/35] build: tests do not work disable
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Checkout the latest HEAD.
The tests were modified and it is now working.

On Mon, Feb 27, 2012 at 11:01 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 21/02/12 02:22, Alon Bar-Lev wrote:
>>
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- Makefile.am |
>> 5 +++-- 1 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile.am b/Makefile.am index 26b80f3..f96eb45 100644
>> --- a/Makefile.am +++ b/Makefile.am @@ -57,16 +57,17 @@ SUBDIRS =3D \
>> service-win32 \ install-win32
>>
>> -TESTS =3D t_client.sh t_lpback.sh t_cltsrv.sh +test_scripts =3D
>> t_client.sh t_lpback.sh t_cltsrv.sh +#TESTS =3D $(test_scripts)
>> sbin_PROGRAMS =3D openvpn
>>
>> dist_doc_DATA =3D \ management/management-notes.txt
>>
>> dist_noinst_SCRIPTS =3D \ - =C2=A0 =C2=A0 $(TESTS) \ doclean \ domake-wi=
n \ +
>> $(test_scripts) \ t_cltsrv-down.sh \ configure_h.awk
>> configure_log.awk
>>
>
> Which of these tests are not working? =C2=A0And how do they fail?
>
> I'm running 'make check' before pushing a new git tree, and it passes
> fine for me. =C2=A0The only "exception" is t_client.sh (generated via
> t_client.sh.in) which depends on a configuration file (t_client.rc) -
> otherwise it is just skipped. =C2=A0This test is however run in our build=
bot
> farm, AFAIR. =C2=A0Gert also runs this test in his development repos. =C2=
=A0So it's
> rather odd to hear that these tests fail.
>
>
> kind regards,
>
> David Sommerseth
>
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk9LRl4ACgkQDC186MBRfrrWcQCgklcEZ8ATjLQqsQ9mxOFLbMjM
> 2FAAoI2cJAVd7GVdv9hO7TvkSSVCAPmK
> =3DxG/s
> -----END PGP SIGNATURE-----

