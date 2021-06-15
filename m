Date: Tue, 15 Jun 2021 20:39:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210615183902.GF976@...1296...>
References: <c80d31ca-bee5-9194-c288-999754eb709a@...2610...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4T0s68+iVkTzwD0O"
Content-Disposition: inline
In-Reply-To: <c80d31ca-bee5-9194-c288-999754eb709a@...2610...>
Subject: Re: [Openvpn-devel] PID is deleted unconditionally on exit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias May <matthias.may@...2610...>
Cc: openvpn-devel@lists.sourceforge.net

--4T0s68+iVkTzwD0O
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this also got no answer so far, but deserves one.

On Wed, May 12, 2021 at 10:02:30PM +0200, Matthias May via Openvpn-devel wr=
ote:
> We recently updated OpenVPN to 2.5.2 and found that the PID
> is since [1] unconditionally deleted when OpenVPN exits.

Right.

> This breaks OpenVPN in our init.

Sorry for that.

> We relied on this file to get the PID to be able to check if the process =
actually started, or something went wrong during init, or to see if the pro=
cess died sometime later.
>=20
> One could argue that the absence of the PID file is indication enough tha=
t the process
> doesn't exist anymore, but that doesn't hold up when there are multiple i=
nstances running.

I do argue that way, and the "multiple instances running" argument does=20
not convince me - if you have multiple instances, they must have unique=20
PID files anyway, so you can see if "openvpn_instance4.pid" exists or not.

So, at startup, you can have 3 situations

 - openvpn started normally, PID exists, process exists
 - openvpn exited (planned or error exit), PID does not exist
 - openvpn crashed (core dump-style), PID exists, process does not exist

this is fairly easy to figure out whether a given instance started up fine.

> Once the process died we used the PID to look in the syslog for clues as =
to why the process died,
> and present the user with an error message based on that.
>=20
> Can you please revert this unconditional deletion of the file?
> Or do you see any alternative to get the PID of a process that
> exits immediately (case of misconfiguration)?

This depends on how you start these instances - if you start them without
--daemon, and call wait() in the caller, you get the PID of whoever exited
back.  If you use systemd, with named instances, it will tell you in
the journal (by instance named).

To find a certain instance in syslog (if you have no systemd), you can also=
=20
use the "--syslog instance1234" trick - so each instance would send its own
identifier, and you can look for "instance1234[" in syslog.

But generally speaking, a process that is ending normally (and we consider
"error exit" to be "ending normally", as opposed to "SIGSEGV core dump
boom") should not end with any resources still in use - so, tun interface
and routes are cleaned up, pid file is removed, auth_control_files are
removed, etc. - and we really believe in "cleaning up".  OpenVPN did not
always do the right thing (especially cleaning up interfaces on error
exit), but we're getting there.


Again, sorry that we caused work here.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--4T0s68+iVkTzwD0O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgyPPFAAoJEB2Cnv7KVigS4HoMAKffMPz6BYq5wCU4K82CrIth
AxY4Ori/AX6CJpesgNB/G26VxytxaHqmwI0UMAdUHPlrmGHF/0EJceLIuJlIHqWg
ToSJWilmjvsIaDd3LBkcneu59UCHeSfq/miPiibiEJk7zoMEVbzLADmMWOuP4wi1
ZrHNmZEmsu3yo7/xsAcCAusO16hBzdxIQUuU501CdMYjV6cjefyx5MF0qjBn/uBM
r+v1bGXc/XfP6XtxvDSVGHT59gDmgThdFPPoBkc35jIKLdakUOWB5DUm7RdQM9UU
ZPAh4s/XAGq8+XAZ2B9k61YTlJUvSxW9ONDILuH7Qa2P9CaC8HtJ8eekB/GWiV9R
9DNCPbfSxLc1cCIlP6cxzt091oFJC3EVoPYE3HYS89b7rT35/ozcnmowizw/TffI
GUVNpTROVMCRKAywszyi/aPza7Gcv6wo+uvOmfq/b8KDoHW59Hidq1JCEGdtDQxP
XLUhcUgC/VIrwszYmTr0DF+6T8MjQCrO17RxNDMNKg==
=vJve
-----END PGP SIGNATURE-----

--4T0s68+iVkTzwD0O--

