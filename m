From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Byte counting bug
In-Reply-To: <436B4299.2040608@...488...>
Message-ID: <Pine.LNX.4.58.0511041250550.13189@...41...>
References: <436B4299.2040608@...488...>
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
Date: Fri Nov  4 11:56:02 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "M. van Cuijk" <mark@...488...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 4 Nov 2005, M. van Cuijk wrote:

> Hi,
> 
> I just discovered a problem with the byte counting code in OpenVPN.
> The counter_type is declared as 'unsigned long', allowing it to count up 
> to 4 GB.

Could you please resend the patch as an attachment (sending patches inline
is generally not a good idea because email clients tend to malform them).

Thanks,
James

