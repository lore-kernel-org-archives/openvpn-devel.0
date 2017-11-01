MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1085875356@...2294...>
References: <99D61A626FDA8A4B90A270669121BE108587171C@...2294...>
 <CAKuzo_her_KFBMA3Xt6zKGmHGLnc89qXkb=n_LnvxcSzsvdV+A@...278...>
 <99D61A626FDA8A4B90A270669121BE1085875356@...2294...>
From: Selva <selva.nair@...277...>
Date: Tue, 31 Oct 2017 23:13:13 -0400
Message-ID: <CAKuzo_hpGEdV8fqTjRYWqPnb8b15JKmng_KrazQOPq6Kaq9qSQ@...278...>
Content-Type: multipart/alternative; boundary="001a114e6508bfce24055ce34159"
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

--001a114e6508bfce24055ce34159
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Oct 31, 2017 at 5:19 PM, Simon Rozman <simon@...2293...> wrote:

> Hi,
>
> > Instead of a pipe name set at compile-time, I think its better to make
> this
> > customizable by the installer. That is, we could take service name from
> an
> > optional registry entry so that it may be renamed by the installation
> package.
>
> Honestly, to make the name of the named pipe and the registry

dynamically configurable was my first idea too. Only to find out

that openvpnserv.exe already supports compile-time customization

of the settings registry key. Thus, extending this practice to the

named pipe was the "KISS" approach.
>
> I'd propose to use a service command line argument. Something

like "--instance name". When --instance is not specified the name

defaults to "OpenVPN". The service command line is stored in

registry after all: HKEY_LOCAL_MACHINE\SYSTEM\Curr
> entControlSet\Services\<service name>\ImagePath.

Example: Microsoft SQL Server is using service command

line arguments to support multiple instances.


> If we could make this patch merged into the official OpenVPN distribution,

it would be a big win for us too, as we would no longer require to compile

openvpnserv.exe ourselves anymore.
>

Named instances sounds like is a good idea. As you pointed out, Microsoft
itself uses command line parameters on service (like -i NAME for SQL server)
so that looks kosher.

There is a problem though: multiple instances also need multiple service
names but the service name is hardcoded in the source. In our case even
the dispatcher needs to know the service name(s) as we use
SERVICE_WIN32_SHARE_PROCESS and share the process between
the legacy service[*] and the interactive service.

Looks like the service name also will have to be dynamically-generated
from the instance name.

If you want to support multiple installations of openvpn.exe/service,
building with a different PACKAGE_NAME can't be avoided, can it?.
Instead, if using the "official" executables is ok, why not just use
oepnvpnserviceinteractive as is. Does eduVPN really need its own instance
of the service?

That said, I like the idea of being able to run multiple (named) instances
of the service each with its own service pipe.

Selva

--001a114e6508bfce24055ce34159
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Tue, Oct 31, 2017 at 5:19 PM, Simon Rozman <span dir=3D"ltr">&lt;=
<a href=3D"mailto:simon@...2293..." target=3D"_blank">simon@...2293...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span><br>
&gt; Instead of a pipe name set at compile-time, I think its better to make=
 this<br>
&gt; customizable by the installer. That is, we could take service name fro=
m an<br>
&gt; optional registry entry so that it may be renamed by the installation =
package.<br>
<br>
</span>Honestly, to make the name of the named pipe and the registry=C2=A0<=
/blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">dynamically configurable was my =
first idea too. Only to find out=C2=A0</blockquote><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">that openvpnserv.exe already supports compile-time customization=C2=
=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">of the settings registry key=
. Thus, extending this practice to the=C2=A0</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">named pipe was the &quot;KISS&quot; approach.<br>
<br>
I&#39;d propose to use a service command line argument. Something=C2=A0</bl=
ockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">like &quot;--instance name&quot;. W=
hen --instance is not specified the name=C2=A0</blockquote><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">defaults to &quot;OpenVPN&quot;. The service command line is=
 stored in=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">registry after =
all: HKEY_LOCAL_MACHINE\SYSTEM\Curr<wbr>entControlSet\Services\&lt;servic<w=
br>e name&gt;\ImagePath.=C2=A0</blockquote><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">E=
xample: Microsoft SQL Server is using service command=C2=A0</blockquote><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">line arguments to support multiple instances.=
=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
If we could make this patch merged into the official OpenVPN distribution,=
=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">it would be a big win for=
 us too, as we would no longer require to compile=C2=A0</blockquote><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">openvpnserv.exe ourselves anymore.<br></blockquote>=
<div><br></div><div>Named instances sounds like is a good idea. As you poin=
ted out, Microsoft</div><div>itself uses command line parameters on service=
 (like -i NAME for SQL server)</div><div>so that looks kosher.</div><div>=
=C2=A0<br></div><div>There is a problem though: multiple instances also nee=
d multiple service</div><div>names but the service name is hardcoded in the=
 source. In our case even</div><div>the dispatcher needs to know the servic=
e name(s) as we use</div><div>SERVICE_WIN32_SHARE_PROCESS and share the pro=
cess between</div><div>the legacy service[*] and the interactive service.</=
div><div><br></div><div>Looks like the service name also will have to be dy=
namically-generated</div><div>from the instance name.</div><div><br></div><=
div>If you want to support multiple installations of openvpn.exe/service,</=
div><div>building with a different PACKAGE_NAME can&#39;t be avoided, can i=
t?.</div><div>Instead, if using the &quot;official&quot; executables is ok,=
 why not just use</div><div>oepnvpnserviceinteractive as is. Does eduVPN re=
ally need its own instance</div><div>of the service?</div><div><br></div><d=
iv>That said, I like the idea of being able to run multiple (named) instanc=
es</div><div>of the service each with its own service pipe.</div><div><br><=
/div><div>Selva</div></div></div></div>

--001a114e6508bfce24055ce34159--

