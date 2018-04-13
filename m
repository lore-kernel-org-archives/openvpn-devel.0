MIME-Version: 1.0
From: Marvin <volleynbike@...277...>
Date: Fri, 13 Apr 2018 10:03:55 -0700
Message-ID: <CAAF3xa-+k10J4URGr+6zfua-p2KmoGUniejfBWDB7nNJ6p03kA@...278...>
Content-Type: multipart/alternative; boundary="0000000000008a40b30569bddb40"
Subject: Re: [Openvpn-devel] Viscosity patch to TAP driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "<openvpn-devel@lists.sourceforge.net>" <openvpn-devel@lists.sourceforge.net>

--0000000000008a40b30569bddb40
Content-Type: text/plain; charset="UTF-8"

Hi Guys,

Would there be any problem with updating the tap-windows6 to the Viscosity
patched version on an older openvpn build (e.g. 2.3.18 on Windows 10)?

Thanks,
Marvin

On Thu, Apr 12, 2018 at 8:45 PM, Eric Thorpe <eric@...1918...> wrote:

> Hi Gert,
>
> PR #47 has been submitted to tap-windows6 on github.
>
> Regards,
> Eric
>
> --
> Eric Thorpe
> SparkLabs Developerhttps://www.sparklabs.comhttps://twitter.com/sparklabssupport@...1918...
>
> On 12/04/2018 6:26 PM, Gert Doering wrote:
>
> Hi Eric,
>
> On Thu, Mar 22, 2018 at 02:25:56PM +1100, Eric Thorpe wrote:
>
> One of the Viscosity developers here. The TAP driver used by Viscosity
> is based on the OpenVPN TAP-Windows driver. We're surprised to hear of
> any performance differences, as the changes we've made are very minimal.
>
> Besides a name and version number change, the only other modification is
> a change to the reported network adapter speed, which has Windows report
> the driver as 1000 Mbit instead of 100 Mbit.
>
> This change was made not because of any actual performance gains, but
> because of user reports that certain firewall or AV software tries to
> QoS the adapter based on its reported adapter speed, which is of course
> a problem if the VPN connection is capable of more than 100 Mbit.
>
> Please find a patch file of the changes attached.
>
> I think it would make sense for us to merge that patch - for two reasons,
> one is "the change could indeed help performance in high-bandwidth
> situtions", and the more important one is "another patch to tap-windows6
> is forthcoming, and that way we can keep the version numbers aligned
> so people can know what is inside".
>
> Do you have the patch in git?  If yes, could you please do the commit
> with "-s" (so the signed-off-by: line is added) and send it as regular
> git commit (git-send-email)?  Alternatively a PR against tap-windows6
> on github should do as well.
>
> Thanks in advance,
>
> gert
>
>
>
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--0000000000008a40b30569bddb40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Guys,<div><br></div><div>Would there be any problem wit=
h updating the tap-windows6 to the Viscosity patched version on an older op=
envpn build (e.g. 2.3.18 on Windows 10)?</div><div><br></div><div>Thanks,<b=
r>Marvin<br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Th=
u, Apr 12, 2018 at 8:45 PM, Eric Thorpe <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:eric@...1918..." target=3D"_blank">eric@...1918...</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
=20=20

=20=20=20=20
=20=20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p>Hi Gert,</p>
    <p>PR #47 has been submitted to tap-windows6 on github.<br>
    </p>
    <p>Regards,<br>
      Eric<br>
    </p>
    <pre class=3D"m_4529237008766805029moz-signature" cols=3D"72">--
Eric Thorpe
SparkLabs Developer
<a class=3D"m_4529237008766805029moz-txt-link-freetext" href=3D"https://www=
.sparklabs.com" target=3D"_blank">https://www.sparklabs.com</a>
<a class=3D"m_4529237008766805029moz-txt-link-freetext" href=3D"https://twi=
tter.com/sparklabs" target=3D"_blank">https://twitter.com/sparklabs</a>
<a class=3D"m_4529237008766805029moz-txt-link-abbreviated" href=3D"mailto:s=
upport@...1918..." target=3D"_blank">support@...1918...</a></pre>
    <div class=3D"m_4529237008766805029moz-cite-prefix">On 12/04/2018 6:26 =
PM, Gert Doering
      wrote:<br>
    </div>
    <blockquote type=3D"cite" id=3D"m_4529237008766805029mid_20180412082603=
_GT69387_greenie_muc_de" class=3D"m_4529237008766805029cite">
      <pre>Hi Eric,

On Thu, Mar 22, 2018 at 02:25:56PM +1100, Eric Thorpe wrote:
</pre>
      <blockquote type=3D"cite" id=3D"m_4529237008766805029Cite_7807" class=
=3D"m_4529237008766805029cite">
        <pre>One of the Viscosity developers here. The TAP driver used by V=
iscosity=20
is based on the OpenVPN TAP-Windows driver. We&#39;re surprised to hear of=
=20
any performance differences, as the changes we&#39;ve made are very minimal.

Besides a name and version number change, the only other modification is=20
a change to the reported network adapter speed, which has Windows report=20
the driver as 1000 Mbit instead of 100 Mbit.

This change was made not because of any actual performance gains, but=20
because of user reports that certain firewall or AV software tries to=20
QoS the adapter based on its reported adapter speed, which is of course=20
a problem if the VPN connection is capable of more than 100 Mbit.

Please find a patch file of the changes attached.
</pre>
      </blockquote>
      <pre>I think it would make sense for us to merge that patch - for two=
 reasons,
one is &quot;the change could indeed help performance in high-bandwidth
situtions&quot;, and the more important one is &quot;another patch to tap-w=
indows6
is forthcoming, and that way we can keep the version numbers aligned
so people can know what is inside&quot;.

Do you have the patch in git?  If yes, could you please do the commit
with &quot;-s&quot; (so the signed-off-by: line is added) and send it as re=
gular
git commit (git-send-email)?  Alternatively a PR against tap-windows6
on github should do as well.

Thanks in advance,

gert

</pre>
    </blockquote>
    <br>
    <br>
  </div>

<br>------------------------------<wbr>------------------------------<wbr>-=
-----------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>_________=
_____________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div></div></div>

--0000000000008a40b30569bddb40--

