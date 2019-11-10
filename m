MIME-Version: 1.0
References: <20191110133525.6069-1-a@...2181...>
 <20191110133525.6069-3-a@...2181...>
In-Reply-To: <20191110133525.6069-3-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 10 Nov 2019 11:48:16 -0500
Message-ID: <CAKuzo_ha8xxM+bw=Lrq01dnCNhNDqzS1EQGaptjUrdDq5pqcLg@...278...>
Content-Type: multipart/alternative; boundary="0000000000000def9b059700c958"
Subject: Re: [Openvpn-devel] [PATCH 3/3] travis: compile with -Werror on
 Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000000def9b059700c958
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, Nov 10, 2019 at 8:36 AM Antonio Quartulli <a@...2181...> wrote:

> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  .travis/build-check.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.travis/build-check.sh b/.travis/build-check.sh
> index 039a7dcf..250bb454 100755
> --- a/.travis/build-check.sh
> +++ b/.travis/build-check.sh
> @@ -8,6 +8,7 @@ fi
>
>  if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
>         export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH:-}"
> +       export CFLAGS="${CFLAGS} -Werror"
>  fi
>

If this is only for linux (and travis), and works with the current code
base, probably its fine.

But it seems it may also affect mingw builds on travis. I would resist the
temptation to add -Werror in general and to Windows cross-build in
particular.

Not all warnings can be fixed easily. Often the only option is to hide the
warning  (e.g, by adding a cast) which imo is not always a good strategy.
-Werror just forces one's hand to use tricks that hide warnings.

Selva

--0000000000000def9b059700c958
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Sun, Nov 10, 2019 at 8:36 AM Antonio Quartulli =
&lt;a@...2181...&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>
---<br>
=C2=A0.travis/build-check.sh | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/.travis/build-check.sh b/.travis/build-check.sh<br>
index 039a7dcf..250bb454 100755<br>
--- a/.travis/build-check.sh<br>
+++ b/.travis/build-check.sh<br>
@@ -8,6 +8,7 @@ fi<br>
<br>
=C2=A0if [ &quot;${TRAVIS_OS_NAME}&quot; =3D &quot;linux&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 export LD_LIBRARY_PATH=3D&quot;${PREFIX}/lib:${=
LD_LIBRARY_PATH:-}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0export CFLAGS=3D&quot;${CFLAGS} -Werror&quot;<b=
r>
=C2=A0fi<br></blockquote><div><br></div><div>If this is only for linux (and=
 travis), and works with the current code</div><div>base, probably its fine=
.</div><div><br></div><div>But it seems it may also affect mingw builds on =
travis. I would resist the</div><div>temptation to add -Werror in general a=
nd to Windows cross-build in particular.</div><div><br></div><div>Not all w=
arnings can be fixed easily. Often the only option is to hide the</div><div=
>warning=C2=A0 (e.g, by adding a cast) which imo is not always a good strat=
egy.</div><div>-Werror just forces one&#39;s hand to use tricks that hide w=
arnings.</div><div><br></div><div>Selva</div></div></div>

--0000000000000def9b059700c958--

