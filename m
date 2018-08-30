MIME-Version: 1.0
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
 <20180829142715.417-3-christian.ehrhardt@...1808...>
 <20180829210556.0b76af25@...1799...>
 <c103429d-fff6-df7d-1f99-4e1a161a16ab@...2080...>
In-Reply-To: <c103429d-fff6-df7d-1f99-4e1a161a16ab@...2080...>
From: Christian Ehrhardt <christian.ehrhardt@...1808...>
Date: Thu, 30 Aug 2018 10:02:24 +0200
Message-ID: <CAATJJ0KKF2c_Uo=ZSP7MJnwHJc=6m4S1iRgkK48YKUKfUbjMBA@...278...>
Content-Type: multipart/alternative; boundary="0000000000005a92a20574a28067"
Subject: Re: [Openvpn-devel] [PATCH 2/2] systemd: extend
 CapabilityBoundingSet for learn-address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000005a92a20574a28067
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 30, 2018 at 1:38 AM David Sommerseth <
openvpn@...2080...> wrote:

> On 29/08/18 21:05, Christian Hesse wrote:
> > Christian Ehrhardt <christian.ehrhardt@...1808...> on Wed, 2018/08/29
> > 16:27:
> >> It seems a not too uncommon case that learn-address needs to recycle
> >> dnsmasq - to do so it would need CAP_KILL.
> >>
> >> This was suggested on https://community.openvpn.net/openvpn/ticket/918
> >>
> >> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@...1808...>
> >> ---
> >>  distro/systemd/openvpn-server@...2221... | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/distro/systemd/openvpn-server@...2221...
> >> b/distro/systemd/openvpn-server@...2221... index d1cc72cb..edace213
> 100644
> >> --- a/distro/systemd/openvpn-server@...2221...
> >> +++ b/distro/systemd/openvpn-server@...2221...
> >> @@ -11,7 +11,7 @@ Type=notify
> >>  PrivateTmp=true
> >>  WorkingDirectory=/etc/openvpn/server
> >>  ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log
> >> --status-version 2 --suppress-timestamps --config %i.conf
> >> -CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> >> CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
> >> CAP_AUDIT_WRITE +CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN
> >> CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT
> >> CAP_DAC_OVERRIDE CAP_AUDIT_WRITE CAP_KILL LimitNPROC=10
> >> DeviceAllow=/dev/null rw DeviceAllow=/dev/net/tun rw
> >
> > I do not like services being allowed to send signals to other processes.
> As
> > dnsmasq supports a dbus interface... How about using that? For example to
> > clear the dns cache of an instance started from Networkmanager:
> >
> > dbus-send --system --print-reply \
> > --dest=org.freedesktop.NetworkManager.dnsmasq /uk/org/thekelleys/dnsmasq
> \
> > uk.org.thekelleys.ClearCache
>
> +1 ... CAP_KILL privileges can too easily prepare the ground for DoS
> attacks.
>
> The D-Bus approach above seems much saner and safer.  Also because D-Bus
> gives
> a reasonable protection in regards to privilege escalation attacks.  But
> you
> most likely need to prepare a D-Bus policy for dnsmasq though, to allow the
> openvpn user (or whatever user who will execute this script) access to the
> uk.org.thekelleys.ClearCache D-Bus method.
>

I don't mind the KILL signal so much we can keep that off for another
discussion.
I like the suggestion if the dbus signal, clearly worth a try for those
with a matching setup.

After all my own thought of "umm KILL might be too much" is why I have
split it :-)

What bug 918 was originally about and would have to be cleared soon is the
CAP_AUDIT_WRITE.

So while we seem to agree we don't want/like CAP_KILL, could we add
CAP_AUDIT_WRITE as submitted?


> --
> kind regards,
>
> David Sommerseth
> OpenVPN Inc
>
>
>

-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd

--0000000000005a92a20574a28067
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu=
, Aug 30, 2018 at 1:38 AM David Sommerseth &lt;<a href=3D"mailto:openvpn@...1186...=
.2080...">openvpn@...2080...</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">On 29/08/18 21:05, Christian Hesse wrote:<br>
&gt; Christian Ehrhardt &lt;<a href=3D"mailto:christian.ehrhardt@...1808...=
" target=3D"_blank">christian.ehrhardt@...1808...</a>&gt; on Wed, 2018/08/2=
9<br>
&gt; 16:27:<br>
&gt;&gt; It seems a not too uncommon case that learn-address needs to recyc=
le<br>
&gt;&gt; dnsmasq - to do so it would need CAP_KILL.<br>
&gt;&gt;<br>
&gt;&gt; This was suggested on <a href=3D"https://community.openvpn.net/ope=
nvpn/ticket/918" rel=3D"noreferrer" target=3D"_blank">https://community.ope=
nvpn.net/openvpn/ticket/918</a><br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Christian Ehrhardt &lt;<a href=3D"mailto:christian.=
ehrhardt@...1808..." target=3D"_blank">christian.ehrhardt@...1808...</a>&gt=
;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 distro/systemd/openvpn-server@...220...<a href=3D"http://ser=
vice.in" rel=3D"noreferrer" target=3D"_blank">service.in</a> | 2 +-<br>
&gt;&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/distro/systemd/openvpn-server@...220...<a href=3D"htt=
p://service.in" rel=3D"noreferrer" target=3D"_blank">service.in</a><br>
&gt;&gt; b/distro/systemd/openvpn-server@...220...<a href=3D"http://service=
.in" rel=3D"noreferrer" target=3D"_blank">service.in</a> index d1cc72cb..ed=
ace213 100644<br>
&gt;&gt; --- a/distro/systemd/openvpn-server@...220...<a href=3D"http://ser=
vice.in" rel=3D"noreferrer" target=3D"_blank">service.in</a><br>
&gt;&gt; +++ b/distro/systemd/openvpn-server@...220...<a href=3D"http://ser=
vice.in" rel=3D"noreferrer" target=3D"_blank">service.in</a><br>
&gt;&gt; @@ -11,7 +11,7 @@ Type=3Dnotify<br>
&gt;&gt;=C2=A0 PrivateTmp=3Dtrue<br>
&gt;&gt;=C2=A0 WorkingDirectory=3D/etc/openvpn/server<br>
&gt;&gt;=C2=A0 ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/sta=
tus-%i.log<br>
&gt;&gt; --status-version 2 --suppress-timestamps --config %i.conf<br>
&gt;&gt; -CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_S=
ERVICE<br>
&gt;&gt; CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE<=
br>
&gt;&gt; CAP_AUDIT_WRITE +CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMI=
N<br>
&gt;&gt; CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHR=
OOT<br>
&gt;&gt; CAP_DAC_OVERRIDE CAP_AUDIT_WRITE CAP_KILL LimitNPROC=3D10<br>
&gt;&gt; DeviceAllow=3D/dev/null rw DeviceAllow=3D/dev/net/tun rw<br>
&gt; <br>
&gt; I do not like services being allowed to send signals to other processe=
s. As<br>
&gt; dnsmasq supports a dbus interface... How about using that? For example=
 to<br>
&gt; clear the dns cache of an instance started from Networkmanager:<br>
&gt; <br>
&gt; dbus-send --system --print-reply \<br>
&gt; --dest=3Dorg.freedesktop.NetworkManager.dnsmasq /uk/org/thekelleys/dns=
masq \<br>
&gt; uk.org.thekelleys.ClearCache<br>
<br>
+1 ... CAP_KILL privileges can too easily prepare the ground for DoS attack=
s.<br>
<br>
The D-Bus approach above seems much saner and safer.=C2=A0 Also because D-B=
us gives<br>
a reasonable protection in regards to privilege escalation attacks.=C2=A0 B=
ut you<br>
most likely need to prepare a D-Bus policy for dnsmasq though, to allow the=
<br>
openvpn user (or whatever user who will execute this script) access to the<=
br>
uk.org.thekelleys.ClearCache D-Bus method.<br></blockquote><div><br></div><=
div><p style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quot;Bitstream =
Vera Sans&quot;,Helvetica,sans-serif;font-size:13px">I don&#39;t mind the K=
ILL signal so much we can keep that off for another discussion.<br>I like t=
he suggestion if the dbus signal, clearly worth a try for those with a matc=
hing setup.<br></p><p style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&=
quot;Bitstream Vera Sans&quot;,Helvetica,sans-serif;font-size:13px">After a=
ll my own thought of &quot;umm KILL might be too much&quot; is why I have s=
plit it :-)</p><p style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quot=
;Bitstream Vera Sans&quot;,Helvetica,sans-serif;font-size:13px">What bug 91=
8 was originally about and would have to be cleared soon is the CAP_AUDIT_W=
RITE.<br></p><p style=3D"color:rgb(0,0,0);font-family:Verdana,Arial,&quot;B=
itstream Vera Sans&quot;,Helvetica,sans-serif;font-size:13px">So while we s=
eem to agree we don&#39;t want/like CAP_KILL, could we add CAP_AUDIT_WRITE =
as submitted?</p></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
-- <br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Inc<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><div><div dir=3D"ltr"><span style=3D"color:rgb(136,136,136);font-size:1=
2.8px">Christian Ehrhardt</span><div style=3D"color:rgb(136,136,136);font-s=
ize:12.8px">Software Engineer, Ubuntu Server</div><div style=3D"color:rgb(1=
36,136,136);font-size:12.8px">Canonical Ltd</div></div></div></div></div></=
div>

--0000000000005a92a20574a28067--

