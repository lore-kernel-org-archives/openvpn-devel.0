From: Sampo Nurmentaus <audiopoppi-13@...22...>
Reply-To: sampo.nurmentaus@...22...
Subject: Re: [Openvpn-devel] --dev and --dev-name under linux 2.4+
In-Reply-To: <200306030136.h531atK03067@...41...>
Message-ID: <Pine.LNX.4.44.0306030951270.1452-100000@...86...>
MIME-Version: 1.0
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
Date: Mon Jun  2 23:57:07 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Hi James,

The original reason for the new option for me was the
ability to move the device file away from /dev.

This was of cource a really special need to
help me porting openvpn to an embedded platform.

How about if --dev would check if the given 
device name begins with / and if so it would
use given string as a complete path to the device file?

And --dev /dev/tun would be equivalent with --dev tun ?


Best regards,
Sampo



> A debian bug report was submitted that inspired me to look deeper into the
> operation of --dev and the new --dev-name flag.
> 
> --dev-name was a patch for tun.c which I received a few months ago, which only
> really does anything for linux 2.4.  On first glance it appeared nominally
> useful, so I merged it, but on further inspection it appears to be mostly
> redundant with --dev.
> 
> It appears that the motivation for implementing --dev-name was that --dev
> assumes its argument is either "tun", "tap", "null", or tun/tap with a unit
> number (e.g. "tun4").  But --dev is limited in that it doesn't allow arbitrary
> renaming.
> 
> In OpenVPN 1.3.2, if the --dev argument was larger than 3 chars, it was
> assumed that a unit number was present.  In 1.4.1 that test was changed so
> that an ascii digit needed to be present to assume a unit number.  If a unit
> number was present, then the name of the device (as it appears in ifconfig)
> would be changed to reflect the explicit unit number.  What I think probably
> inspired the debian bug report is that in 1.3.2 if you said "--dev foobar
> --dev-type tun", openvpn would have renamed the tun device to foobar, because
> foobar is > 3 characters.  In 1.4.1, no rename would occur because "foobar"
> doesn't contain any numerical digits.  In 1.4.1, you would need to say "--dev
> tun --dev-name foobar" to get the same effect.  This seems somewhat arbitrary
> and confusing.
> 
> My conclusion is that the implementation of --dev and --dev-name is mostly
> redundant because --dev can just as easily set the device name based on its
> argument, if that argument is something other than "tun", "tap", "null".  The
> current operation of "--dev tun" or "--dev tap" would be preserved so that a
> dynamic unit number would be allocated if, for example, "--dev tun4" is given.
>  But you could also specify "--dev foo --dev-type tun" and a tun device named
> foo would be created.
> 
> I've patched the current development release to remove --dev-name, and to
> allow --dev to set a specific device name as in the above paragraph.
> 
> Download:
> 
> http://openvpn.sourceforge.net/beta/openvpn-1.4.1.4.tar.gz (or CVS)
> 
> James
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: eBay
> Get office equipment for less on eBay!
> http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


