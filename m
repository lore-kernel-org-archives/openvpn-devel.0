Message-ID: <4E01ADFE.5000200@...515...>
Date: Wed, 22 Jun 2011 11:55:26 +0300
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <1308302282-27985-1-git-send-email-samuli@...515...>	<1308556181-20317-1-git-send-email-samuli@...515...>	<4DFF127B.1060006@...1114...>
	<4DFF1488.4040509@...1147...>	<4DFF165D.7070501@...1114...>
	<4DFF2133.5010003@...1147...>	<4DFF3759.2010709@...1114...>
	<4E00A374.6000007@...515...>
In-Reply-To: <4E00A374.6000007@...515...>
Content-Type: multipart/alternative;
	boundary="------------060303050306080308060706"
Subject: Re: [Openvpn-devel] [PATCH] Add new openssl.cnf to easy-rsa/Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060303050306080308060706
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

A new Windows installer based on release/2.2 branch with my easy-rsa
patches applied is now available here:

<http://build.openvpn.net/downloads/releases/openvpn-2.2.1-install-preview-1.exe>

Also, a standalone version of fixed easy-rsa directory is available here:

<http://build.openvpn.net/easy-rsa.zip>

It can be extracted to an existing OpenVPN 2.2* install directory - just
move old easy-rsa directory out of the way first. If you can, please
test that it works as excepted. Basic usage on WinXP seemed to work fine:

$ init-config
$ vars
$ clean-all
$ build-ca
$ build-key-server
$ build-key client1

If possible, please test "domake-win" builds and see if/how they break.
This is probably the most important fix for 2.2.1 which we hope to get
out on Friday. Use of easy-rsa is documented in the included README file
and here:

<http://openvpn.net/index.php/open-source/documentation/howto.html#pki>

Samuli







> Hi all,
>
> I falsely assumed openssl.cnf was a default file from OpenSSL release
> packages, even though it was heavily modified for easy-rsa. The root
> cause of the issue seems to be that OpenSSL 1.0.0 does not like
> undefined variables in openssl.cnf.  I fixed the Windows side today,
> and a preliminary patch is available here:
>
> <http://build.openvpn.net/0001-Updated-easy-rsa-for-OpenSSL-1.0.0.patch>
>
> This patch applies on top of "Fix a build-ca issue on Windows" in
> "master" and fixes Trac ticket #125. A few other things still need
> fixing :
>
> - Lack of file called "easy-rsa/2.0/openssl.cnf"  will probably break
> "domake-win" builds - or at least easy-rsa on installers generated
> with it.
> - openssl-1.0.0.cnf has not yet been tested on *NIX
> - changes to "easy-rsa/2.0/vars" script have not been tested
>
> The added environment variables should not have negative side-effects.
> I'll test Windows installer generation tomorrow to make sure easy-rsa
> works out of the box on Windows. Help with *NIX+OpenSSL 1.0.0 and
> "domake-win" would be appreciated.
>
> Samuli
>> On 20/06/11 12:30, Jan Just Keijser wrote:
>> [...snip...]
>> >> Samuli, can you please look closer into this?  I did a more
>> careful diff
>> >> from 2.0/openssl.cnf and Windows/openssl.cnf ... and it seems quite
>> >> different.  Can we please unite them?
>> >>
>> >> JJK: Do you know which differences are needed between Windows and
>> >> non-Windows?
>> >>
>> >>   
>> > I just checked that the openssl.cnf file shipped with the windows
>> version
>> > of  openvpn 2.1.4 is identical to the easy-rsa/2.0 version - is
>> there any
>> > reason not to do the same for openvpn 2.2?
>>
>>
>> Good question!
>>
>> Samuli, what do you think?  Could we actually just move the
>> 2.0/openssl.cnf
>> to a common directory where the installers will pick this config
>> file?  To
>> have the same file in more places in the source tree sounds chaotic
>> for me,
>> especially when 2.1.4 uses the same file everywhere.
>>
>> I'd suggest ./easy-rsa as a good common base.
>>
>> I'm also wondering if we need to still carry easy-rsa/1.0 in the source
>> tree.  It looks rather dead ...
>>
>> $ git log --follow --oneline ./easy-rsa/1.0/
>> 3c7f2f5 version 2.1_beta1
>>
>> Compared to this:
>>
>> $ git log --follow --oneline ./easy-rsa/2.0/
>> 6dc6019 pkitool lacks expected option "--help"
>> 2d4e768 bash->bourne script cleanup
>> 564a210 Updated copyright date to 2010.
>> 9f4725e pkitool lacks expected option "--help"
>> d7fa38f Update copyright to 2009.
>> 2534aa4 Fixed revoke-full to deal with issue arising from addition ...
>> dbec0a2 Modified pkitool to allow flexibility in separating the Com...
>> d56dec6 Change to pkitool/openssl.cnf so that calling scripts can s...
>> 367ed08 Copyright notice changed to reflect change in name of Telet...
>> 1c0cc4a Copyright change OpenVPN Solutions LLC -> Telethra, Inc.
>> eca8691 Updated copyright notice to 2008.
>> 4d90d73 Updated version & changelog.
>> d4fb6d4 Set tool defaults in pkitool.
>> eba4632 Added note about alternative version of easy-rsa that suppo...
>> 8d54351 Clean up configure on FreeBSD for recent autotool versions ...
>> acb567c A few more updates: -r 1015:1025 https://svn.openvpn.net/pr...
>> a8105c6 Merged PKCS#11 extensions to easy-rsa/2.0  (Alon Bar-Lev). ...
>> 513baee Small fixes: * Fixed variable declaration in crypto.c that ...
>> 411e89a Merged --remote-cert-ku, --remote-cert-eku, and --remote-ce...
>> 8810c26 Moved easy-rsa 2.0 scripts to easy-rsa/2.0 to be compatible...
>>
>> $ git log --follow --oneline ./easy-rsa/Windows/
>> 54c739e Revert "Add new openssl.cnf to easy-rsa/Windows"
>> 663860a Add new openssl.cnf to easy-rsa/Windows
>> 3810843 Fix a build-ca issue on Windows
>> 6b2883a Change all CRLF linefeeds to LF linefeeds
>> d0b4271 In Windows build, package a statically linked openssl.exe t...
>> 4030142 The easy-rsa directory installed by the windows installer c...
>> 6fbf66f This is the start of the BETA21 branch. It includes the --t...
>>
>>
>> kind regards,
>>
>> David Sommerseth
>
>



--------------060303050306080308060706
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Type=
">
  </head>
  <body text=3D"#000000" bgcolor=3D"#ffffff">
    Hi,<br>
    <br>
    A new Windows installer based on release/2.2 branch with my easy-rsa
    patches applied is now available here:<br>
    <br>
<a class=3D"moz-txt-link-rfc2396E" href=3D"http://build.openvpn.net/downloa=
ds/releases/openvpn-2.2.1-install-preview-1.exe">&lt;http://build.openvpn.n=
et/downloads/releases/openvpn-2.2.1-install-preview-1.exe&gt;</a><br>
    <br>
    Also, a standalone version of fixed easy-rsa directory is available
    here:<br>
    <br>
    <a class=3D"moz-txt-link-rfc2396E" href=3D"http://build.openvpn.net/eas=
y-rsa.zip">&lt;http://build.openvpn.net/easy-rsa.zip&gt;</a><br>
    <br>
    It can be extracted to an existing OpenVPN 2.2* install directory -
    just move old easy-rsa directory out of the way first. If you can,
    please test that it works as excepted. Basic usage on WinXP seemed
    to work fine:<br>
    <br>
    $ init-config<br>
    $ vars<br>
    $ clean-all<br>
    $ build-ca<br>
    $ build-key-server<br>
    $ build-key client1<br>
    <br>
    If possible, please test "domake-win" builds and see if/how they
    break. This is probably the most important fix for 2.2.1 which we
    hope to get out on Friday. Use of easy-rsa is documented in the
    included README file and here:<br>
    <br>
<a class=3D"moz-txt-link-rfc2396E" href=3D"http://openvpn.net/index.php/ope=
n-source/documentation/howto.html#pki">&lt;http://openvpn.net/index.php/ope=
n-source/documentation/howto.html#pki&gt;</a><br>
    <br>
    Samuli<br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <blockquote cite=3D"mid:4E00A374.6000007@...515..." type=3D"cite">
      <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
      <title></title>
      Hi all,<br>
      <br>
      I falsely assumed openssl.cnf was a default file from OpenSSL
      release packages, even though it was heavily modified for
      easy-rsa. The root cause of the issue seems to be that OpenSSL
      1.0.0 does not like undefined variables in openssl.cnf.=C2=A0 I fixed
      the Windows side today, and a preliminary patch is available here:<br>
      <br>
      <a moz-do-not-send=3D"true" class=3D"moz-txt-link-rfc2396E"
href=3D"http://build.openvpn.net/0001-Updated-easy-rsa-for-OpenSSL-1.0.0.pa=
tch">&lt;http://build.openvpn.net/0001-Updated-easy-rsa-for-OpenSSL-1.0.0.p=
atch&gt;</a><br>
      <br>
      <span class=3D"Apple-style-span" style=3D"border-collapse: separate;
        color: rgb(0, 0, 0); font-family: Sans; font-style: normal;
        font-variant: normal; font-weight: normal; letter-spacing:
        normal; line-height: normal; orphans: 2; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; font-size: medium;">This patch applies on top
        of "Fix a build-ca issue on Windows</span>" in "master" and
      fixes Trac ticket #125. A few other things still need fixing :<br>
      <br>
      - Lack of file called "easy-rsa/2.0/openssl.cnf"=C2=A0 will probably
      break "domake-win" builds - or at least easy-rsa on installers
      generated with it.<br>
      - openssl-1.0.0.cnf has not yet been tested on *NIX<br>
      - changes to "easy-rsa/2.0/vars" script have not been tested<br>
      <br>
      The added environment variables should not have negative
      side-effects. I'll test Windows installer generation tomorrow to
      make sure easy-rsa works out of the box on Windows. Help with
      *NIX+OpenSSL 1.0.0 and "domake-win" would be appreciated.<br>
      <br>
      Samuli<br>
      <blockquote type=3D"cite">On 20/06/11 12:30, Jan Just Keijser wrote:<=
br>
        [...snip...]<br>
        &gt;&gt; Samuli, can you please look closer into this?=C2=A0 I did a
        more careful diff<br>
        &gt;&gt; from 2.0/openssl.cnf and Windows/openssl.cnf ... and it
        seems quite<br>
        &gt;&gt; different.=C2=A0 Can we please unite them?<br>
        &gt;&gt;<br>
        &gt;&gt; JJK: Do you know which differences are needed between
        Windows and<br>
        &gt;&gt; non-Windows?<br>
        &gt;&gt;<br>
        &gt;&gt;=C2=A0 =C2=A0<br>
        &gt; I just checked that the openssl.cnf file shipped with the
        windows version<br>
        &gt; of=C2=A0 openvpn 2.1.4 is identical to the easy-rsa/2.0 version
        - is there any<br>
        &gt; reason not to do the same for openvpn 2.2?<br>
        <br>
        <br>
        Good question!<br>
        <br>
        Samuli, what do you think?=C2=A0 Could we actually just move the
        2.0/openssl.cnf<br>
        to a common directory where the installers will pick this config
        file?=C2=A0 To<br>
        have the same file in more places in the source tree sounds
        chaotic for me,<br>
        especially when 2.1.4 uses the same file everywhere.<br>
        <br>
        I'd suggest ./easy-rsa as a good common base.<br>
        <br>
        I'm also wondering if we need to still carry easy-rsa/1.0 in the
        source<br>
        tree.=C2=A0 It looks rather dead ...<br>
        <br>
        $ git log --follow --oneline ./easy-rsa/1.0/<br>
        3c7f2f5 version 2.1_beta1<br>
        <br>
        Compared to this:<br>
        <br>
        $ git log --follow --oneline ./easy-rsa/2.0/<br>
        6dc6019 pkitool lacks expected option "--help"<br>
        2d4e768 bash-&gt;bourne script cleanup<br>
        564a210 Updated copyright date to 2010.<br>
        9f4725e pkitool lacks expected option "--help"<br>
        d7fa38f Update copyright to 2009.<br>
        2534aa4 Fixed revoke-full to deal with issue arising from
        addition ...<br>
        dbec0a2 Modified pkitool to allow flexibility in separating the
        Com...<br>
        d56dec6 Change to pkitool/openssl.cnf so that calling scripts
        can s...<br>
        367ed08 Copyright notice changed to reflect change in name of
        Telet...<br>
        1c0cc4a Copyright change OpenVPN Solutions LLC -&gt; Telethra,
        Inc.<br>
        eca8691 Updated copyright notice to 2008.<br>
        4d90d73 Updated version &amp; changelog.<br>
        d4fb6d4 Set tool defaults in pkitool.<br>
        eba4632 Added note about alternative version of easy-rsa that
        suppo...<br>
        8d54351 Clean up configure on FreeBSD for recent autotool
        versions ...<br>
        acb567c A few more updates: -r 1015:1025 <a
          moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext"
          href=3D"https://svn.openvpn.net/pr">https://svn.openvpn.net/pr</a=
>...<br>
        a8105c6 Merged PKCS#11 extensions to easy-rsa/2.0=C2=A0 (Alon
        Bar-Lev). ...<br>
        513baee Small fixes: * Fixed variable declaration in crypto.c
        that ...<br>
        411e89a Merged --remote-cert-ku, --remote-cert-eku, and
        --remote-ce...<br>
        8810c26 Moved easy-rsa 2.0 scripts to easy-rsa/2.0 to be
        compatible...<br>
        <br>
        $ git log --follow --oneline ./easy-rsa/Windows/<br>
        54c739e Revert "Add new openssl.cnf to easy-rsa/Windows"<br>
        663860a Add new openssl.cnf to easy-rsa/Windows<br>
        3810843 Fix a build-ca issue on Windows<br>
        6b2883a Change all CRLF linefeeds to LF linefeeds<br>
        d0b4271 In Windows build, package a statically linked
        openssl.exe t...<br>
        4030142 The easy-rsa directory installed by the windows
        installer c...<br>
        6fbf66f This is the start of the BETA21 branch. It includes the
        --t...<br>
        <br>
        <br>
        kind regards,<br>
        <br>
        David Sommerseth<br>
      </blockquote>
      <br>
      <br>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------060303050306080308060706--

