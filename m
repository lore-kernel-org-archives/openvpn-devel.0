MIME-Version: 1.0
In-Reply-To: <CAKuzo_hDcoTm-teJ3UeKQ+B=RTpStb3KMjQKLc0x7A2-_TUvoA@...278...>
References: <1480335220-14810-1-git-send-email-steffan.karger@...1435...>
	<CAKuzo_hDcoTm-teJ3UeKQ+B=RTpStb3KMjQKLc0x7A2-_TUvoA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 28 Nov 2016 12:22:01 -0500
Message-ID: <CAKuzo_jNtFE7Fsrtn=iA0EiPsYuzVvrAQsxdEy_quYfeLsg7aQ@...278...>
Content-Type: multipart/alternative; boundary=001a1149b9a8e9020105425fb6a6
Subject: Re: [Openvpn-devel] [PATCH] Introduce and use secure_memzero() to
 erase secrets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149b9a8e9020105425fb6a6
Content-Type: text/plain; charset=UTF-8

Hi,

My sloppy cut-n-paste missed this one:

in ssl_verify.c

@@ -1262,7 +1262,7 @@ verify_user_pass(struct user_pass *up, struct
tls_multi *multi,
                   "No auth-token will be activated now");
       if (multi->auth_token)
  {
-  memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
+  memset (multi->auth_token, 0, AUTH_TOKEN_SIZE); <-- SecureZero
   free (multi->auth_token);
   multi->auth_token = NULL;
  }

Selva

--001a1149b9a8e9020105425fb6a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>My sloppy cut-n-paste mi=
ssed this one:</div><div><br></div><div>in ssl_verify.c</div><div><br></div=
><div>@@ -1262,7 +1262,7 @@ verify_user_pass(struct user_pass *up, struct t=
ls_multi *multi,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;No auth-token will be activated now&quot;);</div=
><div>=C2=A0<span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">=
	</span> =C2=A0 =C2=A0 =C2=A0if (multi-&gt;auth_token)</div><div>=C2=A0<spa=
n class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">		</span>{</div>=
<div>-<span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">		</sp=
an> =C2=A0memset (multi-&gt;auth_token, 0, AUTH_TOKEN_SIZE);</div><div>+<sp=
an class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">		</span> =C2=
=A0memset (multi-&gt;auth_token, 0, AUTH_TOKEN_SIZE); &lt;-- SecureZero</di=
v><div>=C2=A0<span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre"=
>		</span> =C2=A0free (multi-&gt;auth_token);</div><div>=C2=A0<span class=
=3D"gmail-Apple-tab-span" style=3D"white-space:pre">		</span> =C2=A0multi-&=
gt;auth_token =3D NULL;</div><div>=C2=A0<span class=3D"gmail-Apple-tab-span=
" style=3D"white-space:pre">		</span>}</div><div><br></div><div>Selva</div>=
</div>

--001a1149b9a8e9020105425fb6a6--

