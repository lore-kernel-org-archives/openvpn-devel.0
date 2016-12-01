Date: Thu, 1 Dec 2016 13:48:02 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161201134802.0c195664@...1799...>
In-Reply-To: <20161130091223.47faade9@...1799...>
References: <20161129152739.11582-1-list@...1798...>
	<641bcfd7-d750-2cb7-1b49-099026004b4b@...2080...>
	<20161130091223.47faade9@...1799...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/6U9F6hx6r425rEGNkwtc5tT";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Use systemd service manager
 notification
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>, Elias Probst <mail@...2185...>

--Sig_/6U9F6hx6r425rEGNkwtc5tT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian Hesse <list@...1798...> on Wed, 2016/11/30 09:12:
> Ok, lets go into detail. We can use three different settings: Type=3Dsimp=
le,
> Type=3Dforking and Type=3Dnotify.
>=20
> * We used Type=3Dforking for a long time. That is fine: systemd reports
> success when the process forks off first time. That is when openvpn
> successfully completed initialization sequence.
>=20
> * The current systemd unit use Type=3Dsimple (which is implicit). systemd
>   reports success as soon as the process is executed, it does not wait for
>   anything. So startup can look like that: systemd starts openvpn process=
 ->
>   unit is in state 'started' -> openvpn bails out with an error
>   before the initialization sequence completed -> systemd unit is in state
>   'failed' now. The problem is that it was in state 'started'
> intermittently: Manual systemctl (starting service from command line)
> reports success, other services depending on openvpn are started while
> dependency failed later, ... This is just broken.
>=20
> * My patch introduces Type=3Dnotify. The (main) process must not fork, so=
 most
>   things work like simple, except that systemd does not report success on
>   process execution, but waits for the sd_notify() call. We do not have
>   intermittent state 'success' and everything works as expected.
>=20
> I will not package the code as-is with our Arch Linux package. Either I
> revert back to Type=3Dforking or apply the patch for Type=3Dnotify.
>=20
> So I still vote to apply this as soon as possible.

I prepared an example:

root@...1799... ~ # systemctl start openvpn-client@...2202...
root@...1799... ~ # systemctl status openvpn-client@...2202...
=E2=97=8F openvpn-client@...2203... - OpenVPN tunnel for lugor
   Loaded: loaded (/usr/lib/systemd/system/openvpn-client@...1685...; enabl=
ed; vendor preset: disabled)
   Active: active (running) since Thu 2016-12-01 13:35:12 CET; 8s ago
     Docs: man:openvpn(8)
           https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
           https://community.openvpn.net/openvpn/wiki/HOWTO
  Process: 11700 ExecStartPre=3D/bin/sh -c grep -q -E ^daemon %i.conf || ex=
it 0 && /usr/bin/echo "OpenVPN configuration cannot contain --daemon when b=
eing managed by systemd" ; exit 1 (code=3Dexited, status=3D0/SUCCESS)
 Main PID: 11703 (openvpn)
    Tasks: 1 (limit: 4915)
   CGroup: /system.slice/system-openvpn\x2dclient.slice/openvpn-client@...1665...=
203...
           =E2=94=94=E2=94=8011703 /usr/sbin/openvpn --suppress-timestamps =
--nobind --config lugor.conf


Dec 01 13:35:13 leda openvpn[11703]: GID set to nobody
Dec 01 13:35:13 leda openvpn[11703]: UID set to nobody
Dec 01 13:35:13 leda openvpn[11703]: Initialization Sequence Completed
root@...1799... ~ # # looks good...
root@...1799... ~ # echo "bad-option" >> /etc/openvpn/client/lugor.conf
root@...1799... ~ # systemctl restart openvpn-client@...2202...
root@...1799... ~ # # succeeds, no?
root@...1799... ~ # systemctl status openvpn-client@...2202...
=E2=97=8F openvpn-client@...2203... - OpenVPN tunnel for lugor
   Loaded: loaded (/usr/lib/systemd/system/openvpn-client@...1685...; enabl=
ed; vendor preset: disabled)
   Active: failed (Result: exit-code) since Thu 2016-12-01 13:36:14 CET; 15=
s ago
     Docs: man:openvpn(8)
           https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
           https://community.openvpn.net/openvpn/wiki/HOWTO
  Process: 11911 ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobi=
nd --config %i.conf (code=3Dexited, status=3D1/FAILURE)
  Process: 11908 ExecStartPre=3D/bin/sh -c grep -q -E ^daemon %i.conf || ex=
it 0 && /usr/bin/echo "OpenVPN configuration cannot contain --daemon when b=
eing managed by systemd" ; exit 1 (code=3Dexited, status=3D0/SUCCESS)
 Main PID: 11911 (code=3Dexited, status=3D1/FAILURE)

Dec 01 13:36:14 leda systemd[1]: Starting OpenVPN tunnel for lugor...
Dec 01 13:36:14 leda systemd[1]: Started OpenVPN tunnel for lugor.
Dec 01 13:36:14 leda openvpn[11911]: Options error: Unrecognized option or =
missing or extra parameter(s) in lugor.conf:32: bad-option (2.4_beta2)
Dec 01 13:36:14 leda openvpn[11911]: Use --help for more information.
Dec 01 13:36:14 leda systemd[1]: openvpn-client@...2203...: Main process ex=
ited, code=3Dexited, status=3D1/FAILURE
Dec 01 13:36:14 leda systemd[1]: openvpn-client@...2203...: Unit entered fa=
iled state.
Dec 01 13:36:14 leda systemd[1]: openvpn-client@...2203...: Failed with res=
ult 'exit-code'.
3 root@...1799... ~ # # Oops...
3 root@...1799... ~ # # now install openvpn with my systemd patches
3 root@...1799... ~ # systemctl restart openvpn-client@...2202...
Job for openvpn-client@...2203... failed because the control process exited=
 with error code.
See "systemctl status openvpn-client@...2203..." and "journalctl -xe" for d=
etails.
1 root@...1799... ~ # systemctl status openvpn-client@...2202...
=E2=97=8F openvpn-client@...2203... - OpenVPN tunnel for lugor
   Loaded: loaded (/usr/lib/systemd/system/openvpn-client@...1685...; enabl=
ed; vendor preset: disabled)
   Active: failed (Result: exit-code) since Thu 2016-12-01 13:37:10 CET; 50=
s ago
     Docs: man:openvpn(8)
           https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
           https://community.openvpn.net/openvpn/wiki/HOWTO
  Process: 12227 ExecStart=3D/usr/sbin/openvpn --suppress-timestamps --nobi=
nd --config %i.conf (code=3Dexited, status=3D1/FAILURE)
 Main PID: 12227 (code=3Dexited, status=3D1/FAILURE)

Dec 01 13:37:10 leda systemd[1]: Starting OpenVPN tunnel for lugor...
Dec 01 13:37:10 leda openvpn[12227]: Options error: Unrecognized option or =
missing or extra parameter(s) in lugor.conf:32: bad-option (2.4_beta2)
Dec 01 13:37:10 leda openvpn[12227]: Use --help for more information.
Dec 01 13:37:10 leda systemd[1]: openvpn-client@...2203...: Main process ex=
ited, code=3Dexited, status=3D1/FAILURE
Dec 01 13:37:10 leda systemd[1]: Failed to start OpenVPN tunnel for lugor.
Dec 01 13:37:10 leda systemd[1]: openvpn-client@...2203...: Unit entered fa=
iled state.
Dec 01 13:37:10 leda systemd[1]: openvpn-client@...2203...: Failed with res=
ult 'exit-code'.

With current code the unit reports success and fails later in background,
with my code it fails immediately and reports the error to the user. Later
behavior lets things work for enabled unit with dependencies.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/6U9F6hx6r425rEGNkwtc5tT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlhAHAIACgkQiUUh18yA
9HYviggAtPOK7mGkJOj2VdvRa5t9gP4NjgHPuscPN6up5s/e548f7PJdQzp2l1QT
tlIyLmscQDZkNBH52+1mKNSQ2K35ziyG/VcIJBe8B9UUABr3BVMa2iI3zr5O4dsN
9178okujkf21jUOZZ4+JO9CZc/UZcRFpHU7sz7RahO60iNJdbUW/oGreB9d4edD5
sO5ulB5utvKQLlqAHoIF8QGgaS4hXimaSczk6X0sw6k14yiTqHyQ6jL92A/kUUpF
xJoQ5pNnlrwh0+IVX6SKjCye5ETntu+AAT9hDtlSGotdDUngH0DTUVou+di1OGVk
yz7ayPDT13oBCRfbN9xBC5pFN7xZnQ==
=235y
-----END PGP SIGNATURE-----

--Sig_/6U9F6hx6r425rEGNkwtc5tT--

