MIME-Version: 1.0
In-Reply-To: <03afef7f-c193-c209-92cb-2422754dcb2b@...277...>
References: <CAKuzo_g1yJwUsVdUF+RJdO6DeHeVhYOhSgWLX-SoFfiUw3o2sQ@...278...>
 <29a3b6b5-f596-0c63-9a37-377399e1e4d0@...515...>
 <CAKuzo_iVMAAjPR-GLE0s+unhowhq6uxUPzD0f1S1mYZAsZkDng@...278...>
 <CAKuzo_jYRJPnZmKpdbMwC1L=96+f_rRT3TtKbSPF61pPen64fw@...278...>
 <CAKuzo_ib6XmtzOVtd4FzHSJRunPRRYEQA3hH+svx=n-V18Qx-A@...278...>
 <03afef7f-c193-c209-92cb-2422754dcb2b@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 18 Jun 2018 14:17:12 -0400
Message-ID: <CAKuzo_i76hZ6MHrC2qoTe1UttyB=8-Qz7t1ADHk=Cqi-EpbKQA@...278...>
Content-Type: multipart/alternative; boundary="0000000000004fd83c056eee94de"
Subject: Re: [Openvpn-devel] interactive service docs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0000000000004fd83c056eee94de
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Jun 18, 2018 at 1:10 PM, tincanteksup <tincanteksup@...277...>
wrote:

> Hi Selva,
>
> just a note that:
>
>
> - ``--up`` scripts are run by openvpn.exe itself, which is running as user
>   *joe*, all privileges are nicely in place.
>
> - Scripts run by the GUI will run as user *joe*, so that automated tasks
> like
>   *mapping of drives* work as expected.
>
>
> As far as I know, mapping network drives from an --up script does NOT
> work because the VPN will not pass any data until all scripts complete.
>
> So is this really a suitable example ?
>

This is about up script run by the GUI (profile_name_up.bat) and works
nicely for mapping drives. We use it widely for our Windows users.

Selva

--0000000000004fd83c056eee94de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Hi,<br><br></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote">On Mon, Jun 18, 2018 at 1:10 PM=
, tincanteksup <span dir=3D"ltr">&lt;<a href=3D"mailto:tincanteksup@...1354...=
.." target=3D"_blank">tincanteksup@...277...</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">Hi Selva,<br>
<br>
just a note that:<br>
<br>
<br>
- ``--up`` scripts are run by openvpn.exe itself, which is running as user<=
br>
=C2=A0 *joe*, all privileges are nicely in place.<br>
<br>
- Scripts run by the GUI will run as user *joe*, so that automated tasks li=
ke<br>
=C2=A0 *mapping of drives* work as expected.<br>
<br>
<br>
As far as I know, mapping network drives from an --up script does NOT<br>
work because the VPN will not pass any data until all scripts complete.<br>
<br>
So is this really a suitable example ?<br></blockquote><div><br></div><div>=
This is about up script run by the GUI (profile_name_up.bat) and works nice=
ly for mapping drives. We use it widely for our Windows users.<br><br></div=
><div>Selva<br></div></div></div></div>

--0000000000004fd83c056eee94de--

