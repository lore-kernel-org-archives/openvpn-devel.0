Date: Mon, 19 Mar 2018 21:00:21 +0000 (UTC)
From: Ning Wei <xiaoningning@...109...>
Message-ID: <1783935013.3421880.1521493221569@...2084...>
In-Reply-To: <CAKuzo_h9=+BeTmg5t=H9nUQbqqi8r4DFd7oPrSBOSArQepj3_w@...278...>
References: <20180316164059.9120-1-xiaoningning@...109...>
 <CAKuzo_h9=+BeTmg5t=H9nUQbqqi8r4DFd7oPrSBOSArQepj3_w@...278...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_3421878_981046224.1521493221566"
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

------=_Part_3421878_981046224.1521493221566
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Sorry, I did not state the intent clearly in the request.
We wanted to use password field to pass authentication string, such as Toke=
n string,which can be long, the user auth plug in on the sever side can val=
idate the token asthe part authentication step.
Acquiring a token, such as JWT, usually involves user interaction with the =
token brokerservice provider.=C2=A0 So it is better to do this on the clien=
t side.
I agreed on the following statement.=C2=A0 To support a long password field=
 in TLS channels,the Buf size of 4096 is not enough in=C2=A0key_method_2_wr=
ite.=C2=A0 Should we propose to
increase the buffer size further?
"Further, even a TLS_CHANNEL_BUF_SIZE of 4096 does not support a
password that long as there are other things like username, key-source,
local-options that have to fit into the buffer (see key_method_2_write). So
what's the logic behind 4096?"
Regards,Ning    On Friday, March 16, 2018, 10:30:45 AM PDT, Selva Nair <sel=
va.nair@...277...> wrote:=20=20
=20
 Hi,

Apologies in advance if I'm misreading the intent of this patch.

On Fri, Mar 16, 2018 at 12:40 PM, Ning Wei via Openvpn-devel
<openvpn-devel@lists.sourceforge.net> wrote:
> Increase TLS_CHANNEL_BUF_SIZE to 4096. When the build is enabled with
> ENABLE_PKCS11, the password field can be 4096.=C2=A0 The old size of
> TLS_CHANNEL_BUF_SIZE was 2048, which is not enough.

I do not follow the logic behind this. Sure, ENABLE_PKCS11 increases the
password buffer size to 4096, but pkcs11 password is only consumed
locally, not sent out to the remote.

Now, even if a auth-user-pass password or challenge response gets as
large as 4096 bytes, there are other places in the code that
need "fixing" to permit such long "passwords" (or response) -- e.g., it can=
not
be submitted via the management as the parser expects a max line
length of 255 and word length of 255.

Further, even a TLS_CHANNEL_BUF_SIZE of 4096 does not support a
password that long as there are other things like username, key-source,
local-options that have to fit into the buffer (see key_method_2_write). So
what's the logic behind 4096?

Finally, are there any particular challenge-response framework that requires
such long responses? Even for U2F, we wouldn't need to send a response
that large. U2F registration response could get very long (still mostly und=
er
2000 bytes), but doing U2F key registration via the authentication channel =
is
not a good implementation. Authentication responses are much smaller.

In short, it looks premature to increase this value before we start
supporting long responses via the management, and a real practical
need for long challenge response strings that won't fit in the current
2048 bytes (minus overhead) arise.

Selva
=20=20=

------=_Part_3421878_981046224.1521493221566
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:Helvetica Neue, Helvetic=
a, Arial, sans-serif;font-size:13px;"><div></div>
            <div>Sorry, I did not state the intent clearly in the request.<=
/div><div><br></div><div>We wanted to use password field to pass authentica=
tion string, such as Token string,</div><div>which can be long, the user au=
th plug in on the sever side can validate the token as</div><div>the part a=
uthentication step.</div><div><br></div><div>Acquiring a token, such as JWT=
, usually involves user interaction with the token broker</div><div>service=
 provider.&nbsp; So it is better to do this on the client side.</div><div><=
br></div><div>I agreed on the following statement.&nbsp; To support a long =
password field in TLS channels,</div><div>the Buf size of 4096 is not enoug=
h in&nbsp;key_method_2_write.&nbsp; Should we propose to<br></div><div>incr=
ease the buffer size further?</div><div><br></div><div><div dir=3D"ltr" sty=
le=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif=
;">"Further, even a TLS_CHANNEL_BUF_SIZE of 4096 does not support a<br></di=
v><div dir=3D"ltr" style=3D"font-family: &quot;Helvetica Neue&quot;, Helvet=
ica, Arial, sans-serif;">password that long as there are other things like =
username, key-source,<br></div><div dir=3D"ltr" style=3D"font-family: &quot=
;Helvetica Neue&quot;, Helvetica, Arial, sans-serif;">local-options that ha=
ve to fit into the buffer (see key_method_2_write). So<br></div><div dir=3D=
"ltr" style=3D"font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, s=
ans-serif;">what's the logic behind 4096?"</div><br></div><div>Regards,</di=
v><div>Ning</div>
=20=20=20=20=20=20=20=20=20=20=20=20
            <div id=3D"yahoo_quoted_1779238704" class=3D"yahoo_quoted">
                <div style=3D"font-family:'Helvetica Neue', Helvetica, Aria=
l, sans-serif;font-size:13px;color:#26282a;">
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                    <div>
                        On Friday, March 16, 2018, 10:30:45 AM PDT, Selva N=
air &lt;selva.nair@...277...&gt; wrote:
                    </div>
                    <div><br></div>
                    <div><br></div>
                    <div><div dir=3D"ltr">Hi,<br></div><div dir=3D"ltr"><br=
></div><div dir=3D"ltr">Apologies in advance if I'm misreading the intent o=
f this patch.<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">On Fri, =
Mar 16, 2018 at 12:40 PM, Ning Wei via Openvpn-devel<br></div><div dir=3D"l=
tr">&lt;<a ymailto=3D"mailto:openvpn-devel@lists.sourceforge.net" href=3D"m=
ailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...290...=
net</a>&gt; wrote:<br></div><div dir=3D"ltr">&gt; Increase TLS_CHANNEL_BUF_=
SIZE to 4096. When the build is enabled with<br></div><div dir=3D"ltr">&gt;=
 ENABLE_PKCS11, the password field can be 4096.&nbsp; The old size of<br></=
div><div dir=3D"ltr">&gt; TLS_CHANNEL_BUF_SIZE was 2048, which is not enoug=
h.<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">I do not follow the=
 logic behind this. Sure, ENABLE_PKCS11 increases the<br></div><div dir=3D"=
ltr">password buffer size to 4096, but pkcs11 password is only consumed<br>=
</div><div dir=3D"ltr">locally, not sent out to the remote.<br></div><div d=
ir=3D"ltr"><br></div><div dir=3D"ltr">Now, even if a auth-user-pass passwor=
d or challenge response gets as<br></div><div dir=3D"ltr">large as 4096 byt=
es, there are other places in the code that<br></div><div dir=3D"ltr">need =
"fixing" to permit such long "passwords" (or response) -- e.g., it cannot<b=
r></div><div dir=3D"ltr">be submitted via the management as the parser expe=
cts a max line<br></div><div dir=3D"ltr">length of 255 and word length of 2=
55.<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Further, even a TL=
S_CHANNEL_BUF_SIZE of 4096 does not support a<br></div><div dir=3D"ltr">pas=
sword that long as there are other things like username, key-source,<br></d=
iv><div dir=3D"ltr">local-options that have to fit into the buffer (see key=
_method_2_write). So<br></div><div dir=3D"ltr">what's the logic behind 4096=
?<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Finally, are there a=
ny particular challenge-response framework that requires<br></div><div dir=
=3D"ltr">such long responses? Even for U2F, we wouldn't need to send a resp=
onse<br></div><div dir=3D"ltr">that large. U2F registration response could =
get very long (still mostly under<br></div><div dir=3D"ltr">2000 bytes), bu=
t doing U2F key registration via the authentication channel is<br></div><di=
v dir=3D"ltr">not a good implementation. Authentication responses are much =
smaller.<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">In short, it =
looks premature to increase this value before we start<br></div><div dir=3D=
"ltr">supporting long responses via the management, and a real practical<br=
></div><div dir=3D"ltr">need for long challenge response strings that won't=
 fit in the current<br></div><div dir=3D"ltr">2048 bytes (minus overhead) a=
rise.<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr">Selva<br></div><=
/div>
                </div>
            </div></div></body></html>=

------=_Part_3421878_981046224.1521493221566--

