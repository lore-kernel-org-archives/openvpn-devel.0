MIME-Version: 1.0
In-Reply-To: <57BD5780.2030204@...1147...>
References: <57A3C76A.1020809@...277...>
	<CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
	<f9d8f147-e3d1-b80b-5646-faba6b853bc2@...277...>
	<76eb908d-b7b3-7425-5340-e4cd5726fbd1@...2080...>
	<3642cff2-6233-0a28-2a39-36513f008ab4@...277...>
	<20160823123439.GA78279@...1296...>
	<57BD5780.2030204@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Aug 2016 10:03:27 -0400
Message-ID: <CAKuzo_jwni94qa+eHyB5+4J=987srCSF7CuisvPMBPxnAPOa-A@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0a879a115eb9053ad1c0e5
Subject: Re: [Openvpn-devel] Win10 Tun Server +Standard W10 User +OVPN
 Interactive Service +OVPN GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0a879a115eb9053ad1c0e5
Content-Type: text/plain; charset=UTF-8

On Wed, Aug 24, 2016 at 4:14 AM, Jan Just Keijser <janjust@...1147...> wrote:

> Hi,
>
> On 23/08/16 14:34, Gert Doering wrote:
> > On Tue, Aug 23, 2016 at 01:55:23AM +0100, debbie10t wrote:
> >> I need to use --up/--down/--client-connect/disconnect et al ..
> > You can, but they will run with the user privileges of the user that
> > runs openvpn-gui by default.  If you need more privileges, you need
> > to run openvpn.exe or the gui with admin privs.
> >
> >> How does one run openvpn on *windows* without these "considered"
> >> security flaws ? or are we all just "lambs to the slaughter"
> >> from here on in ?
> > You can use openvpnserv2 to run openvpn.exe with admin privs (and no
> > gui), or you can set [x] run as admin on the openvpn-gui (as it was done
> > for 2.3.x).
> >
> > Most people on windows only need privileges to add/delete routes and
> > configure IP addresses - this is what the iservice will give you, without
> > the potential dangers of running openvpn and all scripts with full
> > admin privs.
> >
> just for my understanding: how would a user run an up/down script with
> *USER* credentials (necessary to map a share or printer, for example) in
> this scenario?
>

This requires a non-standard setup. Before iservice was available, we
solved this issue like this: start all connections at boot-time using the
automatic service holding them using management-hold. Then MI-GUI running
as user was used to control the connection (hold release to connect, hold
on + SIGHUP to disconnect and put back on hold). In that case scripts run
by openvpn executed as admin (we allowed no such scripts) and scripts run
by the GUI ran as user. The latter was used for mapping drives.

iservice made all this much simpler --- start the GUI as user and
everything runs as user (ordinary users do not care what happens under the
hood of iservice) or start the GUI as admin and everything runs as admin
(in this case iservice will not be used, but all of that is transparent to
the user).

Going forward, I have a patch in the making (well, it works but needs some
refining) that will allow the GUI to control (connect, disconnect etc..)
prestarted instances so that more advanced users who want to start openvpn
at boot time can still control it using the GUI running as user. In this
case, the prestarted instance could use iservice or be started as admin
depending on the user's need. Obviously, such a use case would be aimed at
"clueful" users.

Selva

--94eb2c0a879a115eb9053ad1c0e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Aug 24, 2016 at 4:14 AM, Jan Just Keijser <span dir=3D"ltr">&lt;<a =
href=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":ej6" class=
=3D"a3s aXjCH m156bb9ff7083d286">Hi,<br>
<span class=3D""><br>
On 23/08/16 14:34, Gert Doering wrote:<br>
&gt; On Tue, Aug 23, 2016 at 01:55:23AM +0100, debbie10t wrote:<br>
&gt;&gt; I need to use --up/--down/--client-connect/<wbr>disconnect et al .=
.<br>
&gt; You can, but they will run with the user privileges of the user that<b=
r>
&gt; runs openvpn-gui by default.=C2=A0 If you need more privileges, you ne=
ed<br>
&gt; to run openvpn.exe or the gui with admin privs.<br>
&gt;<br>
&gt;&gt; How does one run openvpn on *windows* without these &quot;consider=
ed&quot;<br>
&gt;&gt; security flaws ? or are we all just &quot;lambs to the slaughter&q=
uot;<br>
&gt;&gt; from here on in ?<br>
&gt; You can use openvpnserv2 to run openvpn.exe with admin privs (and no<b=
r>
&gt; gui), or you can set [x] run as admin on the openvpn-gui (as it was do=
ne<br>
&gt; for 2.3.x).<br>
&gt;<br>
&gt; Most people on windows only need privileges to add/delete routes and<b=
r>
&gt; configure IP addresses - this is what the iservice will give you, with=
out<br>
&gt; the potential dangers of running openvpn and all scripts with full<br>
&gt; admin privs.<br>
&gt;<br>
</span>just for my understanding: how would a user run an up/down script wi=
th<br>
*USER* credentials (necessary to map a share or printer, for example) in<br>
this scenario?</div></blockquote></div><br>This requires a non-standard set=
up. Before iservice was available, we solved this issue like this: start al=
l connections at boot-time using the automatic service holding them using m=
anagement-hold. Then MI-GUI running as user was used to control the connect=
ion (hold release to connect, hold on + SIGHUP to disconnect and put back o=
n hold). In that case scripts run by openvpn executed as admin (we allowed =
no such scripts) and scripts run by the GUI ran as user. The latter was use=
d for mapping drives.</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">iservice made all this much simpler --- start the GUI as u=
ser and everything runs as user (ordinary users do not care what happens un=
der the hood of iservice) or start the GUI as admin and everything runs as =
admin (in this case iservice will not be used, but all of that is transpare=
nt to the user).</div><div class=3D"gmail_extra"><br></div><div class=3D"gm=
ail_extra">Going forward, I have a patch in the making (well, it works but =
needs some refining) that will allow the GUI to control (connect, disconnec=
t etc..) prestarted instances so that more advanced users who want to start=
 openvpn at boot time can still control it using the GUI running as user. I=
n this case, the prestarted instance could use iservice or be started as ad=
min depending on the user&#39;s need. Obviously, such a use case would be a=
imed at &quot;clueful&quot; users.</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra">Selva</div></div>

--94eb2c0a879a115eb9053ad1c0e5--

