MIME-Version: 1.0
In-Reply-To: <BANLkTi=-c2jxGcNj=+gdujJhhDjwrWP2TQ@...278...>
References: <BANLkTi=-c2jxGcNj=+gdujJhhDjwrWP2TQ@...278...>
Date: Tue, 12 Apr 2011 12:52:00 +0900
Message-ID: <BANLkTimVUW444FFjtaMSQti-yTmV5QcwZg@...278...>
From: crocket <crockabiscuit@...277...>
Subject: Re: [Openvpn-devel] I made a patch that prevents POSIX capabilities
 from disappearing during UID downgrade.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Forget about this patch.
The bug section in "man mlock" tells me that it's a kernel bug.
It seems prctl can't remove the bug.

On Tue, Apr 12, 2011 at 5:23 AM, crocket <crockabiscuit@...277...> wrote:
> diff -Naur a/init.c b/init.c
> --- a/init.c =A0 =A02010-11-05 04:29:02.000000000 +0900
> +++ b/init.c =A0 =A02011-04-12 05:11:43.540370471 +0900
> @@ -41,6 +41,10 @@
>
> =A0#include "occ-inline.h"
>
> +#ifdef TARGET_LINUX
> +#include <sys/prctl.h>
> +#endif
> +
> =A0static struct context *static_context; /* GLOBAL */
>
> =A0/*
> @@ -904,6 +908,10 @@
> =A0 =A0 =A0 if (no_delay)
> =A0 =A0 =A0 =A0{
> =A0 =A0 =A0 =A0 =A0set_group (&c0->group_state);
> +#ifdef TARGET_LINUX
> + =A0 =A0 =A0 =A0 if(prctl(PR_SET_KEEPCAPS, 1) < 0)
> + =A0 =A0 =A0 =A0 =A0 msg (M_ERR, "prctl(PR_SET_KEEPCAPS, 1) failed");
> +#endif
> =A0 =A0 =A0 =A0 =A0set_user (&c0->user_state);
> =A0 =A0 =A0 =A0 =A0c0->uid_gid_set =3D true;
> =A0 =A0 =A0 =A0}
>
> The patch is above.
> I had been investigating why OpenVPN refused to use CAP_IPC_LOCK capabili=
ty.
> I found out that it was because OpenVPN invoked setuid and setuid
> erased POSIX capabilities.
> prctl(PR_SET_KEEPCAPS, 1) lets OpenVPN keep capabilities after setuid
> invocation.
>
> Thanks in advance for considering this patch.
>

