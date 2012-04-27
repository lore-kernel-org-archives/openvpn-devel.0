MIME-Version: 1.0
In-Reply-To: <1335528555-13225-1-git-send-email-alon.barlev@...277...>
References: <1335479238-26420-1-git-send-email-alon.barlev@...277...>
	<1335528555-13225-1-git-send-email-alon.barlev@...277...>
Date: Fri, 27 Apr 2012 15:10:14 +0300
Message-ID: <CAOazyz35dcMKfqLq4Q9NNU_3bZs8dxrDs5Hmm-oXUDPiFWC4OQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: use stdbool.h if available
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
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

On Fri, Apr 27, 2012 at 3:09 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> --- a/src/compat/Makefile.am
> +++ b/src/compat/Makefile.am
> @@ -20,6 +20,7 @@ noinst_LTLIBRARIES =3D libcompat.la
>
> =C2=A0libcompat_la_SOURCES =3D \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0compat.h \
> + =C2=A0 =C2=A0 =C2=A0 compat-stdbool.h \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0compat-dirname.c \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0compat-basename.c \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0compat-gettimeofday.c \

The above hunk was missing.

Alon.

