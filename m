MIME-Version: 1.0
In-Reply-To: <5363B7A2.2000109@...1114...>
References: <535ECBB0.2060709@...1901...> <5362D3E9.3090001@...1114...>
	<5362FA6D.904@...1901...> <20140502072322.GT16637@...1296...>
	<5363B7A2.2000109@...1114...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Fri, 2 May 2014 12:05:29 -0400
Message-ID: <CAEsd45Rnr0pE=-dgB3Ht_7puxKOLhjZfhPdepCuutPQ+AnsSzQ@...278...>
Content-Type: multipart/alternative; boundary=bcaec52d5833c206bb04f86cf500
Subject: Re: [Openvpn-devel] [Openvpn-users] [PATCH] Add support for
 specifying the syslog facility, as requested in trac #188.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--bcaec52d5833c206bb04f86cf500
Content-Type: text/plain; charset=UTF-8

On Fri, May 2, 2014 at 11:20 AM, David Sommerseth <
openvpn.list@...1114...> wrote:

> The core principle in OpenVPN's option
>  parsing is that the last argument wins.  So if you have f.ex. --ping-exit
> 3
> times in a command line and two times in a config file, it's the last one
> which really sets the option.  --syslog-facility should be no different.
>
> IMO, distro init.d scripts should add the config file as the last argument
> when they kick off openvpn.  If they add stuff which overrides the config
> file, then it's a bug in the init.d script.
>

That might be good for distros, but Tunnelblick purposefully starts OpenVPN
with "--management" *after* "--config"; other GUIs may do this, too.
Tunnelblick does this to make sure that the management interface is used
only by Tunnelblick. (Tunnelblick separately warns the user if the
configuration file contains "--management" or other problematic options.)

For some options, it is the *first* argument that wins: "--log",
"--log-append", and I think "--daemon" (and possibly some other options
like "--syslog"). Tunnelblick puts --log and --daemon first to make sure it
controls logging. (Tunnelblick sends the log to a file, which it monitors,
instead of logging through the management interface, so Tunnelblick (the
GUI) does not need to be running when the OpenVPN instance is running --
for example, when nobody is logged in.)

--bcaec52d5833c206bb04f86cf500
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, May 2, 2014 at 11:20 AM, David Sommerseth <span dir=3D"ltr">&lt;<a href=
=3D"mailto:openvpn.list@...1114..." target=3D"_blank">openvpn.list@...1910...=
..</a>&gt;</span> wrote:</div>


<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex"><div>The core principle in Open=
VPN&#39;s option<br>

</div>
parsing is that the last argument wins. =C2=A0So if you have f.ex. --ping-e=
xit 3<br>
times in a command line and two times in a config file, it&#39;s the last o=
ne<br>
which really sets the option. =C2=A0--syslog-facility should be no differen=
t.<br>
<br>
IMO, distro init.d scripts should add the config file as the last argument<=
br>
when they kick off openvpn. =C2=A0If they add stuff which overrides the con=
fig<br>
file, then it&#39;s a bug in the init.d script.<br></blockquote><div><br></=
div><div>That might be good for distros, but Tunnelblick purposefully start=
s OpenVPN with &quot;--management&quot; <b>after</b> &quot;--config&quot;; =
other GUIs may do this, too. Tunnelblick does this to make sure that the ma=
nagement interface is used only by Tunnelblick. (Tunnelblick separately war=
ns the user if the configuration file contains &quot;--management&quot; or =
other problematic options.)<br>


</div><div><br></div><div>For some options, it is the=C2=A0<b>first</b>=C2=
=A0argument that wins: &quot;--log&quot;, &quot;--log-append&quot;, and I t=
hink &quot;--daemon&quot; (and possibly some other options like &quot;--sys=
log&quot;). Tunnelblick puts --log and --daemon first to make sure it contr=
ols logging. (Tunnelblick sends the log to a file, which it monitors, inste=
ad of logging through the management interface, so Tunnelblick (the GUI) do=
es not need to be running when the OpenVPN instance is running -- for examp=
le, when nobody is logged in.)</div>


<div><br></div></div></div></div>

--bcaec52d5833c206bb04f86cf500--

