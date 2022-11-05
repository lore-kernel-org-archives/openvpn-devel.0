Content-Type: multipart/alternative;
 boundary=Apple-Mail-C22E6853-B8D9-4F76-9B58-0E455E7F1451
Content-Transfer-Encoding: 7bit
From: Lev Stipakov <lev@...515...>
Mime-Version: 1.0 (1.0)
Date: Sat, 5 Nov 2022 14:00:16 +0200
Message-Id: <21CD0BAE-B407-4565-B89E-3C4156F36130@...515...>
References: <Y2YvkfZa8HC81e5N@...1296...>
In-Reply-To: <Y2YvkfZa8HC81e5N@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] win32: detect arm64 architecture and
 emulations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net

--Apple-Mail-C22E6853-B8D9-4F76-9B58-0E455E7F1451
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I have tested following configurations:

On my Volterra:
- x86 on arm64 win11
- x64 on arm64 win11
- arm64 on arm64 win11

On my laptop:
- x86 on amd64 win10=20
- amd64 on amd64 win10

On VM:
- x86 on amd64 win7
- amd64 on amd64 win7

If you want to test, you could get binaries (enough to run openvpn =E2=80=
=94version) from my GHA fork (https://github.com/lstipakov/openvpn/actions/=
runs/3392266010). I can also open a PR to openvpn-build and modify GHA scri=
pt so that it points to my openvpn branch, this way we could get MSIs.=20

L=C3=A4hetetty iPhonesta

> Gert Doering <gert@...1296...> kirjoitti 5.11.2022 kello 11.40:
>=20
> =EF=BB=BFHi,
>=20
>> On Fri, Nov 04, 2022 at 11:02:47AM +0200, Lev Stipakov wrote:
>> From: Lev Stipakov <lev@...515...>
>>=20
>> Properly detect process architecture and
>> machine architecture, including arm64.
>>=20
>> Print process architecture and, if machine
>> architecture is different (we are running in
>> emulation), print that too.
>=20
> This looks generally good, so definitely a "feature ACK".
>=20
> Do you have a set of installers available so we can ask for testers?=20=20
> I can do win10+win11 on arm64, but would perfer if someone else would
> do i386/amd64 win7/10/11/server* testing.
>=20
> gert
> --=20
> "If was one thing all people took for granted, was conviction that if you=
=20
> feed honest figures into a computer, honest figures come out. Never doubt=
ed=20
> it myself till I met a computer with a sense of humor."
>                             Robert A. Heinlein, The Moon is a Harsh Mistr=
ess
>=20
> Gert Doering - Munich, Germany                             gert@...1296...

--Apple-Mail-C22E6853-B8D9-4F76-9B58-0E455E7F1451
Content-Type: multipart/mixed;
	boundary=Apple-Mail-24C8F18C-3CA7-469E-A006-DA1A02A72F53
Content-Transfer-Encoding: 7bit

--Apple-Mail-24C8F18C-3CA7-469E-A006-DA1A02A72F53
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body dir=3D"auto">I have tested following configurations:=
<div><br></div><div>On my Volterra:</div><div>- x86 on arm64 win11</div><di=
v>- x64 on arm64 win11</div><div>- arm64 on arm64 win11</div><div><br></div=
><div>On my laptop:</div><div>- x86 on amd64 win10&nbsp;</div><div>- amd64 =
on amd64 win10</div><div><br></div><div>On VM:</div><div>- x86 on amd64 win=
7</div><div>- amd64 on amd64 win7</div><div><br></div><div>If you want to t=
est, you could get binaries (enough to run openvpn =E2=80=94version) from m=
y GHA fork (<a href=3D"https://github.com/lstipakov/openvpn/actions/runs/33=
92266010">https://github.com/lstipakov/openvpn/actions/runs/3392266010</a>)=
. I can also open a PR to openvpn-build and modify GHA script so that it po=
ints to my openvpn branch, this way we could get MSIs.&nbsp;<br><br><div di=
r=3D"ltr">L=C3=A4hetetty iPhonesta</div><div dir=3D"ltr"><br><blockquote ty=
pe=3D"cite">Gert Doering &lt;gert@...1296...&gt; kirjoitti 5.11.2022 kello =
11.40:<br><br></blockquote></div><blockquote type=3D"cite"><div dir=3D"ltr"=
>=EF=BB=BF<span>Hi,</span><br><span></span><br><span>On Fri, Nov 04, 2022 a=
t 11:02:47AM +0200, Lev Stipakov wrote:</span><br><blockquote type=3D"cite"=
><span>From: Lev Stipakov &lt;lev@...515...&gt;</span><br></blockquote><blo=
ckquote type=3D"cite"><span></span><br></blockquote><blockquote type=3D"cit=
e"><span>Properly detect process architecture and</span><br></blockquote><b=
lockquote type=3D"cite"><span>machine architecture, including arm64.</span>=
<br></blockquote><blockquote type=3D"cite"><span></span><br></blockquote><b=
lockquote type=3D"cite"><span>Print process architecture and, if machine</s=
pan><br></blockquote><blockquote type=3D"cite"><span>architecture is differ=
ent (we are running in</span><br></blockquote><blockquote type=3D"cite"><sp=
an>emulation), print that too.</span><br></blockquote><span></span><br><spa=
n>This looks generally good, so definitely a "feature ACK".</span><br><span=
></span><br><span>Do you have a set of installers available so we can ask f=
or testers? &nbsp;</span><br><span>I can do win10+win11 on arm64, but would=
 perfer if someone else would</span><br><span>do i386/amd64 win7/10/11/serv=
er* testing.</span><br><span></span><br><span>gert</span><br><span>-- </spa=
n><br><span>"If was one thing all people took for granted, was conviction t=
hat if you </span><br><span> feed honest figures into a computer, honest fi=
gures come out. Never doubted </span><br><span> it myself till I met a comp=
uter with a sense of humor."</span><br><span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Robert A. H=
einlein, The Moon is a Harsh Mistress</span><br><span></span><br><span>Gert=
 Doering - Munich, Germany &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;gert@...1296...</span><br></di=
v></blockquote></div></body></html>=

--Apple-Mail-24C8F18C-3CA7-469E-A006-DA1A02A72F53
Content-Type: application/octet-stream;
	name=signature.asc;
	x-apple-part-url=C39000B9-A984-432F-A2AF-4E4BEE652B12
Content-Disposition: attachment;
	filename=signature.asc
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjZi+RAAoJEB2Cnv7KVigSn4QL/R2Ry0kGggoqCkgrjm+xU8Xx
rVzfrJwOa3iUhmhPN44AQ1s42FMghwgQNC7WKJEuiux02oLdZqISQB2drxn4ZsRv
J0t71YABi5mPK9SNqzh5NInxT/o71QfPEXnu7eV3aam0viwq50Q6QzgwZQ60J9tF
WpxEUqpLuBuuWilK3c9u1YOQYFGfG0JgxVVqeedGvUb2dLdNboQ4Zq9+Osbb4y+K
wl4Rexcu1O8PbWEbgevDuvE+PXghXRdHQaDgzivyovAMfmFtrzFBwdDDiEPJkac/
sddut5Z4pJjlyaGytRSK7vIcPXwKy1vhAK2/0Jpjh9qndeplE8k/FTIdeVcmW79d
98UbzWpUNkcsQcyZHJ3VtVl4asE+Ewf2ybLqwGJP/EBX3fbUmswYdp1edtJ9LsXW
ILlEHiyOxHSfqHF8Oh7czSF5blfwcZBGOTD5mJhvKB2GQuZF+IqdJoop8sLWnDS6
2bvao19CeG5H8BK1I1O8bzdGXGY4AQo5sfRSyDx05g==
=zg2e
-----END PGP SIGNATURE-----

--Apple-Mail-24C8F18C-3CA7-469E-A006-DA1A02A72F53
Content-Type: text/html;
	charset=us-ascii
Content-Transfer-Encoding: 7bit

<html><head><meta http-equiv="content-type" content="text/html; charset=us-ascii"></head><body dir="auto"><div><blockquote type="cite"><div dir="ltr"></div></blockquote></div></body></html>
--Apple-Mail-24C8F18C-3CA7-469E-A006-DA1A02A72F53--

--Apple-Mail-C22E6853-B8D9-4F76-9B58-0E455E7F1451--

