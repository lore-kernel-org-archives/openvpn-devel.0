From: Alberto Gonzalez Iniesta <agi@...5...>
Message-ID: <20030503094228.GA1496@...30...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Fwd: Re: Compiling and/or linking liblzo with OpenSSL
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
Date: Sat May  3 02:43:05 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Hi all,

Here's Markus answer for our 'little' license issue.
So I think we cleared that one, at least for now.
I'll make libzlo available in Debian's package again and hope no more
license problems arise :) Sorry for all this bothering.

Regards,

Alberto


----- Forwarded message from "Markus F.X.J. Oberhumer" <markus@...81...> -----

From: "Markus F.X.J. Oberhumer" <markus@...81...>
To: Alberto Gonzalez Iniesta <agi@...5...>
Subject: Re: Compiling and/or linking liblzo with OpenSSL
Date: Thu, 1 May 2003 20:02:55 +0200
X-no-Archive: yes
X-GPG-KeyID: 0x0B2043C9
X-GPG-Fingerprint: 1077 CF79 F341 3A50 03A3  93CE 4D61 57AB 0B20 43C9
X-GPG-Keyserver: http://www.keyserver.net/
X-Oberhumer-Conspiracy: There is no conspiracy. At least not today.
X-SpamProbe: GOOD 0.0000000 7bbc7baf191a36e2abba914d9e5bcf28

Hello Alberto,

assuming that OpenSSL is not a system library, which part of OpenSSLs
license makes it incompatible with the GPL ? I can't find any
exact info on this issue.

In any case, I don't feel like globally changing the LZO license, so 
would something like the following help for OpenVPN ? Please feel free
to suggest a better wording.

  Hereby I grant a special exception to the OpenVPN project 
  (http://openvpn.sourceforge.net) to link the LZO library with 
  the OpenSSL library (htttp://www.openssl.org).

  Markus F.X.J. Oberhumer

Cheers,
Markus


On Wed, 30 Apr 2003 19:42:21 +0200 Alberto Gonzalez Iniesta wrote:
> On Wed, Apr 30, 2003 at 04:17:01PM +0200, Markus F.X.J. Oberhumer wrote:
> > Hello Alberto,
> > 
> > very sorry for _this_ long delay, but my old university email account is
> > not active any longer...
> 
> Hi Markus!
> It's OK, I'm happy to hear from you. I should have imagined that and
> searched the net for a more recent address.
> 
> > Could you explain a little bit why the licenses are incompatible - the
> > OpenSSL FAQ claims it is fine for "the major Linux and BSD distributions",
> > and the GPL FAQ does not say too much either.
> >
> > What is the exact problem here ?
> > 
> 
> The difference is that GPL allows linking with libraries that are part of
> the OS with no restrictions. Since OpenSSL can be considered part of some
> Linux and BSD distros, linking LZO (or other GPL software) with OpenSSL
> it's OK in those.
> 
> It's not really clear if OpenSSL is 'part' of Debian (or other distros),
> or and 'additional library', and since we (in Debian) are very picky about 
> licenses, we chose to take LZO from OpenVPN. Just in case.
> 
> I know I'm not being very clear. That's because a) it's not a very
> defined problem (what can be considered linking, what is part of the OS
> and what isn't,...) and b) I don't fully understand this myself.
> 
> Please take a look at OpenVPN's discussion about this subject if you
> want to know more about this:
> 
> http://sourceforge.net/mailarchive/forum.php?thread_id=2033036&forum_id=8482
> 
> 
> > In any case, would a short (possibly PGP signed) README.LZO help that says
> > something like "Hereby I grant the OpenVPN project (http://openvpn.sourceforge.net)
> > to link the LZO library with the OpenSSL library (htttp://www.openssl.org)".
> 
> That should be OK. Even the sentence from OpenSSL FAQ:
> This program is released under the GPL with the additional exemption
> that compiling, linking, and/or using OpenSSL is allowed.
> 
> > That is because the full paragraph of the OpenVPN special exception is more
> > than unclear to me, e.g. "[...] If you do not wish to do so, delete this 
> > exception statement from your version." ???
> 
> That only means that any one using OpenVPN's source can take out this
> exception from the license (In case the want a pure GPL license).
> 
> Anyway, thanks for getting back to me. Let me know if you want more help
> understanding this issue, and I'll take the subject to debian-legal list
> where some one with more knowledge about licenses can help us.
> 
> Best regards,
> 
> Alberto
> 
> 
> PS. GPGing mail as your homepage instructs :)


-- 
Markus Oberhumer, <markus@...81...>, http://www.oberhumer.com/

----- End forwarded message -----

-- 
Alberto Gonzalez Iniesta       | They that give up essential liberty
agi@(agi.as|debian.org)        | to obtain a little temporary safety
Encrypted mail preferred       | deserve neither liberty nor safety.
                                               -- Benjamin Franklin
Key fingerprint = 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

