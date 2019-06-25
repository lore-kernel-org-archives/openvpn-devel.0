MIME-Version: 1.0
References: <1561491241-16380-1-git-send-email-lstipakov@...277...>
 <20190625194905.GM1097@...1296...>
 <CAKuzo_g200Ck8fBTMmTe93R5A_+FjGoK0zKNQr49i01RmHfHkw@...278...>
In-Reply-To: <CAKuzo_g200Ck8fBTMmTe93R5A_+FjGoK0zKNQr49i01RmHfHkw@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 25 Jun 2019 23:38:46 +0300
Message-ID: <CAGyAFMWRqAhpsXaSPouXQPEzmCM5qDMD-Pie2XaqdXPL3weLMA@...278...>
Content-Type: multipart/alternative; boundary="000000000000020771058c2beb1a"
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: enable interactive service
 to open tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000020771058c2beb1a
Content-Type: text/plain; charset="UTF-8"

Hi,


> The way interactive service structures are coded should not require
> this at all, does it? The size and message type are already in the
> header, so why do we need to pass it?


But we need to know the response size in send_msg_iservice() since
we pass it to ReadFile(). So far we assumed that response is always
ask_message_t
and we could do sizeof(*ack). With new response type this assumption
doesn't hold so
as Gert suggested I added another version which accepts arbitrary response
type and size.

bool
send_msg_iservice(HANDLE pipe, const void *data, size_t size,
                  ack_message_t *ack, const char *context)
{
    return send_msg_iservice_ex(pipe, data, size, ack, sizeof(*ack),
context);
}

bool
send_msg_iservice_ex(HANDLE pipe, const void *data, size_t size,
                     void *response, size_t response_size, const char
*context)
{

Will send V2 tomorrow with this and CreateFileW changes.


-- 
-Lev

--000000000000020771058c2beb1a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi,</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">The way interactive servi=
ce structures are coded should not require<br>
this at all, does it? The size and message type are already in the<br>
header, so why do we need to pass it?=C2=A0</blockquote><div><br></div><div=
>But we need to know the response size in=C2=A0send_msg_iservice() since</d=
iv><div>we pass it to ReadFile(). So far we assumed that response is always=
 ask_message_t</div><div>and we could do sizeof(*ack). With new response ty=
pe this assumption doesn&#39;t hold so</div><div>as Gert suggested I added =
another version which accepts arbitrary response type and size.</div><div><=
br></div><div>bool<br>send_msg_iservice(HANDLE pipe, const void *data, size=
_t size,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
ack_message_t *ack, const char *context)<br>{<br>=C2=A0 =C2=A0 return send_=
msg_iservice_ex(pipe, data, size, ack, sizeof(*ack), context);<br>}<br><br>=
bool<br>send_msg_iservice_ex(HANDLE pipe, const void *data, size_t size,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0void *response, size_t response_size, const char *context)<br>{<br></div=
><div><br></div><div>Will send V2 tomorrow with this and CreateFileW change=
s.</div><div><br></div><div>=C2=A0</div></div>-- <br><div dir=3D"ltr" class=
=3D"gmail_signature">-Lev</div></div>

--000000000000020771058c2beb1a--

