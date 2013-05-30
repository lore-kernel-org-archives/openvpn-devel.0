References: <CAMaBZnHDPHTpPmFoLbyDHxKnBwm7PdPDouZi99bgQzrA9=eXDw@...278...>
	<20130529122956.GH20843@...1296...>
	<20130529133817.GG6942@...1330...>
	<CAMaBZnFwr4iMVTg4QSkosMYsqnpq5-_rt9eny-O9fCSLFLoiqg@...278...>
	<20130529185003.GJ20843@...1296...>
	<CAMaBZnFVPuyUDRwKu0qiOLRdZwhmJXiho=29keGvft=fvBA6Sw@...278...>
	<51A75F21.4060200@...515...>
Mime-Version: 1.0 (1.0)
In-Reply-To: <51A75F21.4060200@...515...>
Content-Type: multipart/alternative;
	boundary=Apple-Mail-225CACA2-7064-4396-8171-A2F293C4A66B
Content-Transfer-Encoding: 7bit
Message-Id: <C1340C42-3C88-415C-A51D-3ECC16DFE1B8@...277...>
From: Wayne <praetoriancode@...277...>
Date: Thu, 30 May 2013 19:03:14 -0400
Subject: Re: [Openvpn-devel] Repos for Debian Wheezy?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?utf-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Apple-Mail-225CACA2-7064-4396-8171-A2F293C4A66B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Does that mean you will be building packages against libssl1.0.0?

Sorry for the top posting. Dumb phone email client.=20

On May 30, 2013, at 10:16 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wrote:

> Hi,
>=20
> My OpenVPN Debian packages[1] seem to depend on libssl0.9.8, which probab=
ly means they won't work on Wheezy. I'll be adding wheezy packages soonish,=
 as I need a couple of wheezy VMs for Buildbot anyways.
> --=20
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock
>=20
> [1] <https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>
>=20
>=20
>> I tried using the snapshot branch of squeeze but ran into a dependency p=
roblem with libssl0.9.8.  The version installed in Wheezy is libssl1.0.0.
>>=20=20
>>  root@...1824...:/etc/apt/sources.list.d# apt-get install openvpn
>> Reading package lists... Done
>> Building dependency tree
>> Reading state information... Done
>> Some packages could not be installed. This may mean that you have
>> requested an impossible situation or if you are using the unstable
>> distribution that some required packages have not yet been created
>> or been moved out of Incoming.
>> The following information may help to resolve the situation:
>> The following packages have unmet dependencies:
>>  openvpn : Depends: libssl0.9.8 (>=3D 0.9.8m-1) but it is not installable
>> E: Unable to correct problems, you have held broken packages.
>> Any hints greatly appreciated.
>>=20
>>=20
>> On Wed, May 29, 2013 at 2:50 PM, Gert Doering <gert@...1296...> wrote:
>>> Hi,
>>>=20
>>> On Wed, May 29, 2013 at 02:37:12PM -0400, Praetorian wrote:
>>> > I'll take a look at the one in unstable.  I'm not sure what parts hav=
e been
>>> > back ported to 2.2 that I have been testing in the 2.3 branch.  I wou=
ld
>>> > have thought that 2.3 is mature enough to be in the debian repos by n=
ow.
>>>=20
>>> Nah, this being debian, it's amazing that they are not stuck at 2.0.9 :=
-)
>>>=20
>>> gert
>>> --
>>> USENET is *not* the non-clickable part of WWW!
>>>                                                            //www.muc.de=
/~gert/
>>> Gert Doering - Munich, Germany                             gert@...1726...=
...
>>> fax: +49-89-35655025                        gert@...1297...
>=20
>=20

--Apple-Mail-225CACA2-7064-4396-8171-A2F293C4A66B
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body dir=3D"auto"><div>Does that mean you will be buildin=
g packages against libssl1.0.0?<br><br></div><div>Sorry for the top posting=
. Dumb phone email client.&nbsp;</div><div><br>On May 30, 2013, at 10:16 AM=
, Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samuli@...515...">samuli@...1387...=
5...</a>&gt; wrote:<br><br></div><blockquote type=3D"cite"><div>
=20=20
    <meta content=3D"text/html; charset=3DISO-8859-15" http-equiv=3D"Conten=
t-Type">
=20=20
=20=20
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      My OpenVPN Debian packages[1] seem to depend on libssl0.9.8, which
      probably means they won't work on Wheezy. I'll be adding wheezy
      packages soonish, as I need a couple of wheezy VMs for Buildbot
      anyways.<br>
      <pre class=3D"moz-signature" cols=3D"72">--=20
Samuli Sepp=C3=A4nen
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
    <blockquote cite=3D"mid:CAMaBZnFVPuyUDRwKu0qiOLRdZwhmJXiho=3D29keGvft=
=3DfvBA6Sw@...278..." type=3D"cite">
      <div dir=3D"ltr">
        <div>I tried using the snapshot branch of squeeze but ran into a
          dependency problem with libssl0.9.8.&nbsp; The version installed =
in
          Wheezy is libssl1.0.0.</div>
        <div>&nbsp;</div>
        <div>&nbsp;<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:roo=
t@...1824...:/etc/apt/sources.list.d#">root@...1824...:/etc/apt/sources.lis=
t.d#</a> apt-get install
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
          &nbsp;openvpn : Depends: libssl0.9.8 (&gt;=3D 0.9.8m-1) but it is=
 not
          installable<br>
          E: Unable to correct problems, you have held broken packages.<br>
        </div>
        <div>Any hints greatly appreciated.</div>
      </div>
      <div class=3D"gmail_extra">
        <br>
        <br>
        <div class=3D"gmail_quote">On Wed, May 29, 2013 at 2:50 PM, Gert
          Doering <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true" href=3D=
"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span>
          wrote:<br>
          <blockquote class=3D"gmail_quote" style=3D"margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            Hi,<br>
            <div class=3D"im"><br>
              On Wed, May 29, 2013 at 02:37:12PM -0400, Praetorian
              wrote:<br>
              &gt; I'll take a look at the one in unstable. &nbsp;I'm not
              sure what parts have been<br>
              &gt; back ported to 2.2 that I have been testing in the
              2.3 branch. &nbsp;I would<br>
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
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; &nbsp;//<a moz-do-not-send=3D"true" href=3D"http://w=
ww.muc.de/%7Egert/" target=3D"_blank">www.muc.de/~gert/</a><br>
                Gert Doering - Munich, Germany &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                &nbsp; <a moz-do-not-send=3D"true" href=3D"mailto:gert@...1386...=
296...">gert@...1296...</a><br>
                fax: <a moz-do-not-send=3D"true" href=3D"tel:%2B49-89-35655=
025" value=3D"+498935655025">+49-89-35655025</a>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp;<a moz-do-not-send=3D"true" href=3D"mailto:gert@...493...=
1297...">gert@...1297...</a><br>
              </div>
            </div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
    <br>
=20=20

</div></blockquote></body></html>=

--Apple-Mail-225CACA2-7064-4396-8171-A2F293C4A66B--

