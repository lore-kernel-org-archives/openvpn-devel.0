From: Davide Brini <dave_br@...1278...>
Date: Fri, 30 Apr 2010 18:42:58 +0100
References: <4BDAD39A.1030906@...515...> <4BDAEAB9.8080806@...1114...>
	<201004301824.21244.dave_br@...1278...>
In-Reply-To: <201004301824.21244.dave_br@...1278...>
MIME-Version: 1.0
Message-Id: <201004301842.59101.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] [TESTING NEEDED] Using
	--inactive and --ping seems to defeat each other
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

On Friday 30 April 2010, Davide Brini wrote:

> if (! is_ping_msg (&c->c2.buf))
>    register_activity (c, size);
> 
> This is in two places: in process_outgoing_tun() and
>  process_outgoing_link().

Actually that would probably need to be done only in process_outgoing_link(), 
as I don't think pings ever make it into the tun device to userspace, since 
they are discarded by process_incoming_link().

-- 
D.

