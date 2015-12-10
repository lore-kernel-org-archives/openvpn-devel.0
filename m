References: <5661686A.4090305@...2070...>
	<1449656275-24934-1-git-send-email-iam@...2070...>
	<56694C04.6020904@...277...> <20151210162651.GI24952@...1296...>
	<5669AD21.4000301@...2070...>
	<CAKuzo_jhYhGT7y_+O1Z73RLW51RuHB702MxxmHbVS5XG2jg0dw@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <5669DE06.70509@...2070...>
Date: Thu, 10 Dec 2015 23:18:14 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jhYhGT7y_+O1Z73RLW51RuHB702MxxmHbVS5XG2jg0dw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WNVMhEOEsRvLbU4jfUN89NmDTV16wgxde"
Subject: Re: [Openvpn-devel] [PATCH v8-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WNVMhEOEsRvLbU4jfUN89NmDTV16wgxde
Content-Type: multipart/alternative;
	boundary="------------040503020607030401030400"

This is a multi-part message in MIME format.
--------------040503020607030401030400
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

I'm not totally sure about that, but I suppose it shouldn't leak.
Here's what Microsoft's Best Practice says:
> Use dynamic sessions.
>
> Many applications add filtering policy objects at start, and then delete =
these objects at stop. By using a dynamic session, you guarantee that these=
 objects
> are deleted even if the application crashes. Furthermore, simply closing =
the engine handle at stop is more efficient than making individual calls to=
 delete
> each object.
>
https://msdn.microsoft.com/en-us/library/windows/desktop/bb442411%28v=3Dvs.=
85%29.aspx

> If /session/.*flags* is set to *FWPM_SESSION_FLAG_DYNAMIC*, any WFP objec=
ts added during the session are automatically deleted when the session ends=
. If the
> session is not dynamic, the caller needs to explicitly delete all WFP obj=
ects added during the session.
https://technet.microsoft.com/ru-ru/aa364040


On 12/10/2015 08:17 PM, Selva Nair wrote:
>
> On Thu, Dec 10, 2015 at 11:49 AM, ValdikSS <iam@...2070... <mailto:iam@...1186...=
.2070...>> wrote:
>
> Provided it doesn't leak memory. As the current implementation of wfp_add=
_filter does return the id of the added filter (in &filterid) , its easy to=
 save them
> into some globals and delete all the filters in wfp_uninit.
>
> However, If you are sure there is no leak, just closing the engine is fin=
e.
>
> Other than this v8 is good to go.
>
> Selva
>
>
> -------------------------------------------------------------------------=
-----
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------040503020607030401030400
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    I'm not totally sure about that, but I suppose it shouldn't leak.<br>
    Here's what Microsoft's Best Practice says:<br>
    <blockquote type=3D"cite">Use dynamic sessions.
      <p>Many applications add filtering policy objects at start, and
        then delete these objects at stop. By using a dynamic session,
        you guarantee that these objects are deleted even if the
        application crashes. Furthermore, simply closing the engine
        handle at stop is more efficient than making individual calls to
        delete each object.</p>
    </blockquote>
    <a
href=3D"https://msdn.microsoft.com/en-us/library/windows/desktop/bb442411%2=
8v=3Dvs.85%29.aspx"><a class=3D"moz-txt-link-freetext" href=3D"https://msdn=
.microsoft.com/en-us/library/windows/desktop/bb442411%28v=3Dvs.85%29.aspx">=
https://msdn.microsoft.com/en-us/library/windows/desktop/bb442411%28v=3Dvs.=
85%29.aspx</a></a><br>
    <br>
    <blockquote type=3D"cite">If <em>session</em>.<strong>flags</strong>
      is set to <strong>FWPM_SESSION_FLAG_DYNAMIC</strong>, any WFP
      objects added during the session are
      automatically deleted when the session ends. If the session is not
      dynamic, the caller needs to explicitly delete all WFP objects
      added during the session.</blockquote>
    <a href=3D"https://technet.microsoft.com/ru-ru/aa364040">https://techne=
t.microsoft.com/ru-ru/aa364040</a><br>
    <br>
    <br>
    <div class=3D"moz-cite-prefix">On 12/10/2015 08:17 PM, Selva Nair
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAKuzo_jhYhGT7y_+O1Z73RLW51RuHB702MxxmHbVS5XG2jg0dw@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra"><br>
          <div class=3D"gmail_quote">On Thu, Dec 10, 2015 at 11:49 AM,
            ValdikSS <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
                href=3D"mailto:iam@...2070..." target=3D"_blank">iam@...2098...=
0...</a>&gt;</span>
            wrote:<br>
          </div>
          <br>
        </div>
        <div class=3D"gmail_extra">Provided it doesn't leak memory. As the
          current implementation of wfp_add_filter does return the id of
          the added filter (in &amp;filterid) , its easy to save them
          into some globals and delete all the filters in wfp_uninit.<br>
          <br>
        </div>
        <div class=3D"gmail_extra">However, If you are sure there is no
          leak, just closing the engine is fine.<br>
          <br>
        </div>
        <div class=3D"gmail_extra">Other than this v8 is good to go.<br>
        </div>
        <div class=3D"gmail_extra"><br>
        </div>
        <div class=3D"gmail_extra">Selva<br>
        </div>
      </div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">------------------------------------------------------=
------------------------
</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Openvpn-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-devel@...1466...=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/op=
envpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------040503020607030401030400--

--WNVMhEOEsRvLbU4jfUN89NmDTV16wgxde
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIcBAEBCAAGBQJWad4IAAoJEFzXIC7viPdyf6sQAMwowzmIc/OWdRdIq6QYSqjb
Xdqzj8ukr5VeVT8mOHcBBNix5VOjDBq5r0bcd0jijYMDQ1YNyKh6lER5TFdWOBMc
HRExHf8bvjjcldriPKIFRUDYFLu7a5G+l1B3REgQZyb5yzPxna4pb259TOglurhL
j2QxssN3kkyNIuUG3iMPDGZyNc3x5+sCRdQBhgrkVmYNVLbolftXTp9wR/4ZFiDg
Vpx1eB4uqPhasNa2nJ8ZInrT1qhq5yhbleSy5BgIB6t69SdfOeE9NBKpM71nF/UY
h4dh5whGzv/2TDBA55RhkON1nnJTxVkTlledJ2PmhqD8dSCFvgKiNfwKE7VAcu9M
Je/rS5xrJhrys7vBN1uNbrz41mjJoUeYTL5l8jG/b6x4h1UYU7idPl9MnaqeUZRX
fUj5RQt9qAyyV6rePwLp/RQXzYCLTJw/y22S7jbS+96gqpPKSR/jvfqBOvbf/m9o
xUVVPFW3cvNvDxzLifRv2zki1BGRvzKw3zdJvAubvlcRrB4YkaaKRAyqQN1RQH6M
MbvXBwCKtf+Lk1BiQRR+eNPn983mW+6+MueiAMzu7teRWz4zBJgybc0FirCr0IC4
VFEMpcc2PMMjxfPs13JiJy2vRknKwSdw/xH6xz8CC+87REe+Y84e51AE9+Sl+XuV
0zYM0Mp5TH1e+EPwHfsN
=ss+6
-----END PGP SIGNATURE-----

--WNVMhEOEsRvLbU4jfUN89NmDTV16wgxde--

