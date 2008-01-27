Message-ID: <9e0cf0bf0801271026l4f8fa9e5s3c3e5e4702d85285@...278...>
Date: Sun, 27 Jan 2008 20:26:53 +0200
From: "Alon Bar-Lev" <alon.barlev@...277...>
In-Reply-To: <000001c86106$9dc87fc0$16ada8c0@...576...>
MIME-Version: 1.0
References: <9e0cf0bf0801262257k735616a6r6f0931e4ae5f4e1a@...278...>
	<000001c86106$9dc87fc0$16ada8c0@...576...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.1-rc5 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Dave <dev@...575...>
Cc: Openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>, openvpn-users@lists.sourceforge.net

On Jan 27, 2008 7:04 PM, Dave <dev@...575...> wrote:

> Can you explain the new options, or point me to where they are explained so
> I can reconfigure?

There is a single ID now for PKCS#11 certificate, sync to all projects
OpenVPN, OpensSSH, QCA, eCryptfs etc...
You use pkcs11-id 'id' (mind the single quote).
You can view id list using show-pkcs11-ids.

I updated the HOWTO:
http://openvpn.net/howto.html#pkcs11

So you don't need to specify any other option except of:
pkcs11-providers bt_csp11.dll
pkcs11-id 'serialized-id'

Alon

