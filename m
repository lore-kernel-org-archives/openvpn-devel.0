From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] openvpn <---SSL---> Apache
In-Reply-To: <20686C579479DC438276A726FE80CDAA01F70FE7@...281...>
Message-ID: <Pine.LNX.4.61.0411150954490.32393@...210...>
References: <20686C579479DC438276A726FE80CDAA01F70FE7@...281...>
MIME-Version: 1.0
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
Date: Mon Nov 15 01:08:05 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: satinders@...280...
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 15 Nov 2004 satinders@...280... wrote:

> I was just trying out SSL connection set-up between openvpn client with
> Apache server (openSSL). But it is failing.
> Is there any way to do so? Can I get openvpn client to successfully create
> ssl connection with Apache server?
> What code changes do I need to do in openVPN code?

You don't ;-)

OpenVPN just uses the OpenSSL library for its encryption and 
authentication functionallity. Other than that it has nothing in common 
with SSL protection of HTTP traffic.

Use a web browser or some cmd-line web-tool like wget depending on 
what you want to do...

/Mathias

