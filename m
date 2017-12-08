MIME-Version: 1.0
In-Reply-To: <1512729211-8407-1-git-send-email-steffan@...1856...>
References: <1512729211-8407-1-git-send-email-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 8 Dec 2017 10:16:03 -0500
Message-ID: <CAKuzo_jJx0U0hEnuv=BFGm_d6ME4JP44mDCCoBPwzCBdRs+dVA@...278...>
Content-Type: multipart/alternative; boundary="94eb2c076b9ae6a7ba055fd5aaff"
Subject: Re: [Openvpn-devel] [PATCH] Don't throw fatal errors from
 verify_cert_export_cert()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--94eb2c076b9ae6a7ba055fd5aaff
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Dec 8, 2017 at 5:33 AM, Steffan Karger <steffan@...1856...> wrote:

> From: Steffan Karger <steffan.karger@...1435...>
>
> As with create_temp_file(), this function is called on client connects and
> should not cause fatal errors when I/O (possibly temporarily) fails.
>
> The callers of this function are already fixed in the commit that does the
> same for create_temp_file().
>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/ssl_verify.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index ebb1da2..12cff9a 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -557,13 +557,14 @@ verify_cert_export_cert(openvpn_x509_cert_t
> *peercert, const char *tmp_dir, stru
>      peercert_file = fopen(peercert_filename, "w+");
>      if (!peercert_file)
>      {
> -        msg(M_ERR, "Failed to open temporary file : %s",
> peercert_filename);
> +        msg(M_ERRNO, "Failed to open temporary file : %s",
> peercert_filename);
>

I think M_ERRNO alone is not a good flag  -- if you OR it with M_NONFATAL,
syslog
will get level = LOG_ERR, management will get the 'N' flag etc.

Selva

--94eb2c076b9ae6a7ba055fd5aaff
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Fri, Dec 8, 2017 at 5:33 AM, Steffan Karger <span dir=3D"ltr">&lt=
;<a href=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Steffan Karg=
er &lt;<a href=3D"mailto:steffan.karger@...1435...">steffan.karger@...2191...=
..</a>&gt;<br>
<br>
As with create_temp_file(), this function is called on client connects and<=
br>
should not cause fatal errors when I/O (possibly temporarily) fails.<br>
<br>
The callers of this function are already fixed in the commit that does the<=
br>
same for create_temp_file().<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan.karger@...2191...=
..">steffan.karger@...1435...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/ssl_verify.c | 5 +++--<br>
=C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c<br>
index ebb1da2..12cff9a 100644<br>
--- a/src/openvpn/ssl_verify.c<br>
+++ b/src/openvpn/ssl_verify.c<br>
@@ -557,13 +557,14 @@ verify_cert_export_cert(<wbr>openvpn_x509_cert_t *pee=
rcert, const char *tmp_dir, stru<br>
=C2=A0 =C2=A0 =C2=A0peercert_file =3D fopen(peercert_filename, &quot;w+&quo=
t;);<br>
=C2=A0 =C2=A0 =C2=A0if (!peercert_file)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_ERR, &quot;Failed to open temporary file=
 : %s&quot;, peercert_filename);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_ERRNO, &quot;Failed to open temporary fi=
le : %s&quot;, peercert_filename);<br></blockquote><div><br></div><div>I th=
ink M_ERRNO alone is not a good flag=C2=A0 -- if you OR it with M_NONFATAL,=
 syslog</div><div>will get level =3D LOG_ERR, management will get the &#39;=
N&#39; flag etc.</div><div><br></div><div>Selva=C2=A0</div></div></div></di=
v>

--94eb2c076b9ae6a7ba055fd5aaff--

