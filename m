MIME-Version: 1.0
In-Reply-To: <1449751018-10634-1-git-send-email-arne@...1227...>
References: <1449751018-10634-1-git-send-email-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 15 Dec 2015 22:41:27 -0500
Message-ID: <CAKuzo_isBP22Xh1xyBr4oaXZBWaCsW_-myQAhbHvBd-NJ9n_zg@...278...>
Content-Type: multipart/alternative; boundary=089e012298ec7e6d480526fbaf71
Subject: Re: [Openvpn-devel] [PATCH] Replace ENABLE_CLIENT_CR with
 ENABLE_MANAGMENT with unconditionally enables it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e012298ec7e6d480526fbaf71
Content-Type: text/plain; charset=UTF-8

Hi,

Though nothing breaks, this leads to confusing code fragments like the one
around this one

@@ -1143,7 +1142,7 @@ get_user_pass_cr (struct user_pass *up,
>             { msg(M_FATAL, "neither stdin nor stderr are a tty device,
> can't ask for %s password.  If you used --daemon, you need to use --askpass
> to make passphrase-protected keys work, and you can not use
> --auth-nocache.", prefix ); }
>  #endif
>
> -#ifdef ENABLE_CLIENT_CR
> +#ifdef ENABLE_MANAGEMENT
>           if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE))
>             {
>               struct auth_challenge_info *ac = get_auth_challenge
> (auth_challenge, &gc);
>


would read as "Ifdef ENABLE_MANAGEMENT, read the challenge response from
stdin".

Why not unconditionally enable the challenge-response support irrespective
of whether MANAGEMENT is enabled or not? That will get rid of all those
ifdefs. I don't see any obvious downsides.

Thanks,

Selva

--089e012298ec7e6d480526fbaf71
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote">Hi,<br><br>Though nothing b=
reaks, this leads to confusing code fragments like the one around this one<=
br><br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote">@@ -1143,7 +1142,7=
 @@ get_user_pass_cr (struct user_pass *up,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { msg(M_FATAL, &quot;neither stdi=
n nor stderr are a tty device,=20
can&#39;t ask for %s password.=C2=A0 If you used --daemon, you need to use=
=20
--askpass to make passphrase-protected keys work, and you can not use=20
--auth-nocache.&quot;, prefix ); }<br>
=C2=A0#endif<br>
<br>
-#ifdef <span class=3D"">ENABLE_CLIENT_CR</span><br>
+#ifdef ENABLE_MANAGEMENT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (auth_challenge &amp;&amp; (flags &am=
p; GET_USER_PASS_DYNAMIC_CHALLENGE))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct auth_challenge_info=
 *ac =3D get_auth_challenge (auth_challenge, &amp;gc);<br></blockquote><div=
>=C2=A0</div><div><br></div><div>would read as &quot;Ifdef ENABLE_MANAGEMEN=
T, read the challenge response from stdin&quot;.<br><br></div><div>Why not =
unconditionally enable the challenge-response support irrespective of wheth=
er MANAGEMENT is enabled or not? That will get rid of all those ifdefs. I d=
on&#39;t see any obvious downsides.<br></div><div><br></div><div>Thanks,<br=
><br></div><div>Selva<br></div></div><div class=3D"gmail_extra"><br></div><=
/div>

--089e012298ec7e6d480526fbaf71--

