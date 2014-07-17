Message-ID: <53C7889C.6060003@...1227...>
Date: Thu, 17 Jul 2014 10:26:04 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <24586198.798006.1405584918282.JavaMail.root@...1893...>
In-Reply-To: <24586198.798006.1405584918282.JavaMail.root@...1893...>
Subject: Re: [Openvpn-devel] OpenVPN and OpenVPN-NL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Lisa Minogue <lminogue@...1892...>, openvpn-devel@lists.sourceforge.net

Am 17.07.14 10:15, schrieb Lisa Minogue:
> Hi,
>
> I happened to read some information about OpenVPN-NL.
>
> According to https://openvpn.fox-it.com/background.html a Dutch government agency is of the opinion that among many other reasons, OpenVPN allows insecure configurations.
>
Yes. That is right. Some examples: OpenVPN allows you to do cipher nonet
to disable encryption. It also allows you to turn off replay protection.

Bottomline here is: OpenVPN can be as secure as OpenVPN-NL if configured
correctly. OpenVPN-NL makes it harder to shoot yourself in the foot.

Arne

