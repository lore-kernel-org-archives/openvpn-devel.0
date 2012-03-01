Date: Thu, 1 Mar 2012 11:40:51 +0100
From: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <1015941915.20120301114051@...449...>
In-Reply-To: <7462163.ufeuZ1iJur@...1526...>
References: <4F4CE4FE.3010009@...515...>
	<1957833067.20120229194040@...449...>
	<1787326494.20120229201800@...449...> <7462163.ufeuZ1iJur@...1526...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
Reply-To: =?iso-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Hello Heiko,

>  If that works out, all that is needed is the service increasing the tokens integrity
> level before starting openvpn and the user will have limited access to the
> running openvpn process.

a) this didn't work, you can lower the level and but not higher
b) dll injection is ONE example of how a user can manipulate his own
process. I'm no expert at hacking windows but you can trust me, it
exists 1001 possibilities to do the same. You have no chance to block
them.

Please drop openvpn-service starts openvpn in the context of the user.
It brings in much complexty for no benefit.

greetings
Carsten


