From: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: [Openvpn-devel] Fwd: Bug#182020: openvpn needs dynamic choice on HAVE_LINUX_IF_TUN_H
Message-ID: <20030508090415.GE2698@...30...>
References: <20030507190341.GA922@...30...> <200305080830.h488UZ111579@...41...>
Mime-Version: 1.0
In-Reply-To: <200305080830.h488UZ111579@...41...>
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
Date: Thu May  8 02:05:05 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Thu, May 08, 2003 at 08:30:34AM -0000, James Yonan wrote:
> Alberto Gonzalez Iniesta <agi@...5...> said:
> 
> > When compiled with 2.4.* kernel headers (libc6-dev 2.2.5-14.3 headers)
> > it detects this header file and defines HAVE_LINUX_IF_TUN_H. This allow
> > openvpn to work correctly with 2.4.18 kernels BUT it stops it working
> > with 2.2.X kernels at all (with or without the tun kernel module from
> > sourceforge)
> 
> OpenVPN's config script assumes that if 2.4 headers are present (i.e.
> if_tun.h), then it should build for the 2.4 tun/tap driver.
> 
> I don't completely understand why one would want to put 2.4 kernel headers on
> a 2.2 machine, since that would tend to confuse things, and break apps that
> depend on the userspace <-> kernel interface as defined by the kernel header
> files.

The problem (again) is distributing binaries. I compile Debian's
packages in my 2.4.x box, but those packages may be used in 2.2 boxes.
I could find a 2.2 box (could I?) to compile them, but then the problem
would be the other way around, wouldn't it?

So, and as the bug reported says, we have two choices:

a) I make two binaries in the package, and choose at installation time
which one should be used. (will uname -r do? I guess so)
b) openvpn detects at run time which tun interface to use.

pros? cons?

Regards,

Alberto


> But in any case, you can still build if you do the following.
> 
> (1) run ./configure
> (2) edit config.h
> (3) comment out this line: #define HAVE_LINUX_IF_TUN_H 1
> (4) run make
> 
> This could be automatic if ./configure did a kernel version test, and only
> defined HAVE_LINUX_IF_TUN_H if (a) if_tun.h exists and (b) kernel version is
> 2.4.x.
> 
> James
> 
> > Options are:
> > 
> > 1) Seperate compiles for 2.2.X and 2.4+ kernels, both binaries in the .deb
> > 
> > 2) Patch tun.c to first check if /dev/net/tun exists and works before
> >    falling back to the open_tun_generic(..) function if it doesn't.
> > 
> > I'm currently successfully using openvpn between a 2.2.19 and 2.4.18
> > kernel using the tun0 tunnel and the driver from sourceforge on the 2.2.19
> > machine. (No reboot required to install the tun0 driver) The 2.4.18
> > openvpn is standard, the 2.2.19 has HAVE_LINUX_IF_TUN_H undefined.
> > 
> > Both machines are woody with libc6/testing.
> > 


-- 
Alberto Gonzalez Iniesta   | BOFH excuse #99:
agi@(agi.as|debian.org)    | SIMM crosstalk.
Encrypted mail preferred   | 

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

