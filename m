MIME-Version: 1.0
In-Reply-To: <CAFHpkQHqykCg2U5VtOFNYQnQNvQqAESoRwSqWKpRxD3pC7xCfg@...278...>
References: <d925da2c-5715-6452-1c38-097a123c0de1@...277...>
	<CAKuzo_hWtk=vpR1P4T7O6e6udL8o+yySciD7VveTYdt25c7DRA@...278...>
	<1a7a5efc-2de2-db0b-0aa0-4340379b84f7@...277...>
	<CAKuzo_iB=pNkgkKBD_N-ZPTeeDiEMp_qD7uvHst3dhPMkJ=4Jg@...278...>
	<88b7b1a5-c364-a8d5-9b2e-ee9995acbec7@...277...>
	<CAFHpkQHqykCg2U5VtOFNYQnQNvQqAESoRwSqWKpRxD3pC7xCfg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 4 Jun 2017 14:52:29 +0500
Message-ID: <CAFHpkQH=91OoawzqpuLsD3bd4Cp8zhx4Hv6isbFax4O-22MU=A@...278...>
Content-Type: multipart/alternative; boundary="94eb2c0defc63fabaa05511f584a"
Subject: Re: [Openvpn-devel] block-outside-dns and persist-tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <valdikss@...277...>
Cc: Selva Nair <selva.nair@...277...>, Pavel Zhovner <pavel@...2275...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0defc63fabaa05511f584a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I recall similar issue. When install -> unistall -> install some service
were marked for pending removal and were not installed

4 =D0=B8=D1=8E=D0=BD. 2017 =D0=B3. 12:13 =D0=9F=D0=9F =D0=BF=D0=BE=D0=BB=D1=
=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "ValdikSS" <valdikss@...1186...=
.277...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

Also this:
http://clip2net.com/s/3KOUHWv
"Unable to start OpenVPN Interactive Service on local computer: Error 1075:
parent service does not exist or has been marked as removed".
This is on fresh installation.

And this:

Error in add_block_dns_filters(): FwpEngineOpen: open fwp session failed :
=D0=92 =D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=B5 =D0=BE=D1=82=D0=BE=D0=B1=
=D1=80=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=BD=D0=B5=D1=87=
=D0=BD=D1=8B=D1=85 =D1=82=D0=BE=D1=87=D0=B5=D0=BA =D0=BD=D0=B5 =D0=BE=D1=81=
=D1=82=D0=B0=D0=BB=D0=BE=D1=81=D1=8C =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=
=D0=BD=D1=8B=D1=85 =D0=BA=D0=BE=D0=BD=D0=B5=D1=87=D0=BD=D1=8B=D1=85
=D1=82=D0=BE=D1=87=D0=B5=D0=BA.   [status=3D0x6d9]
Tue May 30 02:28:26 2017 Blocking DNS failed!

"open fwp session failed : There are no more endpoints available from the
endpoint mapper."



On 04.06.2017 07:11, Selva Nair wrote:


On Sat, Jun 3, 2017 at 4:13 PM, ValdikSS <valdikss@...277...> wrote:

I did not find any related to failure to remove WFP filters. That specific
comment link reads

<quote>
Sun May 28 18:07:25 2017 Block_DNS: WFP engine opened
Sun May 28 18:07:25 2017 Error in add_block_dns_filters(): add_sublayer:
failed to add persistent sublayer : =D0=9E=D1=82=D0=BA=D0=B0=D0=B7=D0=B0=D0=
=BD=D0=BE =D0=B2 =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=B5. [status=3D0x5]
Sun May 28 18:07:25 2017 Blocking DNS failed!
Sun May 28 18:07:25 2017 Exiting due to fatal error
</quote>

Obviously "access denied" due to not running as admin and service not in
use.

Selva




---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot



_______________________________________________
Openvpn-devel mailing
listOpenvpn-devel@...1440...://lists.sourceforge.net/lists/listinfo/openvpn=
-devel



------------------------------------------------------------
------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--94eb2c0defc63fabaa05511f584a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I recall similar issue. When install -&gt; unistall -&gt;=
 install some service were marked for pending removal and were not installe=
d</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">4 =D0=B8=
=D1=8E=D0=BD. 2017 =D0=B3. 12:13 =D0=9F=D0=9F =D0=BF=D0=BE=D0=BB=D1=8C=D0=
=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;ValdikSS&quot; &lt;<a h=
ref=3D"mailto:valdikss@...277...">valdikss@...277...</a>&gt; =D0=BD=D0=B0=
=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attribution"><blockquote class=
=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
=20=20
=20=20=20=20
=20=20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF">
    Also this:<br>
    <a class=3D"m_-5443350884485761638moz-txt-link-freetext" href=3D"http:/=
/clip2net.com/s/3KOUHWv" target=3D"_blank">http://clip2net.com/s/3KOUHWv</a=
><br>
    &quot;Unable to start OpenVPN Interactive Service on local computer:
    Error 1075: parent service does not exist or has been marked as
    removed&quot;.<br>
    This is on fresh installation.<br>
    <br>
    And this:<br>
    <tt><br>
      Error in add_block_dns_filters(): FwpEngineOpen: open fwp session
      failed : =D0=92 =D1=81=D0=B8=D1=81=D1=82=D0=B5=D0=BC=D0=B5 =D0=BE=D1=
=82=D0=BE=D0=B1=D1=80=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D1=8F =D0=BA=D0=BE=D0=
=BD=D0=B5=D1=87=D0=BD=D1=8B=D1=85 =D1=82=D0=BE=D1=87=D0=B5=D0=BA =D0=BD=D0=
=B5 =D0=BE=D1=81=D1=82=D0=B0=D0=BB=D0=BE=D1=81=D1=8C
      =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=BD=D1=8B=D1=85 =D0=BA=D0=BE=
=D0=BD=D0=B5=D1=87=D0=BD=D1=8B=D1=85 =D1=82=D0=BE=D1=87=D0=B5=D0=BA.=C2=A0=
=C2=A0 [status=3D0x6d9]</tt><tt><br>
    </tt><tt>Tue May 30 02:28:26 2017 Blocking DNS failed! </tt><br>
    <br>
    &quot;open fwp session failed : There are no more endpoints available
    from the endpoint mapper.&quot;<div class=3D"quoted-text"><br>
    <br>
    <br>
    <div class=3D"m_-5443350884485761638moz-cite-prefix">On 04.06.2017 07:1=
1, Selva Nair wrote:<br>
    </div>
    </div><blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra"><div class=3D"quoted-text"><br>
          <div class=3D"gmail_quote">On Sat, Jun 3, 2017 at 4:13 PM,
            ValdikSS <span dir=3D"ltr">&lt;<a href=3D"mailto:valdikss@...1664...=
7..." target=3D"_blank">valdikss@...277...</a>&gt;</span>
            wrote:<br>
          </div>
          <div class=3D"gmail_extra"><br>
          </div></div><div class=3D"quoted-text">
          I did not find any related to failure to remove WFP filters.
          That specific comment link reads</div></div><div class=3D"quoted-=
text">
        <div class=3D"gmail_extra"><span><br>
          </span></div>
        <div class=3D"gmail_extra"><span>&lt;quote&gt;</span></div>
        <div class=3D"gmail_extra"><span>Sun May 28
            18:07:25 2017 Block_DNS: WFP engine opened</span><br>
          <span>Sun May 28
            18:07:25 2017 Error in add_block_dns_filters():
            add_sublayer: failed to add persistent sublayer : =D0=9E=D1=82=
=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE =D0=B2
            =D0=B4=D0=BE=D1=81=D1=82=D1=83=D0=BF=D0=B5. [status=3D0x5]</spa=
n><br>
          <span>Sun May 28
            18:07:25 2017 Blocking DNS failed!</span><br>
          <span>Sun May 28
            18:07:25 2017 Exiting due to fatal error</span><br>
        </div>
        <div class=3D"gmail_extra"><span>&lt;/quote&gt;</span></div>
        <div class=3D"gmail_extra"><span><br>
          </span></div>
        <div class=3D"gmail_extra"><span>Obviously
            &quot;access denied&quot; due to not running as admin and servi=
ce not
            in use.</span></div>
        <div class=3D"gmail_extra"><span><br>
          </span></div>
        <div class=3D"gmail_extra"><span>Selva</span></div>
        <div class=3D"gmail_extra"><br>
          <br>
        </div>
      </div></div>
      <br>
      <fieldset class=3D"m_-5443350884485761638mimeAttachmentHeader"></fiel=
dset>
      <br><div class=3D"quoted-text">
      <pre>------------------------------<wbr>-----------------------------=
-<wbr>------------------
Check out the vibrant tech community on one of the world&#39;s most
engaging tech sites, Slashdot.org! <a class=3D"m_-5443350884485761638moz-tx=
t-link-freetext" href=3D"http://sdm.link/slashdot" target=3D"_blank">http:/=
/sdm.link/slashdot</a></pre>
      <br>
      <fieldset class=3D"m_-5443350884485761638mimeAttachmentHeader"></fiel=
dset>
      <br>
      <pre>______________________________<wbr>_________________
Openvpn-devel mailing list
<a class=3D"m_-5443350884485761638moz-txt-link-abbreviated" href=3D"mailto:=
Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a>
<a class=3D"m_-5443350884485761638moz-txt-link-freetext" href=3D"https://li=
sts.sourceforge.net/lists/listinfo/openvpn-devel" target=3D"_blank">https:/=
/lists.sourceforge.net/<wbr>lists/listinfo/openvpn-devel</a>
</pre>
    </div></blockquote>
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
<br></blockquote></div><br></div>

--94eb2c0defc63fabaa05511f584a--

