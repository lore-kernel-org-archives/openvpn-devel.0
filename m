Message-ID: <51A75F21.4060200@...515...>
Date: Thu, 30 May 2013 17:16:01 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAMaBZnHDPHTpPmFoLbyDHxKnBwm7PdPDouZi99bgQzrA9=eXDw@...278...>
	<20130529122956.GH20843@...1296...>
	<20130529133817.GG6942@...1330...>
	<CAMaBZnFwr4iMVTg4QSkosMYsqnpq5-_rt9eny-O9fCSLFLoiqg@...278...>
	<20130529185003.GJ20843@...1296...>
	<CAMaBZnFVPuyUDRwKu0qiOLRdZwhmJXiho=29keGvft=fvBA6Sw@...278...>
In-Reply-To: <CAMaBZnFVPuyUDRwKu0qiOLRdZwhmJXiho=29keGvft=fvBA6Sw@...278...>
Content-Type: multipart/alternative;
	boundary="------------000806050105050800070901"
Subject: Re: [Openvpn-devel] Repos for Debian Wheezy?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Praetorian <praetoriancode@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000806050105050800070901
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

My OpenVPN Debian packages[1] seem to depend on libssl0.9.8, which
probably means they won't work on Wheezy. I'll be adding wheezy packages
soonish, as I need a couple of wheezy VMs for Buildbot anyways.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] <https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>


> I tried using the snapshot branch of squeeze but ran into a dependency
> problem with libssl0.9.8.  The version installed in Wheezy is libssl1.0.0.
>=20=20
>  root@...1824...:/etc/apt/sources.list.d# apt-get install openvpn
> Reading package lists... Done
> Building dependency tree
> Reading state information... Done
> Some packages could not be installed. This may mean that you have
> requested an impossible situation or if you are using the unstable
> distribution that some required packages have not yet been created
> or been moved out of Incoming.
> The following information may help to resolve the situation:
> The following packages have unmet dependencies:
>  openvpn : Depends: libssl0.9.8 (>=3D 0.9.8m-1) but it is not installable
> E: Unable to correct problems, you have held broken packages.
> Any hints greatly appreciated.
>
>
> On Wed, May 29, 2013 at 2:50 PM, Gert Doering <gert@...1296...
> <mailto:gert@...1296...>> wrote:
>
>     Hi,
>
>     On Wed, May 29, 2013 at 02:37:12PM -0400, Praetorian wrote:
>     > I'll take a look at the one in unstable.  I'm not sure what
>     parts have been
>     > back ported to 2.2 that I have been testing in the 2.3 branch.
>      I would
>     > have thought that 2.3 is mature enough to be in the debian repos
>     by now.
>
>     Nah, this being debian, it's amazing that they are not stuck at
>     2.0.9 :-)
>
>     gert
>     --
>     USENET is *not* the non-clickable part of WWW!
>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
>      //www.muc.de/~gert/ <http://www.muc.de/%7Egert/>
>     Gert Doering - Munich, Germany=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>     gert@...1296... <mailto:gert@...1296...>
>     fax: +49-89-35655025 <tel:%2B49-89-35655025>=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>      gert@...1297...
>     <mailto:gert@...1297...>
>
>



--------------000806050105050800070901
Content-Type: text/html; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-15"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      My OpenVPN Debian packages[1] seem to depend on libssl0.9.8, which
      probably means they won't work on Wheezy. I'll be adding wheezy
      packages soonish, as I need a couple of wheezy VMs for Buildbot
      anyways.<br>
      <pre class=3D"moz-signature" cols=3D"72">--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock</pre>
      <br>
      [1]
      <a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.=
net/openvpn/wiki/OpenvpnSoftwareRepos">&lt;https://community.openvpn.net/op=
envpn/wiki/OpenvpnSoftwareRepos&gt;</a><br>
      <br>
      <br>
    </div>
    <blockquote
cite=3D"mid:CAMaBZnFVPuyUDRwKu0qiOLRdZwhmJXiho=3D29keGvft=3DfvBA6Sw@...1811...=
.."
      type=3D"cite">
      <div dir=3D"ltr">
        <div>I tried using the snapshot branch of squeeze but ran into a
          dependency problem with libssl0.9.8.=A0 The version installed in
          Wheezy is libssl1.0.0.</div>
        <div>=A0</div>
        <div>=A0<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:root@...220...=
..1824...:/etc/apt/sources.list.d#">root@...1824...:/etc/apt/sources.list.d=
#</a> apt-get install
          openvpn<br>
          Reading package lists... Done<br>
          Building dependency tree<br>
          Reading state information... Done<br>
          Some packages could not be installed. This may mean that you
          have<br>
          requested an impossible situation or if you are using the
          unstable<br>
          distribution that some required packages have not yet been
          created<br>
          or been moved out of Incoming.<br>
          The following information may help to resolve the situation:</div>
        <div>The following packages have unmet dependencies:<br>
          =A0openvpn : Depends: libssl0.9.8 (&gt;=3D 0.9.8m-1) but it is not
          installable<br>
          E: Unable to correct problems, you have held broken packages.<br>
        </div>
        <div>Any hints greatly appreciated.</div>
      </div>
      <div class=3D"gmail_extra">
        <br>
        <br>
        <div class=3D"gmail_quote">On Wed, May 29, 2013 at 2:50 PM, Gert
          Doering <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
              href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1826...=
6...</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            Hi,<br>
            <div class=3D"im"><br>
              On Wed, May 29, 2013 at 02:37:12PM -0400, Praetorian
              wrote:<br>
              &gt; I'll take a look at the one in unstable. =A0I'm not
              sure what parts have been<br>
              &gt; back ported to 2.2 that I have been testing in the
              2.3 branch. =A0I would<br>
              &gt; have thought that 2.3 is mature enough to be in the
              debian repos by now.<br>
              <br>
            </div>
            Nah, this being debian, it's amazing that they are not stuck
            at 2.0.9 :-)<br>
            <div class=3D"HOEnZb">
              <div class=3D"h5"><br>
                gert<br>
                --<br>
                USENET is *not* the non-clickable part of WWW!<br>
                =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0
                =A0 =A0//<a moz-do-not-send=3D"true"
                  href=3D"http://www.muc.de/%7Egert/" target=3D"_blank">www=
.muc.de/~gert/</a><br>
                Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0
                =A0 <a moz-do-not-send=3D"true"
                  href=3D"mailto:gert@...1296...">gert@...1296...</a><br>
                fax: <a moz-do-not-send=3D"true"
                  href=3D"tel:%2B49-89-35655025" value=3D"+498935655025">+4=
9-89-35655025</a>
                =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<a moz-do-no=
t-send=3D"true"
                  href=3D"mailto:gert@...1297...">gert@...1297...</a><br>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------000806050105050800070901--

