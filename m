From: Alberto Gonzalez Iniesta <agi@...64...>
Subject: Re: [Openvpn-devel] FW: Init script/Debian for OpenVPN
Message-ID: <20041203103128.GF1677@...30...>
References: <4EF2C16D1E0D904981F3C973D745261036D236@...323...>
Mime-Version: 1.0
In-Reply-To: <4EF2C16D1E0D904981F3C973D745261036D236@...323...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Dec  3 02:31:01 2004
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

The Debian package has already a init.d script. Did you take a look at
it?
Yours doesn't improve it in any visible way, so, what's the point?
Please take a look at the debian package (use backports.org if you're
using Debian woody) and feel free to send me improvements.

Regards,

Alberto




On Fri, Dec 03, 2004 at 09:24:57AM +0300, ??????? ????????? wrote:
> Hello, OpenVPN developers!
>=20
>  I was advised to send you this shell, and I hope this can be helpful
>=20
> Afanasyev Nikolay
> Afanasyev_n@...322...
>=20=20
>=20
> > -----Original Message-----
> > From: James Yonan [mailto:jim@...41...]=20
> > Sent: Thursday, December 02, 2004 7:21 PM
> > To: ??????? ?????????
> > Subject: Re: Init script/Debian for OpenVPN
> >=20
> > Thanks for your contribution.
> >=20
> > It would be best if you send it to openvpn-devel@lists.sourceforge.net
> >=20
> > Thanks,
> > James
> >=20
> > On Thu, 2 Dec 2004, [koi8-r] ??????? ????????? wrote:
> >=20
> > > Hello, James=20
> > > 	Can I contribute a little to your project? I have init=20
> > script for Debian GNU Linux that I wrote for OpenVPN:=20
> > >=20
> > > PS: sorry bout permissions 8-)
> > >=20
> > > >>>>>>>>>>>> Start openvpn.sh >>>>>>>>>>>>>>>>>>
>=20
> #!/bin/sh
>=20
> DAEMON=3D"/usr/local/sbin/openvpn"
> piddir=3D"/var/run/openvpn"
> work=3D/etc/openvpn
> export LANG=3DC
> export PATH
>=20
> test -f $DAEMON || exit 0
>=20
>=20
>=20
> case "$1" in
>   start)
>     cd $work
>     # Start every .conf in $work and run .sh if exists
>     for c in `/bin/ls *.conf 2>/dev/null`; do
>       bn=3D${c%%.conf}
>       echo -n "Starting OpenVPN whith config $c"
>       args=3D"--daemon --writepid $piddir/$bn.pid --config $c --cd $work"
>       start-stop-daemon --start --pidfile $piddir/$bn.pid --exec $DAEMON =
-- $args
>       if [ $? =3D=3D 0 ]; then=20
>        echo " [OK]"=20
>       else=20
>        echo " [failed]"=20
>       fi=20
>     done
>     ;;
>=20
>   stop)
>     for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
>       if [ -s $pidf ]; then
>         echo -n  "Shuttin' down OpenVPN whith PID file $pidf"
>         start-stop-daemon --stop --pidfile $pidf --oknodo --exec $DAEMON=
=20=20
>         if [ $? =3D=3D 0 ]; then=20
> 	  echo " [OK]"=20
> 	else=20
> 	  echo " [failed]"=20
> 	fi
> 	rm -f $pidf
>       fi
>     done
>     ;;
>=20
>   reload)
>     for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
>       if [ -s $pidf ]; then
>         echo -n "Reload OpenVPN whith PID file $pidf"
>         start-stop-daemon --stop --pidfile $pidf --signal USR1 --exec $DA=
EMON=20=20
> 	if [ $? =3D=3D 0 ]; then=20
> 	  echo " [OK]"=20
> 	else=20
> 	  echo " [failed]"=20
> 	fi
>       fi
>     done
>     ;;
>=20
>   restart)
>     $0 stop
>     $0 start
>     exit $?
>     ;;
>=20
>   *)
>     echo "Usage: $0 {start|stop|reload|restart}"
>     exit 1
>     ;;
> esac
>=20
> if [ $? =3D=3D 0 ]; then=20
>  exit 0
> else=20
>  exit 1=20
> fi
>=20
>=20
> > > <<<<<<<<<<<< End openvpn.sh  <<<<<<<<<<<<<<<<<<
> > >=20
> > >=20
> > >=20
> > >=20
> > > Afanasyev Nikolay
> > > Afanasyev_n@...322...
> > >=20
> > >=20
> >=20
> >=20
> >=20
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.org

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

