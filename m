Message-ID: <547069A9.8020306@...1227...>
Date: Sat, 22 Nov 2014 11:47:05 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1416598835-5269-1-git-send-email-yegorslists@...1030...>	<CAGm1_kucw-c5wgw3e_BjRros=CyaEUQ-=o2aLSvDr=31oFuKCg@...278...>	<54705AA4.2010105@...1856...>
	<20141122102138.GA17158@...1296...>
In-Reply-To: <20141122102138.GA17158@...1296...>
Content-Type: multipart/alternative;
	boundary="------------020800000702030500010708"
Subject: Re: [Openvpn-devel] [PATCH] configure.ac: fix default behavior
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020800000702030500010708
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 
On 22.11.2014 11:21, Gert Doering wrote:
> Hi,
>
> On Sat, Nov 22, 2014 at 10:43:00AM +0100, Steffan Karger wrote:
>> On 21-11-14 20:43, Yegor Yefremov wrote:
>>> This patch is a result of our IRC discussion with Arne. Alternative
>>> approach were to always build with password-save functionality without
>>> configure option at all.
>>
>> Thanks for the patch. But this explanation doesn't help me much in
>> understanding why this feature needs to be enabled by default. Could you
>> please explain?
>>
>> (My first thought would be that locally storing a password defeats the
>> purpose of the password, so it is a good thing this is disabled by
>> default. But good arguments might change my view.)
>
> My thoughts are along the line - yes, there seems to be a discrepancy
> between what configure claims to be the default and "the real default",
> but should we change the actual default here, or the configure help
> message?
>
> Given the previous discussions, there seems to be belief that this is
> a "dangerous feature" that should be "turned off by default" - so I tend
> to, for the sake of consistency, not change the default but change the
> configure help output instead.
>
> ... which makes this a feature-NAK.
>
>
Almost anybody always turns this feature on, at least all distribution
have it on.

Arne
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (MingW32)
 
iEYEARECAAYFAlRwaakACgkQe8+cMNS4zRfeUACdG+bFWRPy0WuekfdRSxzZAtJ6
DhQAoOit70W8Z/M72vCqkOq4bsLJPfVZ
=uCYv
-----END PGP SIGNATURE-----


--------------020800000702030500010708
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <br>
    -----BEGIN PGP SIGNED MESSAGE----- <br>
    Hash: SHA1 <br>
    =A0<br>
    On 22.11.2014 11:21, Gert Doering wrote:<br>
    <span style=3D"white-space: pre;">&gt; Hi,<br>
      &gt;<br>
      &gt; On Sat, Nov 22, 2014 at 10:43:00AM +0100, Steffan Karger
      wrote:<br>
      &gt;&gt; On 21-11-14 20:43, Yegor Yefremov wrote:<br>
      &gt;&gt;&gt; This patch is a result of our IRC discussion with
      Arne. Alternative<br>
      &gt;&gt;&gt; approach were to always build with password-save
      functionality without<br>
      &gt;&gt;&gt; configure option at all.<br>
      &gt;&gt;<br>
      &gt;&gt; Thanks for the patch. But this explanation doesn't help
      me much in<br>
      &gt;&gt; understanding why this feature needs to be enabled by
      default. Could you<br>
      &gt;&gt; please explain?<br>
      &gt;&gt;<br>
      &gt;&gt; (My first thought would be that locally storing a
      password defeats the<br>
      &gt;&gt; purpose of the password, so it is a good thing this is
      disabled by<br>
      &gt;&gt; default. But good arguments might change my view.)<br>
      &gt;<br>
      &gt; My thoughts are along the line - yes, there seems to be a
      discrepancy<br>
      &gt; between what configure claims to be the default and "the real
      default",<br>
      &gt; but should we change the actual default here, or the
      configure help<br>
      &gt; message?<br>
      &gt;<br>
      &gt; Given the previous discussions, there seems to be belief that
      this is <br>
      &gt; a "dangerous feature" that should be "turned off by default"
      - so I tend<br>
      &gt; to, for the sake of consistency, not change the default but
      change the<br>
      &gt; configure help output instead.<br>
      &gt;<br>
      &gt; ... which makes this a feature-NAK.<br>
      &gt;<br>
      &gt;</span><br>
    Almost anybody always turns this feature on, at least all
    distribution have it on.<br>
    <br>
    Arne<br>
    -----BEGIN PGP SIGNATURE-----
<br>
    Version: GnuPG v2.0.22 (MingW32)
<br>
    =A0<br>
    iEYEARECAAYFAlRwaakACgkQe8+cMNS4zRfeUACdG+bFWRPy0WuekfdRSxzZAtJ6
<br>
    DhQAoOit70W8Z/M72vCqkOq4bsLJPfVZ
<br>
    =3DuCYv
<br>
    -----END PGP SIGNATURE-----
<br>
    <br>
  </body>
</html>

--------------020800000702030500010708--

