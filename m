Message-ID: <1e6368e805020914263117032e@...278...>
From: Leonard Isham <leonard.isham@...277...>
Reply-To: Leonard Isham <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] Openvpn 2.0 TAP installation on WindowsXP
In-Reply-To: <ee2671e605020907063b5d4138@...278...>
Mime-Version: 1.0
References: <ee2671e605020907063b5d4138@...278...>
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
Date: Wed Feb  9 14:27:30 2005
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Prem Kumar J <premkumarjayaram@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 9 Feb 2005 20:36:32 +0530, Prem Kumar J
<premkumarjayaram@...277...> wrote:
> Hello Group,
> 
> I recently downloaded the OpenVPN 2.0 from the openvpn site and I
> wanted to setup a TAP device in multi-client fashion on a Windows XP
> box with SP2. As mentioned in the openvpn site, I selected the tap
> interface ( tap0 ) and the ethernet adaptor and bridged it. Also, I
> assigned the IP address and subnet of the ethernet adaptor to the
> bidge interface.
> 
> Now, if I connect more than one client to the server I get connection
> reset problem in few seconds just after the connection is extablished.
> I took the sample conf files from the sample-config-files folder.
> 

You need to allow duplicate certificates.

--duplicate-cn
    Allow multiple clients with the same common name to concurrently
connect. In the absence of this option, OpenVPN will disconnect a
client instance upon connection of a new client having the same common
name.

-- 
Leonard Isham, CISSP 
Ostendo non ostento.

