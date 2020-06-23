MIME-Version: 1.0
References: <20200622232319.8143-2-James.Bottomley@...2316...>
 <202006230628.05N6Sa3g001325@...2054...>
 <20200623072123.GA2034@...1296...>
 <1592917531.4768.4.camel@...2316...>
 <CAFHpkQF5tz91P_UJxMuNCRDUYodw8QPV8=h8mmkSTHOUH5AdfA@...278...>
In-Reply-To: <CAFHpkQF5tz91P_UJxMuNCRDUYodw8QPV8=h8mmkSTHOUH5AdfA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 23 Jun 2020 21:43:35 +0500
Message-ID: <CAFHpkQH-yGFBJ=-Eaz5XCSaUcD-=S00y=MvPs6Vmr5nE_PcTRg@...278...>
Content-Type: multipart/alternative; boundary="0000000000002a2ce505a8c310bd"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine
 keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002a2ce505a8c310bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

as far as I understand, openssl-1.0.2 does not support engines ?

=D0=B2=D1=82, 23 =D0=B8=D1=8E=D0=BD. 2020 =D0=B3. =D0=B2 21:42, =D0=98=D0=
=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...1665...=
77...>:

> apparently, it fails for some build on travis
> https://travis-ci.org/github/OpenVPN/openvpn/jobs/701158156
>
> =D0=B2=D1=82, 23 =D0=B8=D1=8E=D0=BD. 2020 =D0=B3. =D0=B2 18:07, James Bot=
tomley <
> James.Bottomley@...2317...>:
>
>> On Tue, 2020-06-23 at 09:21 +0200, Gert Doering wrote:
>> > Hi,
>> >
>> > On Tue, Jun 23, 2020 at 08:28:36AM +0200, Gert Doering wrote:
>> > > Acked-by: Gert Doering <gert@...1296...>
>> > >
>> > > Tested on :
>> > >  - MacOS Mojave with OpenSSL 1.1.1c (brew) and out-of-tree build,
>> > > works.
>> > >  - Linux with mbedtls (does not try engine tests, good :-) )
>> > >  - Linux with OpenSSL 1.1.1, works
>> > >  - FreeBSD 11.3 with OpenSSL 1.0.2s -> v6 fails, v6 works \o/
>> > >
>> > > Conferred with Arne, we agreed on "this is good enough, and who
>> > > wants
>> > > something more sophisticated is welcome to send more patches".
>> >
>> > Oh well.  We do need another round - Travis tells me that "make
>> > distcheck"
>> > is failing.  Which hints at "autoconf is not told what to pack in the
>> > tarball"
>> >
>> > https://travis-ci.org/github/OpenVPN/openvpn/jobs/701158155
>> > ...
>> > make[6]: Entering directory
>> > '/home/travis/build/OpenVPN/openvpn/openvpn-
>> > 2.5_git/_build/sub/tests/unit_tests/engine-key'
>> > 3672make[6]: *** No rule to make target
>> > '../../../../../tests/unit_tests/engine-key/openssl.cnf.in', needed
>> > by 'openssl.cnf'.  Stop.
>> > 3673make[6]: Leaving directory
>> > '/home/travis/build/OpenVPN/openvpn/openvpn-
>> > 2.5_git/_build/sub/tests/unit_tests/engine-key'
>> > 3674
>> >
>> > (so now the source file is missing)
>> >
>> > Please... :-)
>>
>> Sorry about that ... it's missing files from EXTRA_DIST ... plus I
>> don't usually use make dist, so I never remember to run make distcheck.
>>  It passes after this
>>
>> ---8>8>8><8<8<8---
>>
>> From: James Bottomley <James.Bottomley@...2316...>
>> Subject: [PATCH] Fix make distcheck for new engine key unit test
>>
>> Add config precursor and script to extra dist and make sure
>> built and test leftover files are cleaned up afterwards.
>>
>> Signed-off-by: James Bottomley <James.Bottomley@...2316...>
>> ---
>>  tests/unit_tests/engine-key/Makefile.am | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/unit_tests/engine-key/Makefile.am
>> b/tests/unit_tests/engine-key/Makefile.am
>> index 95e7d868..0bfdfcd4 100644
>> --- a/tests/unit_tests/engine-key/Makefile.am
>> +++ b/tests/unit_tests/engine-key/Makefile.am
>> @@ -2,6 +2,9 @@ AUTOMAKE_OPTIONS =3D foreign
>>
>>  check_LTLIBRARIES =3D libtestengine.la
>>  conffiles =3D openssl.cnf
>> +EXTRA_DIST =3D \
>> +       openssl.cnf.in \
>> +       check_engine_keys.sh
>>
>>  TESTS_ENVIRONMENT =3D srcdir=3D"$(abs_srcdir)"; \
>>         builddir=3D"$(abs_builddir)"; \
>> @@ -12,8 +15,11 @@ TESTS_ENVIRONMENT =3D srcdir=3D"$(abs_srcdir)"; \
>>  TESTS =3D check_engine_keys.sh
>>  check_engine_keys.sh: $(conffiles)
>>
>> -clean-local:
>> -       rm -f $(conffiles)
>> +CLEANFILES =3D \
>> +       client.key \
>> +       passwd \
>> +       log.txt \
>> +       $(conffiles)
>>
>>  $(builddir)/openssl.cnf: $(srcdir)/openssl.cnf.in
>>         sed "s|ABSBUILDDIR|$(abs_builddir)|" < $< > $@
>> --
>> 2.26.2
>>
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>

--0000000000002a2ce505a8c310bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">as far as I understand, openssl-1.0.2 does not support eng=
ines ?<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">=D0=B2=D1=82, 23 =D0=B8=D1=8E=D0=BD. 2020 =D0=B3. =D0=B2 21:42, =
=D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a =
href=3D"mailto:chipitsine@...277...">chipitsine@...277...</a>&gt;:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>ap=
parently, it fails for some build on travis</div><div><a href=3D"https://tr=
avis-ci.org/github/OpenVPN/openvpn/jobs/701158156" target=3D"_blank">https:=
//travis-ci.org/github/OpenVPN/openvpn/jobs/701158156</a></div></div><br><d=
iv class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=82=
, 23 =D0=B8=D1=8E=D0=BD. 2020 =D0=B3. =D0=B2 18:07, James Bottomley &lt;<a =
href=3D"mailto:James.Bottomley@...2317..." target=3D"_blank">James.Bottomle=
y@...2317...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Tue, 2020-06-23 at 09:21 +0200, Gert Doering wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; On Tue, Jun 23, 2020 at 08:28:36AM +0200, Gert Doering wrote:<br>
&gt; &gt; Acked-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." tar=
get=3D"_blank">gert@...1296...</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; Tested on :<br>
&gt; &gt;=C2=A0 - MacOS Mojave with OpenSSL 1.1.1c (brew) and out-of-tree b=
uild,<br>
&gt; &gt; works.<br>
&gt; &gt;=C2=A0 - Linux with mbedtls (does not try engine tests, good :-) )=
<br>
&gt; &gt;=C2=A0 - Linux with OpenSSL 1.1.1, works<br>
&gt; &gt;=C2=A0 - FreeBSD 11.3 with OpenSSL 1.0.2s -&gt; v6 fails, v6 works=
 \o/<br>
&gt; &gt; <br>
&gt; &gt; Conferred with Arne, we agreed on &quot;this is good enough, and =
who<br>
&gt; &gt; wants <br>
&gt; &gt; something more sophisticated is welcome to send more patches&quot=
;.<br>
&gt; <br>
&gt; Oh well.=C2=A0 We do need another round - Travis tells me that &quot;m=
ake<br>
&gt; distcheck&quot;<br>
&gt; is failing.=C2=A0 Which hints at &quot;autoconf is not told what to pa=
ck in the<br>
&gt; tarball&quot;<br>
&gt; <br>
&gt; <a href=3D"https://travis-ci.org/github/OpenVPN/openvpn/jobs/701158155=
" rel=3D"noreferrer" target=3D"_blank">https://travis-ci.org/github/OpenVPN=
/openvpn/jobs/701158155</a><br>
&gt; ...<br>
&gt; make[6]: Entering directory<br>
&gt; &#39;/home/travis/build/OpenVPN/openvpn/openvpn-<br>
&gt; 2.5_git/_build/sub/tests/unit_tests/engine-key&#39;<br>
&gt; 3672make[6]: *** No rule to make target<br>
&gt; &#39;../../../../../tests/unit_tests/engine-key/<a href=3D"http://open=
ssl.cnf.in" rel=3D"noreferrer" target=3D"_blank">openssl.cnf.in</a>&#39;, n=
eeded<br>
&gt; by &#39;openssl.cnf&#39;.=C2=A0 Stop.<br>
&gt; 3673make[6]: Leaving directory<br>
&gt; &#39;/home/travis/build/OpenVPN/openvpn/openvpn-<br>
&gt; 2.5_git/_build/sub/tests/unit_tests/engine-key&#39;<br>
&gt; 3674<br>
&gt; <br>
&gt; (so now the source file is missing)<br>
&gt; <br>
&gt; Please... :-)<br>
<br>
Sorry about that ... it&#39;s missing files from EXTRA_DIST ... plus I<br>
don&#39;t usually use make dist, so I never remember to run make distcheck.=
<br>
=C2=A0It passes after this<br>
<br>
---8&gt;8&gt;8&gt;&lt;8&lt;8&lt;8---<br>
<br>
From: James Bottomley &lt;James.Bottomley@...2316...&gt;<br>
Subject: [PATCH] Fix make distcheck for new engine key unit test<br>
<br>
Add config precursor and script to extra dist and make sure<br>
built and test leftover files are cleaned up afterwards.<br>
<br>
Signed-off-by: James Bottomley &lt;James.Bottomley@...2316...&gt;<br>
---<br>
=C2=A0tests/unit_tests/engine-key/Makefile.am | 10 ++++++++--<br>
=C2=A01 file changed, 8 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/tests/unit_tests/engine-key/Makefile.am b/tests/unit_tests/eng=
ine-key/Makefile.am<br>
index 95e7d868..0bfdfcd4 100644<br>
--- a/tests/unit_tests/engine-key/Makefile.am<br>
+++ b/tests/unit_tests/engine-key/Makefile.am<br>
@@ -2,6 +2,9 @@ AUTOMAKE_OPTIONS =3D foreign<br>
<br>
=C2=A0check_LTLIBRARIES =3D <a href=3D"http://libtestengine.la" rel=3D"nore=
ferrer" target=3D"_blank">libtestengine.la</a><br>
=C2=A0conffiles =3D openssl.cnf<br>
+EXTRA_DIST =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://openssl.cnf.in" rel=3D"norefe=
rrer" target=3D"_blank">openssl.cnf.in</a> \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0check_engine_keys.sh<br>
<br>
=C2=A0TESTS_ENVIRONMENT =3D srcdir=3D&quot;$(abs_srcdir)&quot;; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 builddir=3D&quot;$(abs_builddir)&quot;; \<br>
@@ -12,8 +15,11 @@ TESTS_ENVIRONMENT =3D srcdir=3D&quot;$(abs_srcdir)&quot;=
; \<br>
=C2=A0TESTS =3D check_engine_keys.sh<br>
=C2=A0check_engine_keys.sh: $(conffiles)<br>
<br>
-clean-local:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f $(conffiles)<br>
+CLEANFILES =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0client.key \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0passwd \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0log.txt \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(conffiles)<br>
<br>
=C2=A0$(builddir)/openssl.cnf: $(srcdir)/<a href=3D"http://openssl.cnf.in" =
rel=3D"noreferrer" target=3D"_blank">openssl.cnf.in</a><br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sed &quot;s|ABSBUILDDIR|$(abs_builddir)|&quot; =
&lt; $&lt; &gt; $@<br>
-- <br>
2.26.2<br>
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
</blockquote></div>
</blockquote></div>

--0000000000002a2ce505a8c310bd--

