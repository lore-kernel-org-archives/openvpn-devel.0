MIME-Version: 1.0
In-Reply-To: <CAKuzo_haYL+hX8YPEtuFwMB9uDA2v1CcSb9iqvVDVYi_h7+zpg@...278...>
References: <CAFHpkQEkvbq1AGSYN-kYqfDjMbUXJhe1gysp4g6s1EOQku6JOQ@...278...>
	<20161116184717.GL28918@...1296...>
	<CAFHpkQHaDiP9Wk49ja3p_Oix=1fAtANzpqmPbT6hLZw6FVqLiw@...278...>
	<CAFHpkQHdgDAELAHwkYysyyGf5_sGFO-bkCuSVY=zwPKz1pLOwQ@...278...>
	<20161121194602.GR28918@...1296...>
	<CAFHpkQEFma=G_K3Y4FN+=vVSEQgyUySrR9HxBa6JejhimQxiNg@...278...>
	<CAFHpkQF7GtEXhaHBm-nRmHzcQ-cpsJt=MZM+h_1N4kORHERKeA@...278...>
	<CAKuzo_iEXGcuf1tt9zQh8dh42C5BX=jNoROXc_=CV-sOsBsW1w@...278...>
	<CAFHpkQFdVasrVF6Km_AnVwZL7QhGy1AAJAEeyiX7yt_Cq7R2Nw@...278...>
	<CAKuzo_h3kza0fftPTOc9vqhy=sSgTuOZXL=qzV3e29yhhpY8mA@...278...>
	<20161125152710.GA81859@...1296...>
	<CAKuzo_haYL+hX8YPEtuFwMB9uDA2v1CcSb9iqvVDVYi_h7+zpg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 25 Nov 2016 12:06:45 -0500
Message-ID: <CAKuzo_ibBkffrxSrgeP5r9=L48Y7jHpzqnVaM4sfk5dvWV93qA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0438e0cd612c0542232633
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0438e0cd612c0542232633
Content-Type: text/plain; charset=UTF-8

Typo alert:

On Fri, Nov 25, 2016 at 11:39 AM, Selva Nair <selva.nair@...277...> wrote:

> reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run
> /v "OPENVPN-GUI" /d "path_to_openvpn_gui" /t REG_SZ /f"
>

That should be HKEY_CURRENT_USER instead of HKEY_LOCAL_MACHINE

--94eb2c0438e0cd612c0542232633
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Typo alert:</div><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Fri, Nov 25, 2016 at 11:39 A=
M, Selva Nair <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..."=
 target=3D"_blank">selva.nair@...277...</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><div class=3D"gmail_extra">reg add=C2=A0HKEY_LOCAL_MAC=
HINE\Softwar<wbr>e\Microsoft\Windows\CurrentVer<wbr>sion\Run /v &quot;OPENV=
PN-GUI&quot; /d &quot;path_to_openvpn_gui&quot; /t REG_SZ /f&quot;</div></b=
lockquote></div><br>That should be HKEY_CURRENT_USER instead of HKEY_LOCAL_=
MACHINE</div></div>

--94eb2c0438e0cd612c0542232633--

