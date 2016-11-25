MIME-Version: 1.0
In-Reply-To: <20161125152710.GA81859@...1296...>
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
From: Selva Nair <selva.nair@...277...>
Date: Fri, 25 Nov 2016 11:39:34 -0500
Message-ID: <CAKuzo_haYL+hX8YPEtuFwMB9uDA2v1CcSb9iqvVDVYi_h7+zpg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05ab409b2bae054222c567
Subject: Re: [Openvpn-devel] launch openvpn-gui at windows startup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05ab409b2bae054222c567
Content-Type: text/plain; charset=UTF-8

On Fri, Nov 25, 2016 at 10:27 AM, Gert Doering <gert@...1296...> wrote:

> On Fri, Nov 25, 2016 at 09:38:31AM -0500, Selva Nair wrote:
> > Even if the GUI cjecks HKLM and HKCU, toggling the option will not work
> as
> > the GUI cannot reset HKLM values. We do not want to be requiring admin
> > rights to run the GUI and that option becomes "readonly" for the user if
> > startup is set in HKLM.
>
> How do other packagages handle "this is the system default, but users
> can change their own setting"?  (So the admin could say "I want this
> started
> by default, for all users" and individual users can uncheck this "leave
> me alone!")
>
> Just thinking aloud, no idea how much effort this is, and whether it's
> a useful consideration in the first place.


The installer could enumerate all users and adds the setting to their
HKCU's. But its not perfect as new users will not get the setting.

A more sophisticated approach is to use the "active-setup" feature. I have
never used it but its supposed to work like this:

Installer adds a reg key
"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Active Setup\Installed
Components\OpenVPNUserSetup" with two values:
Version = "2.4.1"  <-- update this every install
StubPath = "some_cmd"  <-- see below

When the user logs system will check the value of Version and if new, will
execute "some_cmd". So we can set som_cmd to just add teh required reg-key
in HKCU like this:

reg add HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run /v
"OPENVPN-GUI" /d "path_to_openvpn_gui" /t REG_SZ /f"

I haven't tested it. For more details see: https://helgeklein.com/
blog/2010/04/active-setup-explained/  or google active setup.

Selva

--94eb2c05ab409b2bae054222c567
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Nov 25, 2016 at 10:27 AM, Gert Doering <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-=
style:solid;padding-left:1ex"><span class=3D"m_6294736153052371988gmail-">O=
n Fri, Nov 25, 2016 at 09:38:31AM -0500, Selva Nair wrote:<br>
&gt; Even if the GUI cjecks HKLM and HKCU, toggling the option will not wor=
k as<br>
&gt; the GUI cannot reset HKLM values. We do not want to be requiring admin=
<br>
&gt; rights to run the GUI and that option becomes &quot;readonly&quot; for=
 the user if<br>
&gt; startup is set in HKLM.<br>
<br>
</span>How do other packagages handle &quot;this is the system default, but=
 users<br>
can change their own setting&quot;?=C2=A0 (So the admin could say &quot;I w=
ant this started<br>
by default, for all users&quot; and individual users can uncheck this &quot=
;leave<br>
me alone!&quot;)<br>
<br>
Just thinking aloud, no idea how much effort this is, and whether it&#39;s<=
br>
a useful consideration in the first place.</blockquote></div><br>The instal=
ler could enumerate all users and adds the setting to their HKCU&#39;s. But=
 its not perfect as new users will not get the setting.</div><div class=3D"=
gmail_extra"><br></div><div class=3D"gmail_extra">A more sophisticated appr=
oach is to use the &quot;active-setup&quot; feature. I have never used it b=
ut its supposed to work like this:</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra">Installer adds a reg key</div><div class=3D"gm=
ail_extra">&quot;HKEY_LOCAL_MACHINE\SOFTWARE\<wbr>Microsoft\Active Setup\In=
stalled Components\OpenVPNUserSetup&quot; with two values:</div><div class=
=3D"gmail_extra">Version =3D &quot;2.4.1&quot; =C2=A0&lt;-- update this eve=
ry install</div><div class=3D"gmail_extra">StubPath =3D &quot;some_cmd&quot=
; =C2=A0&lt;-- see below</div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra">When the user logs system will check the value of Versio=
n and if new, will execute &quot;some_cmd&quot;. So we can set som_cmd to j=
ust add teh required reg-key in HKCU like this:</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">reg add=C2=A0HKEY_LOCAL_MACHINE\<=
wbr>Software\Microsoft\Windows\<wbr>CurrentVersion\Run /v &quot;OPENVPN-GUI=
&quot; /d &quot;path_to_openvpn_gui&quot; /t REG_SZ /f&quot;</div><div clas=
s=3D"gmail_extra"><br></div><div class=3D"gmail_extra">I haven&#39;t tested=
 it. For more details see:=C2=A0<a href=3D"https://helgeklein.com/blog/2010=
/04/active-setup-explained/" target=3D"_blank">https://helgeklein.com/<wbr>=
blog/2010/04/active-setup-<wbr>explained/</a> =C2=A0or google active setup.=
</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva=
</div></div>

--94eb2c05ab409b2bae054222c567--

