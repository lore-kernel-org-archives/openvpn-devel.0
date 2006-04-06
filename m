From: Charles Duffy <cduffy@...294...>
Message-ID: <44351935.9090508@...294...>
References: <op.s7jnsprvioehzu@...603...> <op.s7k8a1niioehzu@...603...>
Mime-Version: 1.0
In-Reply-To: <op.s7k8a1niioehzu@...603...>
Subject: [Openvpn-devel] Re: Who develops TAP-Win32?
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
Date: Thu Apr  6 06:38:02 2006
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Tony wrote:
> Under "some problems" I mean that the neighborhood is un-browsable if 
> NetBEUI is the only protocol used for workgrouping in windows.
> 
> It takes to specify the exact share's name, like "\\server\printer", to 
> find it. No discovery work at all.

That's not a tap-win32 bug; it's normal behavior with a routed VPN 
unless you enable unicast-based discovery with WINS. This is discussed 
in the HOWTO and the mailing list archives.


