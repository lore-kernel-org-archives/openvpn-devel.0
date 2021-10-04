MIME-Version: 1.0
References: <YVrc/1PV72e1WcNC@...1296...>
In-Reply-To: <YVrc/1PV72e1WcNC@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 4 Oct 2021 13:35:26 -0400
Message-ID: <CAKuzo_haSuTr8EhKyUkAokPQm9=ox_C++OB1C-674FTKrRfEWw@...278...>
Content-Type: multipart/alternative; boundary="000000000000fff06405cd8a61ff"
Subject: Re: [Openvpn-devel] [dbelyavs@...1347...: OpenSSH with OpenSSL 3.0:
 preventing loss of remote access]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000fff06405cd8a61ff
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Oct 4, 2021 at 6:53 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> (this is mainly for Arne and Selva, but I've decided to post it to
> the list to raise awareness).
>
> OpenSSL 3.0 seems to bring "interesting" surprises with their provider
> thingie, and openssl.cnf - not sure if this is at all relevant for
> OpenVPN, but it sounds as if it might be.
>

I would consider those as user/admin errors though we can give an option to
not load the default openssl.cnf or use a custom one at user's choice.

For the internal provider we are working on, we'll be loading our provider
and the default provider into a new libctx and using it in the SSL_CTX. But
we'll still have many old-style API calls that does not take libctx or
properties, and will continue to resolve from whatever providers are loaded
implicitly into the default libctx (or explicitly through openssl.cnf).

What I'm not sure about is whether we should also respect any default
properties specified in openssl.cnf when we load our own providers. I think
we should, but that again calls for the user to be careful when they edit
openssl.cnf.

IMO, in OpenVPN we should use our own customized openssl.cnf with minimal
entries required for a preferred state that we want -- things like
signature algorithms, ciphers etc could be set there. Then provide an
option to load the user's config (or system-wide one) if they want to
override it.

Selva



> Hello,
>
> TL;DR. Bad openssl config can break remote access to the system via SSH.
>
> OpenSSL 3.0 doesn't provide any crypto primitives itself. It is done via
> the providers' mechanism. The provider should be loaded and activated to
> make some algorithms and RNG available.
>
> The default provider is a bit special. If no providers are activated
> explicitly, the default one is activated implicitly. (See details in
> https://github.com/openssl/openssl/issues/16249). Its activation is
> commented out in the config file. If anybody tries to activate a legacy
> provider and doesn't uncomment the default provider activation, the system
> becomes almost unsuitable for work and not remotely accessible anymore.
>
> I am pretty sure that there will be enough people who because either not
> reading the documentation or just being in a hurry will turn the remote
> accessibility off.
>
> To prevent it, the viable option is explicitly load the default provider in
> openssh if necessary.
> We can check if it is necessary in several ways. First, we can check if the
> default or FIPS provider is already loaded. Second, we could check that any
> algorithm (I'd prefer some of the AES-CTR family) is available, and load
> the default provider if not, implying that it the selected algorithm is
> implemented in the provider carrying also some sort of key exchange
> algorithm, RNG, etc. I have a tentative patch for this purpose.
>
> There also may be an option to add an explicit switch
> 'FallbackToDefaultProvider yes' to the openssh configuration.
>
> Please, any feedback is welcome.
>
> --
> Dmitry Belyavskiy
> _______________________________________________
> openssh-unix-dev mailing list
> openssh-unix-dev@...2635...
> https://lists.mindrot.org/mailman/listinfo/openssh-unix-dev
>
>
> ----- End forwarded message -----
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000fff06405cd8a61ff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 4, 2021 at 6:53 AM Gert Do=
ering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
(this is mainly for Arne and Selva, but I&#39;ve decided to post it to<br>
the list to raise awareness).<br>
<br>
OpenSSL 3.0 seems to bring &quot;interesting&quot; surprises with their pro=
vider<br>
thingie, and openssl.cnf - not sure if this is at all relevant for <br>
OpenVPN, but it sounds as if it might be.<br></blockquote><div><br></div><d=
iv>I would consider=C2=A0those as user/admin errors though we can give an o=
ption to not load the default openssl.cnf or use a custom one at user&#39;s=
 choice.</div><div><br></div><div>For the internal provider we are working =
on, we&#39;ll be loading our provider and the default provider into a new l=
ibctx and using it in the SSL_CTX. But we&#39;ll still have many old-style =
API calls that does not take libctx=C2=A0or properties, and will continue t=
o resolve from whatever providers are loaded implicitly into the default li=
bctx (or explicitly=C2=A0through openssl.cnf).</div><div><br></div><div>Wha=
t I&#39;m not sure about is whether we should also respect any default prop=
erties specified in openssl.cnf when we load our own providers. I think we =
should, but that again calls for the user to be careful when they edit open=
ssl.cnf.</div><div><br></div><div>IMO, in OpenVPN we should use our own cus=
tomized openssl.cnf with minimal entries required for a preferred state tha=
t we want -- things like signature algorithms, ciphers etc could be set the=
re. Then provide an option to load the user&#39;s config (or system-wide on=
e) if they want to override it.</div><div><br></div><div>Selva</div><div><b=
r></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Hello,<br>
<br>
TL;DR. Bad openssl config can break remote access to the system via SSH.<br>
<br>
OpenSSL 3.0 doesn&#39;t provide any crypto primitives itself. It is done vi=
a<br>
the providers&#39; mechanism. The provider should be loaded and activated t=
o<br>
make some algorithms and RNG available.<br>
<br>
The default provider is a bit special. If no providers are activated<br>
explicitly, the default one is activated implicitly. (See details in<br>
<a href=3D"https://github.com/openssl/openssl/issues/16249" rel=3D"noreferr=
er" target=3D"_blank">https://github.com/openssl/openssl/issues/16249</a>).=
 Its activation is<br>
commented out in the config file. If anybody tries to activate a legacy<br>
provider and doesn&#39;t uncomment the default provider activation, the sys=
tem<br>
becomes almost unsuitable for work and not remotely accessible anymore.<br>
<br>
I am pretty sure that there will be enough people who because either not<br>
reading the documentation or just being in a hurry will turn the remote<br>
accessibility off.<br>
<br>
To prevent it, the viable option is explicitly load the default provider in=
<br>
openssh if necessary.<br>
We can check if it is necessary in several ways. First, we can check if the=
<br>
default or FIPS provider is already loaded. Second, we could check that any=
<br>
algorithm (I&#39;d prefer some of the AES-CTR family) is available, and loa=
d<br>
the default provider if not, implying that it the selected algorithm is<br>
implemented in the provider carrying also some sort of key exchange<br>
algorithm, RNG, etc. I have a tentative patch for this purpose.<br>
<br>
There also may be an option to add an explicit switch<br>
&#39;FallbackToDefaultProvider yes&#39; to the openssh configuration.<br>
<br>
Please, any feedback is welcome.<br>
<br>
-- <br>
Dmitry Belyavskiy<br>
_______________________________________________<br>
openssh-unix-dev mailing list<br>
<a href=3D"mailto:openssh-unix-dev@...2635..." target=3D"_blank">openssh-un=
ix-dev@...2635...</a><br>
<a href=3D"https://lists.mindrot.org/mailman/listinfo/openssh-unix-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.mindrot.org/mailman/listinf=
o/openssh-unix-dev</a><br>
<br>
<br>
----- End forwarded message -----<br>
<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000fff06405cd8a61ff--

