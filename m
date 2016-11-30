Date: Wed, 30 Nov 2016 09:12:23 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20161130091223.47faade9@...1799...>
In-Reply-To: <641bcfd7-d750-2cb7-1b49-099026004b4b@...2080...>
References: <20161129152739.11582-1-list@...1798...>
	<641bcfd7-d750-2cb7-1b49-099026004b4b@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/2d73=E66xXe32OmM_k1X3zj";
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
Cc: Christian Hesse <mail@...1798...>, Elias Probst <mail@...2185...>, openvpn-devel@lists.sourceforge.net

--Sig_/2d73=E66xXe32OmM_k1X3zj
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

CCing Elias Probst as he is listed as contributor for last commit changing
systemd units (8b42c197626430118ed126c1b8256ba5ae1f699a, "systemd: Improve
the systemd unit files").
Anybody else involved with systemd units?

David Sommerseth <openvpn@...2080...> on Wed, 2016/11/30 02:45:
> On 29/11/16 16:27, Christian Hesse wrote:
> > From: Christian Hesse <mail@...1798...>
> >=20
> > Notify systemd service manager when our initialization sequence
> > completed. This helps ordering services as dependencies can rely on vpn
> > being available.=20=20
>=20
> Funny detail is that I have a somewhat similar patch in a local git
> tree, awaiting proper testing ... I postponed it as this is not
> something we will pull into v2.4.  We're going to release 2.4_rc1 this
> week, and that is too late for more intrusive changes (even though the
> changeset itself is small, the code changes makes OpenVPN behave
> somewhat different when managed by systemd).

We should rethink this... I am pretty sure I will not ship the code as-is
with Arch Linux. More below.

Tested by me, works pretty well. ;)

> Just a question, as it is good to see more people looking into these
> code paths ... I was considering to extend my approach to update STATUS=3D
> a bit more frequently.  On the client side, I thought it would be good
> if the status line had "Resolving %s", "Connecting to %s", "Successful
> connection to %s" or "Failed to connect to %s".  On the server side I
> was pondering on a "Successfully started, %i clients connected".  What
> do you think about that?  Does the sd_notify() API support more frequent
> updates?

Interesting idea... I will have a look.

> Also when using Type=3Dnotify ... does systemd expect the OpenVPN process
> to fork into the background or run in the foreground as now?

Ok, lets go into detail. We can use three different settings: Type=3Dsimple,
Type=3Dforking and Type=3Dnotify.

* We used Type=3Dforking for a long time. That is fine: systemd reports suc=
cess
  when the process forks off first time. That is when openvpn successfully
  completed initialization sequence.

* The current systemd unit use Type=3Dsimple (which is implicit). systemd
  reports success as soon as the process is executed, it does not wait for
  anything. So startup can look like that: systemd starts openvpn process ->
  unit is in state 'started' -> openvpn bails out with an error
  before the initialization sequence completed -> systemd unit is in state
  'failed' now. The problem is that it was in state 'started' intermittentl=
y:
  Manual systemctl (starting service from command line) reports success, ot=
her
  services depending on openvpn are started while dependency failed
  later, ... This is just broken.

* My patch introduces Type=3Dnotify. The (main) process must not fork, so m=
ost
  things work like simple, except that systemd does not report success on
  process execution, but waits for the sd_notify() call. We do not have
  intermittent state 'success' and everything works as expected.

I will not package the code as-is with our Arch Linux package. Either I
revert back to Type=3Dforking or apply the patch for Type=3Dnotify.

So I still vote to apply this as soon as possible.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/2d73=E66xXe32OmM_k1X3zj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlg+iecACgkQiUUh18yA
9HYNNwf8Cu+uaci5XZqa1JMTviTaIp2LVlXz3pvBT9cE8grwQWvB18XVcF3dNCT6
LgFOncEfnYli4d4IPf5IJS7PVRt5PGA4zRRqClCcgkk5LDb3kPbcJrU8zITdZf2B
TaMdHiAZ/WNahKrEQhox0dtEFWYyNX49t20smJ7gCmgdHVMixEAb6fXDkH2Dh+I3
k0Ve7yUEOAyx/PDULVUR7Ytq28/9Paym674jj+0fbqa9aZXRljtbaNq7D/l26KWD
Mh2L1Jkzvxc0TV370B2twj1djWvEL+k+r/HVdED8ZGorceCR/nh2FkNKFkpPIXy/
NbIXAqYPyC1h3dMgOTHll1X7yxbX/w==
=8w4h
-----END PGP SIGNATURE-----

--Sig_/2d73=E66xXe32OmM_k1X3zj--

