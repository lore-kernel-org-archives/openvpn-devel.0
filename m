From: Paul Iadonisi <pri.openvpn@...317...>
Message-Id: <1100737211.8135.32.camel@...318...>
Mime-Version: 1.0
Subject: [Openvpn-devel] First post and an alternative idea for OpenVPN startup on Linux
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
Date: Wed Nov 17 16:21:07 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hello,
  I found out about OpenVPN some time ago, but only started playing with
it recently (in the past month or so).  I've set up PPTP VPNs between
Windows and Linux (not so comfortable with the security of it, though)
as well as IPsec using Freeswan aka Openswan (unnecessarily complex,
IMO).  I haven't done anything with the built-in IPsec under Linux 2.6
yet, as my initial (short) experience with it was less than favorable.
  So now that I've played around with OpenVPN for a while, I'm
thoroughly impressed!  Especially at it's simplicity and the included
scripts in easy-rsa (as openssl usually requires black magic to figure
out what you need out of it), and most importantly the ease with which
you can build VPNs right through firewalls (even those you don't control
on the client end).
  While working with various setups, I felt there might be a better way
to start up the VPN(s) with a little more granularity.  In fact, at
least in the case of Fedora Core (2 and 3 in my case), I thought it
might be a good idea to integrate it into the /etc/sysconfig/network-
scripts infrastructure so that I could just type 'ifup vpntowork' or
'ifup vpntoworksite2' to bring up individual vpn interfaces.
  A few days later, I now have a pretty good set of scripts that do just
that.  And to top it off, I have a workaround now for a problem that has
been discussed on this list regarding chroot and/or uid/gid settings:
running a --down script that needs root access.  In my setup, I have two
wrapper scripts, upwrap-openvpn and downwrap-openvpn, which invoke the
user's specified --up and --down scripts respectively.  However,
downwrap is not passed to openvpn; it is instead run by the ifdown-
openvpn script.  Details are in comments in the scripts themselves.
  One thing I haven't commented on in the scripts is that both TYPE and
DEVICETYPE need to be set (TYPE=OpenVPN and DEVICETYPE=openvpn) in your
ifcfg-<interface-or-nickname> script.  Normally, you don't set
DEVICETYPE in ifcfg-<interface> scripts -- it is used internally by
'ifup'.  The proper way to do this is to actually patch a case statement
in ifup, but I figured I'd take care of that after I determined how much
interest there was in this.
  A few more notes:

    o This is very Fedora Core / Red Hat specific.
    o I've changed the location of various directories and files to be
      more in line with the 'ifup' way of doing things.  Keys and scripts
      go in /etc/sysconfig/openvpn, pid files are of the form
      /var/run/openvpn-<interface>.pid, status file is always
      /var/log/openvpn/<interface>.log, etc.
    o Some of ifup-openvpn utilizes some rather obscure features of bash.  I
      doubt it will work with ksh or the posix shell.  I don't think that
      matters much because this is really intended to fit into the GNU/Linux
      (or at least, Fedora Core and Red Hat) way of doing things.
    o I've not handled all OpenVPN options optimally, but plan to put a little
      more work into that.  The trickiest part is options that take zero or
      more arguments.
    o Last updated for OpenVPN 2.0_beta17 (i.e.: includes the --plugin option).
 
  So that's the overview.  I was going to attach the scripts to this
message, but I want to put copyright notices in the scripts first.  Note
that they will be GPLed, and I give James Yohan full permission to
include the scripts in any potential commercial version (that was
discussed not long ago on this list), though I'll retain the copyrights
on this feeble amount of code (in comparison to James'
contribution ;-)).
  What I'll post shortly will be six scripts (ifup-openvpn, ifdown-
openvpn, upwrap-openvpn, downwrap-openvpn, and sample ifcfg-* scripts
for a client and a bridged server) as well as the modified spec file I
use to build my rpms.  All comments and criticisms welcomed.
  Oh, and thanks for an awesome piece of software!
-- 
-Paul Iadonisi
 Senior System Administrator
 Red Hat Certified Engineer / Local Linux Lobbyist
 Ever see a penguin fly?  --  Try Linux.
 GPL all the way: Sell services, don't lease secrets


