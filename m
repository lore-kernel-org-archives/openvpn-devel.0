From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Bridging Question
In-Reply-To: <408EA7E8.2000601@...203...>
Message-ID: <Pine.LNX.4.58.0404280948030.12134@...210...>
References: <408EA7E8.2000601@...203...>
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
Date: Wed Apr 28 00:59:06 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Lonnie Cumberland <lonnie@...203...>
Cc: Openvpn-devel@lists.sourceforge.net

On Tue, 27 Apr 2004, Lonnie Cumberland wrote:

> It appears that on each side of the VPN that the hubs are allowing got
> masked IP on the range of 192.189.0.0/24.
>
> Since each side is allowing the same range of IP's, doesn't this
> particular set up require that no two machines have the same IP even
> though they are on different sides of the bridge?
>
> I would think that an IP conflict would occur if that were to happen, right?

Right. All mashines on both sides of the VPN bridge belong to the same ip
subnet, just like if they were all connected to the same hub/switch.

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

