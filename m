MIME-Version: 1.0
References: <20201220105430.GP976@...1296...>
 <093511bd-43c0-a37c-1d8f-335d9df451d6@...1227...>
 <20201220185402.GQ976@...1296...>
 <CAKuzo_ja=a9XxHkQX5Vv2_UTT1vWNfO8S-XLvvKZ_CQ6f-U1uQ@...278...>
 <20201221070420.GW976@...1296...>
 <CAKuzo_gMh+ZJ0YovjkUdyHzDO8cLsM_2Djsk_Hrx6N3AZMPw7w@...278...>
 <65cbacc6-0c9f-4c46-04aa-6e707c7d5efd@...1147...>
In-Reply-To: <65cbacc6-0c9f-4c46-04aa-6e707c7d5efd@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 25 Dec 2020 12:08:16 -0500
Message-ID: <CAKuzo_ga6XVniU7gCBka4nGBV5kMD5AfUc6FcRPDoFWnyhN=kQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000596de205b74cf942"
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000596de205b74cf942
Content-Type: text/plain; charset="UTF-8"

Hi,

Merry Christmas!

On Wed, Dec 23, 2020 at 6:15 AM Jan Just Keijser <janjust@...1147...> wrote:

> On 21/12/20 18:22, Selva Nair wrote:
>
>
>
> On Mon, Dec 21, 2020 at 2:04 AM Gert Doering <gert@...1296...> wrote:
>
>> Hi,
>>
>> On Sun, Dec 20, 2020 at 07:31:42PM -0500, Selva Nair wrote:
>> > I thought we already went through this when we discussed the proposed
>> "echo
>> > msg" in considerable detail 3 years ago.
>>
>> Yeah, sorry.  Seems I got distracted and forgot all about the discussed
>> "solution space", and just remembered the itch.
>>
>> I'm sure the thread is still sitting in my mailbox... will go looking for
>> it today.
>>
>
> For those who have lost the original threads:
>
>
> https://sourceforge.net/p/openvpn/mailman/openvpn-users/thread/CAEsd45T%2Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8yFtY45Qyh%2BtHjkg%40mail.gmail.com/#msg36136236
>
>
> https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA%40mail.gmail.com/#msg36141193
>
> That was in Nov-Dec 2017. Actually, I was also thinking of reviving this
> only the other day when intimating users about some updates came up..
> Somehow such itches re-surface at the end of the year :)
>
> sorry to chip on so late, but at some point we did have a way to push env
> vars to the client (back in v2.2 at least):
>
> inside a client-connect script you can/could do
>
> echo "push \"setenv-safe MSG1 'hello'\"" > $1
> echo "push \"setenv-safe MSG2 'download version 2.5 please'\"" >> $1
>

setenv-safe is not passed on to the UI/GUI, so not very useful for sending
messages to the user. In fact we already use echo to send env variables to
the UI -- OpenVPN-GUI interprets
push "echo setenv foo bar" and passes it in the env to scripts run by the
GUI.
See https://github.com/OpenVPN/openvpn-gui/pull/200
In one of our setups we use it to pass file server names, SMB shares to map
etc.

Among options that already exist, "echo" is the best candidate for this
purpose, and it's designed for sending "commands" (which could be messages)
from server to client side UI. It's use only requires an agreement on the
syntax so that all UI authors can code to interpret them consistently.

I find it hard to imagine why everyone seems to be avoiding "echo" and
trying to find alternatives.

Selva

--000000000000596de205b74cf942
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Merry Christmas!</div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, =
Dec 23, 2020 at 6:15 AM Jan Just Keijser &lt;<a href=3D"mailto:janjust@...1386...=
147..." target=3D"_blank">janjust@...1147...</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
=20=20
=20=20=20=20
=20=20
  <div bgcolor=3D"#FFFFFF">
    <div>On 21/12/20 18:22, Selva Nair wrote:<br>
    </div>
    <blockquote type=3D"cite">
=20=20=20=20=20=20
      <div dir=3D"ltr">
        <div dir=3D"ltr"><br>
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 21, 2020 at 2:04
            AM Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
            <br>
            On Sun, Dec 20, 2020 at 07:31:42PM -0500, Selva Nair wrote:<br>
            &gt; I thought we already went through this when we
            discussed the proposed &quot;echo<br>
            &gt; msg&quot; in considerable detail 3 years ago.<br>
            <br>
            Yeah, sorry.=C2=A0 Seems I got distracted and forgot all about
            the discussed<br>
            &quot;solution space&quot;, and just remembered the itch.<br>
            <br>
            I&#39;m sure the thread is still sitting in my mailbox... will
            go looking for<br>
            it today.<br>
          </blockquote>
          <div><br>
          </div>
          <div>For those who have lost the original threads:</div>
          <div><br>
          </div>
          <div><a href=3D"https://sourceforge.net/p/openvpn/mailman/openvpn=
-users/thread/CAEsd45T%2Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8yFtY45Qyh%2BtHjkg%40mai=
l.gmail.com/#msg36136236" target=3D"_blank">https://sourceforge.net/p/openv=
pn/mailman/openvpn-users/thread/CAEsd45T%2Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8yFtY4=
5Qyh%2BtHjkg%40mail.gmail.com/#msg36136236</a></div>
          <div><br>
          </div>
          <div><a href=3D"https://sourceforge.net/p/openvpn/mailman/openvpn=
-devel/thread/CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA%40mail.gm=
ail.com/#msg36141193" target=3D"_blank">https://sourceforge.net/p/openvpn/m=
ailman/openvpn-devel/thread/CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2=
WRqA%40mail.gmail.com/#msg36141193</a></div>
          <div><br>
          </div>
          <div>That was in Nov-Dec 2017. Actually, I was also thinking
            of reviving this only the=C2=A0other day when intimating users
            about some updates came=C2=A0up.. Somehow such itches re-surface
            at the end of the year :)</div>
          <br>
        </div>
      </div>
    </blockquote>
    sorry to chip on so late, but at some point we did have a way to
    push env vars to the client (back in v2.2 at least):<br>
    <br>
    inside a client-connect script you can/could do<br>
    <br>
    echo &quot;push \&quot;setenv-safe MSG1 &#39;hello&#39;\&quot;&quot; &g=
t; $1<br>
    echo &quot;push \&quot;setenv-safe MSG2 &#39;download version 2.5 pleas=
e&#39;\&quot;&quot;
    &gt;&gt; $1<br></div></blockquote><div><br></div><div>setenv-safe is no=
t passed on to the UI/GUI, so not very useful for sending messages to the u=
ser. In fact we already use echo to send env variables to the UI -- OpenVPN=
-GUI interprets</div><div>push &quot;echo setenv foo bar&quot; and passes i=
t in the env to scripts run by the GUI.</div><div>See <a href=3D"https://gi=
thub.com/OpenVPN/openvpn-gui/pull/200" target=3D"_blank">https://github.com=
/OpenVPN/openvpn-gui/pull/200</a><br></div><div>In one of our setups we use=
 it to pass file server names, SMB shares to map etc.</div><div><br></div><=
div>Among options that already=C2=A0exist, &quot;echo&quot; is the best can=
didate for this purpose, and it&#39;s designed for sending &quot;commands&q=
uot; (which could be messages) from server to client side UI. It&#39;s=C2=
=A0use only requires an agreement on the syntax so that all UI authors can =
code to interpret them consistently.=C2=A0</div><div><br></div><div>I find =
it hard to imagine why everyone seems to be=C2=A0avoiding &quot;echo&quot; =
and trying to find alternatives.</div><div><br></div><div>Selva<br></div></=
div></div>

--000000000000596de205b74cf942--

