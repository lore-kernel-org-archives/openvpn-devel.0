MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1085876852@...2294...>
References: <99D61A626FDA8A4B90A270669121BE108587171C@...2294...>
 <CAKuzo_her_KFBMA3Xt6zKGmHGLnc89qXkb=n_LnvxcSzsvdV+A@...278...>
 <99D61A626FDA8A4B90A270669121BE1085875356@...2294...>
 <CAKuzo_hpGEdV8fqTjRYWqPnb8b15JKmng_KrazQOPq6Kaq9qSQ@...278...>
 <99D61A626FDA8A4B90A270669121BE1085876852@...2294...>
From: Selva <selva.nair@...277...>
Date: Wed, 1 Nov 2017 10:36:03 -0400
Message-ID: <CAKuzo_gAf8be+-mMijjn0YqA+rxoRPH0ZpEkG7LNv_6+3+oQgw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c061d3cc9ba53055ceccb16"
Subject: Re: [Openvpn-devel] OpenVPN Interactive Service Branding
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel (openvpn-devel@lists.sourceforge.net)" <openvpn-devel@lists.sourceforge.net>, "eduvpn@...321..." <eduvpn@...321...>

--94eb2c061d3cc9ba53055ceccb16
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Nov 1, 2017 at 4:25 AM, Simon Rozman <simon@...2293...> wrote:

> Hi,
>
> > Named instances sounds like is a good idea. As you pointed out, Microsoft
> > itself uses command line parameters on service (like -i NAME for SQL
> server)
> > so that looks kosher.
> >
> > There is a problem though: multiple instances also need multiple service
> > names but the service name is hardcoded in the source. In our case even
> > the dispatcher needs to know the service name(s) as we use
> > SERVICE_WIN32_SHARE_PROCESS and share the process between
> > the legacy service[*] and the interactive service.
> >
> > Looks like the service name also will have to be dynamically-generated
> > from the instance name.
>
> There is a simpler solution for that:
>
> 1. Change the order of services listed in `dispatchTable` so the
> interactive
> service is listed first.
>
> 2. All non-default instances could install as `SERVICE_WIN32_OWN_PROCESS`,
> thus SCM will launch them as a separate process picking only the first
> entry
> in the `dispatchTable` ignoring the service name and ignoring all non-first
> entries.
>

Its not just the dispatch table, RegisterServiceCtrlHandlerEx() has to be
called
with the right name of the service, isn't it? Anyway, once you have a tested
patch all this will fall into place..


> > If you want to support multiple installations of openvpn.exe/service,
> > building with a different PACKAGE_NAME can't be avoided, can it?.
> > Instead, if using the "official" executables is ok, why not just use
> > oepnvpnserviceinteractive as is. Does eduVPN really need its own instance
> > of the service?
>
> No, actually eduVPN client is quite happy with the official interactive
> service as it is. Until we hit deployment issues with the
> openvpn-install-2.4.4-I601.exe installer described below.
>
> - When OpenVPN is not already installed, we would like to install it using
> only the minimum feature selection. You see, OpenVPN GUI desktop shortcut
> and
> auto-start in system tray is not desirable, as it will confuse the end
> users
> how to start using eduVPN.
> This can be accomplished using the command line parameters. So far so good.
>
> - When an older version of OpenVPN is already installed, we would like to
> update it. Unfortunately, the installer does not detect currently installed
> features. It just copies the default feature set overwriting previous
> installation. Again, users get the OpenVPN GUI desktop shortcut and system
> tray icon. Even if they were not installed before.
> We could use the command line parameters again to suggest a feature
> selection,
> but if the OpenVPN GUI was installed before, the update would not update
> it,
> leaving behind some sort of Frankenstein OpenVPN installation.
> The installer is missing a command line parameter to tell it "if feature is
> present then update, else leave it absent".
>
> - eduVPN will require latest up-to-date OpenVPN. Should any user require a
> specific older version of OpenVPN to connect to other service providers
> than
> eduVPN, this would be a problem.
>

This becomes an issue only if/when a future version of openvpn becomes
incompatible with the service in 2.4. (Prior to 2.4 there is no interactive
service).
At that point even the official releases will benefit from support for
multiple
instances (same of different versions) of the service.


>
> Because of those issues, we would like to install local OpenVPN - and keep
> it
> up-to-date - using an MSI package. While openvpn.exe and its dependency
> DLLs
> can easily be managed as a local copy, the interactive service cannot -
> without interfering with original OpenVPN installation.
>

Looks like most of these can be solved by packaging improvements. As samuli
wrote, we want to move to MSI, so contributing to that effort would greatly
help.

Thanks,

Selva

--94eb2c061d3cc9ba53055ceccb16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Wed, Nov 1, 2017 at 4:25 AM, Simon <span class=3D"" id=3D":230.1" =
tabindex=3D"-1">Rozman</span> <span dir=3D"ltr">&lt;<a href=3D"mailto:simon=
@...2293..." target=3D"_blank"><span class=3D"" id=3D":230.2" tabindex=3D"-=
1">simon</span>@<span class=3D"" id=3D":230.3" tabindex=3D"-1">rozman</span=
>.<span class=3D"" id=3D":230.4" tabindex=3D"-1">si</span></a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"gmail-"><br>
&gt; Named instances sounds like is a good idea. As you pointed out, Micros=
oft<br>
&gt; itself uses command line parameters on service (like -i NAME for SQL s=
erver)<br>
&gt; so that looks kosher.<br>
&gt;<br>
&gt; There is a problem though: multiple instances also need multiple servi=
ce<br>
&gt; names but the service name is hardcoded in the source. In our case eve=
n<br>
&gt; the dispatcher needs to know the service name(s) as we use<br>
&gt; SERVICE_WIN32_SHARE_PROCESS and share the process between<br>
&gt; the legacy service[*] and the interactive service.<br>
&gt;<br>
&gt; Looks like the service name also will have to be dynamically-generated=
<br>
&gt; from the instance name.<br>
<br>
</span>There is a simpler solution for that:<br>
<br>
1. Change the order of services listed in `dispatchTable` so the interactiv=
e<br>
service is listed first.<br>
<br>
2. All non-default instances could install as `SERVICE_WIN32_OWN_PROCESS`,<=
br>
thus SCM will launch them as a separate process picking only the first entr=
y<br>
in the `dispatchTable` ignoring the service name and ignoring all non-first=
<br>
entries.<br></blockquote><div><br></div><div>Its not just the dispatch tabl=
e, <span class=3D"" id=3D":230.5" tabindex=3D"-1">RegisterServiceCtrlHandle=
rEx</span>() has to be called</div><div>with the right name of the service,=
 isn&#39;t it? Anyway, once you have a tested</div><div>patch all this will=
 fall into place..</div><div><br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<span class=3D"gmail-"><br>
&gt; If you want to support multiple installations of openvpn.exe/service,<=
br>
&gt; building with a different PACKAGE_NAME can&#39;t be avoided, can it?.<=
br>
&gt; Instead, if using the &quot;official&quot; executables is ok, why not =
just use<br>
&gt; oepnvpnserviceinteractive as is. Does eduVPN really need its own insta=
nce<br>
&gt; of the service?<br>
<br>
</span>No, actually eduVPN client is quite happy with the official interact=
ive<br>
service as it is. Until we hit deployment issues with the<br>
openvpn-install-2.4.4-I601.exe installer described below.<br>
<br>
- When OpenVPN is not already installed, we would like to install it using<=
br>
only the minimum feature selection. You see, OpenVPN GUI desktop shortcut a=
nd<br>
auto-start in system tray is not desirable, as it will confuse the end user=
s<br>
how to start using eduVPN.<br>
This can be accomplished using the command line parameters. So far so good.=
<br>
<br>
- When an older version of OpenVPN is already installed, we would like to<b=
r>
update it. Unfortunately, the installer does not detect currently installed=
<br>
features. It just copies the default feature set overwriting previous<br>
installation. Again, users get the OpenVPN GUI desktop shortcut and system<=
br>
tray icon. Even if they were not installed before.<br>
We could use the command line parameters again to suggest a feature selecti=
on,<br>
but if the OpenVPN GUI was installed before, the update would not update it=
,<br>
leaving behind some sort of Frankenstein OpenVPN installation.<br>
The installer is missing a command line parameter to tell it &quot;if featu=
re is<br>
present then update, else leave it absent&quot;.<br>
<br>
- eduVPN will require latest up-to-date OpenVPN. Should any user require a<=
br>
specific older version of OpenVPN to connect to other service providers tha=
n<br>
eduVPN, this would be a problem.<br></blockquote><div><br></div><div>This b=
ecomes an issue only if/when a future version of <span class=3D"" id=3D":23=
0.6" tabindex=3D"-1">openvpn</span> becomes=C2=A0</div><div>incompatible wi=
th the service in 2.4. (Prior to 2.4 there is no interactive service).</div=
><div>At that point even the official releases will benefit from support fo=
r multiple</div><div>instances (same of different versions) of the service.=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
Because of those issues, we would like to install local OpenVPN - and keep =
it<br>
up-to-date - using an MSI package. While openvpn.exe and its dependency DLL=
s<br>
can easily be managed as a local copy, the interactive service cannot -<br>
without interfering with original OpenVPN installation.<br></blockquote><di=
v><br></div><div>Looks like most of these can be solved by packaging improv=
ements. As <span class=3D"" id=3D":230.7" tabindex=3D"-1">samuli</span></di=
v><div>wrote, we want to move to <span class=3D"" id=3D":230.8" tabindex=3D=
"-1">MSI</span>, so contributing to that effort would greatly help.</div><d=
iv><br></div><div>Thanks,</div><div><br></div><div><span class=3D"" id=3D":=
230.9" tabindex=3D"-1">Selva</span></div></div></div></div>

--94eb2c061d3cc9ba53055ceccb16--

