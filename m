MIME-Version: 1.0
References: <20230204004512.250271-2-selva.nair@...277...>
 <20230204064010.257925-1-selva.nair@...277...>
 <20230204064010.257925-2-selva.nair@...277...>
 <74a4194f-2d86-2bce-195b-0cae9f294597@...1227...>
In-Reply-To: <74a4194f-2d86-2bce-195b-0cae9f294597@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 7 Feb 2023 20:05:10 -0500
Message-ID: <CAKuzo_g3LBd0Ss7DN7MT-D8040FvRUs__093RXG7sWAJAhOxaw@...278...>
Content-Type: multipart/alternative; boundary="00000000000014ad4205f425dc48"
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] Add a unit test for functions in
 cryptoapi.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000014ad4205f425dc48
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Feb 7, 2023 at 7:18 PM Arne Schwabe <arne@...1227...> wrote:

> Am 04.02.23 um 07:40 schrieb selva.nair@...277...:
> > From: Selva Nair <selva.nair@...277...>
> >
> > - Though named cryptoapi_testdriver, right now this only tests
> >    parsing of thumbprint specified as a selector for --cryptioapicert
> >    option. More tests coming..
> >
> > v2: a line that belongs here was mistakenly included in the previous
> > commit. Corrected.
> >
> > Signed-off-by: Selva Nair <selva.nair@...277...>
>
> While a good step, this still has problems. With OpenSSL 1.1.1 it still
> tries to run the check-engine.sh script and unsurprisingly fails:
>
> ---- begin log.txt ----
> ./check_engine_keys.sh: 25: ../../../src/openvpn/openvpn: not found
> --- end log.txt ---
> Key mismatch not detected
> FAIL: check_engine_keys.sh
>
> This can be fixed by:
>
> --- a/tests/unit_tests/engine-key/Makefile.am
> +++ b/tests/unit_tests/engine-key/Makefile.am
> @@ -12,7 +12,9 @@ TESTS_ENVIRONMENT = srcdir="$(abs_srcdir)"; \
>          top_srcdir="$(top_srcdir)"; \
>          export srcdir builddir top_builddir top_srcdir;
>
> +if !CROSS_COMPILING
>   TESTS = check_engine_keys.sh
> +endif
>   check_engine_keys.sh: $(conffiles)
>
>   CLEANFILES = \
>

Thanks for this. I added this to 2/3 where it belongs and submitted it as
v3 2/3. With that, this patch should be okay as is.

For those not following closely, this patch  should be applied after the
cryptoapi patch set where the function being tested here is introduced.

Selva

--00000000000014ad4205f425dc48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Feb 7, 2023 at 7:18 PM Arne Schwabe &lt;<a=
 href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 04.02.=
23 um 07:40 schrieb <a href=3D"mailto:selva.nair@...277..." target=3D"_blan=
k">selva.nair@...277...</a>:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; - Though named cryptoapi_testdriver, right now this only tests<br>
&gt;=C2=A0 =C2=A0 parsing of thumbprint specified as a selector for --crypt=
ioapicert<br>
&gt;=C2=A0 =C2=A0 option. More tests coming..<br>
&gt; <br>
&gt; v2: a line that belongs here was mistakenly included in the previous<b=
r>
&gt; commit. Corrected.<br>
&gt; <br>
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br>
<br>
While a good step, this still has problems. With OpenSSL 1.1.1 it still <br>
tries to run the check-engine.sh script and unsurprisingly fails:<br>
<br>
---- begin log.txt ----<br>
./check_engine_keys.sh: 25: ../../../src/openvpn/openvpn: not found<br>
--- end log.txt ---<br>
Key mismatch not detected<br>
FAIL: check_engine_keys.sh<br>
<br>
This can be fixed by:<br>
<br>
--- a/tests/unit_tests/engine-key/Makefile.am<br>
+++ b/tests/unit_tests/engine-key/Makefile.am<br>
@@ -12,7 +12,9 @@ TESTS_ENVIRONMENT =3D srcdir=3D&quot;$(abs_srcdir)&quot;;=
 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0top_srcdir=3D&quot;$(top_srcdir)&quot;; \=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0export srcdir builddir top_builddir top_s=
rcdir;<br>
<br>
+if !CROSS_COMPILING<br>
=C2=A0 TESTS =3D check_engine_keys.sh<br>
+endif<br>
=C2=A0 check_engine_keys.sh: $(conffiles)<br>
<br>
=C2=A0 CLEANFILES =3D \<br></blockquote><div><br></div><div>Thanks for this=
. I added this to 2/3 where it belongs and submitted it as v3 2/3. With tha=
t, this patch should be okay as is.=C2=A0</div><div><br></div><div>For thos=
e not following closely, this patch=C2=A0 should be applied after the crypt=
oapi patch set where the function being tested here is introduced.</div><di=
v><br></div><div>Selva</div></div></div>

--00000000000014ad4205f425dc48--

