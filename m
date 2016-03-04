References: <56D8A6C4.5080803@...2070...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56D989C7.5040403@...1227...>
Date: Fri, 4 Mar 2016 14:12:39 +0100
MIME-Version: 1.0
In-Reply-To: <56D8A6C4.5080803@...2070...>
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
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
To: ValdikSS <iam@...2070...>, openvpn-devel@lists.sourceforge.net



Am 03.03.16 um 22:04 schrieb ValdikSS:
> Hello everyone,
>
> I'm trying to leisurely move from an old existing 1024 bit CA to a new 4096 bit one without a hassle for a clients.
> From a X.509 perspective it shouldn't be a problem, and I already have new CA self-signed and cross-signed with old CA, it should work just fine.
>
> While there's no problem authenticating clients from both old and new CA using single instance (multiple certificates in --ca are supported, this information is
> documented), I need to send two certificates from OpenVPN server: server certificate, which is signed by new CA, and cross-signed new CA with old CA. This way
> it should work for clients either with old or new CA in configuration files.
>
>
Shouldn't sending the new CA chain only be enough? Since it is
(cross)signed by the old CA, the client will accept it. For the old
clients the new CA will look like an intermediate certificate.

Arne

