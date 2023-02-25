MIME-Version: 1.0
References: <20230214200804.600405-1-selva.nair@...277...>
 <202302251629.31PGTIw9077391@...2054...>
In-Reply-To: <202302251629.31PGTIw9077391@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 25 Feb 2023 12:23:42 -0500
Message-ID: <CAKuzo_icBdV5R2x0s8V+ZGpL0vRdF5JG_FfLMpe4=3U_q0nRHA@...278...>
Content-Type: multipart/alternative; boundary="000000000000db988305f5898263"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add a unit test for
 functions in cryptoapi.c
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

--000000000000db988305f5898263
Content-Type: text/plain; charset="UTF-8"

Hi

On Sat, Feb 25, 2023 at 11:29 AM Gert Doering <gert@...1296...> wrote:

> Acked-by: Gert Doering <gert@...1296...>
>
> Thanks for the v4.  This enabled me to just push to GH to have
> to build and run the tests, without having to bother myself with
> copying binaries around :-)
>
> OTOH, there might be a bit of polishing needed - the other tests
> print out what they are doing ("Running 7 test(s)"), while the
> cryptoapi unit test "just succeeds".  Is there something missing
> wrt cmocka initalization?


>   https://github.com/cron2/openvpn/actions/runs/4270790193/jobs/7434873211


That one is for OpenSSL 1.1.1 while this test is built only for OpenSSL3,
so nothing to run. Do we need to continue testing Windows builds of 2.6 for
OpenSSL 1.1?

Logs for OpenSSL 3 build look okay:

>
https://github.com/OpenVPN/openvpn/actions/runs/4270860888/jobs/7434989645#logs

>
Run ./unittests/cryptoapi_testdriver.exe

> 4[==========] Running 1 test(s).

> 5[ RUN ] test_parse_hexstring

> 6[ OK ] test_parse_hexstring

> 7[ PASSED ] 1 test(s).

> 8[==========] 1 test(s) run.

Selva

--000000000000db988305f5898263
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Sat, Feb 25, 2023 at 11:29 AM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Acked-by: Gert Doering &lt=
;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&g=
t;<br>
<br>
Thanks for the v4.=C2=A0 This enabled me to just push to GH to have<br>
to build and run the tests, without having to bother myself with<br>
copying binaries around :-) <br>
<br>
OTOH, there might be a bit of polishing needed - the other tests<br>
print out what they are doing (&quot;Running 7 test(s)&quot;), while the<br>
cryptoapi unit test &quot;just succeeds&quot;.=C2=A0 Is there something mis=
sing<br>
wrt cmocka initalization?=C2=A0</blockquote><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
=C2=A0 <a href=3D"https://github.com/cron2/openvpn/actions/runs/4270790193/=
jobs/7434873211" rel=3D"noreferrer" target=3D"_blank">https://github.com/cr=
on2/openvpn/actions/runs/4270790193/jobs/7434873211</a></blockquote><div><b=
r></div><div>That one is for OpenSSL 1.1.1 while this test is built only fo=
r OpenSSL3,=C2=A0 so nothing to run. Do we need to continue testing Windows=
 builds of 2.6 for OpenSSL 1.1?</div><div>=C2=A0</div><div>Logs for OpenSSL=
 3 build look okay:</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
</blockquote><div class=3D"gmail_quote"><br></div><a href=3D"https://github=
.com/OpenVPN/openvpn/actions/runs/4270860888/jobs/7434989645#logs">https://=
github.com/OpenVPN/openvpn/actions/runs/4270860888/jobs/7434989645#logs<br>=
</a><blockquote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left=
:1px solid rgb(204,204,204);border-right:1px solid rgb(204,204,204);padding=
-left:1ex;padding-right:1ex"></blockquote><br></div><div class=3D"gmail_quo=
te">Run ./unittests/cryptoapi_testdriver.exe<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);bor=
der-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></=
blockquote>4[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 1 test(s).<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid r=
gb(204,204,204);border-right:1px solid rgb(204,204,204);padding-left:1ex;pa=
dding-right:1ex"></blockquote>5[ RUN ] test_parse_hexstring<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);border-right:1px solid rgb(204,204,204);padding-left:1ex;paddin=
g-right:1ex"></blockquote>6[ OK ] test_parse_hexstring<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);border-right:1px solid rgb(204,204,204);padding-left:1ex;padding-rig=
ht:1ex"></blockquote>7[ PASSED ] 1 test(s).<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0.8ex;border-left:1px solid rgb(204,204,204);bord=
er-right:1px solid rgb(204,204,204);padding-left:1ex;padding-right:1ex"></b=
lockquote>8[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 1 test(s) run.</div><div class=
=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Selva</div></div>

--000000000000db988305f5898263--

