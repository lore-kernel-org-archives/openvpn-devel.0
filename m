Date: Fri, 24 Oct 2008 08:36:56 +0200
From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20081024063656.GA3920@...33...>
References: <48EDBFC7.9040301@...41...>
	<20081017165431.GA20687@...1139...>
MIME-Version: 1.0
In-Reply-To: <20081017165431.GA20687@...1139...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc13 released
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
To: openvpn-devel@lists.sourceforge.net

On Fri, 17 Oct 2008, Felix Kronlage wrote:

> On Thu, Oct 09, 2008 at 02:24:39AM -0600, James Yonan wrote:
> 
> Hi Yonan,
> 
> > Changelog:
> > 2008.10.07 -- Version 2.1_rc13
> > * Bundled OpenSSL 0.9.8i with Windows installer.
> > * Management interface can now listen on a unix
> >    domain socket, for example:
> > 
> >      management /tmp/openvpn unix
> > 
> >    Also added management-client-user and management-client-group
> >    directives to control which processes are allowed to connect
> >    to the socket.
> 
> what I dont quite understand is, why you add stuff like this to
> the release candidate instead of finally getting 2.1 out of the
> door and then make small subsequent releases. OpenVPN has been
> stuck (imho) for way too long in the RC phase now entering the
> infamous game of not just adding new stuff to RC's but instead
> introducing bugs in the RCs instead of just closing them...

This particular change looks a lot like "feature missing for
deployment/integration/...".

-- 
Matthias Andree

