Message-ID: <01af01c1dbae$f8ef7680$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <20020401095130.GD26890@...6...> <000d01c1d9ad$88ef0560$3d5d33c6@...4...> <20020403152813.GA26424@...6...> <014901c1db43$65570ca0$1000000a@...4...> <20020404060239.GA875@...6...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: Debian package
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Thu Apr  4 00:01:24 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Alberto Gonzalez Iniesta <agi@...5...>
Cc: openvpn-devel@lists.sourceforge.net

> > Are you saying you want OpenVPN to read configuration options from a
config
> > file rather than the command line when -f is used?
> >
> > James
> >
>
> That's right. Configuration files have some advantages from my point of
> view:
> - Only one script to start/stop VPNs. A init.d-like script that will
>   call OpenVPN for each one of the conf. files.
> - Configuration files are easier to edit via scripts than shell scripts
>   with lots of '--option val \' lines
> - Configuration files are easier to comment and can even have all
>   options OpenVPN support (Soe commented out, some not)

Hmmm.  I am hesitant to put in a configuration file parser because
linux/unix already seem to have so many powerful external tools to do this,
e.g.

***********

cat >openvpn.config
dnl this is a sample OpenVPN config file

dnl local host
--local near.bar.net

dnl remote host
--remote far.bar.net

dnl tun/tap device
--dev tun1

<control-d>

openvpn `m4 openvpn.config`

********************

which gives you the power of m4 if you want it, but also gives you the
simplicity to be able to build a tunnel with just a short command line.

James



