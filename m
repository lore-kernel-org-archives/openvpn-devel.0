References: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
From: ValdikSS <iam@...2070...>
Message-ID: <073f348b-77a8-3967-2874-77f2c973dbf4@...2070...>
Date: Tue, 16 Aug 2016 19:41:44 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OkpnSq103kahHpQtRpOVxvXbdN6o03uiu"
Subject: Re: [Openvpn-devel] block-outside-dns and multiple tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OkpnSq103kahHpQtRpOVxvXbdN6o03uiu
Content-Type: multipart/mixed; boundary="DKNo6Vwev7vc66gVECBFaNWTufNh89vwr"
From: ValdikSS <iam@...2070...>
To: Selva Nair <selva.nair@...277...>,
	openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <073f348b-77a8-3967-2874-77f2c973dbf4@...2070...>
Subject: Re: block-outside-dns and multiple tunnels
References: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
In-Reply-To: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>

--DKNo6Vwev7vc66gVECBFaNWTufNh89vwr
Content-Type: multipart/alternative;
	boundary="------------B172D7F03375319A9C3512CE"

This is a multi-part message in MIME format.
--------------B172D7F03375319A9C3512CE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

This is known issue (for me), and it was superficially discussed on IRC at =
some point. It wasn't considered significant to implement block-outside-dns=
 for
multiple connections.

Is there ahy reason to use block-outside-dns on multiple connections? Just =
asked supergregg (bug reporter), he probably has a reason if he created the=
 bug.

On 08/06/2016 07:04 AM, Selva Nair wrote:
> Hi,
>
> It has been reported (Trac 718) that --block-outside-dns on multiple tunn=
els blocks all DNS traffic. My tests appear to confirm this.
>
> Apparently this is due to each openvpn instance adding filters to indepen=
dent sublayers. With two tunnels we get port 53 filters in two sublayers:
>
> sublayer 1: permit openvpn, permit tap1, block all  (in that order)
> sublayer 2: permit openvpn, permit tap2, block all
>
> Filter arbitration works roughly like this: filters in each sublayer are =
parsed in order of priority and stops at the first match. Then the result f=
rom all
> sublayers are considered in order of priority in determining the final ac=
tion: a block is final and by default a permit may be overridden by block i=
n lower
> priority sublayers. So for traffic through tap1, we get permit from subla=
yer 1 and block from sublayer 2 leading to a block etc.=20
>
> This could partially mitigated by making the permit tap1/tap2 filters har=
d (they are soft by default -- i.e may be overridden). I say partially beca=
use only
> one of the "permit tap" filters can be thus protected.
>
> I see two ways to allow dns traffic through all tunnels for which --block=
-outside-dns is set
>
> 1. Add all filters to a the default sublayer  --- this is the easiest opt=
ion but not ideal: cluttering the default sublayer with custom filters may =
not not be
> considered a good practice.
>
> 2. Add all filters to a common custom sublayer. This requires a pre-defin=
ed UUID that could be used to define the sublayer and shared between all in=
stances of
> openvpn.
>
> For UUID,
> (a) generate a machine-specific UUID at install time, save in the registr=
y and use it as the sublayer key
>
> OR
>
> (b) hard code a UUID in the executable and use it as the sublayer key
>
> I prefer (b) as its simpler.
>
> Note that each additional instances will add duplicate filters like "perm=
it openvpn" or a low priority "block all". This is required as these filter=
s are
> added in a dynamic session so that they disappear if the process terminat=
es or crashes without removing the filters. As parsing filters within a sub=
layer
> stops as soon as a match (permit or block)  is found, no performance pena=
lty is expected. In any case it will have less overhead than the current si=
tuation
> with multiple sublayers.
>
> Any suggestions?
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


--------------B172D7F03375319A9C3512CE
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    This is known issue (for me), and it was superficially discussed on
    IRC at some point. It wasn't considered significant to implement
    block-outside-dns for multiple connections.<br>
    <br>
    Is there ahy reason to use block-outside-dns on multiple
    connections? Just asked supergregg (bug reporter), he probably has a
    reason if he created the bug.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 08/06/2016 07:04 AM, Selva Nair
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAKuzo_jO0FLo=3DxMakh1yB6_h=3DhuE4Pqp6Xtk2QEgXikeui-F6w@...1811...=
.."
      type=3D"cite">
      <div dir=3D"ltr">Hi,
        <div><br>
        </div>
        <div>It has been reported (Trac 718) that --block-outside-dns on
          multiple tunnels blocks all DNS traffic. My tests appear to
          confirm this.</div>
        <div><br>
        </div>
        <div>Apparently this is due to each openvpn instance adding
          filters to independent sublayers. With two tunnels we get port
          53 filters in two sublayers:</div>
        <div><br>
        </div>
        <div>sublayer 1: permit openvpn, permit tap1, block all=A0 (in
          that order)<br>
        </div>
        <div>sublayer 2: permit openvpn, permit tap2, block all</div>
        <div><br>
        </div>
        <div>Filter arbitration works roughly like this: filters in each
          sublayer are parsed in order of priority and stops at the
          first match. Then the result from all sublayers are considered
          in order of priority in determining the final action: a block
          is final and by default a permit may be overridden by block in
          lower priority sublayers. So for traffic through tap1, we get
          permit from sublayer 1 and block from sublayer 2 leading to a
          block etc.=A0</div>
        <div><br>
        </div>
        <div>This could partially mitigated by making the permit
          tap1/tap2 filters hard (they are soft by default -- i.e may be
          overridden). I say partially because only one of the "permit
          tap" filters can be thus protected.<br>
        </div>
        <div><br>
        </div>
        <div>I see two ways to allow dns traffic through all tunnels for
          which --block-outside-dns is set<br>
        </div>
        <div><br>
        </div>
        <div>1. Add all filters to a the default sublayer=A0 --- this is
          the easiest option but not ideal: cluttering the default
          sublayer with custom filters may not not be considered a good
          practice.<br>
        </div>
        <div><br>
        </div>
        <div>2. Add all filters to a common custom sublayer. This
          requires a pre-defined UUID that could be used to define the
          sublayer and shared between all instances of openvpn. <br>
          <br>
          For UUID,</div>
        <div>(a) generate a machine-specific UUID at install time, save
          in the registry and use it as the sublayer key</div>
        <div><br>
        </div>
        <div>OR</div>
        <div><br>
        </div>
        <div>(b) hard code a UUID in the executable and use it as the
          sublayer key</div>
        <div><br>
        </div>
        <div>I prefer (b) as its simpler.</div>
        <div><br>
        </div>
        <div>Note that each additional instances will add duplicate
          filters like "permit openvpn" or a low priority "block all".
          This is required as these filters are added in a dynamic
          session so that they disappear if the process terminates or
          crashes without removing the filters. As parsing filters
          within a sublayer stops as soon as a match (permit or block)=A0
          is found, no performance penalty is expected. In any case it
          will have less overhead than the current situation with
          multiple sublayers.</div>
        <div><br>
        </div>
        <div>Any suggestions?</div>
        <div><br>
        </div>
        <div>Selva</div>
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

--------------B172D7F03375319A9C3512CE--

--DKNo6Vwev7vc66gVECBFaNWTufNh89vwr--

--OkpnSq103kahHpQtRpOVxvXbdN6o03uiu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: https://keybase.io/valdikss

iQIxBAEBCAAbBQJXs0JIFBxpYW1AdmFsZGlrc3Mub3JnLnJ1AAoJEFzXIC7viPdy
6bIP/AgCNjHd4HliL8yS+w/amx/1J/NfwrHrHq09oFwgZuTY1p58+93g1cufX9Sc
KDHMf6zdKd/9qDhHuxu/2EFOZjbTpG8EJ+ybjroDzW3kuNHoqhgfyiZgQLxy8iae
klvK8SjIve1UqhRkHYto+zf+qLUdYbrBg2c5WEE1PRleGfALfFB72fYd2RDvE3kr
uaKFDQHv8nMXIlsDZWly9779PKGoLJofaCuLRes4lOySZ7Q2YLVCTNLMXBZ7N9Rt
Zccz8w+mlVdeJposfGfKazWB+AQLjyQEqU3sc7Q5kKMAZPaHbFH2LeBE4yES4vzU
XdNUvnlMs0fzZvd17Xe4tCllewG5FeBy62C83eZAQuy3GEMgwtWCzOfwZeBpBsmD
5jTRyNfCnEa+vJjWi76oIRQLtm/idc9DWIGC2IH3/i28DsfoTrDRhTP5R1ioqSUE
w/4VMrbfUA9c5VFl//FFjn2vwOjxuig1Ju0EDKYQx9XaPbVJcT33/QBdxFBk86CV
V00Xoe3YCRWlSm7efeMGDGquCIGOF67VZs9mHDV+U4ibRBOSQv3mEpxyEx83QCZo
JG2xq/f8b2JBhW1KeXoZ4BfN75uxCnlJxMxZsBoG4OWetewxNzZXOb23Cy0VZypw
Nluz2Vto/CLUaDbnmOWt9oSXPiAxujGKtSL/WIIPJXpmiN3M
=G12a
-----END PGP SIGNATURE-----

--OkpnSq103kahHpQtRpOVxvXbdN6o03uiu--

