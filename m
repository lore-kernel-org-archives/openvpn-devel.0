Message-ID: <443EB8F1.4000908@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <443CD0CA.9070206@...41...> <op.s7wjp7i7ioehzu@...603...>
In-Reply-To: <op.s7wjp7i7ioehzu@...603...>
Subject: [Openvpn-devel] Re: [Openvpn-users] Re: OpenVPN 2.0.7 and 2.1-beta13 released
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
Date: Thu Apr 13 13:48:11 2006
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
To: Tony <kb2wjw@...277...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Tony wrote:
> OpenVPN v2.0.7 (server mode) works fine now on winXP-SP2.
>
> However, OpenVPN v2.1b13 (server) reports "TLS negotiation failure" on 
> the same set of keys|certs where v2.0.7 works fine.
>
> I see the servers certificate arriving (on the client) and then the 
> session stops for 60 seconds. After that - "TLS failure" and re-try...
>
> Summary:
> client(v2.1b13)<->server(2.0.7) = OK
> client(v2.1b13)<->server(2.1b13) = NOK
>
I've tracked this one down, and a fix will be issued shortly as 2.1-beta14.

James


