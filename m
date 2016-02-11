MIME-Version: 1.0
In-Reply-To: <56BCB9ED.7050802@...515...>
References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 11 Feb 2016 13:14:05 -0500
Message-ID: <CAKuzo_jrxEp9cASNQ3LO0bcKm3qfraTHL80EeC5dNcoiN++w+g@...278...>
Content-Type: multipart/alternative; boundary=047d7b417921464773052b8285a2
Subject: Re: [Openvpn-devel] OpenVPN installers with openvpn-gui pull
 request #13's code included
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b417921464773052b8285a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

forgot to CC: the list

Hi,

On Thu, Feb 11, 2016 at 11:42 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
 wrote:

PS> C:\> openvpnserv.exe -install
> PS> C:\> openvpnserv.exe -start automatic
>

I suppose you mean openvpnserv.exe -start interactive
(-start automatic or start without any option will start the automatic
service which is not a good idea.)


> After this the interactive service is running, but the non-interactive
> one is not:


A few things to fix:
>
> - Revert commit 2af86368964 in openvpn-gui
>

We may want to do this only for 2.4 (or git master) based binary
distributions. For 2.3 there is no interactive service and this
"highestAvailable" may still be required (or at least expected by users).

One way to handle this is to create a release branch on the GUI repo and
revert the commit only in master. Then 2.3 installers can continue to use
that release branch.


> - Make OpenVPN-GUI fail/warn if it can't reach interactive service
>

In fact it may be ok to require the iservice to operate the GUI -- that is
do not allow the GUI to directly start openvpn.exe -- running as admin will
fail with a message then). But leave this for later?

- Enable interactive service at OpenVPN install
>

I think the installer should include the following commands

(i) openvpnserv.exe -install  <- this will install both auto and
interactive services
this is probably there in the current NSIS installer (the user can disable
it by chosing not to install any service, but its not possible to install
only one of those (not yet, at least).

(ii) openvpnserv.exe --start interactive

Do not start the automatic service by default as that is meant for expert
users. Else it will spawn-up openvpn.exe for all configs found and possibly
mess-up with interactive use.

- Relax OpenVPN's config file permissions, or...
> - ... make OpenVPN-GUI read configs from user's home dir by default
>

With the pull #13, its now possible for the user to edit
HKCU\Software\OpenVPN\config_dir to point the GUI to an alternate location
for configs. Currently there are no access checks in the service, so any
location with read access will work.

Let's revisit this after the service is hardened to restrict configs and
options. Then we can decide how to modify the installer to choose
appropriate defaults for config_dir etc.


>
> Given that OpenVPNService and OpenVPNServiceInteractive have been
> separated, replacing the non-interactive variant with openvpnserv2
> should not be too difficult.
>

While the two services can be independently stopped and started the two are
installed and removed together:
openvpnserv.exe --install sets up two
services OpenVPNService and OpenVPNServiceInteractive. So any replacement
will have to use a name distinct from those. I think openvpnserv2 uses the
same name "OpenVPNService" which will cause a conflict.

In the long run it may be better to remove the automatic service completely
from the openvpnsev.exe code.


>
> Thoughts?
>

See above;)

Cheers,

Selva

--047d7b417921464773052b8285a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">forgot to CC: the list<br><br><=
div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ext=
ra"><span class=3D""><br><div class=3D"gmail_quote">On Thu, Feb 11, 2016 at=
 11:42 AM,=C2=A0Samuli=C2=A0Sepp=C3=A4nen=C2=A0<span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&gt;</s=
pan>=C2=A0wrote:</div><div class=3D"gmail_quote"><br></div></span><div clas=
s=3D"gmail_quote"><span class=3D""><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">PS&gt; C:\&gt; openvpn=
serv.exe -install<br>PS&gt; C:\&gt; openvpnserv.exe -start automatic<br></b=
lockquote><div><br></div></span><div>I suppose you mean=C2=A0openvpnserv.ex=
e=C2=A0-start interactive</div><div>(-start automatic or start without any =
option will start the automatic service which is not a good idea.)</div><sp=
an class=3D""><div>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(2=
04,204,204);border-left-style:solid;padding-left:1ex">After this the intera=
ctive service is running, but the non-interactive<br>one is not:</blockquot=
e><div class=3D"gmail_quote"><br></div></span><span class=3D""><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1=
px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:=
1ex"><div style=3D"overflow:hidden">A few things to fix:<br><br>- Revert co=
mmit 2af86368964 in openvpn-gui<br></div></blockquote><div><br></div></span=
><div>We may want to do this only for 2.4 (or git master) based binary dist=
ributions. For 2.3 there is no interactive service and this &quot;highestAv=
ailable&quot; may still be required (or at least expected by users).</div><=
div><br></div><div>One way to handle this is to create a release branch on =
the GUI=C2=A0repo=C2=A0and revert the commit only in master. Then 2.3 insta=
llers can continue to use that release branch.</div><span class=3D""><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex"><div style=3D"overflow:hidden">- Make OpenVPN-=
GUI fail/warn if it can&#39;t reach interactive service<br></div></blockquo=
te><div><br></div></span><div>In fact it may be=C2=A0ok=C2=A0to require the=
=C2=A0iservice=C2=A0to operate the GUI -- that is do not allow the GUI to d=
irectly start=C2=A0openvpn.exe=C2=A0-- running as admin will fail with a me=
ssage then). But leave this for later?</div><span class=3D""><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;=
padding-left:1ex"><div style=3D"overflow:hidden">- Enable interactive servi=
ce at OpenVPN install<br></div></blockquote><div><br></div></span><div>I th=
ink the installer should include the following commands</div><div><br></div=
><div>(i)=C2=A0openvpnserv.exe=C2=A0-install =C2=A0&lt;- this will install =
both auto and interactive services</div><div>this is probably there in the =
current=C2=A0NSIS=C2=A0installer (the user can disable it by=C2=A0chosing=
=C2=A0not to install any service, but its not possible to install only one =
of those (not yet, at least).</div><div>=C2=A0</div><div>(ii)=C2=A0openvpns=
erv.exe=C2=A0--start interactive</div><div><br></div><div>Do not start the =
automatic service by default as that is meant for expert users. Else it wil=
l spawn-up=C2=A0openvpn.exe=C2=A0for all=C2=A0configs=C2=A0found and possib=
ly mess-up with interactive use.=C2=A0</div><span class=3D""><div><br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;=
padding-left:1ex"><div style=3D"overflow:hidden">- Relax OpenVPN&#39;s conf=
ig file permissions, or...<br>- ... make OpenVPN-GUI read configs from user=
&#39;s home dir by default<br></div></blockquote><div><br></div></span><div=
>With the pull #13, its now possible for the user to edit HKCU\Software\Ope=
nVPN\config_dir=C2=A0to point the GUI to an alternate location for=C2=A0con=
figs. Currently there are no access checks in the service, so any location =
with read access will work.</div><div><br></div><div>Let&#39;s revisit this=
 after the service is hardened to restrict=C2=A0configs=C2=A0and options. T=
hen we can decide how to modify the installer to choose appropriate default=
s for=C2=A0config_dir=C2=A0etc.</div><span class=3D""><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddi=
ng-left:1ex"><div style=3D"overflow:hidden"><br>Given that OpenVPNService a=
nd OpenVPNServiceInteractive have been<br>separated, replacing the non-inte=
ractive variant with openvpnserv2<br>should not be too difficult.<br></div>=
</blockquote><div><br></div></span><div>While the two services can be indep=
endently stopped and started the two are installed and removed together:</d=
iv><div>openvpnserv.exe=C2=A0--install sets up two services=C2=A0OpenVPNSer=
vice=C2=A0and=C2=A0OpenVPNServiceInteractive. So any replacement will have =
to use a name distinct from those. I think openvpnserv2 uses the same name =
&quot;OpenVPNService&quot; which will cause a conflict.</div><div>=C2=A0=C2=
=A0</div><div>In the long run it may be better to remove the automatic serv=
ice completely from the=C2=A0openvpnsev.exe=C2=A0code.=C2=A0</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex"><div style=3D"overflow:hidden"><br>Thoughts?</div=
></blockquote></div><div class=3D"gmail_extra"><br></div>See above;)</div><=
div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Cheers,</div=
><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div=
></div></div></div>

--047d7b417921464773052b8285a2--

