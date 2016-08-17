MIME-Version: 1.0
In-Reply-To: <CAKuzo_jc_mm2165qwc5ACLQCP6kqocRxfaMO9crJzu3HMxJ_og@...278...>
References: <CAKuzo_jc_mm2165qwc5ACLQCP6kqocRxfaMO9crJzu3HMxJ_og@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 17 Aug 2016 01:49:12 -0400
Message-ID: <CAKuzo_ijNQi6p3M33WEeV-MQnFpfOm-qiz=9Ck40OuNp+WpXvA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0a879a94bba1053a3e07dc
Subject: Re: [Openvpn-devel] testing challenge-response
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0a879a94bba1053a3e07dc
Content-Type: text/plain; charset=UTF-8

Hi,

Following up on the previous mail, the server side script for client
authentication and the server/client configs that I use for testing
challenge-response auth are uploaded here:

https://gist.github.com/selvanair/b31ec6d5873e2ffc141ec680fca69254

On the server-side the script should be running in parallel with the
server (run from the same directory) for management-client-auth to work.
No attempt is made to sanitize user input etc. so its useful only for
testing purposes.

The --remote option in the client config should be edited to match the
server.

Selva

On Tue, Aug 16, 2016 at 2:21 PM, Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> As discussed in the IRC meeting, here is a client config that connects to
> a test server I run for static and dynamic challenge. Just run it as
>
> sudo openvpn --config cr-client.conf
>
> Respond with some arbitrary strings at the username,  password and
> static-challenge prompts and the server will send back the strings you
> typed plus a dynamic challenge question. The connection will succeed after
> the server verifies the response to the dynamic challenge. There may be a 5
> seconds restart pause between the two exchanges.
>
> Note that the password and static-challenge response are sent by the
> client to the server base64 encoded, but my server-side script sends them
> back decoded, along with the dynamic challenge. This is done so that the
> correctness of the first round exchange can be tested at the client side.
> The response to the dynamic challenge is verified at the server side and a
> successful connection indicates that the verification passed.
>
> To do this using your own server, I'll post the script doing the
> client-auth at the server side and the server config later today. In the
> mean time please test this against my server.
>
> Selva
>
>
>
>

--94eb2c0a879a94bba1053a3e07dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Following up on the previous mail, =
the server side script for client=C2=A0</div><div>authentication and the se=
rver/client configs that I use for testing</div><div>challenge-response aut=
h are uploaded here:</div><div><br></div><div><a href=3D"https://gist.githu=
b.com/selvanair/b31ec6d5873e2ffc141ec680fca69254" target=3D"_blank">https:/=
/gist.github.com/<wbr>selvanair/<wbr>b31ec6d5873e2ffc141ec680fca692<wbr>54<=
/a><br></div><div><br></div><div>On the server-side the script should be ru=
nning in parallel with the=C2=A0</div><div>server (run from the same direct=
ory) for management-client-auth to work.</div><div>No attempt is made to sa=
nitize user input etc. so its useful only for=C2=A0<br></div><div>testing p=
urposes.</div><div><br></div><div>The --remote option in the client config =
should be edited to match the=C2=A0</div><div>server.</div><div><br></div><=
div>Selva</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Aug 16, 2016 at 2:21 PM, Selva Nair <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi,=
<div><br></div><div>As discussed in the IRC meeting, here is a client confi=
g that connects to a test server I run for static and dynamic challenge. Ju=
st run it as</div><div><br></div><div>sudo openvpn --config cr-client.conf<=
/div><div><br></div><div>Respond with some arbitrary strings at the usernam=
e, =C2=A0password and static-challenge prompts and the server will send bac=
k the strings you typed plus a dynamic challenge question. The connection w=
ill succeed after the server verifies the response to the dynamic challenge=
. There may be a 5 seconds restart pause between the two exchanges.=C2=A0</=
div><div><br></div><div>Note that the password and static-challenge respons=
e are sent by the client to the server base64 encoded, but my server-side s=
cript sends them back decoded, along with the dynamic challenge. This is do=
ne so that the correctness of the first round exchange can be tested at the=
 client side. The response to the dynamic challenge is verified at the serv=
er side and a successful connection indicates that the verification passed.=
</div><div><br></div><div>To do this using your own server, I&#39;ll post t=
he script doing the client-auth at the server side and the server config la=
ter today. In the mean time please test this against my server.</div><span =
class=3D"HOEnZb"><font color=3D"#888888"><div><br></div><div>Selva</div><di=
v><br></div><div><br></div><div><br></div></font></span></div>
</blockquote></div><br></div>

--94eb2c0a879a94bba1053a3e07dc--

