MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=_c942b7f0d90222254cb1865baff3c0bc"
From: pbarton@...1924...
In-Reply-To: <20160108074124.GR24952@...1296...>
Date: Wed, 06 Jul 2016 20:09:48 -0700
Message-Id: <20160706200948.26b81b44f7069d75256c531b0c1ba101.35ea235183.mailapi@...2149...>
Subject: Re: [Openvpn-devel] Code to confirm "FIPS MODE" throwing compile
 error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Kevin Long <kevinlong206@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--=_c942b7f0d90222254cb1865baff3c0bc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

--------- Original Message --------- Subject: Re: [Openvpn-devel] Code to c=
onfirm "FIPS MODE" throwing compile error
From: "Gert Doering" <gert@...1296...>
Date: 1/8/16 1:41 am
To: "Kevin Long" <kevinlong206@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi

 On Thu, Jan 07, 2016 at 02:57:34PM -0800, Kevin Long wrote:
 >=20
 > I believe I have successfully compiled openvpn on debian , using static =
openssl library containing the FIPS compliance module.
 >=20
 >=20
 > However, I have followed this instruction found online:
 >=20
 > "Now you should have a FIPS capable OpenSSL (NOTE: OpenSSL itself is not=
 FIPS validated, only FIPS capable along with the FIPS Object Module). To m=
ake OpenVPN FIPS compliant, you need to add:
 >=20
 > #ifdef OPENSSL_FIPS=20
 > if(options.no_fips <=3D 0) {
 > if(!FIPS_mode_set(1) {
 > ERR_load_crypto_strings();
 > ERR_print_errors_fp(stderr);
 > exit(1);
 >=20
 > }
 > }
 > else
 > fprintf(stderr,"*** IN FIPS MODE ***\n");
 > #endif

 I'm not sure where this is coming from (it's not something I've seen
 before) but it is at least broken C code - the "if (!FIPS_mode_set(1)" line
 is missing a closing bracket - and it is based on patches to options.c
 and options.h that are missing - as you've noticed, there is no "no_fips"
 field in the "options" structure (and, at this place in the code, there
 is not even an "options" variable around).

 gert
 --=20


 I was wondering anyone maintains the patch file that would cover the optio=
ns.h change?  I found one here:
=20
https://build.opensuse.org/package/show/network:vpn/openvpn
=20
but that patch for options.h only has this:
=20
--- openvpn-2.3.2/src/openvpn/options.c
+++ openvpn-2.3.2/src/openvpn/options.c 2015/02/19 09:15:10
@@ -828,6 +828,10 @@ init_options (struct options *o, const b
 #endif
 #ifdef ENABLE_CRYPTO
 o->ciphername =3D "BF-CBC";
+#ifdef OPENSSL_FIPS
+ if(FIPS_mode())
+ o->ciphername =3D "AES-256-CBC";
+#endif
 o->ciphername_defined =3D true;
 o->authname =3D "SHA1";
 o->authname_defined =3D true;
 However, this still does not define the no_fips.  Is there a maintained pa=
tch for openvpn?  Any help would be appreciated.
=20=20
 Thank you,
 Peter

--=_c942b7f0d90222254cb1865baff3c0bc
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<blockquote class=3D"threadBlockQuote" style=3D"border-left: 2px solid #C2C=
2C2; padding-left: 3px; margin-left: 4px;">--------- Original Message -----=
----
<div>Subject: Re: [Openvpn-devel] Code to confirm "FIPS MODE" throwing comp=
ile error<br />From: "Gert Doering" &lt;gert@...1296...&gt;<br />Date: 1/8/=
16 1:41 am<br />To: "Kevin Long" &lt;kevinlong206@...277...&gt;<br />Cc: op=
envpn-devel@lists.sourceforge.net<br /><br />Hi<br /><br /> On Thu, Jan 07,=
 2016 at 02:57:34PM -0800, Kevin Long wrote:<br /> &gt; <br /> &gt; I belie=
ve I have successfully compiled openvpn on debian , using static openssl li=
brary containing the FIPS compliance module.<br /> &gt; <br /> &gt; <br /> =
&gt; However, I have followed this instruction found online:<br /> &gt; <br=
 /> &gt; "Now you should have a FIPS capable OpenSSL (NOTE: OpenSSL itself =
is not FIPS validated, only FIPS capable along with the FIPS Object Module)=
. To make OpenVPN FIPS compliant, you need to add:<br /> &gt; <br /> &gt; #=
ifdef OPENSSL_FIPS <br /> &gt; if(options.no_fips &lt;=3D 0) {<br /> &gt; i=
f(!FIPS_mode_set(1) {<br /> &gt; ERR_load_crypto_strings();<br /> &gt; ERR_=
print_errors_fp(stderr);<br /> &gt; exit(1);<br /> &gt; <br /> &gt; }<br />=
 &gt; }<br /> &gt; else<br /> &gt; fprintf(stderr,"*** IN FIPS MODE ***\n")=
;<br /> &gt; #endif<br /><br /> I'm not sure where this is coming from (it'=
s not something I've seen<br /> before) but it is at least broken C code - =
the "if (!FIPS_mode_set(1)" line<br /> is missing a closing bracket - and i=
t is based on patches to options.c<br /> and options.h that are missing - a=
s you've noticed, there is no "no_fips"<br /> field in the "options" struct=
ure (and, at this place in the code, there<br /> is not even an "options" v=
ariable around).<br /><br /> gert<br /> -- <br /><br /></div>
</blockquote>
<div>I was wondering anyone maintains the patch file that would cover the o=
ptions.h change? &nbsp;I found one here:</div>
<div>&nbsp;</div>
<div>https://build.opensuse.org/package/show/network:vpn/openvpn</div>
<div>&nbsp;</div>
<div>but that patch for options.h only has this:</div>
<div>&nbsp;</div>
<div>
<p>--- openvpn-2.3.2/src/openvpn/options.c<br />+++ openvpn-2.3.2/src/openv=
pn/options.c 2015/02/19 09:15:10<br />@@ -828,6 +828,10 @@ init_options (st=
ruct options *o, const b<br /> #endif<br /> #ifdef ENABLE_CRYPTO<br /> o-&g=
t;ciphername =3D "BF-CBC";<br />+#ifdef OPENSSL_FIPS<br />+ if(FIPS_mode())=
<br />+ o-&gt;ciphername =3D "AES-256-CBC";<br />+#endif<br /> o-&gt;cipher=
name_defined =3D true;<br /> o-&gt;authname =3D "SHA1";<br /> o-&gt;authnam=
e_defined =3D true;</p>
<p>However, this still does not define the no_fips. &nbsp;Is there a mainta=
ined patch for openvpn? &nbsp;Any help would be appreciated.</p>
<p>&nbsp;</p>
<p>Thank you,</p>
<p>Peter</p>
</div>

--=_c942b7f0d90222254cb1865baff3c0bc--

