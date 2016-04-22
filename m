MIME-Version: 1.0
In-Reply-To: <571A0FEA.9060000@...1147...>
References: <CAP=zTkOpzBtS05aN0XmdtX+DJS-owGaSK-qHXEA2vwsSO_NCjg@...278...>
	<571A0FEA.9060000@...1147...>
Date: Fri, 22 Apr 2016 19:30:22 +0530
Message-ID: <CAP=zTkN6u_rOdAWZWxW=qh_q2A9mK3NC6M1k45nJW2y099Svpw@...278...>
From: Shubham Chauhan <shubham13099@...2124...>
Content-Type: multipart/alternative; boundary=001a113fc3327475980531133f3b
Subject: Re: [Openvpn-devel] OpenSSL connect and disconnect calls
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--001a113fc3327475980531133f3b
Content-Type: text/plain; charset=UTF-8

Hey JJ,

Thanks for a quick reply.
I would like to understand it better. How does OpenVPN manage SSL
handshakes? There might be some point where it initiates and terminates an
SSL session. What kind of methods are incorporated in OpenVPN.
A simple example being- if I want to store the negotiated session in a
session variable, I would ideally do it just before the SSL_shutdown() call
and will be using that stored session just before the SSL_connect() call
(by setting the session to the context) in a "true" SSL aplication.
Where do I do this kind of stuff in OpenVPN?

Thanks

On Fri, Apr 22, 2016 at 5:20 PM, Jan Just Keijser <janjust@...1147...> wrote:

> Hi,
>
> On 22/04/16 10:16, Shubham Chauhan wrote:
>
>> Hello,
>>
>> I was going through the codebase, and found myself a bit confused. I
>> wanted to customize some functionalities and run some tests
>>
>> I was specifically looking for the methods where we start (performing the
>> handshake) and end an OpenSSL session.
>>
>> How and where are the OpenSSL calls like the SSL_connect(),
>> SSL_SESSION_free(), SSL_shutdown(),  SSL_free(), implemented?
>>
>> I am following openvpn's release/2.3 branch on github:
>> https://github.com/openvpn/openvpn/tree/release/2.3
>>
>> all openssl code is concentrated in ssl_openssl.c and
> ssl_verify_openssl.c.
> However, OpenVPN is not a "true" SSL application so you won't find
> SSL_connect or SSL_shutdown - connections are established in a different
> manner, as OpenVPN normally runs over UDP and SSL_connect() and friends
> don't like that.
>
> HTH,
>
> JJK
>
>


-- 
Regards
Shubham Chauhan
2013099
B.Tech CSE

--001a113fc3327475980531133f3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey JJ,<div><br></div><div>Thanks for a quick reply.</div>=
<div>I would like to understand it better. How does OpenVPN manage SSL hand=
shakes? There might be some point where it initiates and terminates an SSL =
session. What kind of methods are incorporated in OpenVPN.</div><div>A simp=
le example being- if I want to store the negotiated session in a session va=
riable, I would ideally do it just before the SSL_shutdown() call and will =
be using that stored session just before the SSL_connect() call (by setting=
 the session to the context) in a &quot;true&quot; SSL aplication.</div><di=
v>Where do I do this kind of stuff in OpenVPN?</div><div><br></div><div>Tha=
nks</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Fri, Apr 22, 2016 at 5:20 PM, Jan Just Keijser <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<span class=3D""><br>
<br>
On 22/04/16 10:16, Shubham Chauhan wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello,<br>
<br>
I was going through the codebase, and found myself a bit confused. I wanted=
 to customize some functionalities and run some tests<br>
<br>
I was specifically looking for the methods where we start (performing the h=
andshake) and end an OpenSSL session.<br>
<br>
How and where are the OpenSSL calls like the SSL_connect(), SSL_SESSION_fre=
e(), SSL_shutdown(),=C2=A0 SSL_free(), implemented?<br>
<br>
I am following openvpn&#39;s release/2.3 branch on github: <a href=3D"https=
://github.com/openvpn/openvpn/tree/release/2.3" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/openvpn/openvpn/tree/release/2.3</a><br>
<br>
</blockquote></span>
all openssl code is concentrated in ssl_openssl.c and ssl_verify_openssl.c.=
<br>
However, OpenVPN is not a &quot;true&quot; SSL application so you won&#39;t=
 find SSL_connect or SSL_shutdown - connections are established in a differ=
ent manner, as OpenVPN normally runs over UDP and SSL_connect() and friends=
 don&#39;t like that.<br>
<br>
HTH,<br>
<br>
JJK<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature"><div dir=3D"ltr">Regards<br>Shubham Chauhan<br>2013099=
<br>B.Tech CSE</div></div>
</div>

--001a113fc3327475980531133f3b--

