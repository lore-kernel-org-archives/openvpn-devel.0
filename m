From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] OpenVPN 1.6-beta6 on Windows XP - observations
Message-ID: <20040221000101.GA4288@...33...>
References: <20040220222904.GB20552@...33...> <twig.1077318468.22465@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1077318468.22465@...41...>
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
Date: Fri Feb 20 16:08:27 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Fri, 20 Feb 2004, James Yonan wrote:

> There's a lengthy description of bridging vs. routing in both the
> win32 notes and the FAQ -- perhaps it should be amplified.  Feel free
> to submit something.  

I'd think documentation needs to be compact, not spread out and ample.
Repetition of content doesn't help (although spraying pointers over a
collection of documents that tell the user where to look can be
helpful). It's the alternation between TUN and TAP document, one
paragraph this, next paragraph that, next paragraph this again - that
appears to confuse people.

> > 2. "ip-win32 ipapi" (which is the default) doesn't work reliably for
> > me (it worked after the first install but stopped working after a
> > reboot - but I also ran Windows Update in between)
> > 
> > I've seen logs about OpenVPN being unable to find the TAP interface.
> > netsh is fine. Maybe netsh could be the default for WinXP and ipapi
> > the default for Win2K?
> 
> Did you try "ip-win32 dynamic"?  If so, also make sure to use a
> --route-delay of a few seconds.  I'm considering making this the
> default, but I'd like more feedback first.

No, I haven't tried DHCP emulation yet but I'll try it on the next WinXP
machine I'll equip with OpenVPN.

> I'm not very happy about the idea of changing defaults based on the OS
> version being used.

It indeeds adds complexity that propagates to support.

> --redirect-gateway is experimental and unfortunately doesn't always
> produce the correct result. This has been discussed before on
> openvpn-users.  It is simply a helper function that generates 3 routes
> and undoes them on tunnel shutdown.

No need for excuses. It's an experimental feature in a beta branch, so I
just had to give feedback. :-)

I find this whole Windows routing stuff an order of magnitude less
transparent than Linux/BSD routing and the Windows XP "route print"
isn't exactly concise, in the German version that is. Apart from
outright stupid translations "metric -> Anzahl", the all-numeric
printout with addresses where BSD has interface names isn't helpful, and
DNS configuration adds to the confusion. With Samba and
"net view \\bigserver", WINS also gets into play and I see packets
coming from the wrong and the right source IP...

It's not OpenVPN's fault, fortunately, and affirms that Windows doesn't
make a good router for me :->

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

