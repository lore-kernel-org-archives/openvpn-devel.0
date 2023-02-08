MIME-Version: 1.0
References: <20230204004512.250271-2-selva.nair@...277...>
 <20230204064010.257925-1-selva.nair@...277...>
 <20230204064010.257925-2-selva.nair@...277...>
 <74a4194f-2d86-2bce-195b-0cae9f294597@...1227...>
 <CAKuzo_g3LBd0Ss7DN7MT-D8040FvRUs__093RXG7sWAJAhOxaw@...278...>
 <b1504d9e-32af-28d5-7279-43034a2f3129@...1227...>
In-Reply-To: <b1504d9e-32af-28d5-7279-43034a2f3129@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 8 Feb 2023 10:43:23 -0500
Message-ID: <CAKuzo_g1N8vuq-V19yca2wVDdBMOYBmTzkFmqBdtT-gW-TwWYg@...278...>
Content-Type: multipart/alternative; boundary="000000000000c757d605f4322027"
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

--000000000000c757d605f4322027
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 8, 2023 at 6:16 AM Arne Schwabe <arne@...1227...> wrote:

> Am 08.02.23 um 02:05 schrieb Selva Nair:
> > Hi,
> >
> > On Tue, Feb 7, 2023 at 7:18 PM Arne Schwabe <arne@...1227...
> > <mailto:arne@...1227...>> wrote:
> >
> >     Am 04.02.23 um 07:40 schrieb selva.nair@...277...
> >     <mailto:selva.nair@...277...>:
> >      > From: Selva Nair <selva.nair@...277... <mailto:
> selva.nair@...277...>>
> >      >
> >      > - Though named cryptoapi_testdriver, right now this only tests
> >      >    parsing of thumbprint specified as a selector for
> --cryptioapicert
> >      >    option. More tests coming..
> >      >
> >      > v2: a line that belongs here was mistakenly included in the
> previous
> >      > commit. Corrected.
> >      >
> >      > Signed-off-by: Selva Nair <selva.nair@...277...
> >     <mailto:selva.nair@...277...>>
> >
> >     While a good step, this still has problems. With OpenSSL 1.1.1 it
> still
> >     tries to run the check-engine.sh script and unsurprisingly fails:
> >
> >     ---- begin log.txt ----
> >     ./check_engine_keys.sh: 25: ../../../src/openvpn/openvpn: not found
> >     --- end log.txt ---
> >     Key mismatch not detected
> >     FAIL: check_engine_keys.sh
> >
> >     This can be fixed by:
> >
> >     --- a/tests/unit_tests/engine-key/Makefile.am
> >     +++ b/tests/unit_tests/engine-key/Makefile.am
> >     @@ -12,7 +12,9 @@ TESTS_ENVIRONMENT = srcdir="$(abs_srcdir)"; \
> >               top_srcdir="$(top_srcdir)"; \
> >               export srcdir builddir top_builddir top_srcdir;
> >
> >     +if !CROSS_COMPILING
> >        TESTS = check_engine_keys.sh
> >     +endif
> >        check_engine_keys.sh: $(conffiles)
> >
> >        CLEANFILES = \
> >
> >
> > Thanks for this. I added this to 2/3 where it belongs and submitted it
> > as v3 2/3. With that, this patch should be okay as is.
> >
> > For those not following closely, this patch  should be applied after the
> > cryptoapi patch set where the function being tested here is introduced.
> >
> > Selva
>
> No, I think this that is independent. This is about the engine keys
> support added by James Bottomley.  I needed and tested this patch
> without the cryptoapi patch.
>

Got that. I think gmail is messing up my thread view -- this email appear
for me as linked to my original 3/3 which is on the test for cryptoapi.
That's why I wrote "this patch should be okay as is."  Anyway...

Will look into your patches later today.

Selva

--000000000000c757d605f4322027
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 8, 2023 at 6:16 AM Arne S=
chwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...2068...=
7...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Am 08.02.23 um 02:05 schrieb Selva Nair:<br>
&gt; Hi,<br>
&gt; <br>
&gt; On Tue, Feb 7, 2023 at 7:18 PM Arne Schwabe &lt;<a href=3D"mailto:arne=
@...1227..." target=3D"_blank">arne@...1227...</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...220...=
..1227...</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Am 04.02.23 um 07:40 schrieb <a href=3D"mailto:selv=
a.nair@...277..." target=3D"_blank">selva.nair@...277...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; From: Selva Nair &lt;<a href=3D"mailto:selva.=
nair@...277..." target=3D"_blank">selva.nair@...277...</a> &lt;mailto:<a hr=
ef=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</=
a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; - Though named cryptoapi_testdriver, right no=
w this only tests<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 parsing of thumbprint specified =
as a selector for --cryptioapicert<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 option. More tests coming..<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; v2: a line that belongs here was mistakenly i=
ncluded in the previous<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; commit. Corrected.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Selva Nair &lt;<a href=3D"mail=
to:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0While a good step, this still has problems. With Op=
enSSL 1.1.1 it still<br>
&gt;=C2=A0 =C2=A0 =C2=A0tries to run the check-engine.sh script and unsurpr=
isingly fails:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0---- begin log.txt ----<br>
&gt;=C2=A0 =C2=A0 =C2=A0./check_engine_keys.sh: 25: ../../../src/openvpn/op=
envpn: not found<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- end log.txt ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0Key mismatch not detected<br>
&gt;=C2=A0 =C2=A0 =C2=A0FAIL: check_engine_keys.sh<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This can be fixed by:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/tests/unit_tests/engine-key/Makefile.am<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/tests/unit_tests/engine-key/Makefile.am<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -12,7 +12,9 @@ TESTS_ENVIRONMENT =3D srcdir=3D&q=
uot;$(abs_srcdir)&quot;; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0top_srcdir=3D&qu=
ot;$(top_srcdir)&quot;; \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0export srcdir bu=
ilddir top_builddir top_srcdir;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+if !CROSS_COMPILING<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 TESTS =3D check_engine_keys.sh<br>
&gt;=C2=A0 =C2=A0 =C2=A0+endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 check_engine_keys.sh: $(conffiles)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 CLEANFILES =3D \<br>
&gt; <br>
&gt; <br>
&gt; Thanks for this. I added this to 2/3 where it belongs and submitted it=
 <br>
&gt; as v3 2/3. With that, this patch should be okay as is.<br>
&gt; <br>
&gt; For those not following closely, this patch=C2=A0 should be applied af=
ter the <br>
&gt; cryptoapi patch set where the function being tested here is introduced=
.<br>
&gt; <br>
&gt; Selva<br>
<br>
No, I think this that is independent. This is about the engine keys <br>
support added by James Bottomley.=C2=A0 I needed and tested this patch <br>
without the cryptoapi patch.<br></blockquote><div><br></div><div>Got that. =
I think gmail is messing up my thread view -- this email appear for me as l=
inked to my original 3/3 which is on the test for cryptoapi. That&#39;s why=
 I wrote &quot;this patch should be okay as is.&quot;=C2=A0 Anyway...</div>=
<div><br></div><div>Will look into your patches later today.</div><div><br>=
</div><div>Selva</div></div></div>

--000000000000c757d605f4322027--

