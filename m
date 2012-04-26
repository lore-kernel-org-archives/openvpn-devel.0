MIME-Version: 1.0
In-Reply-To: <CAP+U6tKxU2OjMjeVUuR07dGBh+gdyvB4370+wq3k66=qPfxrPw@...278...>
References: <1333820547-9672-1-git-send-email-alon.barlev@...277...>
	<CAP+U6tKxU2OjMjeVUuR07dGBh+gdyvB4370+wq3k66=qPfxrPw@...278...>
Date: Thu, 26 Apr 2012 19:06:36 +0300
Message-ID: <CAOazyz2Cg78qGwU1izJYihcfQvDsQkgP0cDi2Nif4yQQ2gt5Xw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: remove C++ comments
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
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Apr 26, 2012 at 3:33 PM, Fabian Knittel
<fabian.knittel@...1547...> wrote:
> Hi Alon,
>
> 2012/4/7 Alon Bar-Lev <alon.barlev@...277...>:
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>> ---
>> =C2=A0src/openvpnserv/openvpnserv.c | =C2=A0 =C2=A06 +++---
>> =C2=A01 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/src/openvpnserv/openvpnserv.c b/src/openvpnserv/openvpnserv=
.c
>> index a9a9441..56f5a02 100755
>> --- a/src/openvpnserv/openvpnserv.c
>> +++ b/src/openvpnserv/openvpnserv.c
>> @@ -87,9 +87,9 @@ static HANDLE exit_event =3D NULL;
>> =C2=A0/*
>> =C2=A0* Message handling
>> =C2=A0*/
>> -#define M_INFO =C2=A0 =C2=A0(0) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0// informational
>> -#define M_SYSERR =C2=A0(MSG_FLAGS_ERROR|MSG_FLAGS_SYS_CODE) // error + =
system code
>> -#define M_ERR =C2=A0 =C2=A0 (MSG_FLAGS_ERROR) =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// error
>> +#define M_INFO =C2=A0 =C2=A0(0) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* informational */
>> +#define M_SYSERR =C2=A0(MSG_FLAGS_ERROR|MSG_FLAGS_SYS_CODE) /* error + =
system code */
>> +#define M_ERR =C2=A0 =C2=A0 (MSG_FLAGS_ERROR) =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* error */
>>
>> =C2=A0/* write error to event log */
>> =C2=A0#define MSG(flags, ...) \
>
> ACK. Doesn't hurt to be consistent. Are those the only remaining
> C++-style comments?

there is one more place I chose to ignore, the service implementation
is taken from Microsoft SDK sample, and has C++ comments... to remain
close to the original I left this intact.

> (Does someone know what C standard we aim at? "C++ comments" would be
> just fine for C99.)

Currently openvpn should support C89 based on supported configurations.

Alon.

