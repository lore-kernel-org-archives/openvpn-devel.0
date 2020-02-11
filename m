MIME-Version: 1.0
References: <1522729843-28878-1-git-send-email-selva.nair@...277...>
 <1581359742-30511-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1581359742-30511-1-git-send-email-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 11 Feb 2020 11:52:29 +0200
Message-ID: <CAGyAFMVMTyANkxFoMmctyRum15E5Dntm=hWLSemg9WxgRXT_tg@...278...>
Content-Type: multipart/alternative; boundary="000000000000161d50059e49d1c0"
Subject: Re: [Openvpn-devel] [PATCH 1/2 v3] Skip expired certificates in
 Windows certificate store
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000161d50059e49d1c0
Content-Type: text/plain; charset="UTF-8"

Hi,

+    DWORD find_type;
> +    const void *find_param;



     if (!strncmp(cert_prop, "SUBJ:", 5))
>      {

+        find_param = cert_prop + 5;
> +        find_type = CERT_FIND_SUBJECT_STR_A;
>      }
>      else if (!strncmp(cert_prop, "THUMB:", 6))
>      {
> +        find_type = CERT_FIND_HASH;
> +        find_param = &blob;
> +    }
> +    while(true)
> +    {
>          rv = CertFindCertificateInStore(cert_store, X509_ASN_ENCODING |
> PKCS_7_ASN_ENCODING,
> +                                        0, find_type, find_param, rv);
>

This explodes if cert_prop doesn't start with either "SUBJ:" or "THUMB:"
since we pass
uninitialized arguments.

This problem didn't exist before, since we looked for certificate inside
above "if" blocks where
both variables are initialized.

Another thing:

+    unsigned char hash[255];
> +    CRYPT_HASH_BLOB blob = {.cbData = 0, .pbData = hash};
>
>      else if (!strncmp(cert_prop, "THUMB:", 6))
>      {
> -        unsigned char hash[255];
> -        CRYPT_HASH_BLOB blob;
>

Why did you move "hash" and "blob" to the outer scope? I think those
variables should stay where they have been, since they're not used outside
of "if".

-Lev

--000000000000161d50059e49d1c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">+ =C2=A0 =C2=A0DWORD find_type;<br>+ =C2=A0 =C2=A0con=
st void *find_param;=C2=A0 </blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">=C2=A0=C2=A0</blockquote><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">=C2=A0 =C2=A0 =C2=A0if (!strncmp(=
cert_prop, &quot;SUBJ:&quot;, 5))<br>
=C2=A0 =C2=A0 =C2=A0{=C2=A0</blockquote><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 find_param =3D cert_prop + 5;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 find_type =3D CERT_FIND_SUBJECT_STR_A;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0else if (!strncmp(cert_prop, &quot;THUMB:&quot;, 6))<br>
=C2=A0 =C2=A0 =C2=A0{<br>+=C2=A0 =C2=A0 =C2=A0 =C2=A0 find_type =3D CERT_FI=
ND_HASH;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 find_param =3D &amp;blob;<br>+=C2=A0 =C2=A0 }<=
br>
+=C2=A0 =C2=A0 while(true)<br>
+=C2=A0 =C2=A0 {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rv =3D CertFindCertif=
icateInStore(cert_store, X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, find_=
type, find_param, rv);<br></blockquote><div><br></div><div>This explodes if=
 cert_prop doesn&#39;t start with either &quot;SUBJ:&quot; or &quot;THUMB:&=
quot; since we pass</div><div>uninitialized arguments.</div><div><br></div>=
<div>This problem didn&#39;t exist before, since we looked for certificate =
inside above &quot;if&quot; blocks where</div><div>both variables are initi=
alized.</div><div><br></div><div>Another thing:</div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">+ =C2=A0 =C2=A0unsigned char has=
h[255];<br>+ =C2=A0 =C2=A0CRYPT_HASH_BLOB blob =3D {.cbData =3D 0, .pbData =
=3D hash};<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0else if (!strncmp(cert_prop, &q=
uot;THUMB:&quot;, 6))<br>=C2=A0 =C2=A0 =C2=A0{<br>- =C2=A0 =C2=A0 =C2=A0 =
=C2=A0unsigned char hash[255];<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0CRYPT_HASH_B=
LOB blob;<br></blockquote><div><br></div><div>Why did you move &quot;hash&q=
uot; and &quot;blob&quot; to the outer scope? I think those</div><div>varia=
bles should stay where they have been, since they&#39;re not used outside o=
f &quot;if&quot;.</div><div><br></div><div>-Lev</div></div></div>

--000000000000161d50059e49d1c0--

