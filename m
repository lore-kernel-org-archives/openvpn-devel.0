MIME-Version: 1.0
In-Reply-To: <1335479238-26420-1-git-send-email-alon.barlev@...277...>
References: <CAOazyz02OcvCdJJ-JHBZWcxB-99nEBOXUcCHE6fkN4eGUkyCgQ@...278...>
	<1335479238-26420-1-git-send-email-alon.barlev@...277...>
Date: Fri, 27 Apr 2012 01:28:31 +0300
Message-ID: <CAOazyz26b+W+_5_Sb4xhnWWXgAV5ENAxPTyNqyDAUYMbhUoucw@...278...>
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

On Fri, Apr 27, 2012 at 1:27 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> If stdbool.h is available use it, otherwise create emulation.
>
> basic.h defines a type 'bool' that conflicts with
> the altivec keyword bool which has to be fixed upstream, see
> bugs[1][2].
>
> [1] https://bugs.gentoo.org/show_bug.cgi?id=3D293840
> [2] https://bugs.gentoo.org/show_bug.cgi?id=3D297854
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
> =C2=A0configure.ac =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A02 +-
> =C2=A0src/compat/compat-stdbool.h | =C2=A0 12 ++++++++++++
> =C2=A0src/openvpn/basic.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 13 -------=
------
> =C2=A0src/openvpn/syshead.h =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A04 files changed, 14 insertions(+), 14 deletions(-)
> =C2=A0create mode 100644 src/compat/compat-stdbool.h

Hello,

I took the easy approach.
I think this is the simplest it can be.

Regards,
Alon Bar-Lev.

