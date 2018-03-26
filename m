Date: Mon, 26 Mar 2018 16:36:44 +0000 (UTC)
From: Ning Wei <xiaoningning@...109...>
Message-ID: <2645433.792870.1522082204205@...2084...>
In-Reply-To: <CAKuzo_jpgG8V-Y5ikxW1uwGNvoQoTJeCca=Wosg9UC_dPGJj6Q@...278...>
References: <20180316164059.9120-1-xiaoningning@...109...>
 <CAKuzo_h9=+BeTmg5t=H9nUQbqqi8r4DFd7oPrSBOSArQepj3_w@...278...>
 <1783935013.3421880.1521493221569@...2084...>
 <CAKuzo_jpgG8V-Y5ikxW1uwGNvoQoTJeCca=Wosg9UC_dPGJj6Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_792869_301385780.1522082204203"
Subject: Re: [Openvpn-devel] [PATCH] Increase TLS Control Channel Buffer Size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

------=_Part_792869_301385780.1522082204203
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Both of key_method_2_write and key_method_2_read take TLS_Channel_Bug_Size=
 as buffer size.=C2=A0 The current size, 2048 is not enough to read/write a=
 long password response.=C2=A0 I have notice the management interface has a=
 much smaller than 2048 buffer size to read/write.=C2=A0 Currently, if the =
management interface is not used, increasing tls channel buffer size will s=
erve the need.
As token provider, the size of token can be bigger or smaller.=C2=A0 Someti=
me, it has more than 1600 as a token.=C2=A0 To accommodate that, a bigger b=
uffer size will be needed.
ThanksNing
    On Monday, March 19, 2018, 10:11:25 PM PDT, Selva Nair <selva.nair@...1665...=
77...> wrote:=20=20
=20
 Hi,

On Mon, Mar 19, 2018 at 5:00 PM, Ning Wei <xiaoningning@...109...> wrote:
> Sorry, I did not state the intent clearly in the request.
>
> We wanted to use password field to pass authentication string, such as To=
ken
> string,
> which can be long, the user auth plug in on the sever side can validate t=
he
> token as
> the part authentication step.
>
> Acquiring a token, such as JWT, usually involves user interaction with the
> token broker
> service provider.=C2=A0 So it is better to do this on the client side.

Its hard for me to imagine what authentication would need to pass more
than ~1600 bytes=C2=A0 (that's about the current limit based on the 2048
byte buffer).
Unless you are trying to fit in data unrelated to auth in the token. The U2F
registration case I mentioned earlier would be such an example.

How large is the data you need to transfer? If its not purely
authentication data
(i.e., a challenge string + signature at most), sending it as password is n=
ot
the right approach. If there is extra text included for convenience,
pre-compressing
may help.

How do you plan to pass the "password" to openvpn client -- from stdin? The
management i/f will not let you pass such a long password or username.

>
> I agreed on the following statement.=C2=A0 To support a long password fie=
ld in
> TLS channels,
> the Buf size of 4096 is not enough in key_method_2_write.=C2=A0 Should we=
 propose
> to
> increase the buffer size further?

Increasing to 4096 looks marginally useful to me and will fit a reasonably =
sized
user name (say < 128 bytes) and a largish challenge-response (upto ~3400 by=
tes)
leaving space for other things. Beyond that is unlikely to be necessary.

I mentioned the overhead in key_method_2_write only because your logic
behind this increase didn't make sense to me.

>
> "Further, even a TLS_CHANNEL_BUF_SIZE of 4096 does not support a
> password that long as there are other things like username, key-source,
> local-options that have to fit into the buffer (see key_method_2_write). =
So
> what's the logic behind 4096?"
>
> Regards,
> Ning
> On Friday, March 16, 2018, 10:30:45 AM PDT, Selva Nair
> <selva.nair@...277...> wrote:
>
>
> Hi,
>
> Apologies in advance if I'm misreading the intent of this patch.
>
> On Fri, Mar 16, 2018 at 12:40 PM, Ning Wei via Openvpn-devel
> <openvpn-devel@lists.sourceforge.net> wrote:
>> Increase TLS_CHANNEL_BUF_SIZE to 4096. When the build is enabled with
>> ENABLE_PKCS11, the password field can be 4096.=C2=A0 The old size of
>> TLS_CHANNEL_BUF_SIZE was 2048, which is not enough.
>
> I do not follow the logic behind this. Sure, ENABLE_PKCS11 increases the
> password buffer size to 4096, but pkcs11 password is only consumed
> locally, not sent out to the remote.
>
> Now, even if a auth-user-pass password or challenge response gets as
> large as 4096 bytes, there are other places in the code that
> need "fixing" to permit such long "passwords" (or response) -- e.g., it
> cannot
> be submitted via the management as the parser expects a max line
> length of 255 and word length of 255.
>
> Further, even a TLS_CHANNEL_BUF_SIZE of 4096 does not support a
> password that long as there are other things like username, key-source,
> local-options that have to fit into the buffer (see key_method_2_write). =
So
> what's the logic behind 4096?
>
> Finally, are there any particular challenge-response framework that requi=
res
> such long responses? Even for U2F, we wouldn't need to send a response
> that large. U2F registration response could get very long (still mostly
> under
> 2000 bytes), but doing U2F key registration via the authentication channel
> is
> not a good implementation. Authentication responses are much smaller.
>
> In short, it looks premature to increase this value before we start
> supporting long responses via the management, and a real practical
> need for long challenge response strings that won't fit in the current
> 2048 bytes (minus overhead) arise.
>
> Selva

Selva
=20=20=

------=_Part_792869_301385780.1522082204203
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:Helvetica Neue, Helvetic=
a, Arial, sans-serif;font-size:13px;"><div></div>
            <div>Both of key_method_2_write and key_method_2_read take TLS_=
Channel_Bug_Size as buffer size.&nbsp; The current size, 2048 is not enough=
 to read/write a long password response.&nbsp; I have notice the management=
 interface has a much smaller than 2048 buffer size to read/write.&nbsp; Cu=
rrently, if the management interface is not used, increasing tls channel bu=
ffer size will serve the need.</div><div><br></div><div>As token provider, =
the size of token can be bigger or smaller.&nbsp; Sometime, it has more tha=
n 1600 as a token.&nbsp; To accommodate that, a bigger buffer size will be =
needed.</div><div><br></div><div>Thanks</div><div>Ning</div><div><br></div>
=20=20=20=20=20=20=20=20=20=20=20=20
            <div id=3D"yahoo_quoted_2420554380" class=3D"yahoo_quoted">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                    <div>
                        On Monday, March 19, 2018, 10:11:25 PM PDT, Selva N=
air &lt;selva.nair@...277...&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div><div dir=3D"ltr">Hi,<br clear=3D"none"><br clear=
=3D"none">On Mon, Mar 19, 2018 at 5:00 PM, Ning Wei &lt;<a shape=3D"rect" y=
mailto=3D"mailto:xiaoningning@...109..." href=3D"mailto:xiaoningning@...2386...=
...">xiaoningning@...109...</a>&gt; wrote:<br clear=3D"none">&gt; Sorry, I =
did not state the intent clearly in the request.<br clear=3D"none">&gt;<br =
clear=3D"none">&gt; We wanted to use password field to pass authentication =
string, such as Token<br clear=3D"none">&gt; string,<br clear=3D"none">&gt;=
 which can be long, the user auth plug in on the sever side can validate th=
e<br clear=3D"none">&gt; token as<br clear=3D"none">&gt; the part authentic=
ation step.<br clear=3D"none">&gt;<br clear=3D"none">&gt; Acquiring a token=
, such as JWT, usually involves user interaction with the<br clear=3D"none"=
>&gt; token broker<br clear=3D"none">&gt; service provider.&nbsp; So it is =
better to do this on the client side.<br clear=3D"none"><br clear=3D"none">=
Its hard for me to imagine what authentication would need to pass more<br c=
lear=3D"none">than ~1600 bytes&nbsp; (that's about the current limit based =
on the 2048<br clear=3D"none">byte buffer).<br clear=3D"none">Unless you ar=
e trying to fit in data unrelated to auth in the token. The U2F<br clear=3D=
"none">registration case I mentioned earlier would be such an example.<br c=
lear=3D"none"><br clear=3D"none">How large is the data you need to transfer=
? If its not purely<br clear=3D"none">authentication data<br clear=3D"none"=
>(i.e., a challenge string + signature at most), sending it as password is =
not<br clear=3D"none">the right approach. If there is extra text included f=
or convenience,<br clear=3D"none">pre-compressing<br clear=3D"none">may hel=
p.<br clear=3D"none"><br clear=3D"none">How do you plan to pass the "passwo=
rd" to openvpn client -- from stdin? The<br clear=3D"none">management i/f w=
ill not let you pass such a long password or username.<br clear=3D"none"><b=
r clear=3D"none">&gt;<br clear=3D"none">&gt; I agreed on the following stat=
ement.&nbsp; To support a long password field in<br clear=3D"none">&gt; TLS=
 channels,<br clear=3D"none">&gt; the Buf size of 4096 is not enough in key=
_method_2_write.&nbsp; Should we propose<br clear=3D"none">&gt; to<br clear=
=3D"none">&gt; increase the buffer size further?<br clear=3D"none"><br clea=
r=3D"none">Increasing to 4096 looks marginally useful to me and will fit a =
reasonably sized<br clear=3D"none">user name (say &lt; 128 bytes) and a lar=
gish challenge-response (upto ~3400 bytes)<br clear=3D"none">leaving space =
for other things. Beyond that is unlikely to be necessary.<br clear=3D"none=
"><br clear=3D"none">I mentioned the overhead in key_method_2_write only be=
cause your logic<br clear=3D"none">behind this increase didn't make sense t=
o me.<div class=3D"yqt2558482608" id=3D"yqtfd33968"><br clear=3D"none"><br =
clear=3D"none">&gt;<br clear=3D"none">&gt; "Further, even a TLS_CHANNEL_BUF=
_SIZE of 4096 does not support a<br clear=3D"none">&gt; password that long =
as there are other things like username, key-source,<br clear=3D"none">&gt;=
 local-options that have to fit into the buffer (see key_method_2_write). S=
o<br clear=3D"none">&gt; what's the logic behind 4096?"<br clear=3D"none">&=
gt;<br clear=3D"none">&gt; Regards,<br clear=3D"none">&gt; Ning<br clear=3D=
"none">&gt; On Friday, March 16, 2018, 10:30:45 AM PDT, Selva Nair<br clear=
=3D"none">&gt; &lt;<a shape=3D"rect" ymailto=3D"mailto:selva.nair@...277...=
" href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt; wrote:<=
br clear=3D"none">&gt;<br clear=3D"none">&gt;<br clear=3D"none">&gt; Hi,<br=
 clear=3D"none">&gt;<br clear=3D"none">&gt; Apologies in advance if I'm mis=
reading the intent of this patch.<br clear=3D"none">&gt;<br clear=3D"none">=
&gt; On Fri, Mar 16, 2018 at 12:40 PM, Ning Wei via Openvpn-devel<br clear=
=3D"none">&gt; &lt;<a shape=3D"rect" ymailto=3D"mailto:openvpn-devel@...1199...=
sourceforge.net" href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvp=
n-devel@lists.sourceforge.net</a>&gt; wrote:<br clear=3D"none">&gt;&gt; Inc=
rease TLS_CHANNEL_BUF_SIZE to 4096. When the build is enabled with<br clear=
=3D"none">&gt;&gt; ENABLE_PKCS11, the password field can be 4096.&nbsp; The=
 old size of<br clear=3D"none">&gt;&gt; TLS_CHANNEL_BUF_SIZE was 2048, whic=
h is not enough.<br clear=3D"none">&gt;<br clear=3D"none">&gt; I do not fol=
low the logic behind this. Sure, ENABLE_PKCS11 increases the<br clear=3D"no=
ne">&gt; password buffer size to 4096, but pkcs11 password is only consumed=
<br clear=3D"none">&gt; locally, not sent out to the remote.<br clear=3D"no=
ne">&gt;<br clear=3D"none">&gt; Now, even if a auth-user-pass password or c=
hallenge response gets as<br clear=3D"none">&gt; large as 4096 bytes, there=
 are other places in the code that<br clear=3D"none">&gt; need "fixing" to =
permit such long "passwords" (or response) -- e.g., it<br clear=3D"none">&g=
t; cannot<br clear=3D"none">&gt; be submitted via the management as the par=
ser expects a max line<br clear=3D"none">&gt; length of 255 and word length=
 of 255.<br clear=3D"none">&gt;<br clear=3D"none">&gt; Further, even a TLS_=
CHANNEL_BUF_SIZE of 4096 does not support a<br clear=3D"none">&gt; password=
 that long as there are other things like username, key-source,<br clear=3D=
"none">&gt; local-options that have to fit into the buffer (see key_method_=
2_write). So<br clear=3D"none">&gt; what's the logic behind 4096?<br clear=
=3D"none">&gt;<br clear=3D"none">&gt; Finally, are there any particular cha=
llenge-response framework that requires<br clear=3D"none">&gt; such long re=
sponses? Even for U2F, we wouldn't need to send a response<br clear=3D"none=
">&gt; that large. U2F registration response could get very long (still mos=
tly<br clear=3D"none">&gt; under<br clear=3D"none">&gt; 2000 bytes), but do=
ing U2F key registration via the authentication channel<br clear=3D"none">&=
gt; is<br clear=3D"none">&gt; not a good implementation. Authentication res=
ponses are much smaller.<br clear=3D"none">&gt;<br clear=3D"none">&gt; In s=
hort, it looks premature to increase this value before we start<br clear=3D=
"none">&gt; supporting long responses via the management, and a real practi=
cal<br clear=3D"none">&gt; need for long challenge response strings that wo=
n't fit in the current<br clear=3D"none">&gt; 2048 bytes (minus overhead) a=
rise.<br clear=3D"none">&gt;<br clear=3D"none">&gt; Selva<br clear=3D"none"=
><br clear=3D"none">Selva<br clear=3D"none"></div></div></div>
                </div>
            </div></div></body></html>=

------=_Part_792869_301385780.1522082204203--

