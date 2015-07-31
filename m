Message-ID: <55BAC7D7.6080506@...1147...>
Date: Fri, 31 Jul 2015 02:56:55 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <CALKXstsZLjqxCrzo3E-qGiyhJo3yi9bW1Jf2bKGYphkB+4b0Qg@...278...>	<CALKXsttsrkPxgrT1A+gpRh5WoxTxw6djkBQJh7BjKTSk5itDig@...278...>	<20150730114818.GE382@...1296...>
	<CALKXstt-DBKbwiaheOWCTmFgeTYMok13TnrHnZMyzaUP26H4PA@...278...>
In-Reply-To: <CALKXstt-DBKbwiaheOWCTmFgeTYMok13TnrHnZMyzaUP26H4PA@...278...>
Content-Type: multipart/alternative;
	boundary="------------090602070300020308080108"
Subject: Re: [Openvpn-devel] Openvpn is not working with hardware encryption
 enabled CPU.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rahul Arora <rahul1991.arora@...277...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090602070300020308080108
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 30/07/15 19:04, Rahul Arora wrote:
> Hi
>
> Thanks for the reply.
>
> I am already using "--engine cryptodev" in the configuration file.
>
> I am using "aes-128-cbc"  cipher algorithm and it is supported in my 
> hardware as i am running "openssl speed test" using these ciphers only 
> and in case of "openssl speed test" throughput is increasing but with 
> openvpn it is not so.
>
>
this was reported by someone on the list a few days ago as well.
the problem is not with openvpn , but with the openssl speed command 
used:  the cryptodev engine (and kernel device) do not provide a factor 
of 100+ speedup. It's the "openssl speed -evp aes-256-cbc" command that 
reports erroneous results.
Try running this openssl command on your box:

date ; cat bigfile | openssl enc -e -aes-256-cbc -bufsize 8192 -pass 
pass:testing123 >  /dev/null ; date

where 'bigfile' is some large file of > 2 GB in size.
Then rerun it using

date ; cat bigfile | openssl enc -engine cryptodev -e -aes-256-cbc 
-bufsize 8192 -pass pass:testing123 >  /dev/null ; date

and compare the results. On my hardware I get zero difference whether I 
use cryptodev or not, whereas 'openssl speed' reports a 100+ % improvement:

with cryptodev module loaded:
    aes-256-cbc     286337.65k  1048423.31k  4589489.60k 19596646.40k 
141238272.00k

without cryptodev:
    aes-256-cbc     465276.57k   487043.33k   493990.87k 493776.90k   
495720.11k


so, apart from the fact that openvpn's speed limitations are not 
determined solely by encryption/decryption, this does prove to me that 
the cryptodev device offers little if no performance improvement.

hope this clears things up,

JJK



>
>
> On Thu, Jul 30, 2015 at 5:18 PM, Gert Doering <gert@...1296... 
> <mailto:gert@...1296...>> wrote:
>
>     Hi,
>
>     On Thu, Jul 30, 2015 at 12:55:00PM +0530, Rahul Arora wrote:
>     > *Openvpn --version*
>     > OpenVPN 2.1.3 arm-fsl-linux-gnueabi [SSL] [LZO2] [EPOLL] built on Jul 29
>     > 2015
>
>     This is, uh, ancient.  2.3.7 is the current stable release.
>
>     (It might or might not related, but we're certainly not going back
>     to 2.2
>     or even 2.1 releases to debug anything.  OpenVPN *should* use the
>     crypto
>     accelerator just fine, if OpenSSL can use it - if you need to use an
>     OpenSSL engine, tell OpenVPN with "--engine yourengine".  It might not
>     make an overwhelming difference in speed if you use the wrong crypto
>     algorithms - like, your hardware accelerates 3DES and you use
>     --cipher blowfish...)
>
>     gert
>
>     --
>     USENET is *not* the non-clickable part of WWW!
>        //www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
>     Gert Doering - Munich, Germany gert@...1296...
>     <mailto:gert@...1296...>
>


--------------090602070300020308080108
X-MIME-Autoconverted: from 8bit to quoted-printable by
	outgoing3-ams.mf.surf.net id t6V0xfxp029364
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
      On 30/07/15 19:04, Rahul Arora wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CALKXstt-DBKbwiaheOWCTmFgeTYMok13TnrHnZMyzaUP26H4PA@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div>
          <div>
            <div>Hi<br>
              <br>
            </div>
            Thanks for the reply.<br>
            <br>
          </div>
          I am already using "--engine cryptodev" in the configuration
          file.<br>
          <br>
        </div>
        <div>I am using "aes-128-cbc"=A0 cipher algorithm and it is
          supported in my hardware as i am running "openssl speed test"
          using these ciphers only and in case of "openssl speed test"
          throughput is increasing but with openvpn it is not so.<br>
        </div>
        <div><br>
          <br>
        </div>
      </div>
    </blockquote>
    this was reported by someone on the list a few days ago as well.<br>
    the problem is not with openvpn , but with the openssl speed command
    used:=A0 the cryptodev engine (and kernel device) do not provide a
    factor of 100+ speedup. It's the "openssl speed -evp aes-256-cbc"
    command that reports erroneous results.<br>
    Try running this openssl command on your box:<br>
    <br>
    date ; cat bigfile | openssl enc -e -aes-256-cbc -bufsize 8192 -pass
    pass:testing123 &gt;=A0 /dev/null ; date<br>
    <br>
    where 'bigfile' is some large file of &gt; 2 GB in size.<br>
    Then rerun it using<br>
    <br>
    date ; cat bigfile | openssl enc -engine cryptodev -e -aes-256-cbc
    -bufsize 8192 -pass pass:testing123 &gt;=A0 /dev/null ; date<br>
    <br>
    and compare the results. On my hardware I get zero difference
    whether I use cryptodev or not, whereas 'openssl speed' reports a
    100+ % improvement:<br>
    <br>
    with cryptodev module loaded:<br>
    =A0=A0 aes-256-cbc=A0=A0=A0=A0 286337.65k=A0 1048423.31k=A0 4589489.60k=
 19596646.40k
    141238272.00k<br>
    <br>
    without cryptodev:<br>
    =A0=A0 aes-256-cbc=A0=A0=A0=A0 465276.57k=A0=A0 487043.33k=A0=A0 493990=
.87k=A0=A0
    493776.90k=A0=A0 495720.11k<br>
    <br>
    <br>
    so, apart from the fact that openvpn's speed limitations are not
    determined solely by encryption/decryption, this does prove to me
    that the cryptodev device offers little if no performance
    improvement.<br>
    <br>
    hope this clears things up,<br>
    <br>
    JJK <br>
    <br>
    <br>
    <br>
    <blockquote
cite=3D"mid:CALKXstt-DBKbwiaheOWCTmFgeTYMok13TnrHnZMyzaUP26H4PA@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div>=A0<br>
        </div>
      </div>
      <div class=3D"gmail_extra"><br>
        <div class=3D"gmail_quote">On Thu, Jul 30, 2015 at 5:18 PM, Gert
          Doering <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
              href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1826...=
6...</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
            <br>
            On Thu, Jul 30, 2015 at 12:55:00PM +0530, Rahul Arora wrote:<br>
            &gt; *Openvpn --version*<br>
            <span class=3D"">&gt; OpenVPN 2.1.3 arm-fsl-linux-gnueabi
              [SSL] [LZO2] [EPOLL] built on Jul 29<br>
              &gt; 2015<br>
              <br>
            </span>This is, uh, ancient.=A0 2.3.7 is the current stable
            release.<br>
            <br>
            (It might or might not related, but we're certainly not
            going back to 2.2<br>
            or even 2.1 releases to debug anything.=A0 OpenVPN *should*
            use the crypto<br>
            accelerator just fine, if OpenSSL can use it - if you need
            to use an<br>
            OpenSSL engine, tell OpenVPN with "--engine yourengine".=A0 It
            might not<br>
            make an overwhelming difference in speed if you use the
            wrong crypto<br>
            algorithms - like, your hardware accelerates 3DES and you
            use<br>
            --cipher blowfish...)<br>
            <span class=3D"HOEnZb"><font color=3D"#888888"><br>
                gert<br>
                <br>
                --<br>
                USENET is *not* the non-clickable part of WWW!<br>
                =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
                =A0 =A0//<a moz-do-not-send=3D"true"
                  href=3D"http://www.muc.de/%7Egert/" rel=3D"noreferrer"
                  target=3D"_blank">www.muc.de/~gert/</a><br>
                Gert Doering - Munich, Germany=A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0
                =A0 =A0<a moz-do-not-send=3D"true"
                  href=3D"mailto:gert@...1296...">gert@...1296...</a></font=
></span><br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------090602070300020308080108--

