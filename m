From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] client-server customized session-id
In-Reply-To: <20686C579479DC438276A726FE80CDAA01BC1955@...281...>
Message-ID: <Pine.LNX.4.58.0410060321210.4834@...269...>
References: <20686C579479DC438276A726FE80CDAA01BC1955@...281...>
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
Date: Wed Oct  6 02:33:38 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: satinders@...280...
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 6 Oct 2004 satinders@...280... wrote:

> Hi,
> 	I am implementing client-server openvpn with following additional
> requirement:
> Client-server should share a secret session-id provided by me while starting
> client and server. I dont want to keep this session-id in a file on client
> machine. Preferrable client will be started from an applet. This applet will
> give the session-id to openvpn instance. This session-id will be sent in
> each request from client to server. This session-id will be used to find out
> whether this is legitimate client instance or not. It will also be used to
> check the client'access policy for particular service. Its a kind of
> firewall with specific permissions for each client for accessing servers.

OpenVPN already has a session ID.  See session_id.c.

As far as checking access policies, there are already several ways of 
doing this.  In particular, see --client-connect and --learn-address.
 
James


