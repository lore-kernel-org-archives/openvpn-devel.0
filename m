From: Alberto Gonzalez Iniesta <agi@...5...>
Message-ID: <20030428142748.GA826@...30...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Fwd: Re: comp-lzo and licensing issues
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
Date: Mon Apr 28 07:41:14 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hi all,

Sorry for the huge forward, but everything needed to understand this
problem should be there :)

GPL software does not mix well with OpenSSL, and that's giving me some
headaches lately. As you me see in my mail to Markus (liblzo author) and
James (we all know who he is :) linking liblzo with OpenSSL may be a GPL
violation [1].

So this is a call for comments on this issue. 
Can anybody reach Markus and comment him about this?
Should we switch to another compression library? In that case, which one
would be suitable? zlib?
Should we ignore this and let RMS jump on us? [2]

Hoping to get lots of feedback,

Alberto

[1] http://www.openssl.org/support/faq.html#LEGAL2
[2] Yes, it's a joke

----- Forwarded message from James Yonan <jim@...41...> -----

From: James Yonan <jim@...41...>
To: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: comp-lzo and licensing issues
Date: Sat, 26 Apr 2003 16:57:26 -0000
X-SpamProbe: GOOD 0.0000000 6c2c0cd892c1100831080d47b6f1d8e2

Hi Alberto,

How are you doing?  I haven't heard from you for a while!

Interesting problem.  Well I hope that Markus will agree to the linkage.

It seems that this must be a common problem, if GPL cannot co-exist with
licenses which are still open source but non-GPL.  It also seems that the
whole notion of "linkage" is a thorny issue and would need to be rigorously
defined.  For example, does

gpl-program | non-gpl-program > conundrum.log

constitute linkage?

What if the linkage is between components in user space and kernel space that
have different licenses, but otherwise comingle in the same address space?

Is linkage via shared libraries or static linkage different from interprocess
communication linkages or network communication linkages?

As you mention, zlib is certainly another option, though I don't know how it
scores in the realtime category.  It would also need to be able to
compress/decompress small blocks (i.e. MTU sized) without reference to other
blocks or cross-block state-info.

I would agree that you should post something to openvpn-devel about this.

Best Regards,
James

Alberto Gonzalez Iniesta <agi@...5...> said:

> 
> --/WwmFnJnmDyWGHa4
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> Hi James,
> 
> First of all, sorry for the delay in contacting you about this.  :(
> I'm mailing you off the list because this is can be picky subject. You
> may take this subject to the list whenever you feel like.
> 
> As you can see in http://bugs.debian.org/177497 , I had to disable
> liblzo support in Debian's packages due to a (possible) GPL violation.
> 
> Remember the exception you did to OpenVPN's license so it could be built
> against OpenSSL? Well, the same thing should be done with liblzo. I
> mailed liblzo's author on Jan 26, but I got no answer from him. (See
> attachment)
> 
> So, what happens now? From my point of view, we have two choices:
> a) Try (again) to convince LZO's author to make the exception in his
> source. Until that happens I won't be able to package OpenVPN with LZO
> support (and lots of people require it. See bugs.d.o/182549 and 187117)
> 
> b) My No 1 wishlist request for OpenVPN: a new compression library.
> For example: zlib, which uses a BSD like license and it's used in
> OpenSSH.
> 
> Please, let me know what you think of all this. And, of course, feel
> free to take this discussion to the -devel list.
> 
> Thanks,
> 
> Alberto
> 
> --=20
> Alberto Gonzalez Iniesta       | They that give up essential liberty
> agi@(agi.as|debian.org)        | to obtain a little temporary safety
> Encrypted mail preferred       | deserve neither liberty nor safety.
> 
> Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3
> 
> --/WwmFnJnmDyWGHa4
> Content-Type: message/rfc822
> Content-Disposition: inline
> 
> Date: Sun, 26 Jan 2003 10:51:01 +0100
> From: Alberto Gonzalez Iniesta <agi@...5...>
> To: Markus Franz Xaver Johannes Oberhumer <markus.oberhumer@...79...>
> Subject: Compiling and/or linking liblzo with OpenSSL
> Message-ID: <20030126095100.GA2719@...30...>
> Mime-Version: 1.0
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> User-Agent: Mutt/1.5.3i
> 
> Hi Markus,
> 
> I'm the Debian Maintainer of OpenVPN (http://openvpn.sourceforge.net).
> OpenVPN is, as you may guess, a VPN software with liblzo support for
> improved performance. It's GPL'ed just like liblzo, but uses OpenSSL.
> 
> It seems that GPL and OpenSSL don't mix well:
> http://www.openssl.org/support/faq.html#LEGAL2
> 
> Since we're *very* picky with licenses in Debian, I had to disable libzo
> support in Debian's OpenVPN packages (http://bugs.debian.org/177497).
> That's far from being the best solution to the 'problem', which is
> adding a little exception to liblzo's license. OF COURSE IF, AND ONLY IF
> you completely agree with your source compiling, linking, and/or using
> OpenSSL in any case.
> 
> The exception would be something like this (from OpenVPN's one):
> 
> 
>     In addition, as a special exception, **your name here ** gives
>     permission to link the code of this program with the OpenSSL
>     library (or with modified versions of OpenSSL that use the same
>     license as OpenSSL), and distribute linked combinations including
>     the two.  You must obey the GNU General Public License in all
>     respects for all of the code used other than OpenSSL.  If you modify
>     this file, you may extend this exception to your version of the
>     file, but you are not obligated to do so.  If you do not wish to
>     do so, delete this exception statement from your version.
> 
> 
> Thanks for your time. I'm looking forward to hearing from you soon and 
> hope to be able to use liblzo in OpenVPN from now on :)
> 
> Alberto
> 



-- 



----- End forwarded message -----

-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@(agi.as|debian.org)        | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.

Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

