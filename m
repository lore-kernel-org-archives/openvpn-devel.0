Message-ID: <20100929220528.19467.qmail@...1287...>
Date: Thu, 30 Sep 2010 00:05:28 +0200
From: Peter Stuge <peter@...1287...>
References: <4CA09A9F.6040009@...1147...> <4CA0B3A3.5030506@...1410...>
	<4CA362CD.8030204@...1410...> <4CA0551F.70703@...1410...>
	<4CA08840.3030107@...1147...> <4CA088DD.5040607@...1410...>
	<4CA08C68.1080701@...1147...> <20100927124711.GS3275@...1355...>
	<4CA09A9F.6040009@...1147...> <4CA0B3A3.5030506@...1410...>
MIME-Version: 1.0
In-Reply-To: <4CA362CD.8030204@...1410...> <4CA0B3A3.5030506@...1410...>
Subject: Re: [Openvpn-devel] HTTP/1.1 Host header
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

Lars Hupel wrote:
> I would suggest to always send the Host header (even when HTTP/1.0
> is selected).

I strongly support this. Please watch out for HTTP/1.1, if a client
claims to support 1.1 then servers can respond e.g. with chunked
transfer coding, which certainly isn't supported by 1.0 clients.
On the other hand, if OpenVPN only ever CONNECTs, maybe it's not an
issue.


Lars Hupel wrote:
> As far as I can see, there are two possible hosts which can be sent:
> 
> * 'host' (denoting the 'remote' config option)
> * 'p->options.server' (denoting the 'http-proxy' config option)
> 
> I would guess that sending the latter would be correct, but the
> OpenVPN sources use the first one.

Current behavior is correct. The first one is what should be sent.


> The section about the host header isn't very helpful either:
> 
> >    The Host request-header field specifies the Internet host and port
> >    number of the resource being requested, as obtained from the original
> >    URI given by the user or referring resource (generally an HTTP URL

Actually it is helpful. It says that *the resource being requested as
obtained from the original URI given by the user* is what should be
sent. This is the "remote" parameter and nothing else.

I'll ack your patch if it only adds a Host header where one is
missing, and sends the correct contents, ie. the "remote" hostname.


//Peter

