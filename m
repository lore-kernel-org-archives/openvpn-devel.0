MIME-Version: 1.0
In-Reply-To: <CAKuzo_hBQPwTeko0+DfkzdztyHJj=FaYOPqkbxzh8kGE3FnrpA@...278...>
References: <1449446507-16654-1-git-send-email-selva.nair@...277...>
	<20151207071641.GR24952@...1296...>
	<CAKuzo_iriPYgazMiq=FKwvYbvVE39t9X8zheKP4PqOVwbtjQ7Q@...278...>
	<20151207154740.GD24952@...1296...>
	<CAKuzo_hBQPwTeko0+DfkzdztyHJj=FaYOPqkbxzh8kGE3FnrpA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 7 Dec 2015 23:15:06 -0500
Message-ID: <CAKuzo_j6C3Sw4LAFMsg797=+0g_rW9YU0EvA86M8Qw9mg=2W=g@...278...>
Content-Type: multipart/alternative; boundary=047d7bfcefb02a957805265b3952
Subject: Re: [Openvpn-devel] [PATCH master] Add an autoconf macro to check
 WINAPI functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bfcefb02a957805265b3952
Content-Type: text/plain; charset=UTF-8

On Mon, Dec 7, 2015 at 1:57 PM, Selva Nair <selva.nair@...277...> wrote:

> When pushed to a corner anything is possible...
>
> It turns out that libws2_32 exports all the required function names
> without any mangling (as if cdecl). Not sure this is mingw32 speciifc or
> not. Also unlike I wrote inet_ntop is not redefined, its InetNtopA that is
> redfined. Though Microsoft docs appears to indicate as if InetNtopA is the
> actual name.
>
> What it means is that a simple check without my much hated macro should be
> possible. I'll post a version 2 tonight.
>

However, that's true only for 64 bit targets.  For 32 bit targets the
stdcall names are mangled, as usual, with @NN.

In other words, no version 2, for now.

Thanks,

Selva

--047d7bfcefb02a957805265b3952
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br></div><div class=3D"gmail_e=
xtra"><div class=3D"gmail_quote">On Mon, Dec 7, 2015 at 1:57 PM, Selva Nair=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_b=
lank">selva.nair@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div c=
lass=3D"gmail_extra">When pushed to a corner anything is possible...</div><=
div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">It turns out=
 that libws2_32 exports all the required function names without any manglin=
g (as if cdecl). Not sure this is mingw32 speciifc or not. Also unlike I wr=
ote inet_ntop is not redefined, its InetNtopA that is redfined. Though Micr=
osoft docs appears to indicate as if InetNtopA is the actual name.</div><di=
v class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">What it means =
is that a simple check without my much hated macro should be possible. I&#3=
9;ll post a version 2 tonight.</div></blockquote></div><br>However, that&#3=
9;s true only for 64 bit targets.=C2=A0 For 32 bit targets the stdcall name=
s are mangled, as usual, with @NN.=C2=A0</div><div class=3D"gmail_extra"><b=
r></div><div class=3D"gmail_extra">In other words, no version 2, for now.=
=C2=A0</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"=
>Thanks,</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extr=
a">Selva</div></div>

--047d7bfcefb02a957805265b3952--

