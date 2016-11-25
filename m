Content-Type: multipart/alternative;
	boundary=Apple-Mail-C187105E-F56D-4001-8331-0AE3C9FCFEC0
Mime-Version: 1.0 (1.0)
From: Marvin Adeff <volleynbike@...277...>
In-Reply-To: <CAKuzo_haYL+hX8YPEtuFwMB9uDA2v1CcSb9iqvVDVYi_h7+zpg@...278...>
Date: Fri, 25 Nov 2016 10:24:16 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <A8D1C0D6-04B4-468D-B05D-3842AC06DE58@...277...>
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
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Apple-Mail-C187105E-F56D-4001-8331-0AE3C9FCFEC0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

How about a "preferences" file in %Users%\AppData...?  The installer would =
apply whatever basic choices during install (%defaultUser%\AppData). Then  =
a user could set his personal preferences which WinGUI would save to %Users=
%\AppData.

Sent from my iPhone

> On Nov 25, 2016, at 8:39 AM, Selva Nair <selva.nair@...277...> wrote:
>=20
>=20
>> On Fri, Nov 25, 2016 at 10:27 AM, Gert Doering <gert@...1296...> wrote:
>> On Fri, Nov 25, 2016 at 09:38:31AM -0500, Selva Nair wrote:
>> > Even if the GUI cjecks HKLM and HKCU, toggling the option will not wor=
k as
>> > the GUI cannot reset HKLM values. We do not want to be requiring admin
>> > rights to run the GUI and that option becomes "readonly" for the user =
if
>> > startup is set in HKLM.
>>=20
>> How do other packagages handle "this is the system default, but users
>> can change their own setting"?  (So the admin could say "I want this sta=
rted
>> by default, for all users" and individual users can uncheck this "leave
>> me alone!")
>>=20
>> Just thinking aloud, no idea how much effort this is, and whether it's
>> a useful consideration in the first place.
>=20
> The installer could enumerate all users and adds the setting to their HKC=
U's. But its not perfect as new users will not get the setting.
>=20
> A more sophisticated approach is to use the "active-setup" feature. I hav=
e never used it but its supposed to work like this:
>=20
> Installer adds a reg key
> "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed Components\=
OpenVPNUserSetup" with two values:
> Version =3D "2.4.1"  <-- update this every install
> StubPath =3D "some_cmd"  <-- see below
>=20
> When the user logs system will check the value of Version and if new, wil=
l execute "some_cmd". So we can set som_cmd to just add teh required reg-ke=
y in HKCU like this:
>=20
> reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run =
/v "OPENVPN-GUI" /d "path_to_openvpn_gui" /t REG_SZ /f"
>=20
> I haven't tested it. For more details see: https://helgeklein.com/blog/20=
10/04/active-setup-explained/  or google active setup.
>=20
> Selva
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--Apple-Mail-C187105E-F56D-4001-8331-0AE3C9FCFEC0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body dir=3D"auto"><div>How about a "preferences" file in =
%Users%\AppData...? &nbsp;The installer would apply whatever basic choices =
during install (%defaultUser%\AppData). Then &nbsp;a user could set his per=
sonal preferences which WinGUI would save to&nbsp;<span style=3D"background=
-color: rgba(255, 255, 255, 0);">%Users%\AppData.</span><br><br>Sent from m=
y iPhone</div><div><br>On Nov 25, 2016, at 8:39 AM, Selva Nair &lt;<a href=
=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt; wrote:<br><br=
></div><blockquote type=3D"cite"><div><div dir=3D"ltr"><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On Fri, Nov 25, 2016 at 10:27 AM, Ger=
t Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span=
 class=3D"m_6294736153052371988gmail-">On Fri, Nov 25, 2016 at 09:38:31AM -=
0500, Selva Nair wrote:<br>
&gt; Even if the GUI cjecks HKLM and HKCU, toggling the option will not wor=
k as<br>
&gt; the GUI cannot reset HKLM values. We do not want to be requiring admin=
<br>
&gt; rights to run the GUI and that option becomes "readonly" for the user =
if<br>
&gt; startup is set in HKLM.<br>
<br>
</span>How do other packagages handle "this is the system default, but user=
s<br>
can change their own setting"?&nbsp; (So the admin could say "I want this s=
tarted<br>
by default, for all users" and individual users can uncheck this "leave<br>
me alone!")<br>
<br>
Just thinking aloud, no idea how much effort this is, and whether it's<br>
a useful consideration in the first place.</blockquote></div><br>The instal=
ler could enumerate all users and adds the setting to their HKCU's. But its=
 not perfect as new users will not get the setting.</div><div class=3D"gmai=
l_extra"><br></div><div class=3D"gmail_extra">A more sophisticated approach=
 is to use the "active-setup" feature. I have never used it but its suppose=
d to work like this:</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">Installer adds a reg key</div><div class=3D"gmail_extra">"=
HKEY_LOCAL_MACHINE\SOFTWARE\<wbr>Microsoft\Active Setup\Installed Component=
s\OpenVPNUserSetup" with two values:</div><div class=3D"gmail_extra">Versio=
n =3D "2.4.1" &nbsp;&lt;-- update this every install</div><div class=3D"gma=
il_extra">StubPath =3D "some_cmd" &nbsp;&lt;-- see below</div><div class=3D=
"gmail_extra"><br></div><div class=3D"gmail_extra">When the user logs syste=
m will check the value of Version and if new, will execute "some_cmd". So w=
e can set som_cmd to just add teh required reg-key in HKCU like this:</div>=
<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">reg add&nbs=
p;HKEY_LOCAL_MACHINE\<wbr>Software\Microsoft\Windows\<wbr>CurrentVersion\Ru=
n /v "OPENVPN-GUI" /d "path_to_openvpn_gui" /t REG_SZ /f"</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I haven't tested it. =
For more details see:&nbsp;<a href=3D"https://helgeklein.com/blog/2010/04/a=
ctive-setup-explained/" target=3D"_blank">https://helgeklein.com/<wbr>blog/=
2010/04/active-setup-<wbr>explained/</a> &nbsp;or google active setup.</div=
><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div=
></div>
</div></blockquote><blockquote type=3D"cite"><div><span>-------------------=
-----------------------------------------------------------</span><br></div=
></blockquote><blockquote type=3D"cite"><div><span>________________________=
_______________________</span><br><span>Openvpn-devel mailing list</span><b=
r><span><a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-deve=
l@lists.sourceforge.net</a></span><br><span><a href=3D"https://lists.source=
forge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists=
/listinfo/openvpn-devel</a></span><br></div></blockquote></body></html>=

--Apple-Mail-C187105E-F56D-4001-8331-0AE3C9FCFEC0--

