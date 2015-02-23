Sender: Vasiliy Kulikov <segooon@...277...>
Date: Mon, 23 Feb 2015 17:42:51 +0300
From: Vasily Kulikov <segoon@...2008...>
Message-ID: <20150223144251.GB6378@...2009...>
References: <20150124170446.GA504@...2009...> <54E10A03.3000400@...1227...>
	<20150215220144.GP8134@...1296...>
	<20150223080402.GA5068@...2009...> <54EAE4AF.8010009@...1227...>
	<1424696107.5437.209.camel@...1866...>
MIME-Version: 1.0
In-Reply-To: <1424696107.5437.209.camel@...1866...>
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
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Feb 23, 2015 at 12:55 +0000, David Woodhouse wrote:
> On Mon, 2015-02-23 at 09:28 +0100, Arne Schwabe wrote:
> > 
> > Am 23.02.15 um 09:04 schrieb Vasily Kulikov:
> > >     management-external-cert 'macosx-keychain:SUBJECT:c=US'
> > >
> > > With the approach in patch v3 a user has to start openvpn with the
> > > config file, start keychain-mcd, and pass identity template as an
> > > argument to keychain-mcd.
> > >
> > > What do you think of the change?
> > I like the idea. You could  make the macos-keychain in the string optional.
> 
> I wouldn't make it optional. Keep it URI-like, with 'macos-keychain' as
> the URI scheme.

I'll keep it.  I don't have a strict understanding what is the purpose
of a default scheme, so I don't declare any default.

Also please note that openvpn itself doesn't know about any "scheme", it
simply passes the value to a management interface client.  A client is the
process which parses the value and must know about schemes, default
scheme, etc.

Thanks,

-- 
Vasily Kulikov
http://www.openwall.com - bringing security into open computing environments

