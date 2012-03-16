MIME-Version: 1.0
In-Reply-To: <CAP+U6tJx_xNbEHfhENcJKEpgE1WMf-03ez=nKo2zEwUQEEe7Xw@...278...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-36-git-send-email-alon.barlev@...277...>
	<4F588784.300@...515...>
	<CAOazyz3OzNYscLd01QY_wopFkH9zctixQNhJr-PyoPmTBvrwTw@...278...>
	<CAP+U6tJx_xNbEHfhENcJKEpgE1WMf-03ez=nKo2zEwUQEEe7Xw@...278...>
Date: Fri, 16 Mar 2012 17:58:50 +0200
Message-ID: <CAOazyz2ESjg4vbYRqaCcT4PGdnQKw3Y77kS9UsTi2OD+_mXoSw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 35/52] build: proper selinux detection
	and usage
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Fri, Mar 16, 2012 at 5:25 PM, Fabian Knittel
<fabian.knittel@...1547...> wrote:
> Hi Alon,
>
> sorry for digging up the dead, but our disagreements might have
> started earlier and just went unnoticed so far ... :)
>
> 2012/3/8 Alon Bar-Lev <alon.barlev@...277...>:
>> I wrote this in the introduction of the patch set.
>>
>> There are two approaches to detecting dependencies:
>>
>> 1. Detect all compile time dependences- you detect headers and
>> libraries, this is probably the safest way to go, but makes the code
>> very complex.
>
> Are you referring to the configure code? I might be missing something
> obvious, but
>
> AC_CHECK_LIB([selinux], [setcon], [SELINUX_LIBS=3D"-lselinux"])
>
> versus
>
> AC_CHECK_HEADER([selinux/selinux.h], [
> =C2=A0 =C2=A0AC_CHECK_LIB([selinux], [setcon], [SELINUX_LIBS=3D"-lselinux=
"],
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[AC_MSG_RESULT([SELinux library not found.])]
> =C2=A0 =C2=A0)], =C2=A0[AC_MSG_ERROR([SELinux headers not found.])]
> )
>
> doesn't really qualify as "very complex" to me.

This is untrue.
As most features needs custom CFLAGs as well, it looks like:

old_CFLAGS=3D"${CFLAGS}"
CFLAGS=3D"${CFLAGS} ${SOME_CFLAGS}"
AC_CHECK_HEADER([...])
CFLAGS=3D"${old_CFLAGS}"

And as I wrote, in all build system I re-wrote I used this approach,
no negative impact what so ever.

I don't mind doing this differently in openvpn *IF* there is a good
reason to do so.
A good reason not to do this is to lower the line of code in autoconf.

Alon.

