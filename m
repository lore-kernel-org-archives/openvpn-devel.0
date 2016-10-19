MIME-Version: 1.0
In-Reply-To: <7e5a1e02-9e3c-7386-ac77-d961ac2081af@...515...>
References: <53533abe-e85d-7a42-49ce-465267997724@...515...>
	<44f51d16-5251-e257-263d-375d8e01abcb@...1227...>
	<CAKuzo_ix8a-LDv0tQXk3GoAQ_VAkRAO4CRmz5di0_QM-CuiXbA@...278...>
	<7e5a1e02-9e3c-7386-ac77-d961ac2081af@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 19 Oct 2016 11:43:19 -0400
Message-ID: <CAKuzo_gqkunn76BFBqH5wF7PPxUpnNWU1N8zipaK6P-g_LNg7A@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05e6764b8794053f39acb5
Subject: Re: [Openvpn-devel] Proper location for user-specific OpenVPN
 configuration files used by OpenVPN-GUI?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c05e6764b8794053f39acb5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Samuli Sepp=C3=A4nen <samuli@...515...> wrote:

>
>> Looks like there is a general consensus on this. If so, I will post a
>> patch later today to use %APPDATA%
>>
>> Selva
>>
>
> SviMik had a very good point against using %APPDATA%: it is a hidden
> folder. At least on Windows 7 it seems to be hidden at the filesystem
> level, because no tools seem to see it. However, doing a
>
>   cd $HOME\Appdata
>
> in Powershell will work, so the directory _is_ there even though it is
> invisble.
>
> I don't think we should put the configuration files into folder people
> will not find without extra tinkering.
>
>
As the UI improves with functionality to properly edit/tweak configs, make
new configs, import dependent files etc., the need for direct tinkering
will decrease. We could add a menu option to navigate to the config folder,
but not sure how well that works with hidden folders.

Also note that use of %APPDATA% actually means %APPDATA%\Local  (or
%APPDATA%\Roaming  if domain users need to see the same configs no matter
where the login from, which I do not think is necessary or proper in this
case).

Selva

--94eb2c05e6764b8794053f39acb5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
>Hi,</div><div>=C2=A0</div><div>Samuli Sepp=C3=A4nen=C2=A0<span dir=3D"ltr"=
>&lt;<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...=
</a>&gt;</span>=C2=A0wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(2=
04,204,204);border-left-style:solid;padding-left:1ex"><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border=
-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><spa=
n>
<br>
Looks like there is a general consensus on this. If so, I will post a<br>
patch later today to use %APPDATA%<br>
<br>
Selva<br>
</span></blockquote>
<br>
SviMik had a very good point against using %APPDATA%: it is a hidden folder=
. At least on Windows 7 it seems to be hidden at the filesystem level, beca=
use no tools seem to see it. However, doing a<br>
<br>
=C2=A0 cd $HOME\Appdata<br>
<br>
in Powershell will work, so the directory _is_ there even though it is invi=
sble.<br>
<br>
I don&#39;t think we should put the configuration files into folder people =
will not find without extra tinkering.<div class=3D"gmail-m_-87134555695046=
95065HOEnZb"><div class=3D"gmail-m_-8713455569504695065h5"><br></div></div>=
</blockquote><div><br></div><div>As the UI improves with functionality to p=
roperly edit/tweak configs, make new configs, import dependent files etc., =
the need for direct tinkering will decrease. We could add a menu option to =
navigate to the config folder, but not sure how well that works with hidden=
 folders.</div><div><br></div><div>Also note that use of %APPDATA% actually=
 means %APPDATA%\Local =C2=A0(or %APPDATA%\Roaming =C2=A0if domain users ne=
ed to see the same configs no matter where the login from, which I do not t=
hink is necessary or proper in this case).</div><div><br></div><div>Selva</=
div></div></div></div>

--94eb2c05e6764b8794053f39acb5--

