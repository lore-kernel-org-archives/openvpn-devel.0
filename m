References: <68d50540-ec71-5564-99a7-7bb24ae05d17@...1856...>
	<1480371252-3880-1-git-send-email-steffan@...1856...>
	<CA+0EDdBLaPxX3u07yfg=S-xnVEnFRP7oD=2BnpONtjw7EEkPeQ@...278...>
	<331bcfe6-0373-1542-cdfc-50f360b7ceaa@...1435...>
	<2ebb29c2-6cbf-e770-2f31-5e08fa2f0e9f@...1227...>
	<20161129101812.GE1013@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <769188a1-74c7-a6f9-443c-6bfd8103921c@...1227...>
Date: Tue, 29 Nov 2016 11:28:57 +0100
MIME-Version: 1.0
In-Reply-To: <20161129101812.GE1013@...1296...>
Content-Type: multipart/alternative;
	boundary="------------D8F8A83E56D1B0D4B3CF5F7F"
Subject: Re: [Openvpn-devel] [PATCH v2] Introduce and use secure_memzero()
 to erase secrets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------D8F8A83E56D1B0D4B3CF5F7F
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



Am 29.11.16 um 11:18 schrieb Gert Doering:
> Hi,
>
> On Tue, Nov 29, 2016 at 11:07:12AM +0100, Arne Schwabe wrote:
>> I think we should prefer memset_s if available since it is a C11 standard.
> Since we're currently compiling against C99, we can't rely on it being
> there (in my OS Zoo, only MacOS seems to have it, at least "have a manpage
> for it" - not even FreeBSD 11 or "gentoo current") - but then, configure 
> could check that for us...
I wouldn't add a configure test for that. According to
http://en.cppreference.com/w/c/string/byte/memset:

As all bounds-checked functions, |memset_s| is only guaranteed to be
available if __STDC_LIB_EXT1__ is defined by the implementation and if
the user defines __STDC_WANT_LIB_EXT1__ to the integer constant 1 before
including |string.h|.

so preprocessor magic can check that.
>
> Shall we merge the current patch anyway, as the memory barrier does the
> job on all current compilers, and add a memset_s() variant "whenever 
> one of us finds time to add and test this"?
>
Yes. Go ahead. I might

--------------D8F8A83E56D1B0D4B3CF5F7F
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <p><br>
    </p>
    <br>
    <div class=3D"moz-cite-prefix">Am 29.11.16 um 11:18 schrieb Gert
      Doering:<br>
    </div>
    <blockquote cite=3D"mid:20161129101812.GE1013@...1296..."
      type=3D"cite">
      <pre wrap=3D"">Hi,

On Tue, Nov 29, 2016 at 11:07:12AM +0100, Arne Schwabe wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">I think we should prefer memset_s if available since=
 it is a C11 standard.
</pre>
      </blockquote>
      <pre wrap=3D"">
Since we're currently compiling against C99, we can't rely on it being
there (in my OS Zoo, only MacOS seems to have it, at least "have a manpage
for it" - not even FreeBSD 11 or "gentoo current") - but then, configure=20
could check that for us...</pre>
    </blockquote>
    I wouldn't add a configure test for that. According to
    <a class=3D"moz-txt-link-freetext" href=3D"http://en.cppreference.com/w=
/c/string/byte/memset">http://en.cppreference.com/w/c/string/byte/memset</a=
>:<br>
    <br>
    <meta charset=3D"utf-8">
    <span style=3D"color: rgb(0, 0, 0); font-family: DejaVuSans,
      &quot;DejaVu Sans&quot;, arial, sans-serif; font-size: 12.8px;
      font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: normal; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;">As all bounds-checked functions,<span
        class=3D"Apple-converted-space">=A0</span></span><code
      style=3D"font-family: DejaVuSansMono, &quot;DejaVu Sans Mono&quot;,
      courier, monospace !important; background-color: rgb(255, 255,
      255); color: rgb(0, 0, 0); font-size: 12.8px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; text-decoration-style: initial;
      text-decoration-color: initial;">memset_s</code><span
      style=3D"color: rgb(0, 0, 0); font-family: DejaVuSans, &quot;DejaVu
      Sans&quot;, arial, sans-serif; font-size: 12.8px; font-style:
      normal; font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255); text-decoration-style: initial; text-decoration-color:
      initial; display: inline !important; float: none;"><span
        class=3D"Apple-converted-space">=A0</span>is only guaranteed to be
      available if<span class=3D"Apple-converted-space">=A0</span></span><s=
pan
      class=3D"t-c" style=3D"background-color: rgba(0, 0, 0, 0.027451);
      border: 1px solid rgb(214, 214, 214); border-radius: 3px; margin:
      0px 2px; padding: 0px 2px; display: inline-block; color: rgb(0, 0,
      0); font-family: DejaVuSans, &quot;DejaVu Sans&quot;, arial,
      sans-serif; font-size: 12.8px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; text-decoration-style: initial;
      text-decoration-color: initial;"><span class=3D"mw-geshi c source-c"
        style=3D"font-family: monospace; line-height: normal; white-space:
        nowrap;">__STDC_LIB_EXT1__</span></span><span style=3D"color:
      rgb(0, 0, 0); font-family: DejaVuSans, &quot;DejaVu Sans&quot;,
      arial, sans-serif; font-size: 12.8px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255); text-decoration-style: initial; text-decoration-color:
      initial; display: inline !important; float: none;"><span
        class=3D"Apple-converted-space">=A0</span>is defined by the
      implementation and if the user defines<span
        class=3D"Apple-converted-space">=A0</span></span><span class=3D"t-c"
      style=3D"background-color: rgba(0, 0, 0, 0.027451); border: 1px
      solid rgb(214, 214, 214); border-radius: 3px; margin: 0px 2px;
      padding: 0px 2px; display: inline-block; color: rgb(0, 0, 0);
      font-family: DejaVuSans, &quot;DejaVu Sans&quot;, arial,
      sans-serif; font-size: 12.8px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; text-decoration-style: initial;
      text-decoration-color: initial;"><span class=3D"mw-geshi c source-c"
        style=3D"font-family: monospace; line-height: normal; white-space:
        nowrap;">__STDC_WANT_LIB_EXT1__</span></span><span style=3D"color:
      rgb(0, 0, 0); font-family: DejaVuSans, &quot;DejaVu Sans&quot;,
      arial, sans-serif; font-size: 12.8px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255); text-decoration-style: initial; text-decoration-color:
      initial; display: inline !important; float: none;"><span
        class=3D"Apple-converted-space">=A0</span>to the integer constant<s=
pan
        class=3D"Apple-converted-space">=A0</span></span><span class=3D"t-c"
      style=3D"background-color: rgba(0, 0, 0, 0.027451); border: 1px
      solid rgb(214, 214, 214); border-radius: 3px; margin: 0px 2px;
      padding: 0px 2px; display: inline-block; color: rgb(0, 0, 0);
      font-family: DejaVuSans, &quot;DejaVu Sans&quot;, arial,
      sans-serif; font-size: 12.8px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; text-decoration-style: initial;
      text-decoration-color: initial;"><span class=3D"mw-geshi c source-c"
        style=3D"font-family: monospace; line-height: normal; white-space:
        nowrap;"><span class=3D"nu0" style=3D"color: rgb(0, 0, 128);">1</sp=
an></span></span><span
      style=3D"color: rgb(0, 0, 0); font-family: DejaVuSans, &quot;DejaVu
      Sans&quot;, arial, sans-serif; font-size: 12.8px; font-style:
      normal; font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255); text-decoration-style: initial; text-decoration-color:
      initial; display: inline !important; float: none;"><span
        class=3D"Apple-converted-space">=A0</span>before including<span
        class=3D"Apple-converted-space">=A0</span></span><code
      style=3D"font-family: DejaVuSansMono, &quot;DejaVu Sans Mono&quot;,
      courier, monospace !important; background-color: rgb(255, 255,
      255); color: rgb(0, 0, 0); font-size: 12.8px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; text-decoration-style: initial;
      text-decoration-color: initial;">string.h</code><span
      style=3D"color: rgb(0, 0, 0); font-family: DejaVuSans, &quot;DejaVu
      Sans&quot;, arial, sans-serif; font-size: 12.8px; font-style:
      normal; font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255); text-decoration-style: initial; text-decoration-color:
      initial; display: inline !important; float: none;">.</span><br>
    <br>
    so preprocessor magic can check that.<br>
    <blockquote cite=3D"mid:20161129101812.GE1013@...1296..."
      type=3D"cite">
      <pre wrap=3D"">

Shall we merge the current patch anyway, as the memory barrier does the
job on all current compilers, and add a memset_s() variant "whenever=20
one of us finds time to add and test this"?

</pre>
    </blockquote>
    Yes. Go ahead. I might <br>
  </body>
</html>

--------------D8F8A83E56D1B0D4B3CF5F7F--

