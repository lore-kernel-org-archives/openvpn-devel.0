From: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: [Openvpn-devel] New OpenVPN beta available for testing
Message-ID: <20020602090401.GA2902@...6...>
References: <003f01c2099e$ee25c290$1000000a@...4...>
Mime-Version: 1.0
In-Reply-To: <003f01c2099e$ee25c290$1000000a@...4...>
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
Date: Sun Jun  2 02:05:01 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Sat, Jun 01, 2002 at 01:02:44PM -0600, James Yonan wrote:
> This beta revamps SIGUSR1 signal processing to make it like SIGHUP except
> with more fine-grained control over which OpenVPN subsystems are reset.  It
> also allows a SIGUSR1 to be generated internally based on --ping
> and --ping-restart.  The goal is to make OpenVPN as robust as possible on
> dynamic networks where DHCP, NAT, and firewalls must all be negotiated in a
> dynamic context.  The --persist-tun option allows a reset without closing
> and reopening the tun device (which allows seamless connectivity through the
> tunnel across DHCP resets).  The --persist-ip option allows for preservation
> of remote IP address across DHCP resets.  This allows both OpenVPN peers to
> be DHCP clients.
> 
> Also changed is the pthread handling in the configure script.  The script
> now uses the ACX_PTHREAD macro from the autoconf macro archive to
> intelligently figure out which cc/gcc option to use when building with POSIX
> thread support.  Some problems were reported when trying to build OpenVPN
> with pthread support using gcc3.
> 
> * Added ACX_PTHREAD (from the autoconf
>   macro archive) to configure.ac
>   to figure out the right pthread
>   options for a given platform.

Hi James,

I some archs in Debian build binary packages using gcc3, the following
patch solved the problem:

--- openvpn-1.2.0.orig/configure
+++ openvpn-1.2.0/configure
@@ -9716,7 +9716,7 @@
                CFLAGS="$CFLAGS -pthread"
                ;;
          *)
-               CFLAGS="$CFLAGS -pthread"
+               CFLAGS="$CFLAGS -lpthread"
                ;;
          esac

--- openvpn-1.2.0.orig/configure.ac
+++ openvpn-1.2.0/configure.ac
@@ -284,7 +284,7 @@
                CFLAGS="$CFLAGS -pthread"
                ;;
          *)
-               CFLAGS="$CFLAGS -pthread"
+               CFLAGS="$CFLAGS -lpthread"
                ;;


The new configure* scripts work flawlessly :-)

Regards,

Alberto

-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@...5...                     | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

