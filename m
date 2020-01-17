MIME-Version: 1.0
References: <20200116141900.1524-1-simon@...2293...>
In-Reply-To: <20200116141900.1524-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 17 Jan 2020 11:22:47 +0200
Message-ID: <CAGyAFMW6+XJxzVPT3j4Js=eptdPm0SvLH0JJru8ZmPuzPvcMjQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000dab33e059c527c99"
Subject: Re: [Openvpn-devel] [PATCH] wintun: refactor code to use enum
 driver type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000dab33e059c527c99
Content-Type: text/plain; charset="UTF-8"

Hi,

While we've discussed this during hackathon, it would
nevertheless be nice to explain in commit message
why this is needed (something like make code more device type agnostic).

Also, this line

  +            msg(M_FATAL, "Adapter '%s' is using %s driver, %s expected.
If you want to use this device, adjust --windows-driver.", dev_node,
print_windows_driver(windows_driver),
print_windows_driver(tt->windows_driver));

is a bit too long, it would be nice to split it.

Other than that, looks good.

Built and tested with MSVC.

Acked-by: Lev Stipakov <lstipakov@...277...>

-- 
-Lev

--000000000000dab33e059c527c99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>While we&#39;ve di=
scussed this during hackathon, it would</div><div>nevertheless be nice to e=
xplain in commit message</div><div>why this is needed (something like make =
code more device type agnostic).</div><div><br></div><div>Also, this line</=
div><div><br></div><div>=C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m=
sg(M_FATAL, &quot;Adapter &#39;%s&#39; is using %s driver, %s expected. If =
you want to use this device, adjust --windows-driver.&quot;, dev_node, prin=
t_windows_driver(windows_driver), print_windows_driver(tt-&gt;windows_drive=
r));=C2=A0</div><div><br></div><div>is a bit too long, it would be nice to =
split it.<br></div><div><br></div><div>Other than that, looks good.</div><d=
iv><br></div><div>Built and tested with MSVC.</div><div><br></div><div>Acke=
d-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277...">lstipakov@...493...=
277...</a>&gt;</div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">-Lev</div></div>

--000000000000dab33e059c527c99--

