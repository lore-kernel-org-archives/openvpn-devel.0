MIME-Version: 1.0
In-Reply-To: <57B453A0.6000904@...1147...>
References: <CAKuzo_jc_mm2165qwc5ACLQCP6kqocRxfaMO9crJzu3HMxJ_og@...278...>
	<57B453A0.6000904@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 17 Aug 2016 10:12:35 -0400
Message-ID: <CAKuzo_jBe7OwQx_8sKepiO-6aTxDepZ4UmCkpenCss2-O7JK8A@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05602ecb5c8d053a450f7f
Subject: Re: [Openvpn-devel] testing challenge-response
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05602ecb5c8d053a450f7f
Content-Type: text/plain; charset=UTF-8

Hi JJK,

On Wed, Aug 17, 2016 at 8:08 AM, Jan Just Keijser <janjust@...1147...> wrote:

> Hi Selva,
>
> Selva Nair wrote:
>
>> Hi,
>>
>> As discussed in the IRC meeting, here is a client config that connects to
>> a test server I run for static and dynamic challenge. Just run it as
>>
>> sudo openvpn --config cr-client.conf
>>
>> Respond with some arbitrary strings at the username,  password and
>> static-challenge prompts and the server will send back the strings you
>> typed plus a dynamic challenge question. The connection will succeed after
>> the server verifies the response to the dynamic challenge. There may be a 5
>> seconds restart pause between the two exchanges.
>> Note that the password and static-challenge response are sent by the
>> client to the server base64 encoded, but my server-side script sends them
>> back decoded, along with the dynamic challenge. This is done so that the
>> correctness of the first round exchange can be tested at the client side.
>> The response to the dynamic challenge is verified at the server side and a
>> successful connection indicates that the verification passed.
>>
>> To do this using your own server, I'll post the script doing the
>> client-auth at the server side and the server config later today. In the
>> mean time please test this against my server.
>>
>
> thanks for your config files! I've just tested this against your server,
> and got a successful login on the second attempt. The challenge
>  please answer this : 1+1 =
> failed with a message:
>  Wrong answer to dynamic response or invalid format (2.000 23.000)
>

The client-auth script got 23 instead of the expected 2. Logs show
received from mgmt: 'CRV1::2::23M'
That 23M should have been what you typed (i.e., 2); not sure what went
wrong...

>
> but the second challenge worked fine. Next, I'll play with your server
> config.
>

Thanks,

Selva

--94eb2c05602ecb5c8d053a450f7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi JJK,</div><div class=3D"gmai=
l_extra"><br><div class=3D"gmail_quote">On Wed, Aug 17, 2016 at 8:08 AM, Ja=
n Just Keijser <span dir=3D"ltr">&lt;<a href=3D"mailto:janjust@...1147..." =
target=3D"_blank">janjust@...1147...</a>&gt;</span> wrote:<br><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1p=
x;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1=
ex"><div>Hi Selva,<span><br>
<br>
Selva Nair wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Hi,<br>
<br>
As discussed in the IRC meeting, here is a client config that connects to a=
 test server I run for static and dynamic challenge. Just run it as<br>
<br>
sudo openvpn --config cr-client.conf<br>
<br>
Respond with some arbitrary strings at the username,=C2=A0 password and sta=
tic-challenge prompts and the server will send back the strings you typed p=
lus a dynamic challenge question. The connection will succeed after the ser=
ver verifies the response to the dynamic challenge. There may be a 5 second=
s restart pause between the two exchanges. <br>
Note that the password and static-challenge response are sent by the client=
 to the server base64 encoded, but my server-side script sends them back de=
coded, along with the dynamic challenge. This is done so that the correctne=
ss of the first round exchange can be tested at the client side. The respon=
se to the dynamic challenge is verified at the server side and a successful=
 connection indicates that the verification passed.<br>
<br>
To do this using your own server, I&#39;ll post the script doing the client=
-auth at the server side and the server config later today. In the mean tim=
e please test this against my server.<br>
</blockquote>
<br></span>
thanks for your config files! I&#39;ve just tested this against your server=
, and got a successful login on the second attempt. The challenge<br>
=C2=A0please answer this : 1+1 =3D<br>
failed with a message:<br>
=C2=A0Wrong answer to dynamic response or invalid format (2.000 23.000)<br>=
</div></blockquote><div><br></div><div>The client-auth script got 23 instea=
d of the expected 2. Logs show</div><div>received from mgmt: &#39;CRV1::2::=
23M&#39;</div><div>That 23M should have been what you typed (i.e., 2); not =
sure what went wrong...</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,2=
04);border-left-style:solid;padding-left:1ex"><div>
<br>
but the second challenge worked fine. Next, I&#39;ll play with your server =
config.<br></div></blockquote><div><br></div><div>Thanks,</div><div><br></d=
iv><div>Selva</div></div><div class=3D"gmail_extra"><br></div><br></div></d=
iv>

--94eb2c05602ecb5c8d053a450f7f--

