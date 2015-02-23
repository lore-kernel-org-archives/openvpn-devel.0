Sender: Vasiliy Kulikov <segooon@...277...>
Date: Mon, 23 Feb 2015 17:40:11 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20150223144011.GA6378@...2009...>
References: <20150124170446.GA504@...2009...> <54E10A03.3000400@...1227...>
	<20150215220144.GP8134@...1296...>
	<20150223080402.GA5068@...2009...> <54EAE4AF.8010009@...1227...>
	<20150223090035.GL8134@...1296...>
	<CAEsd45QKyS8N7Vdg9MQ7EE6g4_h4w7ZC8kNuDsdJ88dpdexNyg@...278...>
MIME-Version: 1.0
In-Reply-To: <CAEsd45QKyS8N7Vdg9MQ7EE6g4_h4w7ZC8kNuDsdJ88dpdexNyg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Mon, Feb 23, 2015 at 08:04 -0500, Jonathan K. Bullard wrote:
> On Mon, Feb 23, 2015 at 4:00 AM, Gert Doering <gert@...1296...> wrote:
> >
> > On Mon, Feb 23, 2015 at 09:28:31AM +0100, Arne Schwabe wrote:
> > > > What do you think of the change?
> > > I like the idea. You could  make the macos-keychain in the string optional.
> >
> > What Arne said (both parts of it) :-)
> 
> I agree -- the argument to --needs-external-cert should be optional.

Note: Arne said about 'macos-keychain' prefix in the argument being
optional, not the argument itself being optional.  Acually, I don't
think making the argument optional is a good idea -- its parsing would
be ambiguous unless it is the last argument in argv.

> Note: the argument to --needs-external-cert should be passed on to
> "RSA_SIGN", too. (I think Vasily omitted that from his writeup.)
> 
> So the idea would be:
> 
>  * Add an optional UTF-8 string argument to --needs-external-cert.
> (Perhaps the docs should say this requires support from the management
> interface software and that currently such support is only available
> when using certain GUIs on OS X.)

Right.

>  * OpenVPN passes that argument to RSA_SIGN and NEEDS-CERTIFICATE,
> passing an empty string if the argument does not appear.

Why rsa-sign?  I think doing it with NEEDS-CERTIFICATE is enough.
Identity contains both cert and private key, certificate request is
made at first.  Rsa-sign uses already chosen identity.

>  * OS X GUIs such as Tunnelblick and Viscosity see the new RSA_SIGN or
> NEEDS-CERTIFICATE argument and use keychain-mcd to deal with it. Other
> GUIs ignore it or use something that does something equivalent to what
> keychain-mcd does on OS X.

Right.

> I'm not sure exactly how to add an argument to RSA_SIGN and
> NEEDS-CERTIFICATE without breaking existing management interface
> software but assume that is possible. (Also, the argument may need to
> be escaped when it is passed to RSA_SIGN or NEEDS-CERTIFICATE if it
> contains characters that are used as delimiters.)

IMNSHO don't change rsa-sign at all and have no API breakage.

-- 
Vasily Kulikov
http://www.openwall.com - bringing security into open computing environments

