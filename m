From: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: [Openvpn-devel] Openvpn for RH62 - eek!
Message-ID: <20030502092833.GB984@...30...>
References: <3EB1726A.4000700@...7...> <200305020432.h424WN105246@...41...> <20030502092546.GA984@...30...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20030502092546.GA984@...30...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri May  2 02:29:18 2003
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2003 at 11:25:46AM +0200, Alberto Gonzalez Iniesta wrote:
> Anyway, I'm attaching Debian's init.d script in case you want to take a
> look at it.
> 


Doh! I ALWAYS forget to attach files! Sorry :)


-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@(agi.as|debian.org)        | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn.init.d"

#!/bin/sh -e
#
# Original version by Robert Leslie
# <rob@...80...>, edited by iwj and cs
# Modified for openvpn by Alberto Gonzalez Iniesta <agi@...5...>

test $DEBIAN_SCRIPT_DEBUG && set -v -x

DAEMON=/usr/sbin/openvpn
CONFIG_DIR=/etc/openvpn
test -x $DAEMON || exit 0
test -d $CONFIG_DIR || exit 0

start_vpn () {
    $DAEMON --daemon --writepid /var/run/openvpn.$NAME.pid \
            --config $CONFIG_DIR/$NAME.conf --cd $CONFIG_DIR || echo -n " FAILED->"
    echo -n " $NAME"
}
stop_vpn () {
   kill `cat $PIDFILE` || true
  rm $PIDFILE
}

case "$1" in
start)
  echo -n "Starting openvpn:"
  for CONFIG in `cd $CONFIG_DIR; ls *.conf 2> /dev/null`; do
    NAME=${CONFIG%%.conf}
    start_vpn
  done
  echo "."
  ;;
stop)
  echo -n "Stopping openvpn:"
  for PIDFILE in `ls /var/run/openvpn.*.pid 2> /dev/null`; do
    NAME=`echo $PIDFILE | cut -c18-`
    NAME=${NAME%%.pid}
    stop_vpn
    echo -n " $NAME"
  done
  echo "."
  ;;
# We only 'reload' for running VPNs. New ones will only start with 'start' or 'restart'.
reload|force-reload)
  echo -n "Reloading openvpn:"
  for PIDFILE in `ls /var/run/openvpn.*.pid 2> /dev/null`; do
    NAME=`echo $PIDFILE | cut -c18-`
    NAME=${NAME%%.pid}
# If openvpn if running under a different user than root we'll need to restart
    if egrep '^( |\t)*user' $CONFIG_DIR/$NAME.conf > /dev/null 2>&1 ; then
      stop_vpn
      sleep 1
      start_vpn
      echo -n "(restarted)"
    else
      kill -HUP `cat $PIDFILE` || true
#    start-stop-daemon --stop --signal HUP --quiet --oknodo \
#  	--exec $DAEMON --pidfile $PIDFILE
    echo -n " $NAME"
    fi
  done
  echo "."
  ;;

restart)
  $0 stop
  sleep 1
  $0 start
  ;;
*)
  echo "Usage: $0 {start|stop|reload|restart|force-reload}" >&2
  exit 1
  ;;
esac

exit 0

# vim:set ai et sts=2 sw=2 tw=0:

--oyUTqETQ0mS9luUI--

