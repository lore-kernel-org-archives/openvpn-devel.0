MIME-Version: 1.0
In-Reply-To: <1329477191-634-1-git-send-email-davids@...1347...>
References: <1329477191-634-1-git-send-email-davids@...1347...>
Date: Fri, 17 Feb 2012 13:18:18 +0200
Message-ID: <CAOazyz2YPRM9WEt4LjEVOR05FrYkVr4W1OMWcbHVeDf7m6E+-Q@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Makefile.am referenced a now
	non-existing config-win32.h
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

When did this file gone?
Anyway, this was required with compiling using MSVC...

On Fri, Feb 17, 2012 at 1:13 PM, David Sommerseth <davids@...1347...> wrote:
> This file was moved to win/config.h.in and is the template used
> by the Python build tools in win/. =C2=A0This happened in
> commit 4b312378e9e7084a0699ca6d4b895bdadb7540db
>
> For all other autotools based environments, ./configure will take
> care of creating the proper config.h
>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
> =C2=A0Makefile.am | =C2=A0 =C2=A01 -
> =C2=A01 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index ab86cc1..2029389 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -85,7 +85,6 @@ openvpn_SOURCES =3D \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clinat.c clinat.h \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0common.h \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0compat.h compat.c \
> - =C2=A0 =C2=A0 =C2=A0 config-win32.h \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0crypto.c crypto.h crypto_backend.h \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0crypto_openssl.c crypto_openssl.h \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0crypto_polarssl.c crypto_polarssl.h \
> --
> 1.7.4.4
>
>
> -------------------------------------------------------------------------=
-----
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

