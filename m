MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <CAOazyz2ESjg4vbYRqaCcT4PGdnQKw3Y77kS9UsTi2OD+_mXoSw@...278...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-36-git-send-email-alon.barlev@...277...>
	<4F588784.300@...515...>
	<CAOazyz3OzNYscLd01QY_wopFkH9zctixQNhJr-PyoPmTBvrwTw@...278...>
	<CAP+U6tJx_xNbEHfhENcJKEpgE1WMf-03ez=nKo2zEwUQEEe7Xw@...278...>
	<CAOazyz2ESjg4vbYRqaCcT4PGdnQKw3Y77kS9UsTi2OD+_mXoSw@...278...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Fri, 16 Mar 2012 17:29:02 +0100
Message-ID: <CAP+U6tJ-f9NHPCYU3H08ub2uiNhy2=ubkFXmP=fcoq0B8EptLQ@...278...>
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hi Alon,

>> AC_CHECK_LIB([selinux], [setcon], [SELINUX_LIBS=3D"-lselinux"])
>>
>> versus
>>
>> AC_CHECK_HEADER([selinux/selinux.h], [
>> =C2=A0 =C2=A0AC_CHECK_LIB([selinux], [setcon], [SELINUX_LIBS=3D"-lselinu=
x"],
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0[AC_MSG_RESULT([SELinux library not found.])]
>> =C2=A0 =C2=A0)], =C2=A0[AC_MSG_ERROR([SELinux headers not found.])]
>> )
>>
>> doesn't really qualify as "very complex" to me.
>
> This is untrue.
> As most features needs custom CFLAGs as well, it looks like:
>
> old_CFLAGS=3D"${CFLAGS}"
> CFLAGS=3D"${CFLAGS} ${SOME_CFLAGS}"
> AC_CHECK_HEADER([...])
> CFLAGS=3D"${old_CFLAGS}"

I can see where this would be necessary if you wanted to "search
additional non-standard paths for the libraries and headers" (see my
last email), but it wouldn't be necessary for the simple case, where
you want to make sure that library and header are available and
compilable with the flags the user provided.

So it sounds as if we're actually somewhat in agreement! You don't
want complex, automatic detection of non-standard situations and I
agree wholeheartedly.
But I _do_ want basic checking to achieve clear error messages at
configuration time, not obscure build errors far later in the build
process. Rule of thumb: If "make" fails due to missing or wrong
dependencies, it's a bug in configure, because it didn't detect the
problem beforehand.

Cheers
Fabian

