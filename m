MIME-Version: 1.0
References: <1524752664-27946-1-git-send-email-selva.nair@...277...>
 <201810051051.w95ApC2t040828@...2054...>
In-Reply-To: <201810051051.w95ApC2t040828@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 5 Oct 2018 10:08:50 -0400
Message-ID: <CAKuzo_htbw3sp=T4MVtoTZyCh3u8jwP8a754PSaXy1ya=X68QA@...278...>
Content-Type: multipart/alternative; boundary="000000000000a46cf005777bd0c0"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Pass the hash without the
 DigestInfo header to NCryptSignHash()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a46cf005777bd0c0
Content-Type: text/plain; charset="UTF-8"

Hi,


> As a side note (rambling about comments today), this hunk makes the
> comment above it slightly misleading:
>
>      /* The hash OID is already in 'from'.  So set the hash algorithm
>       * in the padding info struct to NULL.
>       */
> -    BCRYPT_PKCS1_PADDING_INFO padinfo = {NULL};
> +    BCRYPT_PKCS1_PADDING_INFO padinfo = {hash_algo};
>
> .. since we do not set it to NULL anymore...
>

A perfect case of how fast comments and code diverge -- I added that
comment only
the other day.. My bad. Will try to remember to fix next time this is
touched.

Knuth's literate programming never caught on, did it..

Thanks for the ack and merge..

For 2.4, have to look through and figure out --- it has been a while..

Selva

--000000000000a46cf005777bd0c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><br><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
As a side note (rambling about comments today), this hunk makes the<br>
comment above it slightly misleading:<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* The hash OID is already in &#39;from&#39;.=C2=A0 So =
set the hash algorithm<br>
=C2=A0 =C2=A0 =C2=A0 * in the padding info struct to NULL.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 BCRYPT_PKCS1_PADDING_INFO padinfo =3D {NULL};<br>
+=C2=A0 =C2=A0 BCRYPT_PKCS1_PADDING_INFO padinfo =3D {hash_algo};<br>
<br>
.. since we do not set it to NULL anymore...<br></blockquote><div><br></div=
><div>A perfect case of how fast comments and code diverge -- I added that =
comment only<br>the other day.. My bad. Will try to remember to fix next ti=
me this is touched.<br><br>Knuth&#39;s literate programming never caught on=
, did it..<br><br></div><div>Thanks for the ack and merge..<br><br></div><d=
iv>For 2.4, have to look through and figure out --- it has been a while..<b=
r><br></div><div>Selva</div></div></div></div>

--000000000000a46cf005777bd0c0--

