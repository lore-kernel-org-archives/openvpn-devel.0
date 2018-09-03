Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
 <20180829142715.417-2-christian.ehrhardt@...1808...>
 <693d4552-ef0d-485e-4f04-c115402ba037@...2080...>
 <CAATJJ0K1v4eLLSwrpdnSgLV5LZkEAmVW3LfbRT3ssLW8Xb2bCw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <fa1943ae-bdc8-80cb-862b-01bc32ff4ada@...2080...>
Date: Mon, 3 Sep 2018 10:36:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAATJJ0K1v4eLLSwrpdnSgLV5LZkEAmVW3LfbRT3ssLW8Xb2bCw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fYmIkiD99rkq7E6yswv7Wsm45VnWzcxj7"
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
To: Christian Ehrhardt <christian.ehrhardt@...1808...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fYmIkiD99rkq7E6yswv7Wsm45VnWzcxj7
Content-Type: multipart/mixed; boundary="yMnu3YaMOJtHD5noqMMEzT4bR7HqEgE5y";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Ehrhardt <christian.ehrhardt@...1808...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <fa1943ae-bdc8-80cb-862b-01bc32ff4ada@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] systemd: extend CapabilityBoundingSet
 for auth_pam
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
 <20180829142715.417-2-christian.ehrhardt@...1808...>
 <693d4552-ef0d-485e-4f04-c115402ba037@...2080...>
 <CAATJJ0K1v4eLLSwrpdnSgLV5LZkEAmVW3LfbRT3ssLW8Xb2bCw@...278...>
In-Reply-To: <CAATJJ0K1v4eLLSwrpdnSgLV5LZkEAmVW3LfbRT3ssLW8Xb2bCw@...278...>

--yMnu3YaMOJtHD5noqMMEzT4bR7HqEgE5y
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/09/18 08:00, Christian Ehrhardt wrote:
[...snip...]
>     > -CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SE=
RVICE
>     CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>     > +CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SE=
RVICE
>     CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
>     CAP_AUDIT_WRITE
>=20
>     CAP_AUDIT_WRITE sounds safe to add.=C2=A0 But I really need to get a =
better
>     understanding *why* this is needed, when OpenVPN itself don't need th=
is. What
>     is it in the PAM code paths which triggers this requirement and why?
>=20
>     There might be perfect valid reasons, but we can't just blindly jump =
into
>     "Yes, we need it" without a good understanding of why.
>=20
>     I have run tests on RHEL-7, Fedora 28 and some older Debian 8-9-ish-s=
id
>     release.=C2=A0 I only stumble upon this issue on Debian.=C2=A0 So wha=
t is it Debian (and
>     thus Ubuntu) does which causes this error?
>=20
>=20
> I can only assume, but doing so I could think of the default way sudo is =
set
> up for being the reason.
> Looking at the messages:
> =C2=A0 openvpn[1111]: sudo: unable to send audit message
> =C2=A0 openvpn[1111]: sudo: pam_open_session: System error
> =C2=A0 openvpn[1111]: sudo: policy plugin failed session initialization
>=20
> It uses sudo for the callout in the openvpn configuration,
> =C2=A0 =C2=A0 learn-address "/usr/bin/sudo -u root /etc/openvpn/scripts/n=
dp-proxy-setup.sh"
> and the error seems to be related to actually sudo (in the openvpn contex=
t)
> being unable to log it's action.
> Now by default in Ubuntu/Debian there is /var/log/auth.log which will log=
 any
> sudo activity.
>=20
> In a little experiment I got to the same errors by dropping that capabilt=
y:
> running "sudo id" as-is
> $ sudo capsh -- -c "/usr/bin/sudo /usr/bin/id" =C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> uid=3D0(root) gid=3D0(root) groups=3D0(root)
>=20
> There are log entries for this like:
> =C2=A0sudo[4784]: =C2=A0paelzer : TTY=3Dpts/1 ; PWD=3D/home/paelzer ; USE=
R=3Droot ;
> COMMAND=3D/sbin/capsh -- -c /usr/bin/sudo /usr/bin/id
> =C2=A0sudo[4784]: pam_unix(sudo:session): session opened for user root by
> paelzer(uid=3D0)
> =C2=A0sudo[4785]: =C2=A0=C2=A0=C2=A0=C2=A0root : TTY=3Dpts/1 ; PWD=3D/hom=
e/paelzer ; USER=3Droot ;
> COMMAND=3D/usr/bin/id
> =C2=A0sudo[4785]: pam_unix(sudo:session): session opened for user root by
> paelzer(uid=3D0)
>=20
> But now in contrast doing the same with audit_write dropped
> $ sudo capsh --drop=3D"cap_audit_write" -- -c "/usr/bin/sudo /usr/bin/id"
> sudo: unable to send audit message
> sudo: pam_open_session: System error
> sudo: policy plugin failed session initialization
>=20
> And on the log side we will recognize some known messages:
> sudo[4797]: =C2=A0paelzer : TTY=3Dpts/1 ; PWD=3D/home/paelzer ; USER=3Dro=
ot ;
> COMMAND=3D/sbin/capsh --drop=3Dcap_audit_write -- -c /usr/bin/sudo /usr/b=
in/id
> sudo[4797]: pam_unix(sudo:session): session opened for user root by
> paelzer(uid=3D0)
> sudo[4798]: =C2=A0=C2=A0=C2=A0=C2=A0root : TTY=3Dpts/1 ; PWD=3D/home/pael=
zer ; USER=3Droot ;
> COMMAND=3D/usr/bin/id
> sudo[4798]: PAM audit_log_acct_message() failed: Operation not permitted
> sudo[4798]: pam_unix(sudo:session): session opened for user root by
> paelzer(uid=3D0)
> sudo[4798]: =C2=A0=C2=A0=C2=A0=C2=A0root : pam_open_session: System error=
 ; TTY=3Dpts/1 ;
> PWD=3D/home/paelzer ; USER=3Droot ; COMMAND=3D/usr/bin/id
> sudo[4797]: pam_unix(sudo:session): session closed for user root
>=20
>=20
> On RH sudo isn't even installed by default, it is just not their common w=
ay to
> do these things.

This used to be the case, but sudo is more widely used these days.  As Free=
IPA
is being used more and more widely, which has a neat centralized sudo manag=
ement,
the advantages of sudo becomes more apparent - also on Fedora/RHEL.  I even=
 see
more and more blog posts where sudo is used, and even anaconda has for some=
 time
allowed system installation without setting the root password and can creat=
e a
user account with sudo access.

> I also haven't seen anything like /var/log/auth.log on a bare fedora syst=
em
> while you'll always find it configured on Debian/Ubuntu.

It's in /var/log/secure and /var/log/audit/audit.log.  The former is what
is auth.log on Deb/Ubu, the audit.log is more commonly related to more fine
grained audit logging from other aspects of the authentication/security=20
mechanisms.  And the log format is also very different.

> Maybe the callout isn't even done with sudo in the RH/Fedora case, I'd as=
sume
> that is (one of?) the reasons for the different behavior.

Both your sudo tests works out-of-the box on my RHEL-7 system, even the one=
=20
with "--drop=3Dcap_audit_write" - but with a warning printed to the termina=
l.=20=20
But it executes without failure.

$ sudo capsh --drop=3D"cap_audit_write" -- -c "/usr/bin/sudo /usr/bin/id"=20
sudo: unable to send audit message
uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dunconfined_u:unconfi=
ned_r:unconfined_t:s0-s0:c0.c1023


Here's some details from both /var/log/secure ...

sudo:  testuser : TTY=3Dpts/12 ; PWD=3D/home/testuser ; USER=3Droot ; COMMA=
ND=3D/sbin/capsh --drop=3Dcap_audit_write -- -c /usr/bin/sudo /usr/bin/id
sudo:  testuser : TTY=3Dpts/12 ; PWD=3D/home/testuser ; USER=3Droot ; COMMA=
ND=3D/usr/bin/id

... and /var/log/audit/audit.log:

type=3DCRED_REFR msg=3Daudit(1535960094.675:11847): pid=3D24379 uid=3D0 aui=
d=3D2001 ses=3D634 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c=
1023 msg=3D'op=3DPAM:setcred grantors=3Dpam_env,pam_fprintd acct=3D"root" e=
xe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/12 res=3Dsuc=
cess'

type=3DUSER_START msg=3Daudit(1535960094.676:11848): pid=3D24379 uid=3D0 au=
id=3D2001 ses=3D634 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.=
c1023 msg=3D'op=3DPAM:session_open grantors=3Dpam_keyinit,pam_limits acct=
=3D"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/1=
2 res=3Dsuccess'

type=3DUSER_END msg=3Daudit(1535960094.695:11849): pid=3D24379 uid=3D0 auid=
=3D2001 ses=3D634 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1=
023 msg=3D'op=3DPAM:session_close grantors=3Dpam_keyinit,pam_limits acct=3D=
"root" exe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/12 r=
es=3Dsuccess'

type=3DCRED_DISP msg=3Daudit(1535960094.695:11850): pid=3D24379 uid=3D0 aui=
d=3D2001 ses=3D634 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c=
1023 msg=3D'op=3DPAM:setcred grantors=3Dpam_env,pam_fprintd acct=3D"root" e=
xe=3D"/usr/bin/sudo" hostname=3D? addr=3D? terminal=3D/dev/pts/12 res=3Dsuc=
cess'



To compare that against running 'sudo capsh' without --drop:

$ sudo capsh -- -c "/usr/bin/sudo /usr/bin/id"=20
uid=3D0(root) gid=3D0(root) groups=3D0(root) context=3Dunconfined_u:unconfi=
ned_r:unconfined_t:s0-s0:c0.c1023
--yMnu3YaMOJtHD5noqMMEzT4bR7HqEgE5y--

--fYmIkiD99rkq7E6yswv7Wsm45VnWzcxj7--
