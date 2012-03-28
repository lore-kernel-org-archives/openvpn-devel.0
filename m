MIME-Version: 1.0
In-Reply-To: <CAP+U6tJ=QO=u+BMSDpCCV3n3gmuhCZ0PnrMWryj+5L7saj+pkg@...278...>
References: <20120328171611.GH1359@...1296...>
	<1332960258-25371-1-git-send-email-alon.barlev@...277...>
	<CAP+U6tJ=QO=u+BMSDpCCV3n3gmuhCZ0PnrMWryj+5L7saj+pkg@...278...>
Date: Wed, 28 Mar 2012 21:22:33 +0200
Message-ID: <CAOazyz00v53K28Kdt6zSa_csWEe0QYhd_BEwsZku6Fi3Zt0dmQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid using ~0
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
Cc: Openvpn-devel@lists.sourceforge.net

On Wed, Mar 28, 2012 at 9:17 PM, Fabian Knittel
<fabian.knittel@...1547...> wrote:
> Hi Alon,
>
> I stumbled over a minor mistake:
>
> 2012/3/28 Alon Bar-Lev <alon.barlev@...277...>:
>> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
>> index bf7af63..05ea57f 100644
>> --- a/src/openvpn/route.c
>> +++ b/src/openvpn/route.c
>> @@ -1367,7 +1367,7 @@ add_route (struct route *r,
>> =C2=A0 =C2=A0 else if ((flags & ROUTE_METHOD_MASK) =3D=3D ROUTE_METHOD_E=
XE)
>> =C2=A0 =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0netcmd_semaphore_lock ();
>> - =C2=A0 =C2=A0 =C2=A0 status =3D openvpn_execve_check (&argv, es, 0, "E=
RROR: Windows route add command failed");
>> + =C2=A0 =C2=A0 =C2=A0 status =3D openvpn_execve_check (&argv, es, 0, "E=
RROR: Windows route add command f(DWORD)ailed");
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0netcmd_semaphore_release ();
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 else if ((flags & ROUTE_METHOD_MASK) =3D=3D ROUTE_METHOD_A=
DAPTIVE)
>
> Cheers
> Fabian

Great catch!
Don't know where this came from :)

Alon.

