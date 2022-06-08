MIME-Version: 1.0
References: <20220607163049.10056-1-facboy@...277...>
In-Reply-To: <20220607163049.10056-1-facboy@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 8 Jun 2022 09:37:24 +0300
Message-ID: <CAGyAFMUdnfxk4TpRF9tWcPtq0Eak+jCj=3n0_tw7EDdwO=b65g@...278...>
Content-Type: multipart/alternative; boundary="000000000000e64d3905e0e9f08a"
Subject: Re: [Openvpn-devel] [PATCH OpenVPN3 1/2] ovpnagent: fix quoting of
 omiclient parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christopher Ng <facboy@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000e64d3905e0e9f08a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As per discussion on https://github.com/OpenVPN/openvpn3/pull/218

Acked-by: Lev Stipakov <lstipakov@...277...>

ti 7. kes=C3=A4k. 2022 klo 20.30 Christopher Ng (facboy@...277...) kirjoitt=
i:

> Signed-off-by: Christopher Ng <facboy@...277...>
> ---
>  openvpn/ovpnagent/win/ovpnagent.cpp | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/openvpn/ovpnagent/win/ovpnagent.cpp
> b/openvpn/ovpnagent/win/ovpnagent.cpp
> index 8a31b0aa..fa020e7d 100644
> --- a/openvpn/ovpnagent/win/ovpnagent.cpp
> +++ b/openvpn/ovpnagent/win/ovpnagent.cpp
> @@ -444,14 +444,16 @@ public:
>
>        // create command line for openvpn process
>        std::ostringstream ss;
> -      ss << "client --config " << config_dir << "\\" << config_file << "
> --exit-event-name "
> +      ss << "client --config \"" << config_dir << "\\" << config_file <<
> "\" --exit-event-name "
>          << exit_event_name << " --auth-retry interact --management " <<
> management_host << " "
>          << management_port << " stdin --management-query-passwords
> --management-hold " << "--log"
> -        << (log_append ? "-append " : " ") << log;
> +        << (log_append ? "-append \"" : " \"") << log << "\"";
>        std::string cmd =3D ss.str();
>        std::unique_ptr<char[]> buf(new char[cmd.length() + 1]);
>        strcpy(buf.get(), cmd.c_str());
>
> +      // OPENVPN_LOG("Launching omiclient: " <<
> config.omiclient_exe.c_str() << " " << buf.get());
> +
>        STARTUPINFO startup_info =3D { 0 };
>        startup_info.cb =3D sizeof(startup_info);
>        startup_info.dwFlags =3D STARTF_USESTDHANDLES;
> --
> 2.34.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


--=20
-Lev

--000000000000e64d3905e0e9f08a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">As per discussion on=C2=A0<a href=3D"https://github.com/Op=
enVPN/openvpn3/pull/218">https://github.com/OpenVPN/openvpn3/pull/218</a><d=
iv><br></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...1186...=
.277...">lstipakov@...277...</a>&gt;</div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">ti 7. kes=C3=A4k. 2022 klo 20.30 =
Christopher Ng (<a href=3D"mailto:facboy@...277...">facboy@...277...</a>) k=
irjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed=
-off-by: Christopher Ng &lt;<a href=3D"mailto:facboy@...277..." target=3D"_=
blank">facboy@...277...</a>&gt;<br>
---<br>
=C2=A0openvpn/ovpnagent/win/ovpnagent.cpp | 6 ++++--<br>
=C2=A01 file changed, 4 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/openvpn/ovpnagent/win/ovpnagent.cpp b/openvpn/ovpnagent/win/ov=
pnagent.cpp<br>
index 8a31b0aa..fa020e7d 100644<br>
--- a/openvpn/ovpnagent/win/ovpnagent.cpp<br>
+++ b/openvpn/ovpnagent/win/ovpnagent.cpp<br>
@@ -444,14 +444,16 @@ public:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0// create command line for openvpn process<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0std::ostringstream ss;<br>
-=C2=A0 =C2=A0 =C2=A0 ss &lt;&lt; &quot;client --config &quot; &lt;&lt; con=
fig_dir &lt;&lt; &quot;\\&quot; &lt;&lt; config_file &lt;&lt; &quot; --exit=
-event-name &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 ss &lt;&lt; &quot;client --config \&quot;&quot; &lt;&=
lt; config_dir &lt;&lt; &quot;\\&quot; &lt;&lt; config_file &lt;&lt; &quot;=
\&quot; --exit-event-name &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;&lt; exit_event_name &lt;&lt; &quot; =
--auth-retry interact --management &quot; &lt;&lt; management_host &lt;&lt;=
 &quot; &quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;&lt; management_port &lt;&lt; &quot; =
stdin --management-query-passwords --management-hold &quot; &lt;&lt; &quot;=
--log&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;&lt; (log_append ? &quot;-append &quot; : =
&quot; &quot;) &lt;&lt; log;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;&lt; (log_append ? &quot;-append \&quot;&q=
uot; : &quot; \&quot;&quot;) &lt;&lt; log &lt;&lt; &quot;\&quot;&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0std::string cmd =3D ss.str();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0std::unique_ptr&lt;char[]&gt; buf(new char[cmd.l=
ength() + 1]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0strcpy(buf.get(), cmd.c_str());<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 // OPENVPN_LOG(&quot;Launching omiclient: &quot; &lt;=
&lt; config.omiclient_exe.c_str() &lt;&lt; &quot; &quot; &lt;&lt; buf.get()=
);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0STARTUPINFO startup_info =3D { 0 };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0startup_info.cb =3D sizeof(startup_info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0startup_info.dwFlags =3D STARTF_USESTDHANDLES;<b=
r>
-- <br>
2.34.1<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div>

--000000000000e64d3905e0e9f08a--

