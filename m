MIME-Version: 1.0
In-Reply-To: <CAKuzo_iSwvk8MTW0ACT+n5JRkNDNyOoHHvmYw+fonN=ASUPuCw@...278...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<CAKuzo_iSwvk8MTW0ACT+n5JRkNDNyOoHHvmYw+fonN=ASUPuCw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 3 Feb 2016 20:57:18 -0500
Message-ID: <CAKuzo_hLdWaxZau_KtBhO1LvTivmurinrdqPsNTrjUfWnrZBvA@...278...>
Content-Type: multipart/alternative; boundary=089e0115f28e265c7c052ae80f63
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Heiko Hund <heiko.hund@...1489...>

--089e0115f28e265c7c052ae80f63
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Feb 1, 2016 at 11:34 AM, Selva Nair <selva.nair@...277...> wrote:

> Other comments I have are more specific to code snippets and of minor
> consequence. Will send them after compile/test runs


Following up on that, a couple of comments below:

      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
>       if (iphlpapi == NULL)
>         return GetLastError ();
>       CreateIpForwardEntry2 = (CreateIpForwardEntry2Fn) GetProcAddress
> (iphlpapi, "CreateIpForwardEntry2");
>       if (!CreateIpForwardEntry2)
>         return GetLastError ();


Is this run-time lookup necessary?

Anyway, the iservice works well and the only real problem I ran into was
lack of write access to the default log_dir. That leads to a log-jam as the
stdout is now a pipe which the service is not actively reading from. Could
be handled in the GUI + registry by making sure openvpn is started with a
writable log file..

Anyway, the service part of the code looks good and does well what it
promises to do.

Selva

--089e0115f28e265c7c052ae80f63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, Feb 1, 2016 at 11:34 AM, Selva =
Nair <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=
=3D"_blank">selva.nair@...277...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
Other comments I have are more specific to code snippets and of minor conse=
quence. Will send them after compile/test runs</blockquote></div><div class=
=3D"gmail_extra"><br></div>Following up on that, a couple of comments below=
:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddi=
ng-left:1ex">=C2=A0 =C2=A0 =C2=A0 HMODULE iphlpapi =3D GetModuleHandle (TEX=
T(&quot;iphlpapi.dll&quot;));<br>=C2=A0 =C2=A0 =C2=A0 if (iphlpapi =3D=3D N=
ULL)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError ();<br>=C2=A0 =C2=
=A0 =C2=A0 CreateIpForwardEntry2 =3D (CreateIpForwardEntry2Fn) GetProcAddre=
ss (iphlpapi, &quot;CreateIpForwardEntry2&quot;);<br>=C2=A0 =C2=A0 =C2=A0 i=
f (!CreateIpForwardEntry2)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastErr=
or ();</blockquote><div class=3D"gmail_extra">=C2=A0</div></div><div class=
=3D"gmail_extra">Is this run-time lookup necessary?<br></div><div class=3D"=
gmail_extra"><br>Anyway, the iservice works well and the only real problem =
I ran into was lack of write access to the default log_dir. That leads to a=
 log-jam as the stdout is now a pipe which the service is not actively read=
ing from. Could be handled in the GUI + registry by making sure openvpn is =
started with a writable log file..<br></div><div class=3D"gmail_extra"><br>=
</div><div class=3D"gmail_extra">Anyway, the service part of the code looks=
 good and does well what it promises to do.=C2=A0<br></div><div class=3D"gm=
ail_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--089e0115f28e265c7c052ae80f63--

