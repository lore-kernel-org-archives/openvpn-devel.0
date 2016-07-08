References: <20160708075524.26b81b44f7069d75256c531b0c1ba101.470311a15d.mailapi@...2149...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <2514f480-3a44-cd26-72b4-cd793d66d640@...1147...>
Date: Fri, 8 Jul 2016 18:18:08 +0200
MIME-Version: 1.0
In-Reply-To: <20160708075524.26b81b44f7069d75256c531b0c1ba101.470311a15d.mailapi@...2149...>
Content-Type: multipart/alternative;
	boundary="------------7A7C162A3F0D2179D1B1BB33"
Subject: Re: [Openvpn-devel] [Openvpn-users] Segmentation Fault
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: pbarton@...1924..., openvpn-users@lists.sourceforge.net, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------7A7C162A3F0D2179D1B1BB33
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 08/07/16 16:55, pbarton@...1924... wrote:
>
>     Please run the OpenVPN instance which core dumps via gdb. When it
>     segfaults, type the command 'bt' (backtrace) and provide us with the
>     complete backtrace. Then we can have an idea where in the code it
>     crashed.
>
>     Another alternative is to enable core dump files (a global system
>     configuration, not an OpenVPN setting), those files can then be
>     run via
>     gdb and the backtrace can be captured afterwards.
>
>     Without a backtrace it is nearly impossible to understand why it
>     crashes. Most likely it is related to a NULL pointer, but which
>     pointer
>     will be plain guesswork which mostly would be a lot of wasted time.
>
>
>
I can reproduce the exact same thing; the culprit in the code is in 
ssl.c, line 1453:

1431 static void
1432 tls1_PRF(uint8_t *label,
1433      int label_len,
1434      const uint8_t *sec,
1435      int slen,
1436      uint8_t *out1,
1437      int olen)
1438 {
1439   struct gc_arena gc = gc_new ();
1440   const md_kt_t *md5 = md_kt_get("MD5");
1441   const md_kt_t *sha1 = md_kt_get("SHA1");
1442   int len,i;
1443   const uint8_t *S1,*S2;
1444   uint8_t *out2;
1445
1446   out2 = (uint8_t *) gc_malloc (olen, false, &gc);
1447
1448   len=slen/2;
1449   S1=sec;
1450   S2= &(sec[len]);
1451   len+=(slen&1); /* add for odd, make longer */
1452
1453   tls1_P_hash(md5 ,S1,len,label,label_len,out1,olen);
1454   tls1_P_hash(sha1,S2,len,label,label_len,out2,olen);
1455
1456   for (i=0; i<olen; i++)
1457     out1[i]^=out2[i];
1458
1459   memset (out2, 0, olen);
1460
1461   dmsg (D_SHOW_KEY_SOURCE, "tls1_PRF out[%d]: %s", olen, format_hex 
(out1, olen, 0, &gc));
1462
1463   gc_free (&gc);
1464 }


I'm actually not entirely surprised that a FIPS-enabled ssl lib no 
longer likes MD5 - but the question is, what can be done about it 
without breaking OpenVPN interoperability?

Weirdly enough, the "md5" object does not seem to be NULL
There's a patch from OpenSuSE that adds FIPS support to OpenVPN 2.3.2 - 
perhaps we should take a closer look at that:

https://build.opensuse.org/package/view_file/network:vpn/openvpn/openvpn-fips140-2.3.2.patch?expand=1


HTH,

JJK



--------------7A7C162A3F0D2179D1B1BB33
X-MIME-Autoconverted: from 8bit to quoted-printable by
	outgoing3-ams.mf.surf.net id u68GIB8H009261
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      On 08/07/16 16:55, <a class=3D"moz-txt-link-abbreviated" href=3D"mail=
to:pbarton@...1924...">pbarton@...1924...</a> wrote:<br>
    </div>
    <blockquote
cite=3D"mid:20160708075524.26b81b44f7069d75256c531b0c1ba101.470311a15d.mail=
api@...2149..."
      type=3D"cite">
      <blockquote class=3D"threadBlockQuote" style=3D"border-left: 2px solid
        #C2C2C2; padding-left: 3px; margin-left: 4px;">
        <div>Please run the OpenVPN instance which core dumps via gdb.
          When it<br>
          segfaults, type the command 'bt' (backtrace) and provide us
          with the<br>
          complete backtrace. Then we can have an idea where in the code
          it crashed.<br>
          <br>
          Another alternative is to enable core dump files (a global
          system<br>
          configuration, not an OpenVPN setting), those files can then
          be run via<br>
          gdb and the backtrace can be captured afterwards.<br>
          <br>
          Without a backtrace it is nearly impossible to understand why
          it<br>
          crashes. Most likely it is related to a NULL pointer, but
          which pointer<br>
          will be plain guesswork which mostly would be a lot of wasted
          time.<br>
          <br>
          <br>
        </div>
        <br>
      </blockquote>
    </blockquote>
    I can reproduce the exact same thing; the culprit in the code is in
    ssl.c, line 1453:<br>
    <br>
    1431 static void<br>
    1432 tls1_PRF(uint8_t *label,<br>
    1433=A0=A0=A0=A0=A0 int label_len,<br>
    1434=A0=A0=A0=A0=A0 const uint8_t *sec,<br>
    1435=A0=A0=A0=A0=A0 int slen,<br>
    1436=A0=A0=A0=A0=A0 uint8_t *out1,<br>
    1437=A0=A0=A0=A0=A0 int olen)<br>
    1438 { <br>
    1439=A0=A0 struct gc_arena gc =3D gc_new ();<br>
    1440=A0=A0 const md_kt_t *md5 =3D md_kt_get("MD5"); <br>
    1441=A0=A0 const md_kt_t *sha1 =3D md_kt_get("SHA1");<br>
    1442=A0=A0 int len,i;<br>
    1443=A0=A0 const uint8_t *S1,*S2;<br>
    1444=A0=A0 uint8_t *out2;<br>
    1445 <br>
    1446=A0=A0 out2 =3D (uint8_t *) gc_malloc (olen, false, &amp;gc);<br>
    1447 <br>
    1448=A0=A0 len=3Dslen/2;<br>
    1449=A0=A0 S1=3Dsec;<br>
    1450=A0=A0 S2=3D &amp;(sec[len]);<br>
    1451=A0=A0 len+=3D(slen&amp;1); /* add for odd, make longer */<br>
    1452 <br>
    1453=A0=A0 tls1_P_hash(md5 ,S1,len,label,label_len,out1,olen);<br>
    1454=A0=A0 tls1_P_hash(sha1,S2,len,label,label_len,out2,olen);<br>
    1455=A0=A0 <br>
    1456=A0=A0 for (i=3D0; i&lt;olen; i++)<br>
    1457=A0=A0=A0=A0 out1[i]^=3Dout2[i];<br>
    1458=A0=A0=A0=A0 <br>
    1459=A0=A0 memset (out2, 0, olen);<br>
    1460 <br>
    1461=A0=A0 dmsg (D_SHOW_KEY_SOURCE, "tls1_PRF out[%d]: %s", olen,
    format_hex (out1, olen, 0, &amp;gc));<br>
    1462 <br>
    1463=A0=A0 gc_free (&amp;gc);<br>
    1464 }<br>
    <br>
    <br>
    I'm actually not entirely surprised that a FIPS-enabled ssl lib no
    longer likes MD5 - but the question is, what can be done about it
    without breaking OpenVPN interoperability?<br>
    <br>
    Weirdly enough, the "md5" object does not seem to be NULL <br>
    There's a patch from OpenSuSE that adds FIPS support to OpenVPN
    2.3.2 - perhaps we should take a closer look at that:<br>
    <br>
<a class=3D"moz-txt-link-freetext" href=3D"https://build.opensuse.org/packa=
ge/view_file/network:vpn/openvpn/openvpn-fips140-2.3.2.patch?expand=3D1">ht=
tps://build.opensuse.org/package/view_file/network:vpn/openvpn/openvpn-fips=
140-2.3.2.patch?expand=3D1</a><br>
    <br>
    <br>
    HTH,<br>
    <br>
    JJK<br>
    <br>
    <br>
  </body>
</html>

--------------7A7C162A3F0D2179D1B1BB33--

