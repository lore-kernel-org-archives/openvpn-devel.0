Date: Mon, 27 Sep 2010 15:47:11 +0300
From: Heikki Kallasjoki <heikki.kallasjoki@...124...>
Message-ID: <20100927124711.GS3275@...1355...>
References: <4CA0551F.70703@...1410...> <4CA08840.3030107@...1147...>
	<4CA088DD.5040607@...1410...> <4CA08C68.1080701@...1147...>
MIME-Version: 1.0
In-Reply-To: <4CA08C68.1080701@...1147...>
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

On Mon, Sep 27, 2010 at 02:22:00PM +0200, Jan Just Keijser wrote:
> ah right, now I see... hmmm 'Host: ...' headers should not be required 
> by a web server and with apache's Virtual Hosts you can override this using

I would have to disagree with whether Host: headers should be required,
given that the HTTP/1.1 specification explicitly says [RFC2616]:

"All Internet-based HTTP/1.1 servers MUST respond with a 400 (Bad
Request) status code to any HTTP/1.1 request message which lacks a Host
header field."

The client also "MUST" send a Host: header in every request, it is not
an optional field.  Changing only the version number on the CONNECT line
OpenVPN sends does not make it a real HTTP/1.1 request.

(From what I can tell, and based on a very quick test, the string
"_default_" in an Apache <VirtualHost> config also only matches unlisted
IP addresses, and does not change how it processes HTTP requests that
claim to be version 1.1 but aren't.)


-- 
Heikki Kallasjoki
heikki.kallasjoki@...124...

