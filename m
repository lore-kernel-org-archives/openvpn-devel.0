MIME-Version: 1.0
content-class: urn:content-classes:message
Message-ID: <4EF2C16D1E0D904981F3C973D745261036D236@...323...>
From: =?koi8-r?B?7snLz8zByiDhxsHOwdPYxdc=?= <Afanasyev_N@...322...>
Subject: [Openvpn-devel] FW: Init script/Debian for OpenVPN
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
Date: Thu Dec  2 22:27:01 2004
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello, OpenVPN developers!

 I was advised to send you this shell, and I hope this can be helpful

Afanasyev Nikolay
Afanasyev_n@...322...
=20

> -----Original Message-----
> From: James Yonan [mailto:jim@...41...]=20
> Sent: Thursday, December 02, 2004 7:21 PM
> To: =EE=C9=CB=CF=CC=C1=CA =E1=C6=C1=CE=C1=D3=D8=C5=D7
> Subject: Re: Init script/Debian for OpenVPN
>=20
> Thanks for your contribution.
>=20
> It would be best if you send it to openvpn-devel@lists.sourceforge.net
>=20
> Thanks,
> James
>=20
> On Thu, 2 Dec 2004, [koi8-r] =EE=C9=CB=CF=CC=C1=CA =E1=C6=C1=CE=C1=D3=D8=
=C5=D7 wrote:
>=20
> > Hello, James=20
> > 	Can I contribute a little to your project? I have init=20
> script for Debian GNU Linux that I wrote for OpenVPN:=20
> >=20
> > PS: sorry bout permissions 8-)
> >=20
> > >>>>>>>>>>>> Start openvpn.sh >>>>>>>>>>>>>>>>>>

#!/bin/sh

DAEMON=3D"/usr/local/sbin/openvpn"
piddir=3D"/var/run/openvpn"
work=3D/etc/openvpn
export LANG=3DC
export PATH

test -f $DAEMON || exit 0



case "$1" in
  start)
    cd $work
    # Start every .conf in $work and run .sh if exists
    for c in `/bin/ls *.conf 2>/dev/null`; do
      bn=3D${c%%.conf}
      echo -n "Starting OpenVPN whith config $c"
      args=3D"--daemon --writepid $piddir/$bn.pid --config $c --cd $work"
      start-stop-daemon --start --pidfile $piddir/$bn.pid --exec $DAEMON --=
 $args
      if [ $? =3D=3D 0 ]; then=20
       echo " [OK]"=20
      else=20
       echo " [failed]"=20
      fi=20
    done
    ;;

  stop)
    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
      if [ -s $pidf ]; then
        echo -n  "Shuttin' down OpenVPN whith PID file $pidf"
        start-stop-daemon --stop --pidfile $pidf --oknodo --exec $DAEMON=20=
=20
        if [ $? =3D=3D 0 ]; then=20
	  echo " [OK]"=20
	else=20
	  echo " [failed]"=20
	fi
	rm -f $pidf
      fi
    done
    ;;

  reload)
    for pidf in `/bin/ls $piddir/*.pid 2>/dev/null`; do
      if [ -s $pidf ]; then
        echo -n "Reload OpenVPN whith PID file $pidf"
        start-stop-daemon --stop --pidfile $pidf --signal USR1 --exec $DAEM=
ON=20=20
	if [ $? =3D=3D 0 ]; then=20
	  echo " [OK]"=20
	else=20
	  echo " [failed]"=20
	fi
      fi
    done
    ;;

  restart)
    $0 stop
    $0 start
    exit $?
    ;;

  *)
    echo "Usage: $0 {start|stop|reload|restart}"
    exit 1
    ;;
esac

if [ $? =3D=3D 0 ]; then=20
 exit 0
else=20
 exit 1=20
fi


> > <<<<<<<<<<<< End openvpn.sh  <<<<<<<<<<<<<<<<<<
> >=20
> >=20
> >=20
> >=20
> > Afanasyev Nikolay
> > Afanasyev_n@...322...
> >=20
> >=20
>=20
>=20
>=20

