MIME-Version: 1.0
References: <CAFHpkQFauuHVbkLAVCz2b1s2m4dwUjxQPyBn9Laa0BmwyYQmGQ@...278...>
In-Reply-To: <CAFHpkQFauuHVbkLAVCz2b1s2m4dwUjxQPyBn9Laa0BmwyYQmGQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 11 Apr 2019 03:51:50 +0500
Message-ID: <CAFHpkQFwOTOrqucoFs+mcLr7bCvVzYnUhK7hEM084suOFjm85Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000ea3d57058634ead5"
Subject: Re: [Openvpn-devel] cirrus-ci: freebsd builds ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000ea3d57058634ead5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

couple of findings:

1) error when built with mbedtls-2.16.0 (surprizingly, build does not fail)

[       OK ] tls_crypt_v2_wrap_unwrap_no_metadata
[ RUN      ] tls_crypt_v2_wrap_unwrap_max_metadata
[       OK ] tls_crypt_v2_wrap_unwrap_max_metadata
[ RUN      ] tls_crypt_v2_wrap_too_long_metadata
ERROR: could not crypt: insufficient space in dst
[       OK ] tls_crypt_v2_wrap_too_long_metadata
[ RUN      ] tls_crypt_v2_wrap_unwrap_wrong_key
[       OK ] tls_crypt_v2_wrap_unwrap_wrong_key


2) base64 is missing --> build is ok (we have similar "failures" on
travis-ci osx builds)

Testing tls-crypt-v2 key generation (max length metadata)..../t_lpback.sh:
base64: not found
OK
PASS: t_lpback.sh


=D1=81=D1=80, 10 =D0=B0=D0=BF=D1=80. 2019 =D0=B3. =D0=B2 23:44, =D0=98=D0=
=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...1665...=
77...>:

> hello,
>
> I have implemented cirrus-ci support (with freebsd fix),
> please have a look
>
> https://github.com/OpenVPN/openvpn/pull/125
>
> builds:
>
> https://cirrus-ci.com/task/6511771119517696
> https://cirrus-ci.com/task/5385871212675072
>
> thoughts ? suggestions ?
>

--000000000000ea3d57058634ead5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>couple of findings:=
</div><div><br></div><div>1) error when built with mbedtls-2.16.0 (surprizi=
ngly, build does not fail)<br></div><div><br></div><div>[=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 OK ] tls_crypt_v2_wrap_unwrap_no_metadata
<br>[ RUN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ] tls_crypt_v2_wrap_unwrap_max_meta=
data
<br>[=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OK ] tls_crypt_v2_wrap_unwrap_max=
_metadata
<br>[ RUN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ] tls_crypt_v2_wrap_too_long_metada=
ta
<br>ERROR: could not crypt: insufficient space in dst
<br>[=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OK ] tls_crypt_v2_wrap_too_long_m=
etadata
<br>[ RUN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ] tls_crypt_v2_wrap_unwrap_wrong_key
<br>[=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OK ] tls_crypt_v2_wrap_unwrap_wro=
ng_key</div><div></div><div><br></div><div><br></div><div>2) base64 is miss=
ing --&gt; build is ok (we have similar &quot;failures&quot; on travis-ci o=
sx builds)<br></div><div><br></div><div>Testing tls-crypt-v2 key generation=
 (max length metadata)..../t_lpback.sh: base64: not found
<br>OK
<br>PASS: t_lpback.sh<br></div><div><br></div></div></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 10 =
=D0=B0=D0=BF=D1=80. 2019 =D0=B3. =D0=B2 23:44, =D0=98=D0=BB=D1=8C=D1=8F =D0=
=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...1186...=
.277...">chipitsine@...277...</a>&gt;:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><=
div dir=3D"ltr"><div>hello,</div><div><br></div><div>I have implemented cir=
rus-ci support (with freebsd fix),</div><div>please have a look</div><div><=
br></div><div><a href=3D"https://github.com/OpenVPN/openvpn/pull/125" targe=
t=3D"_blank">https://github.com/OpenVPN/openvpn/pull/125</a></div><div><br>=
</div><div>builds:</div><div><br></div><div><a href=3D"https://cirrus-ci.co=
m/task/6511771119517696" target=3D"_blank">https://cirrus-ci.com/task/65117=
71119517696</a></div><div><a href=3D"https://cirrus-ci.com/task/53858712126=
75072" target=3D"_blank">https://cirrus-ci.com/task/5385871212675072</a></d=
iv><div><br></div><div>thoughts ? suggestions ?<br></div></div></div></div>=
</div>
</blockquote></div>

--000000000000ea3d57058634ead5--

