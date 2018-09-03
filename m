MIME-Version: 1.0
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
 <20180829142715.417-2-christian.ehrhardt@...1808...>
 <693d4552-ef0d-485e-4f04-c115402ba037@...2080...>
In-Reply-To: <693d4552-ef0d-485e-4f04-c115402ba037@...2080...>
From: Christian Ehrhardt <christian.ehrhardt@...1808...>
Date: Mon, 3 Sep 2018 08:00:59 +0200
Message-ID: <CAATJJ0K1v4eLLSwrpdnSgLV5LZkEAmVW3LfbRT3ssLW8Xb2bCw@...278...>
Content-Type: multipart/alternative; boundary="0000000000008b36a50574f1456d"
Subject: Re: [Openvpn-devel] [PATCH 1/2] systemd: extend
 CapabilityBoundingSet for auth_pam
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000008b36a50574f1456d
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 30, 2018 at 9:10 PM David Sommerseth <
openvpn@...2080...> wrote:

> On 29/08/18 16:27, Christian Ehrhardt wrote:
> > Auth_pam will require audit writes or the connection will be rejected
> > as the plugin fails to initialize like:
> >   openvpn[1111]: sudo: unable to send audit message
> >   openvpn[1111]: sudo: pam_open_session: System error
> >   openvpn[1111]: sudo: policy plugin failed session initialization
> >
> > See links from https://community.openvpn.net/openvpn/ticket/918 for
> > more.
> >
> > auth_pam is a common use case and capabilties for it should be allowed
> > by the .service file.
> >
> > Fixes: #918
> >
> > Signed-off-by: Christian Ehrhardt <christian.ehrhardt@...1808...>
> > ---
> >  distro/systemd/openvpn-server@...2221... | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/distro/systemd/openvpn-server@...2221...
> b/distro/systemd/openvpn-server@...2221...
> > index a8366a04..d1cc72cb 100644
> > --- a/distro/systemd/openvpn-server@...2221...
> > +++ b/distro/systemd/openvpn-server@...2221...
> > @@ -11,7 +11,7 @@ Type=notify
> >  PrivateTmp=true
> >  WorkingDirectory=/etc/openvpn/server
> >  ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log
> --status-version 2 --suppress-timestamps --config %i.conf
> > -CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
> > +CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
> CAP_AUDIT_WRITE
>
> CAP_AUDIT_WRITE sounds safe to add.  But I really need to get a better
> understanding *why* this is needed, when OpenVPN itself don't need this.
> What
> is it in the PAM code paths which triggers this requirement and why?
>
> There might be perfect valid reasons, but we can't just blindly jump into
> "Yes, we need it" without a good understanding of why.
>
> I have run tests on RHEL-7, Fedora 28 and some older Debian 8-9-ish-sid
> release.  I only stumble upon this issue on Debian.  So what is it Debian
> (and
> thus Ubuntu) does which causes this error?
>

I can only assume, but doing so I could think of the default way sudo is
set up for being the reason.
Looking at the messages:
  openvpn[1111]: sudo: unable to send audit message
  openvpn[1111]: sudo: pam_open_session: System error
  openvpn[1111]: sudo: policy plugin failed session initialization

It uses sudo for the callout in the openvpn configuration,
    learn-address "/usr/bin/sudo -u root
/etc/openvpn/scripts/ndp-proxy-setup.sh"
and the error seems to be related to actually sudo (in the openvpn context)
being unable to log it's action.
Now by default in Ubuntu/Debian there is /var/log/auth.log which will log
any sudo activity.

In a little experiment I got to the same errors by dropping that capabilty:
running "sudo id" as-is
$ sudo capsh -- -c "/usr/bin/sudo /usr/bin/id"
uid=0(root) gid=0(root) groups=0(root)

There are log entries for this like:
 sudo[4784]:  paelzer : TTY=pts/1 ; PWD=/home/paelzer ; USER=root ;
COMMAND=/sbin/capsh -- -c /usr/bin/sudo /usr/bin/id
 sudo[4784]: pam_unix(sudo:session): session opened for user root by
paelzer(uid=0)
 sudo[4785]:     root : TTY=pts/1 ; PWD=/home/paelzer ; USER=root ;
COMMAND=/usr/bin/id
 sudo[4785]: pam_unix(sudo:session): session opened for user root by
paelzer(uid=0)

But now in contrast doing the same with audit_write dropped
$ sudo capsh --drop="cap_audit_write" -- -c "/usr/bin/sudo /usr/bin/id"
sudo: unable to send audit message
sudo: pam_open_session: System error
sudo: policy plugin failed session initialization

And on the log side we will recognize some known messages:
sudo[4797]:  paelzer : TTY=pts/1 ; PWD=/home/paelzer ; USER=root ;
COMMAND=/sbin/capsh --drop=cap_audit_write -- -c /usr/bin/sudo /usr/bin/id
sudo[4797]: pam_unix(sudo:session): session opened for user root by
paelzer(uid=0)
sudo[4798]:     root : TTY=pts/1 ; PWD=/home/paelzer ; USER=root ;
COMMAND=/usr/bin/id
sudo[4798]: PAM audit_log_acct_message() failed: Operation not permitted
sudo[4798]: pam_unix(sudo:session): session opened for user root by
paelzer(uid=0)
sudo[4798]:     root : pam_open_session: System error ; TTY=pts/1 ;
PWD=/home/paelzer ; USER=root ; COMMAND=/usr/bin/id
sudo[4797]: pam_unix(sudo:session): session closed for user root


On RH sudo isn't even installed by default, it is just not their common way
to do these things.
I also haven't seen anything like /var/log/auth.log on a bare fedora system
while you'll always find it configured on Debian/Ubuntu.
Maybe the callout isn't even done with sudo in the RH/Fedora case, I'd
assume that is (one of?) the reasons for the different behavior.

I'd think sudo is a fairly common way to set things up, I'd also assume
that its logging is recommended default and thereby Debian/Ubuntu but
probably also some other distributions would benefit from adding
CAP_AUDIT_WRITE
Does this suffice as explanation why/how this is needed?

I did a little search the PAM error which occurs (audit_log_acct_message()
> failed: Operation not permitted), and I could find a similar error in
> Fedora 8
> (which is from 2007-2008).  But from what I can grasp, this doesn't sound
> directly related to this issue we're seeing here.  And this was around PAM
> version 0.99.
>
> My Debian test VM uses pam-1.1.8-3.6, RHEL-7 pam-1.1.8-22 and Fedora 28
> pam-1.3.1-1.
>
> Since both my Debian VM and my RHEL-7 install uses essentially quite
> similar
> PAM releases .... Debian must be doing something different ... but what?  I
> even verified that all distros are compiled with libaudit, and they are.
>
> Anyone got a clue?
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Inc
>
>
>
>
>

-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd

--0000000000008b36a50574f1456d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr">On Thu, Aug 30, 2018 at 9:10 PM David Sommerseth &lt;<a href=3D"=
mailto:openvpn@...2080...">openvpn@...2080...</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">On 29/08/18 16:27, Christian E=
hrhardt wrote:<br>
&gt; Auth_pam will require audit writes or the connection will be rejected<=
br>
&gt; as the plugin fails to initialize like:<br>
&gt;=C2=A0 =C2=A0openvpn[1111]: sudo: unable to send audit message<br>
&gt;=C2=A0 =C2=A0openvpn[1111]: sudo: pam_open_session: System error<br>
&gt;=C2=A0 =C2=A0openvpn[1111]: sudo: policy plugin failed session initiali=
zation<br>
&gt; <br>
&gt; See links from <a href=3D"https://community.openvpn.net/openvpn/ticket=
/918" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/op=
envpn/ticket/918</a> for<br>
&gt; more.<br>
&gt; <br>
&gt; auth_pam is a common use case and capabilties for it should be allowed=
<br>
&gt; by the .service file.<br>
&gt; <br>
&gt; Fixes: #918<br>
&gt; <br>
&gt; Signed-off-by: Christian Ehrhardt &lt;<a href=3D"mailto:christian.ehrh=
ardt@...1808..." target=3D"_blank">christian.ehrhardt@...1808...</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 distro/systemd/openvpn-server@...220...<a href=3D"http://service=
.in" rel=3D"noreferrer" target=3D"_blank">service.in</a> | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/distro/systemd/openvpn-server@...220...<a href=3D"http://=
service.in" rel=3D"noreferrer" target=3D"_blank">service.in</a> b/distro/sy=
stemd/openvpn-server@...220...<a href=3D"http://service.in" rel=3D"noreferr=
er" target=3D"_blank">service.in</a><br>
&gt; index a8366a04..d1cc72cb 100644<br>
&gt; --- a/distro/systemd/openvpn-server@...220...<a href=3D"http://service=
.in" rel=3D"noreferrer" target=3D"_blank">service.in</a><br>
&gt; +++ b/distro/systemd/openvpn-server@...220...<a href=3D"http://service=
.in" rel=3D"noreferrer" target=3D"_blank">service.in</a><br>
&gt; @@ -11,7 +11,7 @@ Type=3Dnotify<br>
&gt;=C2=A0 PrivateTmp=3Dtrue<br>
&gt;=C2=A0 WorkingDirectory=3D/etc/openvpn/server<br>
&gt;=C2=A0 ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-=
%i.log --status-version 2 --suppress-timestamps --config %i.conf<br>
&gt; -CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVI=
CE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE<br>
&gt; +CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVI=
CE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AU=
DIT_WRITE<br>
<br>
CAP_AUDIT_WRITE sounds safe to add.=C2=A0 But I really need to get a better=
<br>
understanding *why* this is needed, when OpenVPN itself don&#39;t need this=
. What<br>
is it in the PAM code paths which triggers this requirement and why?<br>
<br>
There might be perfect valid reasons, but we can&#39;t just blindly jump in=
to<br>
&quot;Yes, we need it&quot; without a good understanding of why.<br>
<br>
I have run tests on RHEL-7, Fedora 28 and some older Debian 8-9-ish-sid<br>
release.=C2=A0 I only stumble upon this issue on Debian.=C2=A0 So what is i=
t Debian (and<br>
thus Ubuntu) does which causes this error?<br></blockquote><div><br></div><=
div>I can only assume, but doing so I could think of the default way sudo i=
s set up for being the reason.</div><div>Looking at the messages:</div><div=
><span style=3D"color:rgb(51,51,51);font-family:monospace;font-size:12px">=
=C2=A0 openvpn[1111]: sudo: unable to send audit message</span><br style=3D=
"color:rgb(51,51,51);font-family:monospace;font-size:12px"><span style=3D"c=
olor:rgb(51,51,51);font-family:monospace;font-size:12px">=C2=A0 openvpn[111=
1]: sudo: pam_open_session: System error</span><br style=3D"color:rgb(51,51=
,51);font-family:monospace;font-size:12px"><span style=3D"color:rgb(51,51,5=
1);font-family:monospace;font-size:12px">=C2=A0 openvpn[1111]: sudo: policy=
 plugin failed session initialization</span><br></div><div><br></div><div>I=
t uses sudo for the callout in the openvpn configuration,</div><div>=C2=A0 =
=C2=A0 learn-address &quot;/usr/bin/sudo -u root /etc/openvpn/scripts/ndp-p=
roxy-setup.sh&quot;<br></div><div>and the error seems to be related to actu=
ally sudo (in the openvpn context) being unable to log it&#39;s action.</di=
v><div>Now by default in Ubuntu/Debian there is /var/log/auth.log which wil=
l log any sudo activity.<br><br>In a little experiment I got to the same er=
rors by dropping that capabilty:</div><div><span style=3D"font-family:monos=
pace"><span style=3D"color:rgb(0,0,0)">running &quot;sudo id&quot; as-is</s=
pan></span></div><div><span style=3D"font-family:monospace"><span style=3D"=
color:rgb(0,0,0)">$ sudo capsh -- -c &quot;/usr/bin/sudo /usr/bin/id&quot; =
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
</span><br>uid=3D0(root) gid=3D0(root) groups=3D0(root)<br>
<br>There are log entries for this like:</span></div><div><span style=3D"fo=
nt-family:monospace"><span style=3D"color:rgb(0,0,0)">=C2=A0sudo[4784]: </s=
pan><span style=3D"font-weight:bold;color:rgb(0,0,0)">=C2=A0paelzer : TTY=
=3Dpts/1 ; PWD=3D/home/paelzer ; USER=3Droot ; COMMAND=3D/sbin/capsh -- -c =
/usr/bin/sudo /usr/bin/id</span><span style=3D"color:rgb(0,0,0)">
</span><br>=C2=A0sudo[4784]: pam_unix(sudo:session): session opened for use=
r root by paelzer(uid=3D0)
<br>=C2=A0sudo[4785]: <span style=3D"font-weight:bold;color:rgb(0,0,0)">=C2=
=A0=C2=A0=C2=A0=C2=A0root : TTY=3Dpts/1 ; PWD=3D/home/paelzer ; USER=3Droot=
 ; COMMAND=3D/usr/bin/id</span><span style=3D"color:rgb(0,0,0)">
</span><br>=C2=A0sudo[4785]: pam_unix(sudo:session): session opened for use=
r root by paelzer(uid=3D0)<br></span><br>But now in contrast doing the same=
 with audit_write dropped</div><div><span style=3D"font-family:monospace"><=
span style=3D"color:rgb(0,0,0)">$ sudo capsh --drop=3D&quot;cap_audit_write=
&quot; -- -c &quot;/usr/bin/sudo /usr/bin/id&quot;
</span><br>sudo: unable to send audit message
<br>sudo: pam_open_session: System error
<br>sudo: policy plugin failed session initialization<br></span><br>And on =
the log side we will recognize some known messages:</div><div><span style=
=3D"font-family:monospace"><span style=3D"color:rgb(0,0,0)">sudo[4797]: </s=
pan><span style=3D"font-weight:bold;color:rgb(0,0,0)">=C2=A0paelzer : TTY=
=3Dpts/1 ; PWD=3D/home/paelzer ; USER=3Droot ; COMMAND=3D/sbin/capsh --drop=
=3Dcap_audit_write -- -c /usr/bin/sudo /usr/bin/id</span><span style=3D"col=
or:rgb(0,0,0)">
</span><br>sudo[4797]: pam_unix(sudo:session): session opened for user root=
 by paelzer(uid=3D0)
<br>sudo[4798]: <span style=3D"font-weight:bold;color:rgb(0,0,0)">=C2=A0=C2=
=A0=C2=A0=C2=A0root : TTY=3Dpts/1 ; PWD=3D/home/paelzer ; USER=3Droot ; COM=
MAND=3D/usr/bin/id</span><span style=3D"color:rgb(0,0,0)">
</span><br>sudo[4798]: <span style=3D"font-weight:bold;color:rgb(255,84,84)=
">PAM audit_log_acct_message() failed: Operation not permitted</span><span =
style=3D"color:rgb(0,0,0)">
</span><br>sudo[4798]: pam_unix(sudo:session): session opened for user root=
 by paelzer(uid=3D0)
<br>sudo[4798]: <span style=3D"font-weight:bold;color:rgb(255,84,84)">=C2=
=A0=C2=A0=C2=A0=C2=A0root : pam_open_session: System error ; TTY=3Dpts/1 ; =
PWD=3D/home/paelzer ; USER=3Droot ; COMMAND=3D/usr/bin/id</span><span style=
=3D"color:rgb(0,0,0)">
</span><br>sudo[4797]: pam_unix(sudo:session): session closed for user root=
<br>
<br></span><br>On RH sudo isn&#39;t even installed by default, it is just n=
ot their common way to do these things.<br>I also haven&#39;t seen anything=
 like /var/log/auth.log on a bare fedora system while you&#39;ll always fin=
d it configured on Debian/Ubuntu.</div>Maybe the callout isn&#39;t even don=
e with sudo in the RH/Fedora case, I&#39;d assume that is (one of?) the rea=
sons for the different behavior.<div><br></div><div>I&#39;d think sudo is a=
 fairly common way to set things up, I&#39;d also assume that its logging i=
s recommended default and thereby Debian/Ubuntu but probably also some othe=
r distributions would benefit from adding CAP_AUDIT_WRITE</div><div>Does th=
is suffice as explanation why/how this is needed?</div><div><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
I did a little search the PAM error which occurs (audit_log_acct_message()<=
br>
failed: Operation not permitted), and I could find a similar error in Fedor=
a 8<br>
(which is from 2007-2008).=C2=A0 But from what I can grasp, this doesn&#39;=
t sound<br>
directly related to this issue we&#39;re seeing here.=C2=A0 And this was ar=
ound PAM<br>
version 0.99.<br>
<br>
My Debian test VM uses pam-1.1.8-3.6, RHEL-7 pam-1.1.8-22 and Fedora 28<br>
pam-1.3.1-1.<br>
<br>
Since both my Debian VM and my RHEL-7 install uses essentially quite simila=
r<br>
PAM releases .... Debian must be doing something different ... but what?=C2=
=A0 I<br>
even verified that all distros are compiled with libaudit, and they are.<br>
<br>
Anyone got a clue?<br>
<br>
-- <br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Inc<br>
<br>
<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><span sty=
le=3D"color:rgb(136,136,136);font-size:12.8px">Christian Ehrhardt</span><di=
v style=3D"color:rgb(136,136,136);font-size:12.8px">Software Engineer, Ubun=
tu Server</div><div style=3D"color:rgb(136,136,136);font-size:12.8px">Canon=
ical Ltd</div></div></div></div></div></div></div>

--0000000000008b36a50574f1456d--

