Date: Thu, 30 Sep 2010 10:24:38 +0300
From: Heikki Kallasjoki <heikki.kallasjoki@...124...>
Message-ID: <20100930072438.GV3275@...1355...>
References: <4CA0551F.70703@...1410...> <4CA08840.3030107@...1147...>
	<4CA088DD.5040607@...1410...> <4CA08C68.1080701@...1147...>
	<20100927124711.GS3275@...1355...> <4CA09A9F.6040009@...1147...>
	<4CA0B3A3.5030506@...1410...> <20100929220528.19467.qmail@...1287...>
	<4CA3D978.8080700@...1410...> <20100930003840.14209.qmail@...1287...>
MIME-Version: 1.0
In-Reply-To: <20100930003840.14209.qmail@...1287...>
Subject: Re: [Openvpn-devel] HTTP Host header
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

On Thu, Sep 30, 2010 at 02:38:40AM +0200, Peter Stuge wrote:
> Lars Hupel wrote:
> > > Current behavior is correct. The first one is what should be sent.
> > > [...]
> > > Actually it is helpful. It says that *the resource being requested as
> > > obtained from the original URI given by the user* is what should be
> > > sent. This is the "remote" parameter and nothing else.
> > 
> > So what you're implying is that if a request is sent, the part after
> > 'CONNECT' must be always the same as the part after 'Host'.
> 
> Yep. It's a bit redundant, but consider that CONNECT is already the
> odd kid among the HTTP verbs. Most other verbs only take an absolute
> path URI, without host component.

On the other hand, in a proxy context the host component is always
present even for the other methods.  ("The absoluteURI form is REQUIRED
when the request is being made to a proxy.")  In that sense the host
header is sort-of redundant for all proxy requests, and could be used
for name-based "do we act as a proxy or an origin server" decisions.
Still, duplicating the "target" host name seems to be what regular web
browsers do; mine sends "GET http://example.com/test HTTP/1.1" followed
by "Host: example.com".  And I do agree that this is what the "original
URI" verbiage in the RFC implies, though I think it could have been
worder better.

(Also, the patch looks good.)

-- 
Heikki Kallasjoki
heikki.kallasjoki@...124...

