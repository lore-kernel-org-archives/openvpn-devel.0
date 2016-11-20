References: <1479677932-22078-1-git-send-email-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <345177b8-6ef3-b357-7fea-025b34fa0e3f@...1227...>
Date: Sun, 20 Nov 2016 23:29:32 +0100
MIME-Version: 1.0
In-Reply-To: <1479677932-22078-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Handle --dhcp-option DNS6 on Windows
 using netsh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

Am 20.11.16 um 22:38 schrieb Selva Nair:
> TODO: set dns servers using the interactive service
>

I was playing with ANdroid/IPv6 and this. For Android, the resolver
takes the DNS server always in the order that I give it. Since there are
now seperate lists for DNS and DNS6 I have to prefer always DNS or DNS6
and cannot use the order I am given from the server.

I think we refactor the dns_list into a common dns list. I can also do
this later since this is probably an Android specific problem.

(So basically ACK to the patch, but I will send a followup later)

Arne


