Message-Id: <200305080830.h488UZ111579@...41...>
Subject: Re: [Openvpn-devel] Fwd: Bug#182020: openvpn needs dynamic choice on HAVE_LINUX_IF_TUN_H
From: "James Yonan" <jim@...41...>
In-Reply-To: <20030507190341.GA922@...30...>
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
Date: Thu May  8 01:31:10 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...5...>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Alberto Gonzalez Iniesta <agi@...5...> said:

> Hi all, 
> 
> Sorry for the delay forwarding this email, but I don't find time to 
> breath lately (and thus Oxygen does not make it to my brain :)
> 
> Hope it's an easy one.
> 
> 
> ----- Forwarded message from Robert de Bath <robert$@mayday.cix.co.uk> -----
> 
> From: Robert de Bath <robert$@mayday.cix.co.uk>
> Reply-To: Robert de Bath <robert$@mayday.cix.co.uk>, 182020@...40...
> To: submit@...40...
> Subject: Bug#182020: openvpn needs dynamic choice on HAVE_LINUX_IF_TUN_H
> Date: Sat, 22 Feb 2003 11:03:19 +0000 (GMT)
> X-URL: <http://www.cix.co.uk/~mayday>
> X-Dev86-Version: 0.16.10
> Reply-By: 01 jan 2001 00:00:00
> X-Message-Flag: Linux: The choice of a GNU generation.
> Return-Receipt-To: receipts@...82...
> X-Spam-Level: 
> X-SpamProbe: GOOD 0.0000000 f10cd08f2b096e6bf59bcfea5e2f80a4
> X-Spam-Status: No, hits=-4.5 required=5.0
tests=SENT_BY_BTS,FORGED_RCVD_FOUND version=2.20
> X-Spam-Level: 
> 
> Package: openvpn
> Version: 1.3.0-2
> 
> When compiled with 2.4.* kernel headers (libc6-dev 2.2.5-14.3 headers)
> it detects this header file and defines HAVE_LINUX_IF_TUN_H. This allow
> openvpn to work correctly with 2.4.18 kernels BUT it stops it working
> with 2.2.X kernels at all (with or without the tun kernel module from
> sourceforge)

OpenVPN's config script assumes that if 2.4 headers are present (i.e.
if_tun.h), then it should build for the 2.4 tun/tap driver.

I don't completely understand why one would want to put 2.4 kernel headers on
a 2.2 machine, since that would tend to confuse things, and break apps that
depend on the userspace <-> kernel interface as defined by the kernel header
files.

But in any case, you can still build if you do the following.

(1) run ./configure
(2) edit config.h
(3) comment out this line: #define HAVE_LINUX_IF_TUN_H 1
(4) run make

This could be automatic if ./configure did a kernel version test, and only
defined HAVE_LINUX_IF_TUN_H if (a) if_tun.h exists and (b) kernel version is
2.4.x.

James

> Options are:
> 
> 1) Seperate compiles for 2.2.X and 2.4+ kernels, both binaries in the .deb
> 
> 2) Patch tun.c to first check if /dev/net/tun exists and works before
>    falling back to the open_tun_generic(..) function if it doesn't.
> 
> I'm currently successfully using openvpn between a 2.2.19 and 2.4.18
> kernel using the tun0 tunnel and the driver from sourceforge on the 2.2.19
> machine. (No reboot required to install the tun0 driver) The 2.4.18
> openvpn is standard, the 2.2.19 has HAVE_LINUX_IF_TUN_H undefined.
> 
> Both machines are woody with libc6/testing.
> 
> -- 
> Rob.                          (Robert de Bath <robert$ @ debath.co.uk>)
>                                        <http://www.cix.co.uk/~mayday>
> Google Homepage:   http://www.google.com/search?btnI&q=Robert+de+Bath
> 
> 
> ----- End forwarded message -----
> 
> -- 
> Alberto Gonzalez Iniesta   | BOFH excuse #2:
> agi@(agi.as|debian.org)    | solar flares
> Encrypted mail preferred   | 
> 
> Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3
> 
> 
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
> The only event dedicated to issues related to Linux enterprise solutions
> www.enterpriselinuxforum.com
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




