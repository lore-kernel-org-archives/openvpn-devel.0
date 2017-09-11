MIME-Version: 1.0
In-Reply-To: <cf0cbe5b-238c-8790-5be1-3cb693ac4148@...1147...>
References: <CAFHpkQGG9x_kYP6bthSxgB+1Y38r45ffD1WCnaA+Jp4Ed8PbQw@...278...>
 <cf0cbe5b-238c-8790-5be1-3cb693ac4148@...1147...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 11 Sep 2017 16:54:03 +0500
Message-ID: <CAFHpkQGu93WJEhFMyA1y4RFdL9bJJijdMrQWOMdHt+DU1iVO-g@...278...>
Content-Type: multipart/alternative; boundary="001a113ec75a55088a0558e895d9"
Subject: Re: [Openvpn-devel] proper configuring of "tls-verify"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113ec75a55088a0558e895d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-09-11 16:45 GMT+05:00 Jan Just Keijser <janjust@...1147...>:

> Hi,
>
> On 11/09/17 13:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>
>> Hello,
>>
>> is someone actually using "tls-verify" in production ?
>> we tried to implement additional certificate check using tls-verify
>>
>>
>> while it works in general, in case when it hits "exit 1", it look like a
>> timeout from client point of view. it is not any good
>>
>
> do you mean that when a client is denied access (i.e. the tls-verify
> script exits 1 on the server) that the client sees this as a timeout?  th=
at
> is "normal" behaviour, as the server does not tell the client *WHY* access
> is refused - it simply stop responding to a client that does not pass
> authentication/authorization. The client will not hear from the server, a=
nd
> will time out after a specified interval.  This is actually the most secu=
re
> way to do things, as a rogue client cannot DoS a server this way.
>

I'd say it depends.

we run a lot of openvpn-gui with real people sitting in front of them, from
their point of view it "oh, it does not work! fix it!"
in out case better UX is to deliver proper reason to the client

for someone maybe the better UX is to keep silence


while I think "exit 1" will not be the most common case (it is rather an
exception), we'd like to deliver better UX to people



>
> HTH,
>
> JJK
>
>

--001a113ec75a55088a0558e895d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-09-11 16:45 GMT+05:00 Jan Just Keijser <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">Hi,<span class=3D""><br>
<br>
On 11/09/17 13:22, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello,<br>
<br>
is someone actually using &quot;tls-verify&quot; in production ?<br>
we tried to implement additional certificate check using tls-verify<br>
<br>
<br>
while it works in general, in case when it hits &quot;exit 1&quot;, it look=
 like a timeout from client point of view. it is not any good<br>
</blockquote>
<br></span>
do you mean that when a client is denied access (i.e. the tls-verify script=
 exits 1 on the server) that the client sees this as a timeout?=C2=A0 that =
is &quot;normal&quot; behaviour, as the server does not tell the client *WH=
Y* access is refused - it simply stop responding to a client that does not =
pass authentication/authorization. The client will not hear from the server=
, and will time out after a specified interval.=C2=A0 This is actually the =
most secure way to do things, as a rogue client cannot DoS a server this wa=
y.<br></blockquote><div><br></div><div>I&#39;d say it depends.<br><br></div=
><div>we run a lot of openvpn-gui with real people sitting in front of them=
, from their point of view it &quot;oh, it does not work! fix it!&quot;<br>=
</div><div>in out case better UX is to deliver proper reason to the client<=
br><br></div><div>for someone maybe the better UX is to keep silence <br><b=
r><br></div><div>while I think &quot;exit 1&quot; will not be the most comm=
on case (it is rather an exception), we&#39;d like to deliver better UX to =
people<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
HTH,<br>
<br>
JJK<br>
<br>
</blockquote></div><br></div></div>

--001a113ec75a55088a0558e895d9--

