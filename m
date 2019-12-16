MIME-Version: 1.0
References: <20191213191634.250-1-lstipakov@...277...>
 <20191213191901.300-1-lstipakov@...277...>
 <CAKuzo_jNn9NG-chJHx62H2CTiB64dCrq3S3_oW7oR8Tngf4F9w@...278...>
 <CAGyAFMVReSwJsYAKo5S4pV4POV31g0roxz4P2Ajvr+8hoEYbeA@...278...>
 <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
In-Reply-To: <CAKuzo_hMws66xJsN69qa6WmgXNdrSKioHQrpE9VZ89-J2O7+KA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 16 Dec 2019 23:31:01 +0200
Message-ID: <CAGyAFMWfEnYrNOwugvO6y1HoFsdih0xu9Lm1_fO=QgrgeyxzzQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000444ed70599d8eed7"
Subject: Re: [Openvpn-devel] [PATCH v6 4/7] wintun: ring buffers based I/O
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000444ed70599d8eed7
Content-Type: text/plain; charset="UTF-8"

>
> I have already said what I think of it. As an admin I wouldn't like to see
> users running processes that elevate to SYSTEM like this.
>

Would it be too much if

 - openvpn.exe process detects that it is not started by interactive service
 - interactive service process is running
 - wintun is used as --windows-driver

then openvpn behaves as a command-line version of openvpn-gui - connects to
service, which
runs openvpn.exe, and then prints output, received via management
interface, to console?

-- 
-Lev

--000000000000444ed70599d8eed7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">I have already said what I think of it. As an admin I wo=
uldn&#39;t like to see<br>
users running processes that elevate to SYSTEM like this.<br></blockquote><=
div><br></div><div>Would it be too much if=C2=A0</div><div>=C2=A0</div><div=
>=C2=A0- openvpn.exe process detects that it is not started by interactive =
service</div><div>=C2=A0- interactive service process is running</div><div>=
=C2=A0- wintun is used as --windows-driver</div><div><br></div><div>then op=
envpn behaves as a command-line version of openvpn-gui - connects to servic=
e, which=C2=A0</div><div>runs openvpn.exe, and then prints output, received=
 via management interface, to console?</div></div><div><br></div>-- <br><di=
v dir=3D"ltr">-Lev</div></div>

--000000000000444ed70599d8eed7--

