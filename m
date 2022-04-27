MIME-Version: 1.0
References: <20220427074828.6283-1-kprovost@...2661...>
 <20220427074828.6283-2-kprovost@...2661...>
 <761e5640-6d43-d25b-4845-25698d2e0688@...2181...>
 <CAGyAFMXA0YdQtOFUJ0ShANVJeZ9gLv1Y4DB0_xN7E6-_d4Va3A@...278...>
 <CAGyAFMV7=m0kJ7kG3NKEp4oBEHTdYdGWCRUAJs9hZ8dh+2Wbeg@...278...>
In-Reply-To: <CAGyAFMV7=m0kJ7kG3NKEp4oBEHTdYdGWCRUAJs9hZ8dh+2Wbeg@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 27 Apr 2022 16:24:39 +0300
Message-ID: <CAGyAFMXYy+9POqU43wP5-mJj-app6C+Kb2zy7unpgwr+1p41ag@...278...>
Content-Type: multipart/alternative; boundary="000000000000ec0c0e05dda2bb7a"
Subject: Re: [Openvpn-devel] [PATCH] Handle (DCO) timeouts in client mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--000000000000ec0c0e05dda2bb7a
Content-Type: text/plain; charset="UTF-8"

And of course I forgot non-dco dummy implementation (which we don't call
yet, because on Windows dco is always defined)

https://github.com/lstipakov/openvpn/commit/f223bef8449f15ff5de06acdfee16088b855c47a

ke 27. huhtik. 2022 klo 16.18 Lev Stipakov (lstipakov@...277...) kirjoitti:

> How about we'll add dco_check_timeout(int, context) to dco.h with platform
> specific implementations?
>
> Here is what I just did for Windows (Linux part is no-nop):
> https://github.com/lstipakov/openvpn/commit/ce242896c621273578a446c5194d5ca6aee04237
>
> ke 27. huhtik. 2022 klo 15.32 Lev Stipakov (lstipakov@...277...)
> kirjoitti:
>
>> Hi,
>>
>> @Lev, just a heads up: does dco-win deal with this case? It would be
>>> good to have a look on your side too.
>>>
>>
>> Good point - this functionality (dco keepalive timeout) works in openvpn3
>> but not in openvpn2.
>>
>> dco-win notifies userspace about keepalive timeout by returning certain
>> error code (STATUS_CONNECTION_DISCONNECTED in kernel
>> which translates to GetLastError 64 ERROR_NETNAME_DELETED, don't ask me
>> why) in response to read request, so we should catch it
>> inside read_incoming_link() after link_socket_read() call. Will do.
>>
>> --
>> -Lev
>>
>
>
> --
> -Lev
>


-- 
-Lev

--000000000000ec0c0e05dda2bb7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">And of course I forgot non-dco dummy implementation (which=
 we don&#39;t call yet, because on Windows dco is always defined)<div><br><=
/div><div><a href=3D"https://github.com/lstipakov/openvpn/commit/f223bef844=
9f15ff5de06acdfee16088b855c47a">https://github.com/lstipakov/openvpn/commit=
/f223bef8449f15ff5de06acdfee16088b855c47a</a><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">ke 27. huhtik. 2022 =
klo 16.18 Lev Stipakov (<a href=3D"mailto:lstipakov@...277...">lstipakov@...1186...=
.277...</a>) kirjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr">How about we&#39;ll add dco_check_timeout(int, con=
text) to dco.h with platform specific implementations?<div><br></div><div>H=
ere is what=C2=A0I just did for Windows (Linux part is no-nop):=C2=A0<a hre=
f=3D"https://github.com/lstipakov/openvpn/commit/ce242896c621273578a446c519=
4d5ca6aee04237" target=3D"_blank">https://github.com/lstipakov/openvpn/comm=
it/ce242896c621273578a446c5194d5ca6aee04237</a></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">ke 27. huhtik. 2022 =
klo 15.32 Lev Stipakov (<a href=3D"mailto:lstipakov@...277..." target=3D"_b=
lank">lstipakov@...277...</a>) kirjoitti:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div d=
ir=3D"ltr"><br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
@Lev, just a heads up: does dco-win deal with this case? It would be <br>
good to have a look on your side too.<br></blockquote><div><br></div><div>G=
ood point - this functionality (dco keepalive timeout) works in openvpn3 bu=
t not in openvpn2.</div><div><br></div><div>dco-win notifies userspace abou=
t keepalive timeout by returning certain error code (STATUS_CONNECTION_DISC=
ONNECTED in kernel</div><div>which translates to GetLastError 64 ERROR_NETN=
AME_DELETED, don&#39;t ask me why) in response to read request, so we shoul=
d catch it</div><div>inside read_incoming_link() after link_socket_read() c=
all. Will do.</div><div><br></div></div>-- <br><div dir=3D"ltr">-Lev</div><=
/div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>-Lev</div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000ec0c0e05dda2bb7a--

